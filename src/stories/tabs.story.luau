local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local container = require(script.Parent.Parent.components.container)
local padding = require(script.Parent.Parent.components.padding)
local tabs = require(script.Parent.Parent.components.tabs)
local text = require(script.Parent.Parent.components.text)

local source = vide.source

return function(target)

	return vide.mount(function()
		local selected = source(1)
		
		return container {

			tabs {
				selected = selected,
				update_selected = selected,
	
				{
					name = "Home",
					child = function()
						return background {
							padding {
								padding = UDim.new(0, 8)
							},
							text {
								Text = "Home"
							}
						}
					end
				},
				{
					name = "Model",
					child = function()
						return background {
							padding {
								padding = UDim.new(0, 8)
							},
							text {
								Text = "Model"
							}
						}
					end
				}
			},

			padding {
				padding = UDim.new(0, 8),
				bottom = UDim.new(0, 80)
			}

		}
	end, target)

end