
local vide = require(script.Parent.Parent.Parent.vide)
local tree = require(script.Parent.tree)

local source = vide.source

type can<T> = T | () -> T
type instance_tree = {
	instances: {Instance},
	
	selected: (() -> {[Instance]: true})?,
	update_selected: ((instance: Instance, state: boolean) -> ())?
}

local function instance_tree(props: instance_tree)
	
	local update_selected_callback = props.update_selected
	local selected = props.selected

	local function update_selected(state: boolean, new)
		if update_selected_callback then
			update_selected_callback(new.instance :: Instance, state)
		end
	end

	local function turn_children_into_elements(children: {Instance})
		debug.profilebegin("build tree")
		local elements = {}
		for i, child in children do
			elements[i] = {
				name = child.Name,
				instance = child,
				children = turn_children_into_elements(child:GetChildren()),
				
				update_selected = update_selected,
				selected = function()
					return if selected then selected()[child] or false else false
				end
			}
		end
		debug.profileend()
		return elements
	end
	
	return tree {
		elements = turn_children_into_elements(props.instances)
	}
end

return instance_tree