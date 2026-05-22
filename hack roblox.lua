--========================
-- MINI GUI + AIM LOCK PRO (SỬA LỖI)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- === TẠO GUI ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MiniGUI"
screenGui.Parent = game.CoreGui

-- === NÚT MỞ GUI ===
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
openBtn.Draggable = true
openBtn.Active = true

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- === MAIN WINDOW ===
local mainFrame = Instance.new("Frame")
mainFrame.Parent = screenGui
mainFrame.Size = UDim2.new(0, 260, 0, 320)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true
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

-- === NÚT ĐÓNG ===
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = mainFrame
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
closeBtn.BackgroundTransparency = 0.5
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 3

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeBtn

-- === TÊN GUI ===
local title = Instance.new("TextLabel")
title.Parent = mainFrame
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 12, 0, 8)
title.BackgroundTransparency = 1
title.Text = "⚡ MINI GUI"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 3

-- === KHU VỰC NỘI DUNG ===
local content = Instance.new("ScrollingFrame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -10, 1, -55)
content.Position = UDim2.new(0, 5, 0, 42)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 120)
content.BorderSizePixel = 0
content.ZIndex = 2

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)

-- === STATUS BAR ===
local statusBar = Instance.new("Frame")
statusBar.Parent = mainFrame
statusBar.Size = UDim2.new(1, 0, 0, 22)
statusBar.Position = UDim2.new(0, 0, 1, -22)
statusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.BorderSizePixel = 0
statusBar.ZIndex = 3

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
local function addButton(name, icon, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 55)
    btn.BackgroundTransparency = 0.2
    btn.Text = "   " .. icon .. "  " .. name
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamSemibold
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.ZIndex = 2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05, BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2, BackgroundColor3 = color or Color3.fromRGB(40, 40, 55)}):Play()
    end)
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end

--========================
-- AIM LOCK PRO MAX
--========================

-- ==================== CẤU HÌNH AIM LOCK ====================
local AimLockConfig = {
    Enabled = false,
    MaxDistance = 300,
    PriorityMode = "Closest",
    AimPart = "Head",
    LockSmoothness = 0,
    LockSpeed = 0.3,
    VerticalOffset = 0,
    HorizontalOffset = 0,
    CheckLineOfSight = false,
    AutoSwitchTarget = true,
    IgnoreTeam = false,
    ShowDistance = false,
    ShowTargetName = false,
    ToggleKey = Enum.KeyCode.K,
}

-- ==================== BIẾN TOÀN CỤC ====================
local AimLockState = {
    IsActive = false,
    CurrentTarget = nil,
    CurrentDistance = 0,
    LockConnection = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetDistance(pointA, pointB)
    return (pointA - pointB).Magnitude
end

local function IsValidTarget(targetPlayer)
    if not targetPlayer or targetPlayer == player then return false end
    
    if AimLockConfig.IgnoreTeam and targetPlayer.Team and player.Team then
        if targetPlayer.Team == player.Team then return false end
    end
    
    local character = targetPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    local aimPart = character:FindFirstChild(AimLockConfig.AimPart) or character:FindFirstChild("Head")
    if not aimPart then return false end
    
    return true, humanoid, aimPart
end

local function GetAimPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return nil end
    local aimPart = targetPlayer.Character:FindFirstChild(AimLockConfig.AimPart) or targetPlayer.Character:FindFirstChild("Head")
    if not aimPart or not aimPart:IsA("BasePart") then return nil end
    return aimPart.Position + Vector3.new(AimLockConfig.HorizontalOffset, AimLockConfig.VerticalOffset, 0)
end

-- ==================== TÌM MỤC TIÊU ====================
local function FindClosestPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0 end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPos = myRoot.Position
    local closestPlayer = nil
    local shortestDistance = AimLockConfig.MaxDistance + 1
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and IsValidTarget(otherPlayer) then
            local otherChar = otherPlayer.Character
            local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local distance = GetDistance(myPos, otherRoot.Position)
                if distance < shortestDistance and distance <= AimLockConfig.MaxDistance then
                    shortestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end
    return closestPlayer, shortestDistance
end

local function FindBestTarget()
    return FindClosestPlayer()
end

-- ==================== KHÓA CAMERA ====================
local function LockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    return true
end

local function LockOntoTarget(targetPlayer)
    if not targetPlayer then return false end
    local aimPosition = GetAimPosition(targetPlayer)
    if not aimPosition then return false end
    return LockCameraHard(aimPosition)
end

-- ==================== KIỂM TRA TARGET ====================
local function IsCurrentTargetValid()
    if not AimLockState.CurrentTarget then return false end
    return IsValidTarget(AimLockState.CurrentTarget)
end

local function SwitchToNewTarget()
    local newTarget, distance = FindBestTarget()
    if newTarget then
        AimLockState.CurrentTarget = newTarget
        AimLockState.CurrentDistance = distance
        return true
    end
    AimLockState.CurrentTarget = nil
    return false
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function UpdateAimLock()
    if not AimLockState.IsActive then return end
    
    if not IsCurrentTargetValid() then
        SwitchToNewTarget()
    end
    
    if AimLockState.CurrentTarget then
        LockOntoTarget(AimLockState.CurrentTarget)
    end
end

local function StartAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
    end
    AimLockState.LockConnection = RunService.RenderStepped:Connect(UpdateAimLock)
end

local function StopAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
        AimLockState.LockConnection = nil
    end
    AimLockState.CurrentTarget = nil
end

-- ==================== BẬT/TẮT AIM LOCK ====================
local function ToggleAimLock()
    AimLockState.IsActive = not AimLockState.IsActive
    
    if AimLockState.IsActive then
        SwitchToNewTarget()
        StartAimLock()
    else
        StopAimLock()
    end
end

-- ==================== PHÍM TẮT K ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        ToggleAimLock()
    end
end)

-- === XỬ LÝ RESPAWN ===
player.CharacterAdded:Connect(function()
    if AimLockState.IsActive then
        task.wait(0.5)
        SwitchToNewTarget()
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if AimLockState.IsActive and AimLockState.CurrentTarget == leavingPlayer then
        SwitchToNewTarget()
    end
end)

-- === THÊM NÚT AIM LOCK VÀO GUI ===
local aimBtn = addButton("AIM LOCK", "🎯", Color3.fromRGB(80, 50, 120), function()
    ToggleAimLock()
    if AimLockState.IsActive then
        statusText.Text = "● AIM LOCK: ON"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        aimBtn.Text = "     AIM LOCK [ON]"
    else
        statusText.Text = "● AIM LOCK: OFF"
        aimBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
        aimBtn.Text = "     AIM LOCK"
    end
    task.wait(1.5)
    statusText.Text = "● READY"
end)

-- === CẬP NHẬT CANVAS ===
local function updateCanvas()
    task.wait(0.05)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)
updateCanvas()

-- === XỬ LÝ MỞ/ĐÓNG ===
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
