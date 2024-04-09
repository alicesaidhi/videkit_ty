local StudioService = game:GetService("StudioService")

local vide = require(script.Parent.Parent.Parent.vide)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type class_icon = {
	class: can<string>,
	layout: vide.vImageLabel?
}

local function class_icon(props: class_icon)

	local class = props.class

	local function class_icon_data(): {Image: string, ImageRectOffset: Vector2, ImageRectSize: Vector2}
		return StudioService:GetClassIcon(read(class))
	end

	return create "ImageLabel" {

		Size = UDim2.fromOffset(16, 16),

		BackgroundTransparency = 1,

		Image = function()
			return class_icon_data().Image
		end,
		ImageRectOffset = function()
			return class_icon_data().ImageRectOffset
		end,
		ImageRectSize = function()
			return class_icon_data().ImageRectSize
		end,
		ScaleType = Enum.ScaleType.Crop,
		ResampleMode = Enum.ResamplerMode.Pixelated,

		props.layout

	}
	
end

return class_icon