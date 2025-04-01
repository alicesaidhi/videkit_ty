
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local color = require(script.Parent.Parent.util.color)
local padding = require(script.Parent.padding)

local create = vide.create
local source = vide.source
local changed = vide.changed
local spring = vide.spring
local read = vide.read

type can<T> = T | () -> T
type toggle = {
	toggled: can<boolean>,
	update_toggle: (new: boolean) -> ()
}

local function toggle(props: toggle)

	local toggled = props.toggled
	local update_toggle = props.update_toggle

	local gui_state = source(Enum.GuiState.Idle)

	local anim = spring(function()
		return if read(toggled) then UDim2.fromScale(1, 0.5) else UDim2.fromScale(0, 0.5)
	end, 0.2)

	return create "TextButton" {

		Size = UDim2.fromOffset(40, 20),

		BackgroundColor3 = spring(color("TableItem", function()
			return if toggled() then "Selected" else "Default"
		end), 0.1),

		changed("GuiState", gui_state),

		Activated = function()
			update_toggle(not read(toggled))
		end,

		create "UICorner" {
			CornerRadius = UDim.new(1)
		},

		create "UIStroke" {
			Color = spring(color("TableItem", function()
				return
				if gui_state() == Enum.GuiState.Press then "Pressed"	
				elseif gui_state() == Enum.GuiState.Hover then "Hover" elseif toggled() then "Selected" else "Default"
			end), 0.1),
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		},

		padding {
			x = UDim.new(0, 4),
			y = UDim.new()
		},

		create "Frame" {

			Size = spring(function()
				local scale = anim().X.Scale
				return
					if read(toggled) and scale < 0.5 or not read(toggled) and scale > 0.5 then UDim2.fromOffset(24, 14)
					else UDim2.fromOffset(14, 14)
			end, 0.15),
			Position = anim,
			AnchorPoint = spring(function()
				return if read(toggled) then Vector2.new(1, 0.5) else Vector2.new(0, 0.5)
			end, 0.2),

			BackgroundColor3 = color("BrightText"),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0)
			},

			ZIndex = 100
		},

		create "Frame" {

			Size = UDim2.new(1, 0, 0, 14),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0, 0.5),

			BackgroundColor3 = color(function()
				return if color() == "Dark" and toggled() or color() == "Light" and not toggled()
					then "Dark"
					else "Light"
			end),
			BackgroundTransparency = spring(function() 
				return if gui_state() ~= Enum.GuiState.Idle then 0.5 else 1
			end, 0.1),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0)
			},
		}

	}
	
end

return toggle