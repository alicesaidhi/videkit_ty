local vide = require(script.Parent.Parent.Parent.vide)
local background = require(script.Parent.Parent.components.background)
local loading_circle = require(script.Parent.Parent.components.loading_circle)

return function(target)

	return vide.mount(function()
		return loading_circle {}
	end, target)

end