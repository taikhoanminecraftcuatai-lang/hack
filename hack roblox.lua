--========================
-- MINI GUI + AIM LOCK PRO
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

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

-- === MAIN WINDOW (KHÔNG THANH TIÊU ĐỀ) ===
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

-- === KHU VỰC NỘI DUNG ===
local content = Instance.new("ScrollingFrame")
content.Parent = mainFrame
content.Size = UDim2.new(1, -20, 1, -50)
content.Position = UDim2.new(0, 10, 0, 42)
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
-- Version: 5.0
-- Tác giả: Sidbuddb
-- Mô tả: Tự động khóa camera vào đầu người chơi gần nhất
-- Độ chính xác: Cực cao, không rung, lock cứng
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH AIM LOCK ====================
local AimLockConfig = {
    Enabled = false,
    MaxDistance = 300,              -- Khoảng cách tối đa (studs)
    PriorityMode = "Closest",       -- "Closest" (gần nhất) hoặc "LowestHealth" (ít máu)
    AimPart = "Head",               -- "Head", "UpperTorso", "HumanoidRootPart"
    LockSmoothness = 0,             -- 0 = lock cứng (không rung), 1-10 = lock mượt
    LockSpeed = 0.3,                -- Tốc độ lock mượt (chỉ dùng khi LockSmoothness > 0)
    VerticalOffset = 0,             -- Độ lệch dọc (studs) - thường để 0
    HorizontalOffset = 0,           -- Độ lệch ngang (studs)
    CheckLineOfSight = false,       -- Kiểm tra vật cản (tường, chướng ngại)
    AutoSwitchTarget = true,        -- Tự động chuyển target khi target hiện tại chết
    IgnoreTeam = false,             -- Bỏ qua đồng đội
    ShowDistance = false,           -- Hiển thị khoảng cách (debug)
    ShowTargetName = false,         -- Hiển thị tên target (debug)
    ToggleKey = Enum.KeyCode.K,     -- Phím bật/tắt (K)
}

