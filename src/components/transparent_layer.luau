--[[

transparent_layer is a special kind of component useful for doing transparency
animations. It uses an CanvasGroup to perform the animation, and if the transparency
is low enough (< 0.01) it will parent the given instances to an normal Frame, making
it render normally.

]]
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type transparent_layer = {
	transparency: can<number>,

	[number]: Instance
}

local function transparent_layer(props: transparent_layer)
	
	local transparency = props.transparency

	local canvas = create "CanvasGroup" {

		Name = "Canvas",

		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,
		GroupTransparency = transparency

	}
	local base = create "Frame" {

		Name = "TransparentLayer",

		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,

		canvas

	}

	local function parent()
		return if read(transparency) < 0.01 then base else canvas
	end

	create "Frame" {
		Parent = parent,

		Size = UDim2.fromScale(1, 1),

		BackgroundTransparency = 1,

		unpack(props)
	}

	return base
	
end

return transparent_layer