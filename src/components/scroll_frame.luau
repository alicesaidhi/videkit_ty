
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local color = require(script.Parent.Parent.util.color)

local create = vide.create

type can<T> = T | () -> T
type scroll_frame = vide.vScrollingFrame

local function scroll_frame(props: scroll_frame)
	return create "ScrollingFrame" {

		Size = UDim2.fromScale(1, 1),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.XY,

		BackgroundTransparency = 1,

		ScrollBarThickness = 6,
		ScrollBarImageColor3 = color("SubText"),

		props

	}
	
end

return scroll_frame