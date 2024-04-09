
local vide = require(script.Parent.Parent.Parent.vide)
local container = require(script.Parent.container)
local portal = require(script.Parent.portal)
local shadow = require(script.Parent.shadow)
local transparent_layer = require(script.Parent.transparent_layer)

local create = vide.create
local read = vide.read

type can<T> = T | () -> T
type popup = {
	enabled: can<boolean>,
	inherit_layout: can<boolean>?,

	[number]: Instance
}

local function popup(props: popup)
	
	local enabled = props.enabled

	local function transparency()
		return if read(enabled) then 0 else 1
	end

	return portal {
		inherit_layout = props.inherit_layout,

		create "TextButton" {
			Name = "Dim",

			Size = UDim2.fromScale(1, 1),
			
			BackgroundColor3 = Color3.new(),
			BackgroundTransparency = vide.spring(function()
				return transparency() / 2 + 0.5
			end, 0.15),

			Active = enabled,
			Interactable = enabled
		},

		transparent_layer {
			transparency = vide.spring(function()
				return transparency()
			end, 0.15),

			shadow {

				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
	
				container {
	
					unpack(props)
	
				}
	
			}
		}

	}
	
end

return popup