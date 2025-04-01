--[[

Creates a container for a list of elements.

]]

local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
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
		
		create "UIListLayout" {
			Padding = UDim.new(0, 8),

			props.list
		},

		props.layout,

		unpack(props)
	}
	
end

return layout