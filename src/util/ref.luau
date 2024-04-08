local vide = require(script.Parent.Parent.Parent.vide)

local function ref(value: (Instance) -> ())
	return vide.action(value)
end

return ref