local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local radio_button = require(script.Parent.Parent.components.radio_button)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()
		local toggled = vide.source(false)
		return radio_button {
			toggled = toggled,
			update_toggled = toggled,
			
			text {
				Text = "testing"
			}
		}
	end, target)

end