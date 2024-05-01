--[[

Component used to capture mouse data

]]


local container = require(script.Parent.container)
local portal = require(script.Parent.portal)

type can<T> = T | () -> T
type mouse = {
	position_changed: () -> Vector3
}

local function mouse(props: mouse)

	local position_changed = props.position_changed

	return portal {

		inherit_layout = false,

		container {
			Name = "MouseCapture",

			Size = UDim2.fromScale(1, 1),

			InputChanged = function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					position_changed(input.Position)
				end
			end
		}

	}
	
end

return mouse