local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local dropdown = require(script.Parent.Parent.components.dropdown)
local text_input = require(script.Parent.Parent.components.text_input)

return function(target)

	return vide.mount(function()
		local selected = vide.source(1)

		return dropdown {
			selected = selected,
			update_selected = selected,
			options = {
				"a",
				"b",
				"c"
			}
		}
	end, target)

end