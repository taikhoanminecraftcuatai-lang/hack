--========================
-- MINI GUI PRO + AIM LOCK (CHUYÊN NGHIỆP)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- === TẠO GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MiniGUIPro"
screenGui.Parent = game.CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- === NÚT MỞ GUI (CÓ HIỆU ỨNG) ===
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenBtn"
openBtn.Parent = screenGui
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -27)
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
openBtn.BackgroundTransparency = 0.15
openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 28
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Draggable = true
openBtn.Active = true

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- Hiệu ứng hover
openBtn.MouseEnter:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 70), BackgroundTransparency = 0.05}):Play()
end)
openBtn.MouseLeave:Connect(function()
    TweenService:Create(openBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 42), BackgroundTransparency = 0.15}):Play()
end)

-- === MAIN WINDOW ===
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 280, 0, 380)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
mainFrame.BackgroundTransparency = 0.12
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.BorderSizePixel = 0

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(100, 100, 150)
mainStroke.Thickness = 1
mainStroke.Transparency = 0.6
mainStroke.Parent = mainFrame

-- === HEADER ===
local header = Instance.new("Frame")
header.Parent = mainFrame
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 0
header.Draggable = true
header.Active = true

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(1, -55, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ MINI GUI PRO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = header
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -36, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold

-- === KHU VỰC NỘI DUNG (SCROLLING) ===
local content = Instance.new("ScrollingFrame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -16, 1, -85)
content.Position = UDim2.new(0, 8, 0, 55)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 110)
content.BorderSizePixel = 0

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)

-- === STATUS BAR ===
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.Size = UDim2.new(1, 0, 0, 26)
statusBar.Position = UDim2.new(0, 0, 1, -26)
statusBar.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 14)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Parent = statusBar
statusText.Size = UDim2.new(1, -12, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 11
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left

-- === HÀM TẠO NÚT ===
local function createButton(text, icon, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(1, -10, 0, 48)
    btn.BackgroundColor3 = color or Color3.fromRGB(38, 38, 52)
    btn.BackgroundTransparency = 0.2
    btn.Text = ""
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Parent = btn
    iconLabel.Size = UDim2.new(0, 42, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.TextSize = 22
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = btn
    textLabel.Size = UDim2.new(1, -100, 0, 22)
    textLabel.Position = UDim2.new(0, 48, 0, 8)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(235, 235, 245)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Parent = btn
    statusLabel.Size = UDim2.new(1, -100, 0, 16)
    statusLabel.Position = UDim2.new(0, 48, 0, 28)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Click to toggle"
    statusLabel.TextColor3 = Color3.fromRGB(140, 140, 170)
    statusLabel.TextSize = 10
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = btn
    toggleBtn.Size = UDim2.new(0, 55, 0, 28)
    toggleBtn.Position = UDim2.new(1, -65, 0.5, -14)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    toggleBtn.TextSize = 11
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.BorderSizePixel = 0
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 8)
    toggleCorner.Parent = toggleBtn
    
    local isActive = false
    
    local function updateToggle()
        if isActive then
            toggleBtn.Text = "ON"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
            toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            statusLabel.Text = "● ACTIVE"
            statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        else
            toggleBtn.Text = "OFF"
            toggleBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 75)
            toggleBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
            statusLabel.Text = "Click to toggle"
            statusLabel.TextColor3 = Color3.fromRGB(140, 140, 170)
        end
    end
    
    toggleBtn.MouseButton1Click:Connect(function()
        isActive = not isActive
        updateToggle()
        if callback then
            callback(isActive)
        end
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05, BackgroundColor3 = Color3.fromRGB(50, 50, 68)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2, BackgroundColor3 = color or Color3.fromRGB(38, 38, 52)}):Play()
    end)
    
    updateToggle()
    return {btn = btn, toggle = toggleBtn, getActive = function() return isActive end}
end

--========================
-- AIM LOCK THỰC TẾ
--========================
local aimLockActive = false
local currentTarget = nil
local aimConnection = nil

-- Tìm người chơi gần nhất
local function findClosestPlayer()
    local character = player.Character
    if not character then return nil end
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local myPos = root.Position
    local closest = nil
    local closestDist = 300
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local otherChar = other.Character
            if otherChar then
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                local otherHead = otherChar:FindFirstChild("Head")
                local otherHum = otherChar:FindFirstChild("Humanoid")
                if otherRoot and otherHead and otherHum and otherHum.Health > 0 then
                    local dist = (myPos - otherRoot.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = other
                    end
                end
            end
        end
    end
    return closest
end

-- Lock camera vào đầu
local function lockOntoHead(target)
    if not target then return end
    local targetChar = target.Character
    if not targetChar then return end
    local head = targetChar:FindFirstChild("Head")
    if not head then return end
    
    local camera = workspace.CurrentCamera
    if camera then
        local cameraPos = camera.CFrame.Position
        camera.CFrame = CFrame.new(cameraPos, head.Position)
    end
end

-- Vòng lặp AIM LOCK
local function startAimLock()
    if aimConnection then aimConnection:Disconnect() end
    aimConnection = RunService.RenderStepped:Connect(function()
        if aimLockActive then
            local target = findClosestPlayer()
            if target then
                currentTarget = target
                lockOntoHead(target)
                statusText.Text = "● AIM LOCK: ON → " .. target.Name
            else
                statusText.Text = "● AIM LOCK: ON (NO TARGET)"
            end
        else
            if statusText.Text:find("AIM LOCK") then
                statusText.Text = "● READY"
            end
        end
    end)
end

-- Tạo nút AIM LOCK
local aimLockBtn = createButton("AIM LOCK", "🎯", Color3.fromRGB(70, 50, 110), function(active)
    aimLockActive = active
    if active then
        if not aimConnection then startAimLock() end
        statusText.Text = "● AIM LOCK: ACTIVATED"
    else
        currentTarget = nil
        statusText.Text = "● AIM LOCK: DEACTIVATED"
    end
    task.wait(1.5)
    if not aimLockActive then
        statusText.Text = "● READY"
    end
end)

-- === CẬP NHẬT CANVAS ===
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)
task.wait(0.2)
updateCanvas()

-- === XỬ LÝ MỞ/ĐÓNG ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        updateCanvas()
    end
end)

-- Cleanup khi nhân vật respawn
player.CharacterAdded:Connect(function()
    if aimLockActive then
        currentTarget = nil
    end
end)
