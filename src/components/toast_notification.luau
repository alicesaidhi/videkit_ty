--todo: make this better
local Players = game:GetService("Players")

local vide = require(script.Parent.Parent.Parent.vide)
local color = require(script.Parent.Parent.util.color)
local background = require(script.Parent.background)
local button = require(script.Parent.button)
local image = require(script.Parent.image)
local list = require(script.Parent.list)
local padding = require(script.Parent.padding)
local row = require(script.Parent.row)
local text = require(script.Parent.text)

local create = vide.create
local spring = vide.spring
local root = vide.root
local cleanup = vide.cleanup
local source = vide.source
local changed = vide.changed
local indexes = vide.indexes

local function create_mounting()
	return root(function()
		local ok, parent = pcall(game.GetService, game, "CoreGui")

		if not ok then parent = Players.LocalPlayer.PlayerGui end

		return create "ScreenGui" {

			Parent = parent,
			Name = "ToastNotifications",

			create "UIListLayout" {
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = UDim.new(0, 8)
			},

			padding {}
		}
	end)
end

local function get_mounting()
	shared._toast_mount_plugin = shared._toast_mount_plugin or create_mounting()
	return shared._toast_mount_plugin
end

type can<T> = T | () -> T
type toast_notification = {
	icon: string?,
	message: string,
	alive_for: number,

	actions: {
		{
			text: string,
			primary: boolean?,
			activated: () -> ()
		}
	}?
}

local function toast_notification(props: toast_notification)
	
	vide.root(function(destroy)

		local cleaning_up = source(false)
		local absolute_size = source(Vector2.new(0, 0))
		local function size_and_padding()
			return absolute_size() + Vector2.new(0, 8)
		end

		local spring_size = spring(function()
			return if cleaning_up() then Vector2.zero else size_and_padding()
		end, 0.2)

		local function stop()
			if cleaning_up() then return end
			cleaning_up(true)
			task.wait(2)
			destroy()
		end

		task.delay(props.alive_for, stop)

		cleanup(create "Frame" {

			Name = "ToastContainer",

			Parent = get_mounting(),
			Size = function()
				return if cleaning_up() then UDim2.fromOffset(0, spring_size().Y)
					else UDim2.fromOffset(0, size_and_padding().Y)
			end,
			
			BackgroundTransparency = 1,

			background {

				Name = "Toast",
	
				Size = UDim2.fromOffset(0, 0),
				AutomaticSize = Enum.AutomaticSize.XY,

				Position = spring(function()
					return if cleaning_up() then UDim2.fromOffset(16, 0) else UDim2.fromScale(0, 0)
				end, 0.2),
				AnchorPoint = spring(function()
					return if cleaning_up() then Vector2.new(0, 0) else Vector2.new(1, 0)
				end, 0.2),

				changed("AbsoluteSize", absolute_size),
		
				padding {
					padding = UDim.new(0, 8)
				},

				create "UIStroke" {
					Color = color("Border")
				},

				create "UICorner" {
					CornerRadius = UDim.new(0, 4)
				},

				list {

					row {
						layout = {Name = "TextContainer"},
						list = {VerticalAlignment = Enum.VerticalAlignment.Center},

						if props.icon then
							image {
								Image = props.icon,

								create "UICorner" {CornerRadius = UDim.new(0, 4)}
							}
						else nil,
						if props.message then text {
							Text = props.message,
							TextWrapped = false
						} else nil
					},
					if props.actions then
						row {
							layout = {Name = "Actions"},
							list = {
								HorizontalAlignment = Enum.HorizontalAlignment.Right
							},
							indexes(source(props.actions), function(value, key)
								return button {
									layout = {
										Size = UDim2.new(),
										AutomaticSize = Enum.AutomaticSize.XY
									},
									primary = value().primary,
									text = value().text,
									activated = function()
										value().activated(stop)
									end
								}
							end)	
						}
					else nil
				}
		
			}

		})
	end)

end

return toast_notification