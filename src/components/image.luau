
local vide = require(script.Parent.Parent.Parent.vide)

local create = vide.create

type can<T> = T | () -> T
type image = vide.vImageLabel

local function image(props: image)
	
	return create "ImageLabel" {

		Name = "Image",
		
		Size = UDim2.fromOffset(64, 64),

		BackgroundTransparency = 1,

		props

	}
	
end

return image