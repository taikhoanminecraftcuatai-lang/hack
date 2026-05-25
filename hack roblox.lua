-- LocalScript trong StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Tạo button có thể kéo thả
local dragButton = Instance.new("TextButton")
dragButton.Size = UDim2.new(0, 50, 0, 50)
dragButton.Position = UDim2.new(0.5, -25, 0.5, -25)
dragButton.Text = "☰"
dragButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dragButton.TextColor3 = Color3.new(1, 1, 1)
dragButton.Parent = screenGui

-- Bo góc
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = dragButton

-- Tạo menu (ẩn mặc định)
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 200, 0, 150)
menu.Position = UDim2.new(0.5, -100, 0.5, -75)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.Visible = false
menu.Parent = screenGui

local menuCorner = Instance.new("UICorner")
menuCorner.Parent = menu

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0.3, 0)
label.Text = "Menu"
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1
label.Parent = menu

-- Bấm button để toggle menu
dragButton.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

-- Kéo thả button
local dragging, dragInput, dragStart, startPos

dragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = dragButton.Position
    end
end)

dragButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        dragButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