-- ==================== BIẾN TOÀN CỤC ====================
local AimLockState = {
    IsActive = false,
    CurrentTarget = nil,
    CurrentDistance = 0,
    LockConnection = nil,
    LastUpdateTime = 0,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetDistance(pointA, pointB)
    return (pointA - pointB).Magnitude
end

local function GetHealthPercent(humanoid)
    if not humanoid then return 100 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

-- Kiểm tra target có hợp lệ không
local function IsValidTarget(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == player then return false end
    
    -- Kiểm tra team (nếu bật)
    if AimLockConfig.IgnoreTeam and targetPlayer.Team and player.Team then
        if targetPlayer.Team == player.Team then return false end
    end
    
    local character = targetPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    
    -- Kiểm tra bộ phận aim
    local aimPart = character:FindFirstChild(AimLockConfig.AimPart)
    if not aimPart then
        aimPart = character:FindFirstChild("Head")
        if not aimPart then return false end
    end
    
    return true, humanoid, aimPart
end

-- Lấy vị trí cần aim
local function GetAimPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return nil end
    
    local aimPart = targetPlayer.Character:FindFirstChild(AimLockConfig.AimPart)
    if not aimPart then
        aimPart = targetPlayer.Character:FindFirstChild("Head")
        if not aimPart then return nil end
    end
    
    if not aimPart:IsA("BasePart") then return nil end
    
    local position = aimPart.Position
    position = position + Vector3.new(AimLockConfig.HorizontalOffset, AimLockConfig.VerticalOffset, 0)
    return position
end

-- Kiểm tra vật cản (line of sight)
local function HasLineOfSight(targetPosition)
    if not AimLockConfig.CheckLineOfSight then return true end
    
    local camera = workspace.CurrentCamera
    if not camera then return true end
    
    local origin = camera.CFrame.Position
    local direction = (targetPosition - origin).Unit
    local distance = (origin - targetPosition).Magnitude
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character, workspace.CurrentCamera}
    
    local result = workspace:Raycast(origin, direction * distance, raycastParams)
    
    if result then
        local hitDistance = (origin - result.Position).Magnitude
        return hitDistance >= distance - 2
    end
    
    return true
end

-- ==================== TÌM MỤC TIÊU ====================
-- Tìm người gần nhất
local function FindClosestPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPos = myRoot.Position
    local closestPlayer = nil
    local shortestDistance = AimLockConfig.MaxDistance + 1
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local isValid = IsValidTarget(otherPlayer)
            if isValid then
                local otherChar = otherPlayer.Character
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local distance = GetDistance(myPos, otherRoot.Position)
                    if distance < shortestDistance and distance <= AimLockConfig.MaxDistance then
                        -- Kiểm tra vật cản
                        local aimPos = GetAimPosition(otherPlayer)
                        if aimPos and HasLineOfSight(aimPos) then
                            shortestDistance = distance
                            closestPlayer = otherPlayer
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer, shortestDistance
end

-- Tìm người ít máu nhất (trong khoảng cách cho phép)
local function FindLowestHealthPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPos = myRoot.Position
    local lowestHealthPlayer = nil
    local lowestHealth = 101
    local lowestDistance = AimLockConfig.MaxDistance + 1
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local isValid, humanoid = IsValidTarget(otherPlayer)
            if isValid then
                local otherChar = otherPlayer.Character
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local distance = GetDistance(myPos, otherRoot.Position)
                    if distance <= AimLockConfig.MaxDistance then
                        local healthPercent = GetHealthPercent(humanoid)
                        if healthPercent < lowestHealth then
                            lowestHealth = healthPercent
                            lowestHealthPlayer = otherPlayer
                            lowestDistance = distance
                        end
                    end
                end
            end
        end
    end
    
    return lowestHealthPlayer, lowestDistance
end

-- Tìm target dựa trên chế độ ưu tiên
local function FindBestTarget()
    if AimLockConfig.PriorityMode == "Closest" then
        return FindClosestPlayer()
    elseif AimLockConfig.PriorityMode == "LowestHealth" then
        return FindLowestHealthPlayer()
    end
    return FindClosestPlayer()
end

-- ==================== KHÓA CAMERA ====================
-- Lock cứng (không rung, không mượt)
local function LockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    
    local cameraPos = camera.CFrame.Position
    local newCFrame = CFrame.new(cameraPos, targetPosition)
    camera.CFrame = newCFrame
    
    return true
end

-- Lock mượt (có tween, giảm rung)
local function LockCameraSmooth(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPosition)
    local newCF = currentCF:Lerp(targetCF, AimLockConfig.LockSpeed)
    camera.CFrame = newCF
    
    return true
end

-- Hàm lock chính
local function LockOntoTarget(targetPlayer)
    if not targetPlayer then return false end
    
    local aimPosition = GetAimPosition(targetPlayer)
    if not aimPosition then return false end
    
    if AimLockConfig.LockSmoothness <= 0 then
        return LockCameraHard(aimPosition)
    else
        return LockCameraSmooth(aimPosition)
    end
end

-- ==================== KIỂM TRA TARGET ====================
-- Kiểm tra target hiện tại còn hợp lệ không
local function IsCurrentTargetValid()
    if not AimLockState.CurrentTarget then return false end
    return IsValidTarget(AimLockState.CurrentTarget)
end

-- Tìm target mới (ưu tiên gần nhất)
local function SwitchToNewTarget()
    local newTarget, distance = FindBestTarget()
    if newTarget then
        AimLockState.CurrentTarget = newTarget
        AimLockState.CurrentDistance = distance
        
        if AimLockConfig.ShowTargetName then
            print("[AIM LOCK] New target: " .. newTarget.Name .. " (" .. math.floor(distance) .. " studs)")
        end
        return true
    end
    AimLockState.CurrentTarget = nil
    return false
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function UpdateAimLock()
    if not AimLockState.IsActive then return end
    
    -- Kiểm tra target hiện tại
    local targetValid = IsCurrentTargetValid()
    
    -- Nếu target không hợp lệ hoặc chết, tìm target mới
    if not targetValid then
        SwitchToNewTarget()
    end
    
    -- Nếu target hợp lệ, lock vào
    if AimLockState.CurrentTarget then
        LockOntoTarget(AimLockState.CurrentTarget)
        
        -- Hiển thị khoảng cách (nếu bật debug)
        if AimLockConfig.ShowDistance then
            local myChar = player.Character
            local targetChar = AimLockState.CurrentTarget.Character
            if myChar and targetChar then
                local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                if myRoot and targetRoot then
                    local dist = GetDistance(myRoot.Position, targetRoot.Position)
                    if math.floor(dist) ~= math.floor(AimLockState.CurrentDistance) then
                        AimLockState.CurrentDistance = dist
                    end
                end
            end
        end
    end
end

-- Khởi động vòng lặp
local function StartAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
    end
    AimLockState.LockConnection = RunService.RenderStepped:Connect(UpdateAimLock)
end

-- Dừng vòng lặp
local function StopAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
        AimLockState.LockConnection = nil
    end
    AimLockState.CurrentTarget = nil
end

-- ==================== BẬT/TẮT AIM LOCK ====================
local function EnableAimLock()
    if AimLockState.IsActive then return end
    
    -- Tìm target ngay khi bật
    SwitchToNewTarget()
    
    AimLockState.IsActive = true
    StartAimLock()
    
    print("[AIM LOCK] ENABLED - Mode: " .. AimLockConfig.PriorityMode)
end

local function DisableAimLock()
    if not AimLockState.IsActive then return end
    
    AimLockState.IsActive = false
    StopAimLock()
    
    print("[AIM LOCK] DISABLED")
end

local function ToggleAimLock()
    if AimLockState.IsActive then
        DisableAimLock()
    else
        EnableAimLock()
    end
end

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupHotkey()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == AimLockConfig.ToggleKey then
            ToggleAimLock()
            -- Hiển thị thông báo
            local notif = Instance.new("TextLabel")
            notif.Parent = game.CoreGui
            notif.Size = UDim2.new(0, 150, 0, 35)
            notif.Position = UDim2.new(0.5, -75, 0.85, 0)
            notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            notif.BackgroundTransparency = 0.4
            notif.TextColor3 = AimLockState.IsActive and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
            notif.Font = Enum.Font.GothamBold
            notif.TextSize = 12
            notif.Text = AimLockState.IsActive and "🔒 AIM LOCK ON" or "🔓 AIM LOCK OFF"
            notif.TextStrokeTransparency = 0.3
            Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
            task.wait(1)
            notif:Destroy()
        end
    end)
