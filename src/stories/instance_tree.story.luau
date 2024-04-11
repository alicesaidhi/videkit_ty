local vide = require(script.Parent.Parent.Parent.vide)
local tree = require(script.Parent.Parent.components.instance_tree)

return function(target)
	return vide.mount(function()

		local selected = vide.source({})
		local function update_selected(object: Instance, new)
			selected()[object] = if new then true else nil
			selected(selected())
		end

		return tree {
			instances = {workspace, game.ServerStorage},
			layout = {},

			selected = selected,
			update_selected = update_selected
		}
	end, target)

end