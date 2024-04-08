local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)

return function(target)

	return vide.mount(function()
		return background {}
	end, target)

end