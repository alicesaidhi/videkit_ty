local vide = require(script.Parent.Parent.Parent.vide)
local bullet_list = require(script.Parent.Parent.components.bullet_list)
local scroll_frame = require(script.Parent.Parent.components.scroll_frame)

return function(target)

	return vide.mount(function()
		local t = {}

		for i = 1, 100 do
			t[i] = tostring(i)
		end

		return scroll_frame {
			bullet_list {
				list = t
			}
		}
	end, target)

end