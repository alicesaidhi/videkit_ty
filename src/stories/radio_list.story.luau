local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local background = require(script.Parent.Parent.components.background)
local radio_list = require(script.Parent.Parent.components.radio_list)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()
		local toggled = vide.source(1)
		return radio_list {
			toggled = toggled,
			update_toggled = toggled,
			
			options = {
				text {Text = "grapes"},
				text {Text = "apples"},
				text {Text = "bananas"},
				
			}
		}
	end, target)

end