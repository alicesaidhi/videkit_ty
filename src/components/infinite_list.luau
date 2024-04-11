--[[

infinite lists dynamically render elements when necessary.
if the index is -1, that means it should go unrendered.

]]
local vide = require(script.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)
local scroll_frame = require(script.Parent.scroll_frame)

local source = vide.source
local changed = vide.changed
local indexes = vide.indexes
local derive = vide.derive
local effect = vide.effect
local untrack = vide.untrack
local read = vide.read

type can<T> = T | () -> T
type infinite_list = {
	
	max_items: can<number>?,
	item_size: number,
	item: (index: () -> number) -> Instance,

	layout: vide.vScrollingFrame?

}

local ITEMS_OFF = 4 -- controls how many items to render off screen

local function infinite_list(props: infinite_list)
	
	local canvas_position = source(Vector2.zero)
	local canvas_size = source(Vector2.zero)
	local absolute_size = source(Vector2.zero)

	local max_items = props.max_items
	local item_size = props.item_size
	local item = props.item

	local items = source({} :: {number})

	-- handles the updating logic of items
	-- we use derives here to reduce computations within the effect.
	local lowest = derive(function()
		return math.max(
			math.floor(canvas_position().Y // item_size) - ITEMS_OFF,
			0
		)
	end)
	
	local amount_to_render = derive(function()
		return math.ceil(absolute_size().Y / item_size) + ITEMS_OFF * 2
	end)

	effect(function()

		local lowest, highest = lowest(), math.min(lowest() + amount_to_render(), read(max_items) or math.huge)

		local unused = table.create(highest - lowest, true)
		local copy = table.clone(untrack(items))

		local to_be_replaced = {}
		for index, item in copy do
			if item > lowest and item < highest then -- item is used
				unused[item - lowest] = nil
			elseif amount_to_render() < index then
				copy[index] = nil
			else
				table.insert(to_be_replaced, index)
			end
		end

		for _, index in to_be_replaced do
			local unused_index = next(unused)
			if unused_index then
				copy[index] = unused_index + lowest
				unused[unused_index] = nil
			else
				copy[index] = -1
			end
		end

		for unused_index in unused do
			local found = false
			unused_index += lowest

			-- find the first nil value
			for i = 1, highest - lowest do
				if copy[i] == nil then
					copy[i] = unused_index
					found = true
					break
				end
			end
			
			if not found then
				-- no nil value, insert at end
				table.insert(copy, unused_index)
			end
		end

		items(copy)

	end)

	return scroll_frame {

		CanvasSize = function()
			return if max_items then UDim2.fromOffset(0, read(max_items) * item_size)
			else UDim2.fromOffset(0, canvas_position().Y + absolute_size().Y + 200)
		end,

		changed("CanvasPosition", canvas_position),
		changed("CanvasSize", canvas_size),
		changed("AbsoluteSize", absolute_size),

		indexes(items, function(value, key)
			return container {
				Name = function()
					return `{key}:{value()}`
				end,

				Position = function()
					return UDim2.fromOffset(0, (value() - 1) * item_size)
				end,
				Size = UDim2.new(1, 0, 0, item_size),

				item(value)
			}
		end),

		layout = props.layout
	}
	
end

return infinite_list