
local vide = require(script.Parent.Parent.Parent.vide)
local tree = require(script.Parent.tree)

local create = vide.create
local derive = vide.derive
local source = vide.source
local read = vide.read

type can<T> = T | () -> T
type instance_tree = {
	instances: {Instance},
	
	selected: (() -> {[Instance]: true})?,
	update_selected: ((instance: Instance, state: boolean) -> ())?
}

local function instance_tree(props: instance_tree)
	
	local update_selected_callback = props.update_selected
	local selected = props.selected

	local function update_selected(state: boolean, new)
		if update_selected_callback then
			update_selected_callback(new.instance :: Instance, state)
		end
	end

	local function turn_children_into_elements(children: {Instance})
		local elements = {}
		for i, child in children do
			local memo
			elements[i] = {
				name = child.Name,
				instance = child,
				children = function()
					if memo then
						return memo
					else
						memo = turn_children_into_elements(child:GetChildren())
						return memo
					end
				end,
				can_expand = function()
					return #child:GetChildren() > 0
				end,
				
				update_selected = update_selected,
				selected = function()
					return if selected then selected()[child] or false else false
				end
			}
		end
		return elements
	end
	
	return tree {
		elements = turn_children_into_elements(props.instances)
	}
end

return instance_tree