end

-- ==================== XỬ LÝ RESPAWN ====================
local function OnCharacterRespawn()
    if AimLockState.IsActive then
        task.wait(0.5)
        SwitchToNewTarget()
    end
end

player.CharacterAdded:Connect(OnCharacterRespawn)

-- ==================== XỬ LÝ NGƯỜI CHƠI RỜI GAME ====================
local function OnPlayerRemoving(leavingPlayer)
    if AimLockState.IsActive and AimLockState.CurrentTarget == leavingPlayer then
        SwitchToNewTarget()
    end
end

Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- ==================== KHỞI TẠO ====================
local function InitializeAimLock()
    SetupHotkey()
    print("=" .. string.rep("=", 50))
    print("AIM LOCK PRO MAX LOADED SUCCESSFULLY!")
    print("Version: 5.0")
    print("Features:")
    print("  - Priority: " .. AimLockConfig.PriorityMode)
    print("  - Max Distance: " .. AimLockConfig.MaxDistance .. " studs")
    print("  - Aim Part: " .. AimLockConfig.AimPart)
    print("  - Hotkey: " .. tostring(AimLockConfig.ToggleKey))
    print("  - Lock Style: " .. (AimLockConfig.LockSmoothness == 0 and "HARD (No Shake)" or "SMOOTH"))
    print("=" .. string.rep("=", 50))
    
    -- Trả về hàm toggle để gán vào nút GUI
    return {
        toggle = ToggleAimLock,
        enable = EnableAimLock,
        disable = DisableAimLock,
        isEnabled = function() return AimLockState.IsActive end,
        setConfig = function(newConfig)
            for k, v in pairs(newConfig) do
                if AimLockConfig[k] ~= nil then
                    AimLockConfig[k] = v
                end
            end
        end
    }
end

-- Khởi tạo và export
local AimLock = InitializeAimLock()
-- Ví dụ gán vào nút GUI:
local myButton = Instance.new("TextButton")
myButton.Text = "AIM LOCK"
myButton.MouseButton1Click:Connect(function()
    AimLock.toggle()
end)
