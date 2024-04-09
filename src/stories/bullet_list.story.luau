local vide = require(script.Parent.Parent.Parent.vide)
local bullet_list = require(script.Parent.Parent.components.bullet_list)
local button = require(script.Parent.Parent.components.button)
local text_input = require(script.Parent.Parent.components.text_input)

return function(target)

	return vide.mount(function()
		return bullet_list {
			list = {
				"one",
				"good point",
				
				text_input {
					multi_line = true
				},

				"excellent!",

				button {
					text = "meow"
				},
				
			}
		}
	end, target)

end