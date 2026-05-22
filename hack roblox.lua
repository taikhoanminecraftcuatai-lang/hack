--========================
-- SIDHUB PREMIUM (FIXED)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- === KEY SYSTEM ===
local correctKey = "tailovuong"
local whitelist = { ["sidbuddb"] = true }
local keyEntered = false

if not whitelist[player.Name] then
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeySystem"
    keyGui.Parent = game.CoreGui
    
    local keyFrame = Instance.new("Frame")
    keyFrame.Parent = keyGui
    keyFrame.Size = UDim2.new(0, 340, 0, 220)
    keyFrame.Position = UDim2.new(0.5, -170, 0.5, -110)
    keyFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
    keyFrame.BackgroundTransparency = 0.05
    keyFrame.BorderSizePixel = 0
    
    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 14)
    keyCorner.Parent = keyFrame
    
    local keyTitle = Instance.new("TextLabel")
    keyTitle.Parent = keyFrame
    keyTitle.Size = UDim2.new(1, 0, 0, 55)
    keyTitle.Position = UDim2.new(0, 0, 0.12, 0)
    keyTitle.BackgroundTransparency = 1
    keyTitle.Text = " SIDHUB"
    keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyTitle.TextSize = 26
    keyTitle.Font = Enum.Font.GothamBold
    
    local keyBox = Instance.new("TextBox")
    keyBox.Parent = keyFrame
    keyBox.Size = UDim2.new(0.7, 0, 0, 42)
    keyBox.Position = UDim2.new(0.15, 0, 0.52, 0)
    keyBox.PlaceholderText = " INPUT KEY"
    keyBox.Text = ""
    keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 14
    keyBox.BorderSizePixel = 0
    
    local keyBoxCorner = Instance.new("UICorner")
    keyBoxCorner.CornerRadius = UDim.new(0, 10)
    keyBoxCorner.Parent = keyBox
    
    local submitBtn = Instance.new("TextButton")
    submitBtn.Parent = keyFrame
    submitBtn.Size = UDim2.new(0.4, 0, 0, 38)
    submitBtn.Position = UDim2.new(0.3, 0, 0.78, 0)
    submitBtn.Text = "UNLOCK"
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 14
    submitBtn.BorderSizePixel = 0
    submitBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 140)
    
    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = UDim.new(0, 10)
    submitCorner.Parent = submitBtn
    
    local keyStatus = Instance.new("TextLabel")
    keyStatus.Parent = keyFrame
    keyStatus.Size = UDim2.new(1, 0, 0, 25)
    keyStatus.Position = UDim2.new(0, 0, 0.92, 0)
    keyStatus.BackgroundTransparency = 1
    keyStatus.Text = " WAITING FOR KEY"
    keyStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
    keyStatus.TextSize = 11
    keyStatus.Font = Enum.Font.Gotham
    
    submitBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == correctKey then
            keyStatus.Text = " ACCESS GRANTED"
            keyStatus.TextColor3 = Color3.fromRGB(100, 255, 100)
            task.wait(0.5)
            keyGui:Destroy()
            keyEntered = true
        else
            keyStatus.Text = " INVALID KEY"
            keyStatus.TextColor3 = Color3.fromRGB(255, 80, 80)
            keyBox.Text = ""
            task.wait(1)
            keyStatus.Text = " WAITING FOR KEY"
            keyStatus.TextColor3 = Color3.fromRGB(255, 200, 100)
        end
    end)
    
    repeat task.wait() until keyEntered
else
    keyEntered = true
end

-- === GUI CHÍNH ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SidHub"
screenGui.Parent = game.CoreGui

-- === LOADING SCREEN ===
local loadingFrame = Instance.new("Frame")
loadingFrame.Parent = screenGui
loadingFrame.Size = UDim2.new(0, 350, 0, 140)
loadingFrame.Position = UDim2.new(0.5, -175, 0.5, -70)
loadingFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
loadingFrame.BackgroundTransparency = 0.05
loadingFrame.BorderSizePixel = 0

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 14)
loadingCorner.Parent = loadingFrame

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Parent = loadingFrame
loadingTitle.Size = UDim2.new(1, 0, 0, 40)
loadingTitle.Position = UDim2.new(0, 0, 0.15, 0)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "SIDHUB PREMIUM"
loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
loadingTitle.TextSize = 22
loadingTitle.Font = Enum.Font.GothamBold

