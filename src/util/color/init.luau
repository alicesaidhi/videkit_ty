--[[

color/init.lua
utility function to get a stored color based on Studio's themeing.

usage:

```lua
create "Frame" {
	BackgroundColor3 = color("MainBackground")
}
```

]]

local RunService = game:GetService("RunService")

local studio = require(script.studio)
local types = require(script.types)

type can<T> = T | () -> T

return function(name: can<types.StudioColors>, modifier: can<types.StudioModifiers>?)
	if RunService:IsStudio() then
		if not name then return studio() end
		return studio(name, modifier or "Default")
	end

	return error("unsupported outside of studio")
end :: ((name: can<types.StudioColors>, modifier: can<types.StudioModifiers>?) -> () -> Color3) & () -> string