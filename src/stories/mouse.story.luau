local vide = require(script.Parent.Parent.Parent.vide)
local container = require(script.Parent.Parent.components.container)
local mouse = require(script.Parent.Parent.components.mouse)
local text = require(script.Parent.Parent.components.text)

return function(target)
	return vide.mount(function()
		
		local position = vide.source(Vector3.zero)

		return container {

			text {
				Text = function()
					return tostring(position())
				end
			},

			mouse {
				position_changed = position
			}

		}

	end, target)
end