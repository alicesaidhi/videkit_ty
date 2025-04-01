local RunService = game:GetService("RunService")

local vide = require(script.Parent.Parent.Parent.roblox_packages.vide)
local color = require(script.Parent.Parent.util.color)

local create = vide.create
local source = vide.source
local cleanup = vide.cleanup

type can<T> = T | () -> T
type progress_circle = vide.vFrame

local DARK = Color3.fromRGB(11, 90, 175)
local HIGHLIGHT = Color3.fromRGB(0, 162, 255)
local color_sequence = ColorSequence.new(
	{
		ColorSequenceKeypoint.new(0, DARK),
		ColorSequenceKeypoint.new(0.001, HIGHLIGHT),
		ColorSequenceKeypoint.new(0.4, HIGHLIGHT),
		ColorSequenceKeypoint.new(0.6, DARK),
		ColorSequenceKeypoint.new(1, DARK),
		
	}
)

local function loading_circle(props: progress_circle)
	
	local rotation = source(0)
	
	cleanup(RunService.Heartbeat:Connect(function(dt)
		rotation(rotation() + dt * 360)
	end))

	return create "Frame" {

		Size = UDim2.fromOffset(64, 64),

		BackgroundTransparency = 1,

		create "Frame" {

			Size = UDim2.fromOffset(32, 32),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			
			BackgroundColor3 = Color3.new(1, 1, 1),

			create "UICorner" {
				CornerRadius = UDim.new(1, 0)
			},

			create "UIGradient" {
				Color = color_sequence,
				Rotation = rotation,
			}

		},

		create "Frame" {

			Size = UDim2.fromOffset(24, 24),
			Position = UDim2.fromScale(0.5, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
	
			BackgroundColor3 = color("MainBackground"),
	
			
	
			create "UICorner" {
				CornerRadius = UDim.new(1, 0)
			}
	
		},

	}

end

return loading_circle