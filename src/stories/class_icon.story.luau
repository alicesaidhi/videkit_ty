local vide = require(script.Parent.Parent.Parent.vide)
local class_icon = require(script.Parent.Parent.components.class_icon)
local row = require(script.Parent.Parent.components.row)

return function(target)

	return vide.mount(function()
		return row {
			class_icon {
				class = "Instance"
			},
			class_icon {
				class = "Model"
			},
			class_icon {
				class = "Part"
			},
			class_icon {
				class = "Script"
			},
			class_icon {
				class = "IntValue"
			},
			class_icon {
				class = "Actor"
			},
			class_icon {
				class = "Workspace"
			},
			class_icon {
				class = "ModuleScript"
			},
			

		}
	end, target)

end