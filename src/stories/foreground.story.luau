local vide = require(script.Parent.Parent.Parent.vide)
local foreground = require(script.Parent.Parent.components.foreground)

return function(target)

	return vide.mount(function()
		return foreground {}
	end, target)

end