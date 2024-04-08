--[[

rounded_frame is a special kind of frame with UICorner controls for every
single corner.

]]

local vide = require(script.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type rounded_frame = {
	topleft: can<UDim>?,
	topright: can<UDim>?,
	bottomleft: can<UDim>?,
	bottomright: can<UDim>?,

	color: can<Color3>?,

	layout: vide.vFrame,

	[number]: Instance,
}

local function rounded_frame(props: rounded_frame)
	local topleft = props.topleft or UDim.new()
	local topright = props.topright or UDim.new()
	local bottomleft = props.bottomleft or UDim.new()
	local bottomright = props.bottomright or UDim.new()

	local function corner(name: string, position: UDim2, anchor_point: Vector2, udim: can<UDim>)
		return create "Frame" {
			Name = name,

			Size = function()
				return UDim2.new(read(udim), read(udim))
			end,
			Position = position,
			AnchorPoint = anchor_point,

			BackgroundTransparency = 1,
			ClipsDescendants = true,

			create "Frame" {
				Name = "TopLeft",
	
				Size = UDim2.fromScale(2, 2),
				Position = UDim2.fromScale(-anchor_point.X, -anchor_point.Y),
	
				BackgroundColor3 = props.color,
				ClipsDescendants = true,
	
				create "UICorner" {
					CornerRadius = udim
				}
			}

		}
	end

	return create "Frame" {

		Name = "RoundedFrame",

		BackgroundTransparency = 1,

		corner("TopLeft", UDim2.fromScale(0, 0), Vector2.new(0, 0), topleft),
		corner("TopRight", UDim2.fromScale(1, 0), Vector2.new(1, 0), topright),
		corner("BottomLeft", UDim2.fromScale(0, 1), Vector2.new(0, 1), bottomleft),
		corner("BottomRight", UDim2.fromScale(1, 1), Vector2.new(1, 1), bottomright),
		
		create "Frame" {
			
			Name = "FrameLeft",

			Size = function()
				return UDim2.new(
					0.5,
					0,
					1 - read(topleft).Scale - read(bottomleft).Scale,
					- (read(topleft).Offset + read(bottomleft).Offset)
				)
			end,
			Position = function()
				return UDim2.new(
					0, 0,
					0.5 + read(topleft).Scale / 2 - read(bottomleft).Scale / 2,
					0 + read(topleft).Offset / 2 - read(bottomleft).Offset / 2
				)
			end,
			AnchorPoint = Vector2.new(0, 0.5),

			BackgroundColor3 = props.color,
		},

		create "Frame" {
			
			Name = "FrameRight",

			Size = function()
				return UDim2.new(
					0.5,
					0,
					1 - read(topright).Scale - read(bottomright).Scale,
					- (read(topright).Offset + read(bottomright).Offset)
				)
			end,
			Position = function()
				return UDim2.new(
					1, 0,
					0.5 + read(topright).Scale / 2 - read(bottomright).Scale / 2,
					0 + read(topright).Offset - read(bottomright).Offset
				)
			end,
			AnchorPoint = Vector2.new(1, 0.5),

			BackgroundColor3 = props.color,
		},

		create "Frame" {
			
			Name = "FrameTop",

			Size = function()
				return UDim2.new(
					1 - read(topleft).Scale - read(topright).Scale,
					- (read(topleft).Offset + read(topright).Offset),
					0.5,
					0
				)
			end,
			Position = function()
				return UDim2.new(
					0.5 + read(topleft).Scale / 2 - read(topright).Scale / 2,
					0 + read(topleft).Offset / 2 - read(topright).Offset / 2,
					0, 0
				)
			end,
			AnchorPoint = Vector2.new(0.5, 0),

			BackgroundColor3 = props.color,
		},

		create "Frame" {
			
			Name = "FrameBottom",

			Size = function()
				return UDim2.new(
					1 - read(bottomleft).Scale - read(bottomright).Scale,
					- (read(bottomleft).Offset + read(bottomright).Offset),
					0.5,
					0
				)
			end,
			Position = function()
				return UDim2.new(
					0.5 + read(bottomleft).Scale / 2 - read(bottomright).Scale / 2,
					0 + read(bottomleft).Offset / 2 - read(bottomright).Offset / 2,
					1, 0
				)
			end,
			AnchorPoint = Vector2.new(0.5, 1),

			BackgroundColor3 = props.color,
		},

		container {
			unpack(props)
		},

		props.layout

	}
	
end

return rounded_frame