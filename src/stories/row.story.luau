local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local button = require(script.Parent.Parent.components.button)
local row = require(script.Parent.Parent.components.row)

return function(target)

	return vide.mount(function()
		return row {

			button {
				text = "button 1",

				layout = {
					Size = UDim2.new(0.5, -6, 0, 24)
				}
			},

			button {
				text = "button 2",

				layout = {
					Size = UDim2.new(0.5, -6, 0, 24)
				}
			},

			

		}
	end, target)

end