
local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local color = require(script.Parent.Parent.util.color)
local padding = require(script.Parent.padding)

local create = vide.create
local source = vide.source
local changed = vide.changed
local spring = vide.spring
local read = vide.read

type can<T> = T | () -> T
type text_input = {
	
	text: can<string>?,
	update_text: ((new: string) -> ())?,
	focus_lost: ((new: string, enter_pressed: boolean) -> ())?, 

	placeholder: can<string>?,
	
	multi_line: can<boolean>?,

	disabled: can<boolean>?,

	layout: vide.vTextBox?

}

local function text_input(props: text_input)
	
	local text = props.text or ""
	local update_text = props.update_text or function() end
	local focus_lost = props.focus_lost
	local multi_line = props.multi_line
	local disabled = props.disabled

	local raw_text = source("")
	local gui_state = source(Enum.GuiState.Idle)
	local focused = source(false)

	return create "TextBox" {

		Size = UDim2.fromOffset(200, 24),
		AutomaticSize = function()
			return if read(multi_line) then Enum.AutomaticSize.Y else Enum.AutomaticSize.None
		end,

		BackgroundColor3 = color("InputFieldBackground", function()
			return if read(disabled) then "Disabled" else "Default"
		end) ,

		TextColor3 = color("MainText", "Default"),
		PlaceholderColor3 = color("DimmedText", "Default"),
		Font = Enum.Font.SourceSans,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,

		ClipsDescendants = true,

		Text = text,
		MultiLine = multi_line,
		PlaceholderText = props.placeholder,

		Interactable = function()
			return not read(disabled)
		end,

		changed("GuiState", gui_state),
		changed("Text", raw_text),
		changed("Text", update_text),

		Focused = function()
			focused(true)
		end,

		FocusLost = function(enter)
			focused(false)
			if not focus_lost then return end
			focus_lost(raw_text(), enter)
		end,

		create "UIStroke" {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = spring(color("InputFieldBorder", function()
				return if focused() then "Selected" 
					elseif gui_state() == Enum.GuiState.NonInteractable then "Disabled"
					elseif gui_state() == Enum.GuiState.Press then "Pressed"
					elseif gui_state() == Enum.GuiState.Hover then "Hover"
					else "Default"
			end), 0.1)
		},

		create "UICorner" {
			CornerRadius = UDim.new(0, 3)
		},

		padding {
			x = UDim.new(0, 5),
			y = UDim.new(0, 5)
		},

		props.layout

	}
	
end

return text_input