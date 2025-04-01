--[[

Tabs allow for rendering multiple components in the same widget. This is
useful for splitting information

]]

local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
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
local spring = vide.spring
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

		list = {Padding = UDim.new()},

		row {
			list = {Padding = UDim.new()},

			layout = {	
				Size = UDim2.new(1, 0, 0, 24),
				AutomaticSize = Enum.AutomaticSize.None,

				BackgroundColor3 = color("Tab"),
				BackgroundTransparency = 0,

				ZIndex = 100
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
					Size = function()
						return if is_selected() then UDim2.new(0, 0, 1, 2) else UDim2.fromScale(0, 1)
					end,
					AutomaticSize = Enum.AutomaticSize.X,

					BackgroundColor3 = color(function()
						return if is_selected() then "MainBackground" else "Tab"
					end, function()
						return if gui_state() == Enum.GuiState.Hover then "Hover"
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
							top = UDim.new(0, 5)
						},

						text {
							TextSize = 14,
							TextColor3 = spring(color(function()
								return if is_selected() or gui_state() ~= Enum.GuiState.Idle
									then "BrightText"
									else "TitlebarText"
							end), 0.1),
							Text = function()
								return value().name
							end,
						},
					},

					create "Frame" {

						Size = UDim2.new(1, 0, 0, 2),

						BackgroundColor3 = color("RibbonTabTopBar"),
						BackgroundTransparency = spring(function()
							return if is_selected() then 0 else 1 
						end, 0.1)

					}
				}
			end)
		},

		background {

			Size = UDim2.fromScale(1, 1),

			create "UIStroke" {
				Color = color("Border")
			},

			switch(selected)(map)

		}

	}
	
end

return tabs