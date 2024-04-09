
local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)
local container = require(script.Parent.container)
local list = require(script.Parent.list)
local text = require(script.Parent.text)

local create = vide.create
local indexes = vide.indexes
local switch = vide.switch
local read = vide.read

type can<T> = T | () -> T
type bullet_list = {
	list: can<{string | Instance}>,
	layout: vide.vFrame?
}

local function bullet_list(props: bullet_list)
	
	local list_data = props.list

	return list {
		Name = "BulletList",
		
		Size = UDim2.new(),
		AutomaticSize = Enum.AutomaticSize.XY,

		indexes(function()
			return read(list_data)
		end, function(value, key)
			return container {
				Size = UDim2.new(1, 0, 0, 18),
				AutomaticSize = Enum.AutomaticSize.Y,

				create "ImageLabel" {
					Name = "Marker",
					
					BackgroundTransparency = 1,

					Position = UDim2.fromOffset(0, 7),
					Size = UDim2.fromOffset(4, 4),

					Image = "rbxasset://textures/StudioSharedUI/dot.png",
					ImageColor3 = color("MainText")
				},

				switch(function() return typeof(value()) end) {
					["string"] = function()
						return text {
							Name = "Content",
		
							Position = UDim2.fromOffset(16, -1),
							AutomaticSize = Enum.AutomaticSize.XY,
		
							Text = value
						}
					end,
					["Instance"] = function()
						return container {
							Name = "Content",

							Size = UDim2.new(),
							Position = UDim2.fromOffset(16, -1),
							AutomaticSize = Enum.AutomaticSize.XY,

							value
						}
					end
				}
			}
		end)
	}
	
end

return bullet_list