local vide = require(script.Parent.Parent.Parent.vide)
local portal = require(script.Parent.Parent.components.portal)

local create = vide.create

return function(target)

	return vide.mount(function()
		return portal {
			inherit_layout = true,
	
			layout = {
				create "TextLabel" {
					Size = UDim2.fromOffset(100, 50),

					Text = "Portal",
					TextSize = 14,
					Font = Enum.Font.BuilderSans
				}
			}
		}
	end, target)

end