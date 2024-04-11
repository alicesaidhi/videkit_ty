local vide = require(script.Parent.Parent.Parent.vide)
local bullet_list = require(script.Parent.Parent.components.bullet_list)
local infinite_list = require(script.Parent.Parent.components.infinite_list)
local scroll_frame = require(script.Parent.Parent.components.scroll_frame)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()

		return infinite_list {

			item_size = 24,
			max_items = 1000,

			item = function(value)
				return text {
					Text = function()
						return `index: {value()}`
					end
				}
			end
		}
	end, target)

end