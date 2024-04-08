local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)
local padding = require(script.Parent.padding)

local create = vide.create

type props = { [any]: any }

local function shadow(props: props)
	return create "ImageLabel" {

		Name = "Shadow",

		Size = UDim2.new(),
		AutomaticSize = Enum.AutomaticSize.XY,

		BackgroundTransparency = 1,

		Image = "rbxasset://textures/StudioSharedUI/dropShadow.png",
		ImageColor3 = color("DropShadow"),
		ImageTransparency = 0.7,

		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(8, 8, 8, 8),
		SliceScale = 0.5,

		padding {
			padding = UDim.new(0, 3)
		},

		props,
	}
end

return shadow
