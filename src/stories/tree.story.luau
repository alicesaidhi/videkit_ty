local vide = require(script.Parent.Parent.Parent.vide)
local tree = require(script.Parent.Parent.components.tree)

return function(target)

	local function create_elements(n: number)
		local t = {}

		for i = 1, n do
			local selected = vide.source(false)
			local elements = vide.source()

			t[i] = {
				name = `element {i}`,
				image = "rbxassetid://16976967730",
				children = function()
					if not elements() then
						elements(create_elements(1e3))
						return elements()
					else
						return elements()
					end
				end,
				can_expand = true,

				selected = selected,
				update_selected = selected
			}
		end

		return t
	end

	return vide.mount(function()
		return tree {
			elements = create_elements(1e5),
			layout = {}
		}
	end, target)

end