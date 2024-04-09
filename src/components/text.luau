--[[

Displays text

]]

local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)

local create = vide.create

type can<T> = T | () -> T
type text = vide.vTextLabel

local function text(props: text)
	return create "TextLabel" {

		Size = UDim2.new(),
		AutomaticSize = Enum.AutomaticSize.XY,

		BackgroundTransparency = 1,

		TextColor3 = color("MainText"),
		Font = Enum.Font.SourceSans,
		TextSize = 16,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,

		props

	}
	
end

return text