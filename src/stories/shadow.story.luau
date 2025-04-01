local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local foreground = require(script.Parent.Parent.components.foreground)
local shadow = require(script.Parent.Parent.components.shadow)

return function(target)

	return vide.mount(function()
		return shadow {

			foreground {
				Size = UDim2.fromOffset(100, 50)
			}

		}
	end, target)

end