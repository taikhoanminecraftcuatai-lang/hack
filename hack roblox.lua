-- LocalScript trong StarterPlayerScripts

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Button kéo thả
local dragButton = Instance.new("TextButton")
dragButton.Size = UDim2.new(0, 50, 0, 50)
dragButton.Position = UDim2.new(0, 100, 0, 100)
dragButton.Text = "🇻🇳"
dragButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
dragButton.TextColor3 = Color3.new(1, 1, 1)
dragButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = dragButton

-- Menu
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 200, 0, 150)
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

-- Cập nhật vị trí menu theo button
local function updateMenuPos()
    local bPos = dragButton.Position
    menu.Position = UDim2.new(
        bPos.X.Scale, bPos.X.Offset + 55,
        bPos.Y.Scale, bPos.Y.Offset
    )
end

-- Drag logic
local dragging = false
local wasDragged = false
local dragStart, startPos

dragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        wasDragged = false
        dragStart = input.Position
        startPos = dragButton.Position
    end
end)

dragButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
        -- Chỉ toggle menu nếu KHÔNG kéo
        if not wasDragged then
            menu.Visible = not menu.Visible
            updateMenuPos()
        end
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        -- Chỉ tính là "kéo" nếu di chuyển > 5px
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            wasDragged = true
        end
        dragButton.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
        if menu.Visible then
            updateMenuPos()
        end
    end
end)
