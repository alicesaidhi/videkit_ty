
local vide = require(script.Parent.Parent.Parent.vide)
local list = require(script.Parent.list)
local radio_button = require(script.Parent.radio_button)

local indexes = vide.indexes
local read = vide.read

type can<T> = T | () -> T
type radio_list = {
	toggled: can<number>?,
	update_toggled: ((new: number) -> ())?,

	options: can<{Instance}>
}

local function radio_list(props: radio_list)
	local toggled = props.toggled
	local update_toggled = props.update_toggled or function() end
	local options = props.options

	return list {
		list = {Padding = UDim.new(0, 2)},

		indexes(function() return read(options) end, function(value, key)
			return radio_button {
				toggled = function()
					return read(toggled) == key
				end,
				update_toggled = function()
					update_toggled(key)
				end,

				value
			}
		end)

	}
end

return radio_list