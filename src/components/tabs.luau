
local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)
local background = require(script.Parent.background)
local container = require(script.Parent.container)
local list = require(script.Parent.list)
local padding = require(script.Parent.padding)
local row = require(script.Parent.row)
local text = require(script.Parent.text)

local create = vide.create
local switch = vide.switch
local indexes = vide.indexes
local source = vide.source
local changed = vide.changed

type can<T> = T | () -> T
type tabs = {
	selected: () -> number,
	update_selected: (index: number) -> (),

	[number]: {
		name: string,
		child: () -> ()
	}
}

local function tabs(props: tabs)
	
	local selected = props.selected
	local update_selected = props.update_selected

	local map = {}

	for index, value in ipairs(props) do
		map[index] = value.child
	end

	return list {

		list = {Padding = UDim.new(), HorizontalAlignment = Enum.HorizontalAlignment.Right},

		row {
			list = {Padding = UDim.new()},

			layout = {	
				Size = UDim2.new(1, 0, 0, 24),

				BackgroundColor3 = color("Tab"),
				BackgroundTransparency = 0
			},

			create "UIStroke" {
				Color = color("Border")
			},
			
			indexes(function()
				return {unpack(props)} :: {{name: string, child: () -> ()}}
			end, function(value, key)

				local gui_state = source("Idle")

				local function is_selected()
					return key == selected()
				end

				return create "TextButton" {
					Size = UDim2.fromScale(0, 1),
					AutomaticSize = Enum.AutomaticSize.X,

					BackgroundColor3 = color("Tab", function()
						return if is_selected() then "Selected"
							elseif gui_state() == Enum.GuiState.Hover then "Hover"
							else "Default"
					end),

					changed("GuiState", gui_state),

					MouseButton1Down = function()
						update_selected(key)
					end,

					container {
						
						padding {
							x = UDim.new(0, 16),
							y = UDim.new(0, 4),
						},

						text {
							TextColor3 = color(function()
								return if is_selected() or gui_state() ~= Enum.GuiState.Idle then "BrightText" else "TitlebarText"
							end),
							TextSize = 14,
							Text = function()
								return value().name
							end,
						},
					},

					create "Frame" {

						Size = UDim2.new(1, 0, 0, 1),

						BackgroundColor3 = color("RibbonTabTopBar"),

						Visible = is_selected

					}
				}
			end)
		},

		background {

			Size = UDim2.new(1, -1, 1, 0),

			create "UIStroke" {
				Color = color("Border")
			},

			switch(selected)(map)

		}

	}
	
end

return tabs