local progressBarBg = Instance.new("Frame")
progressBarBg.Parent = loadingFrame
progressBarBg.Size = UDim2.new(0.8, 0, 0, 6)
progressBarBg.Position = UDim2.new(0.1, 0, 0.55, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
progressBarBg.BorderSizePixel = 0

local progressBgCorner = Instance.new("UICorner")
progressBgCorner.CornerRadius = UDim.new(1, 0)
progressBgCorner.Parent = progressBarBg

local progressFill = Instance.new("Frame")
progressFill.Parent = progressBarBg
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
progressFill.BorderSizePixel = 0

local loadingText = Instance.new("TextLabel")
loadingText.Parent = loadingFrame
loadingText.Size = UDim2.new(1, 0, 0, 20)
loadingText.Position = UDim2.new(0, 0, 0.75, 0)
loadingText.BackgroundTransparency = 1
loadingText.Text = "LOADING... 0%"
loadingText.TextColor3 = Color3.fromRGB(160, 160, 200)
loadingText.TextSize = 11
loadingText.Font = Enum.Font.Gotham

-- === ICON MỞ GUI ===
local iconBtn = Instance.new("TextButton")
iconBtn.Parent = screenGui
iconBtn.Size = UDim2.new(0, 50, 0, 50)
iconBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
iconBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
iconBtn.BackgroundTransparency = 0.1
iconBtn.Text = "⚡"
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.TextSize = 26
iconBtn.Font = Enum.Font.GothamBold
iconBtn.BorderSizePixel = 0
iconBtn.Visible = false
iconBtn.Draggable = true
iconBtn.Active = true

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = iconBtn

-- === MAIN WINDOW (CÓ THỂ KÉO) ===
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 550, 0, 470)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -235)
mainFrame.BackgroundColor3 = Color3.fromRGB(13, 13, 22)
mainFrame.BackgroundTransparency = 0.08
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- === HEADER ===
local headerFrame = Instance.new("Frame")
headerFrame.Parent = mainFrame
headerFrame.Size = UDim2.new(1, 0, 0, 55)
headerFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 35)
headerFrame.BackgroundTransparency = 0.2
headerFrame.BorderSizePixel = 0
headerFrame.Draggable = true
headerFrame.Active = true

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = headerFrame

local headerIcon = Instance.new("TextLabel")
headerIcon.Parent = headerFrame
headerIcon.Size = UDim2.new(0, 45, 1, 0)
headerIcon.Position = UDim2.new(0, 12, 0, 0)
headerIcon.BackgroundTransparency = 1
headerIcon.Text = "⚡"
headerIcon.TextColor3 = Color3.fromRGB(0, 180, 255)
headerIcon.TextSize = 28
headerIcon.Font = Enum.Font.GothamBold

local headerTitle = Instance.new("TextLabel")
headerTitle.Parent = headerFrame
headerTitle.Size = UDim2.new(1, -120, 1, 0)
headerTitle.Position = UDim2.new(0, 55, 0, 0)
headerTitle.BackgroundTransparency = 1
headerTitle.Text = "SIDHUB PREMIUM"
headerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
headerTitle.TextSize = 18
headerTitle.Font = Enum.Font.GothamBold
headerTitle.TextXAlignment = Enum.TextXAlignment.Left

-- NÚT X (ĐÓNG GUI)
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = headerFrame
closeBtn.Size = UDim2.new(0, 40, 1, 0)
closeBtn.Position = UDim2.new(1, -45, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 18
closeBtn.Font = Enum.Font.GothamBold

-- === TABS ===
local tabFrame = Instance.new("Frame")
tabFrame.Parent = mainFrame
tabFrame.Size = UDim2.new(1, 0, 0, 45)
tabFrame.Position = UDim2.new(0, 0, 0, 55)
tabFrame.BackgroundTransparency = 1

local tabs = {" COMBAT", " VISUAL", " MOVEMENT", " UTILITY"}
local tabButtons = {}
local contentContainers = {}

for i, tabName in ipairs(tabs) do
    local tab = Instance.new("TextButton")
    tab.Parent = tabFrame
    tab.Size = UDim2.new(0.25, 0, 1, 0)
    tab.Position = UDim2.new((i-1) * 0.25, 0, 0, 0)
    tab.Text = tabName
    tab.TextColor3 = Color3.fromRGB(180, 180, 220)
    tab.TextSize = 13
    tab.Font = Enum.Font.GothamSemibold
    tab.BackgroundTransparency = 1
    tab.BorderSizePixel = 0
    
    local indicator = Instance.new("Frame")
    indicator.Parent = tab
    indicator.Size = UDim2.new(0.6, 0, 0, 3)
    indicator.Position = UDim2.new(0.2, 0, 1, -3)
    indicator.BackgroundColor3 = Color3.fromRGB(0, 160, 255)
    indicator.BorderSizePixel = 0
    indicator.Visible = (i == 1)
    
    local container = Instance.new("ScrollingFrame")
    container.Parent = mainFrame
    container.Size = UDim2.new(1, -20, 1, -115)
    container.Position = UDim2.new(0, 10, 0, 105)
    container.BackgroundTransparency = 1
    container.CanvasSize = UDim2.new(0, 0, 0, 0)
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
    container.Visible = (i == 1)
    
    local containerLayout = Instance.new("UIListLayout")
    containerLayout.Parent = container
    containerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    containerLayout.Padding = UDim.new(0, 8)
    
    tabButtons[i] = {tab = tab, indicator = indicator, container = container, layout = containerLayout}
    contentContainers[i] = container
    
    tab.MouseButton1Click:Connect(function()
        for j, btn in pairs(tabButtons) do
            btn.indicator.Visible = (j == i)
            btn.tab.TextColor3 = (j == i) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 220)
            btn.container.Visible = (j == i)
        end
    end)
