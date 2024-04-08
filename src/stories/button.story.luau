local vide = require(script.Parent.Parent.Parent.vide)
local button = require(script.Parent.Parent.components.button)
local container = require(script.Parent.Parent.components.container)

return function(target)

	return vide.mount(function()
		return container {
			button {
				text = "Button"
			},

			button {
				primary = true,
				text = "Primary",
				layout = {
					Position = UDim2.fromOffset(0, 30)
				},
				
				activated = function()
					print("activated")
				end
			}
		}
	end, target)

end