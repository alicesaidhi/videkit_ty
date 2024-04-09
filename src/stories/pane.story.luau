local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local padding = require(script.Parent.Parent.components.padding)
local pane = require(script.Parent.Parent.components.pane)
local text = require(script.Parent.Parent.components.text)

return function(target)

	return vide.mount(function()
		return background {

			padding {},

			pane {
				title = "Test",
	
				text {
					Text = "wack"
				}
			}

		}
	end, target)

end