end

-- === STATUS BAR ===
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.Size = UDim2.new(1, 0, 0, 28)
statusBar.Position = UDim2.new(0, 0, 1, -28)
statusBar.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
statusBar.BackgroundTransparency = 0.3
statusBar.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 14)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.Size = UDim2.new(1, -15, 1, 0)
statusText.Position = UDim2.new(0, 12, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● SYSTEM READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 11
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- === HÀM TẠO NÚT TÍNH NĂNG ===
local function createFeatureButton(container, name, desc, icon)
    local btn = Instance.new("TextButton")
    btn.Parent = container
    btn.Size = UDim2.new(1, -10, 0, 52)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    btn.BackgroundTransparency = 0.3
    btn.Text = ""
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Parent = btn
    iconLabel.Size = UDim2.new(0, 45, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextSize = 22
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Parent = btn
    nameLabel.Size = UDim2.new(1, -120, 0, 22)
    nameLabel.Position = UDim2.new(0, 50, 0, 6)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Parent = btn
    descLabel.Size = UDim2.new(1, -120, 0, 18)
    descLabel.Position = UDim2.new(0, 50, 0, 28)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = Color3.fromRGB(140, 140, 170)
    descLabel.TextSize = 11
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton")
    toggle.Parent = btn
    toggle.Size = UDim2.new(0, 50, 0, 26)
    toggle.Position = UDim2.new(1, -60, 0.5, -13)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggle.TextSize = 11
    toggle.Font = Enum.Font.GothamBold
    toggle.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggle
    
    local active = false
    
    toggle.MouseButton1Click:Connect(function()
        active = not active
        if active then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            statusText.Text = "● " .. name .. " ENABLED"
            task.wait(1.5)
            statusText.Text = "● SYSTEM READY"
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
            statusText.Text = "● " .. name .. " DISABLED"
            task.wait(1.5)
            statusText.Text = "● SYSTEM READY"
        end
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.1}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.3}):Play()
    end)
    
    return btn
end

-- === THÊM TÍNH NĂNG VÀO TỪNG TAB ===
local combatContainer = tabButtons[1].container
local visualContainer = tabButtons[2].container
local movementContainer = tabButtons[3].container
local utilityContainer = tabButtons[4].container

createFeatureButton(combatContainer, "AIM LOCK", "Auto lock onto closest enemy", "🎯")
createFeatureButton(combatContainer, "SILENT AIM", "Invisible aim assistance", "🔇")
createFeatureButton(combatContainer, "TRIGGER BOT", "Auto shoot when on target", "🔫")

createFeatureButton(visualContainer, "ESP PLAYER", "Show players through walls", "👁️")
createFeatureButton(visualContainer, "ESP ITEM", "Show lootable items", "📦")
createFeatureButton(visualContainer, "CHAMS", "Colored characters", "🌈")

createFeatureButton(movementContainer, "INFINITE JUMP", "Jump infinitely in air", "🦘")
createFeatureButton(movementContainer, "FLY", "Free flight mode", "✈️")
createFeatureButton(movementContainer, "SPEED HACK", "Increase walk speed", "⚡")

createFeatureButton(utilityContainer, "AUTO CLICKER", "Auto mouse clicker", "🖱️")
createFeatureButton(utilityContainer, "NO CLIP", "Walk through walls", "🚪")
createFeatureButton(utilityContainer, "FULL BRIGHT", "Remove shadows", "💡")

-- Cập nhật CanvasSize cho từng container
local function updateCanvas(container)
    local layout = container:FindFirstChildWhichIsA("UIListLayout")
    if layout then
        container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y)
    end
end

for _, tab in pairs(tabButtons) do
    tab.container.ChildAdded:Connect(function()
        task.wait(0.1)
        updateCanvas(tab.container)
    end)
    updateCanvas(tab.container)
end

-- === LOADING ANIMATION ===
local function animateLoading()
    local steps = {0, 15, 35, 55, 75, 90, 100}
    local texts = {
        "INITIALIZING... 0%",
        "LOADING CORE... 15%",
        "CONFIGURING GUI... 35%",
        "LOADING MODULES... 55%",
        "FINALIZING... 75%",
        "VERIFYING... 90%",
        "COMPLETE! 100%"
    }
    
    for i, percent in ipairs(steps) do
        TweenService:Create(progressFill, TweenInfo.new(0.15), {Size = UDim2.new(percent / 100, 0, 1, 0)}):Play()
        loadingText.Text = texts[i]
        task.wait(0.12)
    end
    
    task.wait(0.3)
    
    TweenService:Create(loadingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    TweenService:Create(loadingFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    task.wait(0.3)
    loadingFrame.Visible = false
    
    iconBtn.Visible = true
    TweenService:Create(iconBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.1}):Play()
end

-- === XỬ LÝ NÚT ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    statusText.Text = "● HACK DISABLED"
    task.wait(1)
    statusText.Text = "● SYSTEM READY"
end)

iconBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

animateLoading()
