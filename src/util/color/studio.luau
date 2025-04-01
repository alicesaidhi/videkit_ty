local vide = require(script.Parent.Parent.Parent.Parent.roblox_packages.vide)
local types = require(script.Parent.types)

local source = vide.source
local read = vide.read

local theme = source()

local function update_theme()
	theme(settings():GetService("Studio").Theme :: StudioTheme)
end

local connection

type can<T> = T | () -> T

return function(color: can<types.StudioColors>, modifier: can<types.StudioModifiers>)

	if not color then return theme().Name end

	if not connection then
		update_theme()
		connection = settings():GetService("Studio").ThemeChanged:Connect(update_theme)
	end

	return function()
		return theme():GetColor(Enum.StudioStyleGuideColor[read(color)], Enum.StudioStyleGuideModifier[read(modifier)])
	end
end :: ((can<types.StudioColors>, can<types.StudioModifiers>) -> () -> Color3) & () -> string