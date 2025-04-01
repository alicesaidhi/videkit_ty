
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local color = require(script.Parent.Parent.util.color)
local background = require(script.Parent.background)
local container = require(script.Parent.container)
local padding = require(script.Parent.padding)
local text = require(script.Parent.text)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type pane = {
	title: can<string>?,
	layout: vide.vFrame?,

	[number]: Instance
}

local function pane(props: pane)

	local title = props.title
	
	return background {

		Name = function()
			return `Pane:{read(title)}`
		end,

		Size = UDim2.new(1, 0, 0, 32),
		AutomaticSize = Enum.AutomaticSize.Y,

		props.layout,

		create "UIStroke" {Color = color("Border")},
		create "UICorner" {CornerRadius = UDim.new(0, 4)},

		background {
			Name = "Name",

			Size = UDim2.fromOffset(0, 0),
			Position = UDim2.fromOffset(6, 0),
			AutomaticSize = Enum.AutomaticSize.XY,
			AnchorPoint = Vector2.new(0, 0.5),

			padding {
				padding = UDim.new(0, 2)
			},

			create "UIListLayout" {
				VerticalAlignment = Enum.VerticalAlignment.Center
			},

			Visible = function() return not not title end,

			text {
				Text = title or "",
				TextSize = 14,
				TextColor3 = color("SubText")
			}

		},

		container {

			Name = "Container",

			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,

			padding {
				padding = UDim.new(0, 8),
				x = UDim.new(0, 12)
			},

			unpack(props)

		}

	}
	
end

return pane