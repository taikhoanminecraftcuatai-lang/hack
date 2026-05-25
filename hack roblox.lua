local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGUI"
screenGui.Parent = game.CoreGui

-- Nút mở
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Draggable = true  -- Kéo thả được ngay
openBtn.Parent = screenGui

Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- Menu chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.Visible = false
mainFrame.Draggable = true  -- Kéo thả được ngay
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.Parent = mainFrame

Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ MY TOOL"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -36, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

-- Content
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -56)
content.Position = UDim2.new(0, 8, 0, 48)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = content

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

-- Hàm tạo button
local function makeButton(text, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.Text = text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    btn.Parent = content
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)

    return btn
end

-- Toggle menu
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)
