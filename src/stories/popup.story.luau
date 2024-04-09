local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local button = require(script.Parent.Parent.components.button)
local container = require(script.Parent.Parent.components.container)
local padding = require(script.Parent.Parent.components.padding)
local popup = require(script.Parent.Parent.components.popup)
local row = require(script.Parent.Parent.components.row)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()
		local enabled = vide.source(false)
		
		return container {
			
			popup {
				enabled = enabled,
				inherit_layout = true,

				background {

					padding {
						padding = UDim.new(0, 16)
					},

					vide.create "UIListLayout" {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = UDim.new(0, 16)
					},

					text {
						Text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tristique dolor a lectus dictum, a mollis neque ultrices. Nunc dictum nulla nec elit fermentum varius. Sed egestas lorem vel odio eleifend, at suscipit erat fermentum. Aliquam nulla odio, interdum quis nunc ut, sollicitudin viverra enim. Cras leo mauris, maximus ut accumsan et, consequat sit amet enim. Ut pellentesque mi eget quam pulvinar suscipit ut in dolor. Integer eu urna ac mi vestibulum commodo. "
					},

					row {

						button {
							text = "Close",
							
							activated = function()
								enabled(false)
							end,

							layout = {
								Size = UDim2.new(0.5, -8, 0, 24)
							}
						},

						button {
							primary = true,
							text = "OK",
							
							activated = function()
								enabled(false)
							end,
							
							layout = {
								Size = UDim2.new(0.5, -8, 0, 24)
							}
						}

					}
				}
			},

			button {
				text = "Start Popup",

				activated = function()
					print("start")
					enabled(true)
				end
			}
		}
	end, target)

end