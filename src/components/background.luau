--[[

A basic background used to contain frames

]]

local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)

local create = vide.create

type background = vide.vFrame

local function background(props: background)
	return create "Frame" {

		Name = "Background",

		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = color("MainBackground"),

		props
	}
	
end

return background