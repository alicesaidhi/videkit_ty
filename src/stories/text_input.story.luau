local vide = require(script.Parent.Parent.Parent.vide)
local list = require(script.Parent.Parent.components.list)
local text_input = require(script.Parent.Parent.components.text_input)

return function(target)

	return vide.mount(function()

		local text_limited = vide.source("")

		return list {

			text_input {
				placeholder = "Unlimited"
			},

			text_input {
				text = text_limited,
				update_text = function(input: string)
					input = string.sub(input, 1, 6)
					print(input, text_limited())
					text_limited(input)
				end,
				focus_lost = function(input, enter)
					input = string.sub(input, 1, 6)
					text_limited("")
					text_limited(input)
				end,

				placeholder = "Limited"
			},

			text_input {
				multi_line = true,
				placeholder = "Multiline",
			},

			text_input {
				disabled = true,
				placeholder = "Disabled",
			},

		}
	end, target)

end