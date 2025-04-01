
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local quick = require(script.Parent.Parent.util.quick)
local button = require(script.Parent.button)
local image = require(script.Parent.image)
local infinite_list = require(script.Parent.infinite_list)

local batch = vide.batch
local create = vide.create
local effect = vide.effect
local source = vide.source
local cleanup = vide.cleanup
local read = vide.read

type can<T> = T | () -> T
type element = {
	name: can<string>,
	image: can<string>?,

	selected: (() -> boolean)?,
	update_selected: ((selected: boolean, element: element) -> ())?,

	children: can<{element}?>,
	can_expand: can<boolean>?
	
}
type ielement = element & {
	_children: {element}?,
	_nesting: number?,
	_scope: () -> ()
}
type tree = {
	elements: {element},
	layout: vide.vScrollingFrame?
}

local function shallow_eq(a: {any}, b: {any}): boolean
	if #a ~= #b then return false end

	for k, v in a do
		if b[k] ~= v then return false end
	end

	for k, v in b do
		if a[k] ~= v then return false end
	end

	return true
end

type element_props = {
	index: () -> number,
	element: () -> ielement,

	expand: (index: number) -> (),
	collapse: (index: number) -> (),
}
local function element(props: element_props)
	local current_element = props.element
	
	local function element(): ielement
		return current_element() or {
			name = "",
			_nesting = 0,
		}
	end

	local function selected(): boolean
		return if element().selected then read(element().selected) or false else false
	end

	local index = props.index
	local expand = props.expand
	local collapse = props.collapse

	local function expanded()
		return not not element()._children
	end

	local function expandable()
		local can_expand = read(element().can_expand)
		local children = read(element()._children)
		local has_children = typeof(element().children) == "table" and #element().children > 0
		return can_expand or children or has_children
	end
	
	return button {

		text = function()
			if element() == nil then return "" end
			return read(element().name)
		end,

		activated = function()
			local update = element().update_selected
			if not update then return end
			update(not selected(), element())
		end,

		_custom = "TableItem",
		_selected = function()
			return read(element().selected)
		end,
		_noborder = true,
		_nocorner = true,

		layout = {
			Size = UDim2.new(1, 0, 0, 24),
			AutomaticSize = Enum.AutomaticSize.X,
		},

		child = {
			create "UIListLayout" {
				FillDirection = Enum.FillDirection.Horizontal,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			create "Frame" {
				Name = "Indent",
				Size = function()
					return UDim2.fromOffset((element()._nesting or 0) * 16, 0)
				end,
				LayoutOrder = -3
			},
			create "TextButton" {
				Name = "Arrow",
				LayoutOrder = -2,

				Size = UDim2.fromOffset(24, 24),
				
				BackgroundTransparency = 1,
				
				Interactable = expandable,
				
				Activated = function()
					if expanded() then
						batch(function()
							collapse(index())
						end)
					else
						expand(index())
					end
				end,
				
				image {
					Position = UDim2.fromScale(0.5, 0.5),
					Size = function()
						return if expanded() then UDim2.fromOffset(9, 7)
							else UDim2.fromOffset(7, 9)
					end,
					AnchorPoint = Vector2.new(0.5, 0.5),
	
					Image = function()
						return if expanded() then "rbxasset://textures/StudioToolbox/ArrowExpanded.png"
						else "rbxasset://textures/StudioToolbox/ArrowCollapsed.png"
					end,
					ScaleType = Enum.ScaleType.Fit,
					
					Visible = expandable,
				},

			},
			image {
				Size = UDim2.fromOffset(16, 16),
				Image = function()
					return read(element().image) or ""
				end,
				Visible = function()
					return not not read(element().image)
				end,
				LayoutOrder = -1
			}
		}
	}
end

local function tree(props: tree)
	
	local elements = props.elements
	local stored_elements = source({} :: {ielement})
	local total_elements = source(0)

	local function collapse(index: number)
		local element = stored_elements()[index]
		local children: {ielement}? = read(element._children)

		if not children then return end

		-- we must collapse every child first
		for i = 1, #children do
			collapse(index + i)
		end

		if element._scope then
			element._scope()
			element._scope = nil
		end

		-- then we can get rid of this element
		element._children = nil
		quick.remove(stored_elements(), index + 1, #children)
		stored_elements(stored_elements())
		total_elements(total_elements() - #children)
	end

	local function expand(index: number)
		local element = stored_elements()[index]
		local children: {ielement}? = read(element.children)

		if not children then return end

		children = table.clone(children) -- work with an immutable copy
		element._children = children
		
		-- this will create an effect that will automatically collapse and expand
		-- this element to get it to update it's children.
		if typeof(element.children) == "function" then
			local already_updating = false

			local function update()
				if already_updating then return end
				if shallow_eq(children, element.children()) then return end
				already_updating = true
				task.defer(function()
					-- we defer this to the end of the frame
					collapse(index)
					expand(index)
				end)
			end

			element._scope = vide.mount(function()
				effect(update)
			end)
		end

		quick.insert(stored_elements(), children, index + 1)

		for _, child in children do
			child._nesting = element._nesting + 1
		end

		stored_elements(stored_elements())
		total_elements(total_elements() + #children)
	end

	cleanup(function()
		for index in stored_elements() do
			collapse(index)
		end
	end)
	
	for _, element: ielement in read(elements) do
		element._nesting = 0
		table.insert(stored_elements(), element)
	end
	total_elements(#stored_elements())

	return infinite_list {

		item_size = 24,
		max_items = total_elements,

		item = function(index)
			return element {
				index = index,
				element = function()
					return stored_elements()[index()]
				end,
				expand = expand,
				collapse = collapse,
			}
		end,

		layout = props.layout

	}
	
end

return tree