local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local button = require(script.Parent.Parent.components.button)
local list = require(script.Parent.Parent.components.list)
local text_input = require(script.Parent.Parent.components.text_input)
local toast_notification = require(script.Parent.Parent.components.toast_notification)

return function(target)
	
	return vide.mount(function()
		
		local text = vide.source("")
		local icon = vide.source("")
		local alive_for = vide.source(3)

		return list {

			text_input {
				text = text,
				update_text = text,

				placeholder = "Text",
				multi_line = true
			},

			text_input {
				text = icon,
				update_text = icon,

				placeholder = "rbxassetid://"
			},

			text_input {
				text = alive_for,
				update_text = function(input)
					alive_for(tonumber(input) or 0)
				end,
			},

			button {
				text = "Create Toast",

				activated = function()
					print(icon())
					toast_notification {
						message = text(),
						icon = icon() ~= "" and icon() or nil,
						alive_for = alive_for(),
					}
				end
			}

		}

	end, target)

end