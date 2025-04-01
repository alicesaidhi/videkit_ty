local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local container = require(script.Parent.Parent.components.container)
local rounded_frame = require(script.Parent.Parent.components.rounded_frame)

return function(target)

	return vide.mount(function()
		return rounded_frame {

			topleft = UDim.new(0.4, 0),
			topright = UDim.new(0.5, 0),
			bottomright = UDim.new(0.1, 0),
			bottomleft = UDim.new(0, 30),

			layout = {
				Size = UDim2.fromOffset(400, 100),

				container {
					vide.create "TextLabel" {
						BackgroundTransparency = 1,
						Size = UDim2.fromScale(1, 1),
						Text = "ugh",

						TextSize = 14,
					}
				}
			}
		}
	end, target)

end