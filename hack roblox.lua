--========================
-- SIDHUB GUI (TRONG SUOT, THANH TRUOT, ICON)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Tạo GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SidHub"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

-- === ICON MỞ GUI (LUÔN HIỆN) ===
local iconBtn = Instance.new("TextButton")
iconBtn.Name = "IconBtn"
iconBtn.Parent = screenGui
iconBtn.Size = UDim2.new(0, 55, 0, 55)
iconBtn.Position = UDim2.new(0.02, 0, 0.5, -27)
iconBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
iconBtn.BackgroundTransparency = 0.1
iconBtn.Text = "⚡"
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.TextSize = 28
iconBtn.Font = Enum.Font.GothamBold
iconBtn.BorderSizePixel = 0

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = iconBtn

-- Hiệu ứng hover
iconBtn.MouseEnter:Connect(function()
    TweenService:Create(iconBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
end)
iconBtn.MouseLeave:Connect(function()
    TweenService:Create(iconBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)

-- === MAIN WINDOW (TRONG SUOT) ===
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 500, 0, 400)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.15
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BorderSizePixel = 0

-- Bo góc chính
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Viền sáng mỏng
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(100, 100, 130)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.6
mainStroke.Parent = mainFrame

-- === THANH TIÊU ĐỀ ===
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Parent = mainFrame
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.BackgroundTransparency = 0.3
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

-- Tên script
local titleText = Instance.new("TextLabel")
titleText.Parent = titleBar
titleText.Size = UDim2.new(1, -80, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = " SIDHUB"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Nút thu nhỏ thành icon (ẩn GUI, chỉ để icon)
local hideBtn = Instance.new("TextButton")
hideBtn.Parent = titleBar
hideBtn.Size = UDim2.new(0, 35, 1, 0)
hideBtn.Position = UDim2.new(1, -75, 0, 0)
hideBtn.BackgroundTransparency = 1
hideBtn.Text = "🗕"
hideBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
hideBtn.TextSize = 16
hideBtn.Font = Enum.Font.GothamBold
hideBtn.Parent = titleBar

-- Nút X (xoá hack - đóng hoàn toàn, chỉ để icon)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleBar
closeBtn.Size = UDim2.new(0, 35, 1, 0)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

-- === NỘI DUNG CHÍNH (CÓ THANH TRƯỢT) ===
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Parent = mainFrame
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.ScrollBarThickness = 5
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
contentFrame.ScrollBarImageTransparency = 0.5
contentFrame.BorderSizePixel = 0

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = contentFrame
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 8)

-- === HÀM TẠO NÚT ===
local function createButton(text, color, order)
    local btn = Instance.new("TextButton")
    btn.Parent = contentFrame
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 45, 65)
    btn.BackgroundTransparency = 0.3
    btn.Text = "  " .. text
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.LayoutOrder = order or 1

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn

    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(65, 65, 85)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3, BackgroundColor3 = color or Color3.fromRGB(45, 45, 65)}):Play()
    end)

    return btn
end

-- === STATUS BAR ===
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.Size = UDim2.new(1, 0, 0, 28)
statusBar.Position = UDim2.new(0, 0, 1, -28)
statusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
statusBar.BackgroundTransparency = 0.3
statusBar.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 12)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.Size = UDim2.new(1, -10, 1, 0)
statusText.Position = UDim2.new(0, 5, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = " READY"
statusText.TextColor3 = Color3.fromRGB(150, 255, 150)
statusText.TextSize = 11
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

-- === CHỨC NĂNG NÚT ===
-- Nút X: Xoá hack (đóng hoàn toàn GUI, chỉ để icon)
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    statusText.Text = " HACK DISABLED"
    task.wait(1)
    statusText.Text = " READY"
end)

-- Nút thu nhỏ: ẩn GUI, chỉ để icon
hideBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Icon: mở GUI
iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        statusText.Text = " GUI OPENED"
        task.wait(1)
        statusText.Text = " READY"
    end
end)
