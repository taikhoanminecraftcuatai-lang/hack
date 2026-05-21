--========================
-- SIDHUB GUI (LOADING BAR + CHI CO NUT X)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Tạo GUI chính
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SidHub"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

-- === LOADING SCREEN ===
local loadingFrame = Instance.new("Frame")
loadingFrame.Parent = screenGui
loadingFrame.Size = UDim2.new(0, 350, 0, 150)
loadingFrame.Position = UDim2.new(0.5, -175, 0.5, -75)
loadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
loadingFrame.BackgroundTransparency = 0.1
loadingFrame.BorderSizePixel = 0
loadingFrame.ZIndex = 10

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 12)
loadingCorner.Parent = loadingFrame

local loadingStroke = Instance.new("UIStroke")
loadingStroke.Color = Color3.fromRGB(80, 80, 120)
loadingStroke.Thickness = 1
loadingStroke.Transparency = 0.5
loadingStroke.Parent = loadingFrame

-- Tiêu đề loading
local loadingTitle = Instance.new("TextLabel")
loadingTitle.Parent = loadingFrame
loadingTitle.Size = UDim2.new(1, 0, 0, 40)
loadingTitle.Position = UDim2.new(0, 0, 0.2, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "SIDHUB"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextSize = 24
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.TextScaled = true

-- Thanh progress bar
local progressBarBg = Instance.new("Frame")
progressBarBg.Parent = loadingFrame
progressBarBg.Size = UDim2.new(0.8, 0, 0, 8)
progressBarBg.Position = UDim2.new(0.1, 0, 0.6, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressBarBg.BorderSizePixel = 0

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(1, 0)
progressBgCorner.Parent = progressBarBg

local progressFill = Instance.new("Frame")
progressFill.Parent = progressBarBg
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
progressFill.BorderSizePixel = 0

local progressFillCorner = Instance.new("UICorner")
progressFillCorner.CornerRadius = UDim.new(1, 0)
progressFillCorner.Parent = progressFill

-- Text loading
local loadingText = Instance.new("TextLabel")
loadingText.Parent = loadingFrame
loadingText.Size = UDim2.new(1, 0, 0, 20)
loadingText.Position = UDim2.new(0, 0, 0.8, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "LOADING... 0%"
loadingText.TextColor3 = Color3.fromRGB(180, 180, 200)
loadingText.TextSize = 12
loadingText.Font = Enum.Font.Gotham

-- === ICON MỞ GUI ===
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
iconBtn.Visible = false

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = iconBtn

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

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

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

local titleText = Instance.new("TextLabel")
titleText.Parent = titleBar
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = " SIDHUB"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left

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

-- === HÀM TẠO NÚT (ĐỂ SAU THÊM) ===
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

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1, BackgroundColor3 = Color3.fromRGB(65, 65, 85)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3, BackgroundColor3 = color or Color3.fromRGB(45, 45, 65)}):Play()
    end)

    return btn
end

-- === HIỆU ỨNG LOADING ===
local function animateLoading()
    local steps = {10, 25, 45, 60, 75, 90, 95, 99, 100}
    local texts = {
        "INITIALIZING... 10%",
        "LOADING MODULES... 25%",
        "CONFIGURING GUI... 45%",
        "ESTABLISHING CONNECTION... 60%",
        "LOADING FEATURES... 75%",
        "FINALIZING... 90%",
        "ALMOST DONE... 95%",
        "VERIFYING... 99%",
        "COMPLETE! 100%"
    }
    
    for i, percent in ipairs(steps) do
        local targetWidth = (percent / 100) * progressBarBg.AbsoluteSize.X
        TweenService:Create(progressFill, TweenInfo.new(0.1), {Size = UDim2.new(percent / 100, 0, 1, 0)}):Play()
        loadingText.Text = texts[i]
        task.wait(0.08)
    end
    
    task.wait(0.3)
    
    -- Ẩn loading, hiện GUI
    TweenService:Create(loadingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(loadingFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    loadingFrame.Visible = false
    
    iconBtn.Visible = true
    TweenService:Create(iconBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
    
    statusText.Text = " READY"
end

-- === CHỨC NĂNG NÚT ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    statusText.Text = " HACK DISABLED"
    task.wait(1)
    statusText.Text = " READY"
end)

iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

-- Chạy loading khi script được execute
animateLoading()
