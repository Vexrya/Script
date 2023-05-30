local LibraryName = "Notification Library"
local NotificationLibrary = {}
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local library
local templateFolder
local canvas

function NotificationLibrary:Load()
    library = game:GetObjects("rbxassetid://12149165324")[1]
    templateFolder = library.Templates
    canvas = library.list
    library.Name = LibraryName
    library.Parent = CoreGui
end

function NotificationLibrary:Notify(config)
    local libaryCore = CoreGui:FindFirstChild(LibraryName)
    if not CoreGui:FindFirstChild(LibraryName) then
        NotificationLibrary:Load()
    else
        library = libaryCore
        templateFolder = library.Templates
        canvas = library.list
    end

    local title = config.Title or ""
    local content = config.Content or ""
    local duration = config.Duration or 5

    task.spawn(function()
        local success, err = pcall(function()
            local Notification = templateFolder:WaitForChild("Default"):Clone()
            local filler = Notification.Filler
            local bar = Notification.bar

            Notification.Header.Text = title
            Notification.Content.Text = content

            Notification.Visible = true
            Notification.Parent = canvas

            Notification.Size = UDim2.new(0, 0, 0.087, 0)
            filler.Size = UDim2.new(1, 0, 1, 0)

            local T1 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local T2 = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local T3 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            TweenService:Create(Notification, T1, {Size = UDim2.new(1, 0, 0.087, 0)}):Play()
            task.wait(0.2)
            TweenService:Create(filler, T3, {Size = UDim2.new(0.011, 0, 1, 0)}):Play()

            TweenService:Create(bar, T2, {Size = UDim2.new(1, 0, 0.05, 0)}):Play()

            task.wait(duration)

            TweenService:Create(filler, T1, {Size = UDim2.new(1, 0, 1, 0)}):Play()
            task.wait(0.25)
            TweenService:Create(Notification, T3, {Size = UDim2.new(0, 0, 0.087, 0)}):Play()
            task.wait(0.25)
            Notification:Destroy()
        end)

        if not success then
            warn("There was an error while trying to create a notification!")
            warn(err)
        end
    end)
end

return NotificationLibrary
