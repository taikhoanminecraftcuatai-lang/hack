--========================
-- MINI GUI (SỬA LỖI KÉO)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Tạo GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MiniGUI"
screenGui.Parent = game.CoreGui

-- === NÚT MỞ GUI (CÓ THỂ KÉO) ===
local openBtn = Instance.new("TextButton")
openBtn.Parent = screenGui
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Draggable = true   -- Nút menu có thể kéo
openBtn.Active = true

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- === MAIN WINDOW (KÉO ĐƯỢC TOÀN BỘ) ===
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 300, 0, 350)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true      -- TOÀN BỘ MAINFRAME KÉO ĐƯỢC
mainFrame.Active = true
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 120)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.5
mainStroke.Parent = mainFrame

-- === HEADER (CHỈ LÀM ĐẸP, KHÔNG KÉO) ===
local header = Instance.new("Frame")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0
header.Draggable = false         -- KHÔNG CHO KÉO HEADER
header.Active = false

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ MINI GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 35, 1, 0)
closeBtn.Position = UDim2.new(1, -38, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold

-- === KHU VỰC NỘI DUNG ===
local content = Instance.new("ScrollingFrame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)

-- === STATUS BAR ===
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.Size = UDim2.new(1, 0, 0, 24)
statusBar.Position = UDim2.new(0, 0, 1, -24)
statusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 12)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.Size = UDim2.new(1, -10, 1, 0)
statusText.Position = UDim2.new(0, 8, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 10
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- === HÀM TẠO NÚT ===
local function addButton(name, icon, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.BackgroundTransparency = 0.2
    btn.Text = "   " .. icon .. "  " .. name
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05, BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2, BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
    end)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

-- === HÀM CẬP NHẬT CANVAS ===
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)

-- === XỬ LÝ MỞ/ĐÓNG ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    statusText.Text = "● HIDDEN"
    task.wait(0.5)
    statusText.Text = "● READY"
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
