local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local row = require(script.Parent.Parent.components.row)
local text = require(script.Parent.Parent.components.text)
local toggle = require(script.Parent.Parent.components.toggle)

return function(target)

	return vide.mount(function()
		local toggled = vide.source(false)
		return row {
			text {
				Text = "something something"
			},
			toggle {
				toggled = toggled,
				update_toggle = toggled
			}
		}
	end, target)

end