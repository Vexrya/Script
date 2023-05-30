local NotificationLibrary = {}

local NotificationTemplate = Instance.new("ScreenGui")
NotificationTemplate.Name = "NotificationTemplate"
NotificationTemplate.IgnoreGuiInset = true
NotificationTemplate.ResetOnSpawn = false

local NotificationFrame = Instance.new("Frame")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.BackgroundTransparency = 0.9
NotificationFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
NotificationFrame.BorderColor3 = Color3.fromRGB(20, 20, 20)
NotificationFrame.BorderSizePixel = 1
NotificationFrame.Position = UDim2.new(1, -320, 0, 20)
NotificationFrame.Size = UDim2.new(0, 300, 0, 80)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 10)
TitleLabel.Size = UDim2.new(1, -20, 0, 25)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = ""
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "TextLabel"
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 10, 0, 40)
TextLabel.Size = UDim2.new(1, -20, 1, -50)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = ""
TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
TextLabel.TextSize = 16
TextLabel.TextWrapped = true

NotificationFrame.Parent = NotificationTemplate
TitleLabel.Parent = NotificationFrame
TextLabel.Parent = NotificationFrame

function NotificationLibrary:CreateNotification(title, text, duration)
	local notification = NotificationTemplate:Clone()
	local frame = notification.NotificationFrame
	local titleLabel = frame.TitleLabel
	local textLabel = frame.TextLabel

	titleLabel.Text = title
	textLabel.Text = text

	notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	frame:TweenPosition(UDim2.new(1, -320, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)

	wait(duration)

	frame:TweenPosition(UDim2.new(1, 10, 0, 20), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.5, true)

	wait(0.5)

	notification:Destroy()
end

return NotificationLibrary
