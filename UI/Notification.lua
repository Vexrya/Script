local Notification = Instance.new("ScreenGui")
Notification.Name = "Notification"
Notification.DisplayOrder = 10
Notification.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Name = "Frame"
Frame.Parent = Notification
Frame.AnchorPoint = Vector2.new(0.5, 1)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.BackgroundTransparency = 0.8
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.5, 0, 1, -10)
Frame.Size = UDim2.new(0, 200, 0, 80)
Frame.ZIndex = 10
Frame.ClipsDescendants = true

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = Frame
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 10, 0, 5)
TitleLabel.Size = UDim2.new(1, -20, 0, 25)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.Text = "XeyHub X Notification"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.TextWrapped = true

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "TextLabel"
TextLabel.Parent = Frame
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 10, 0, 30)
TextLabel.Size = UDim2.new(1, -20, 1, -35)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "Welcome. Loading script."
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 14
TextLabel.TextWrapped = true

Notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

wait(10) -- Durée d'affichage de la notification (10 secondes)

Notification:Destroy()
