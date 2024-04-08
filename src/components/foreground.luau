--[[

A basic background used to contain frames

]]

local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)

local create = vide.create

type background = vide.vFrame

local function background(props: background)
	return create "Frame" {

		Name = "Foreground",

		Size = UDim2.fromScale(1, 1),

		BackgroundColor3 = color("Tab", "Default"),

		props
	}
	
end

return background