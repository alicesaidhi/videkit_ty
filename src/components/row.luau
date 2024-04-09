--[[

Creates a container used to fill items in a row.

]]

local vide = require(script.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)

local create = vide.create

type can<T> = T | () -> T
type layout = {
	list: vide.vUIListLayout?,
	layout: vide.vFrame?,

	[number]: Instance
}

local function layout(props: layout)
	return container {

		Size = UDim2.fromScale(1, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		
		create "UIListLayout" {
			Padding = UDim.new(0, 8),
			FillDirection = Enum.FillDirection.Horizontal,

			props.list
		},

		props.layout,

		unpack(props)
	}
	
end

return layout