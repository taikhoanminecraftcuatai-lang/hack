local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MAIN_GUI"
gui.Parent = game.CoreGui
gui.Enabled = false

local open = Instance.new("TextButton")
open.Parent = gui
open.Size = UDim2.new(0, 70, 0, 35)
open.Position = UDim2.new(0, 20, 0.5, -35)
open.Text = "MENU"
open.TextSize = 12
open.Font = Enum.Font.GothamBlack
open.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
open.TextColor3 = Color3.new(1, 1, 1)
open.BorderSizePixel = 0
open.Active = true
open.Draggable = true

Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 450, 0, 450)
frame.Position = UDim2.new(0.5, -225, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "TOOL HUB"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.new(1, 1, 1)

local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 40)
status.Position = UDim2.new(0, 0, 0.25, 0)
status.BackgroundTransparency = 1
status.Text = "STATUS : READY"
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.new(1, 1, 1)

local buttonContainer = Instance.new("Frame")
buttonContainer.Parent = frame
buttonContainer.Size = UDim2.new(1, -40, 0, 300)
buttonContainer.Position = UDim2.new(0, 20, 0.42, 0)
buttonContainer.BackgroundTransparency = 1

local correctKey = "tailovuong"
local whitelist = { ["sidbuddb"] = true }

local keyGui = Instance.new("ScreenGui")
keyGui.Parent = game.CoreGui

local keyFrame = Instance.new("Frame")
keyFrame.Parent = keyGui
keyFrame.Size = UDim2.new(0, 350, 0, 220)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0

Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 18)

local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 60)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "ENTER KEY"
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextColor3 = Color3.new(1, 1, 1)

local keyBox = Instance.new("TextBox")
keyBox.Parent = keyFrame
keyBox.Size = UDim2.new(0.8, 0, 0, 50)
keyBox.Position = UDim2.new(0.1, 0, 0.38, 0)
keyBox.PlaceholderText = "INPUT KEY..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.Font = Enum.Font.GothamBold
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BorderSizePixel = 0

Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 12)

local enter = Instance.new("TextButton")
enter.Parent = keyFrame
enter.Size = UDim2.new(0.5, 0, 0, 45)
enter.Position = UDim2.new(0.25, 0, 0.7, 0)
enter.Text = "UNLOCK"
enter.TextScaled = true
enter.Font = Enum.Font.GothamBlack
enter.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
enter.TextColor3 = Color3.new(1, 1, 1)
enter.BorderSizePixel = 0

Instance.new("UICorner", enter).CornerRadius = UDim.new(0, 12)

local keyStatus = Instance.new("TextLabel")
keyStatus.Parent = keyFrame
keyStatus.Size = UDim2.new(1, 0, 0, 30)
keyStatus.Position = UDim2.new(0, 0, 0.88, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = "STATUS : WAITING"
keyStatus.TextScaled = true
keyStatus.Font = Enum.Font.GothamBold
keyStatus.TextColor3 = Color3.new(1, 1, 1)

if whitelist[player.Name] then
    gui.Enabled = true
    keyGui.Enabled = false
end

enter.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        keyStatus.Text = "STATUS : ACCESS GRANTED"
        task.wait(0.5)
        keyGui:Destroy()
        gui.Enabled = true
    else
        keyStatus.Text = "STATUS : WRONG KEY"
        keyFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        task.wait(0.3)
        keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end
end)

open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

local function click(button)
    local old = button.Size
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = old - UDim2.new(0, 4, 0, 4)
        }):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = old
        }):Play()
    end)
end

click(open)
click(enter)

local function makeButton(text, row, col, color)
    local b = Instance.new("TextButton")
    b.Parent = buttonContainer
    b.Size = UDim2.new(0, 120, 0, 35)
    b.Position = UDim2.new(0, 10 + (col - 1) * 130, 0, 10 + (row - 1) * 45)
    b.Text = text
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    click(b)
    return b
end
--========================
-- SYSTEM: AIM LOCK PRO MAX
-- Version: 4.0
-- Tác giả: Sidbuddb
-- Mô tả: Tự động xoay camera vào đầu người chơi gần nhất
-- Tối ưu: Không rung, không lag, xử lý lỗi triệt để
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH AIM LOCK ====================
local AimLockConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    MaxDistance = 300,              -- Khoảng cách tối đa (studs)
    UpdateRate = 0.01,              -- Tốc độ cập nhật (giây)
    Priority = "Closest",           -- Ưu tiên: "Closest" hoặc "LowestHealth"
    AimPart = "Head",               -- Bộ phận aim: "Head", "UpperTorso", "HumanoidRootPart"
    
    -- Cài đặt camera
    LockSmoothness = 0,             -- 0 = lock cứng, 1-10 = lock mượt
    VerticalOffset = 0,             -- Độ lệch dọc (studs)
    HorizontalOffset = 0,           -- Độ lệch ngang (studs)
    
    -- Cài đặt phím tắt
    ToggleKey = Enum.KeyCode.K,     -- Phím bật/tắt
    ToggleKeyModifier = nil,        -- Phím kết hợp (Shift, Ctrl, Alt)
    
    -- Cài đặt hiển thị
    ShowDistance = false,           -- Hiển thị khoảng cách tới mục tiêu
    ShowTargetName = false,         -- Hiển thị tên mục tiêu
    ShowNotifications = true,       -- Hiển thị thông báo khi bật/tắt
    
    -- Cài đặt nâng cao
    IgnoreTeam = false,             -- Bỏ qua đồng đội (nếu game có team)
    IgnoreFriends = false,          -- Bỏ qua bạn bè
    AutoSwitchTarget = true,        -- Tự động chuyển mục tiêu khi target chết
    CheckLineOfSight = false,       -- Kiểm tra xem có vật cản không
    RequireToolEquipped = false,    -- Chỉ aim khi đang cầm tool
    AllowedTools = {},              -- Danh sách tool được phép aim (để trống là tất cả)
    
    -- Cài đặt thời gian
    TargetTimeout = 3.0,            -- Thời gian mất target nếu không thấy (giây)
    CooldownOnSwitch = 0.2,         -- Thời gian chờ khi chuyển mục tiêu (giây)
}

-- ==================== BIẾN TOÀN CỤC ====================
local AimState = {
    IsRunning = false,
    CurrentTarget = nil,
    LastTarget = nil,
    TargetSwitchTime = 0,
    LastUpdateTime = 0,
    LastDistance = 0,
    FailedAttempts = 0,
    LockConnection = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function IsPlayerValid(targetPlayer)
    -- Kiểm tra cơ bản
    if not targetPlayer then return false end
    if targetPlayer == player then return false end
    
    -- Kiểm tra đồng đội
    if AimLockConfig.IgnoreTeam and targetPlayer.Team and player.Team and targetPlayer.Team == player.Team then
        return false
    end
    
    -- Kiểm tra bạn bè
    if AimLockConfig.IgnoreFriends then
        local isFriend = false
        for _, friendId in pairs(player.Friends:GetFriends()) do
            if friendId == targetPlayer.UserId then
                isFriend = true
                break
            end
        end
        if isFriend then return false end
    end
    
    -- Kiểm tra nhân vật
    local character = targetPlayer.Character
    if not character then return false end
    
    -- Kiểm tra Humanoid
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    
    -- Kiểm tra bộ phận aim
    local aimPart = character:FindFirstChild(AimLockConfig.AimPart)
    if not aimPart then
        aimPart = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("HumanoidRootPart")
        if not aimPart then return false end
    end
    
    return true, humanoid, aimPart
end

local function GetDistanceBetweenPlayers(player1, player2)
    local char1 = player1.Character
    local char2 = player2.Character
    if not char1 or not char2 then return math.huge end
    
    local root1 = char1:FindFirstChild("HumanoidRootPart")
    local root2 = char2:FindFirstChild("HumanoidRootPart")
    if not root1 or not root2 then return math.huge end
    
    return (root1.Position - root2.Position).Magnitude
end

local function CheckLineOfSight(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera then return true end
    
    local origin = camera.CFrame.Position
    local direction = (targetPosition - origin).Unit
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character, workspace.CurrentCamera}
    
    local raycastResult = workspace:Raycast(origin, direction * AimLockConfig.MaxDistance, raycastParams)
    
    if raycastResult then
        local hitDistance = (origin - raycastResult.Position).Magnitude
        local targetDistance = (origin - targetPosition).Magnitude
        return hitDistance >= targetDistance - 2
    end
    
    return true
end

-- ==================== HÀM TÌM MỤC TIÊU ====================
local function FindClosestPlayer()
    local myCharacter = player.Character
    if not myCharacter then return nil, math.huge end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, math.huge end
    
    local closestTarget = nil
    local closestDistance = AimLockConfig.MaxDistance + 1
    local myPosition = myRoot.Position
    
    -- Kiểm tra tool nếu cần
    if AimLockConfig.RequireToolEquipped then
        local hasTool = false
        for _, tool in pairs(myCharacter:GetChildren()) do
            if tool:IsA("Tool") then
                if #AimLockConfig.AllowedTools == 0 then
                    hasTool = true
                    break
                else
                    for _, allowed in pairs(AimLockConfig.AllowedTools) do
                        if tool.Name:lower():find(allowed:lower()) then
                            hasTool = true
                            break
                        end
                    end
                end
            end
        end
        if not hasTool then return nil, math.huge end
    end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        local isValid, humanoid, aimPart = IsPlayerValid(otherPlayer)
        if isValid and aimPart then
            local distance = (myPosition - aimPart.Position).Magnitude
            if distance < closestDistance and distance <= AimLockConfig.MaxDistance then
                if AimLockConfig.CheckLineOfSight then
                    if CheckLineOfSight(aimPart.Position) then
                        closestDistance = distance
                        closestTarget = otherPlayer
                    end
                else
                    closestDistance = distance
                    closestTarget = otherPlayer
                end
            end
        end
    end
    
    return closestTarget, closestDistance
end

local function FindLowestHealthPlayer()
    local lowestHealthTarget = nil
    local lowestHealth = 101
    local closestDistance = AimLockConfig.MaxDistance + 1
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if not myRoot then return nil, math.huge end
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        local isValid, humanoid, aimPart = IsPlayerValid(otherPlayer)
        if isValid and humanoid then
            local distance = (myRoot.Position - aimPart.Position).Magnitude
            if distance <= AimLockConfig.MaxDistance then
                local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100
                if healthPercent < lowestHealth then
                    lowestHealth = healthPercent
                    lowestHealthTarget = otherPlayer
                    closestDistance = distance
                elseif healthPercent == lowestHealth and distance < closestDistance then
                    lowestHealthTarget = otherPlayer
                    closestDistance = distance
                end
            end
        end
    end
    
    return lowestHealthTarget, closestDistance
end

local function FindTarget()
    if AimLockConfig.Priority == "Closest" then
        return FindClosestPlayer()
    elseif AimLockConfig.Priority == "LowestHealth" then
        return FindLowestHealthPlayer()
    end
    return FindClosestPlayer()
end

-- ==================== HÀM LOCK CAMERA ====================
local function GetAimPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return nil end
    
    local aimPart = targetPlayer.Character:FindFirstChild(AimLockConfig.AimPart)
    if not aimPart then
        aimPart = targetPlayer.Character:FindFirstChild("Head") or 
                  targetPlayer.Character:FindFirstChild("UpperTorso") or 
                  targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    end
    
    if not aimPart then return nil end
    
    local position = aimPart.Position
    position = position + Vector3.new(AimLockConfig.HorizontalOffset, AimLockConfig.VerticalOffset, 0)
    
    return position
end

local function LockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    
    local cameraPos = camera.CFrame.Position
    local newCFrame = CFrame.new(cameraPos, targetPosition)
    camera.CFrame = newCFrame
    
    return true
end

local function LockCameraSmooth(targetPosition, smoothness)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    
    local currentCFrame = camera.CFrame
    local targetCFrame = CFrame.new(currentCFrame.Position, targetPosition)
    
    local alpha = math.min(1, smoothness or (AimLockConfig.LockSmoothness / 10))
    local newCFrame = currentCFrame:Lerp(targetCFrame, alpha)
    camera.CFrame = newCFrame
    
    return true
end

local function LockCamera(targetPlayer)
    if not targetPlayer then return false end
    
    local aimPosition = GetAimPosition(targetPlayer)
    if not aimPosition then return false end
    
    if AimLockConfig.LockSmoothness <= 0 then
        return LockCameraHard(aimPosition)
    else
        return LockCameraSmooth(aimPosition)
    end
end

-- ==================== HÀM XỬ LÝ TRẠNG THÁI ====================
local function UpdateAimState()
    local currentTime = GetCurrentTime()
    
    -- Kiểm tra thời gian cooldown
    if currentTime - AimState.TargetSwitchTime < AimLockConfig.CooldownOnSwitch then
        return
    end
    
    -- Tìm mục tiêu mới
    local newTarget, distance = FindTarget()
    
    -- Kiểm tra xem có nên chuyển mục tiêu không
    local shouldSwitch = false
    
    if not AimState.CurrentTarget then
        shouldSwitch = true
    elseif not IsPlayerValid(AimState.CurrentTarget) then
        shouldSwitch = true
    elseif AimLockConfig.AutoSwitchTarget then
        local currentDistance = GetDistanceBetweenPlayers(player, AimState.CurrentTarget)
        if distance < currentDistance - 20 then
            shouldSwitch = true
        end
    end
    
    if shouldSwitch and newTarget then
        AimState.LastTarget = AimState.CurrentTarget
        AimState.CurrentTarget = newTarget
        AimState.TargetSwitchTime = currentTime
        AimState.LastDistance = distance
        
        if AimLockConfig.ShowTargetName then
            status.Text = "AIMING: " .. newTarget.Name
        end
    end
    
    -- Thực hiện lock
    if AimState.CurrentTarget and IsPlayerValid(AimState.CurrentTarget) then
        LockCamera(AimState.CurrentTarget)
        AimState.FailedAttempts = 0
        
        if AimLockConfig.ShowDistance then
            local currentDistance = GetDistanceBetweenPlayers(player, AimState.CurrentTarget)
            if currentDistance ~= AimState.LastDistance then
                -- Có thể cập nhật hiển thị ở đây
            end
        end
    else
        AimState.CurrentTarget = nil
        AimState.FailedAttempts = AimState.FailedAttempts + 1
    end
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function StartAimLockLoop()
    if AimState.LockConnection then
        AimState.LockConnection:Disconnect()
        AimState.LockConnection = nil
    end
    
    AimState.LockConnection = RunService.RenderStepped:Connect(function()
        if AimLockConfig.Enabled then
            UpdateAimState()
        end
    end)
end

local function StopAimLockLoop()
    if AimState.LockConnection then
        AimState.LockConnection:Disconnect()
        AimState.LockConnection = nil
    end
end

-- ==================== HÀM BẬT/TẮT ====================
local function ShowNotification(message, isError)
    if not AimLockConfig.ShowNotifications then return end
    
    local notif = Instance.new("TextLabel")
    notif.Parent = game.CoreGui
    notif.Size = UDim2.new(0, 250, 0, 40)
    notif.Position = UDim2.new(0.5, -125, 0.85, 0)
    notif.BackgroundColor3 = isError and Color3.fromRGB(80, 0, 0) or Color3.fromRGB(0, 0, 0)
    notif.BackgroundTransparency = 0.3
    notif.TextColor3 = isError and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 14
    notif.Text = message
    notif.TextStrokeTransparency = 0.3
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    
    task.wait(2)
    notif:Destroy()
end

local function ToggleAimLock()
    AimLockConfig.Enabled = not AimLockConfig.Enabled
    
    if AimLockConfig.Enabled then
        StartAimLockLoop()
        ShowNotification("AIM LOCK: BẬT - Khoảng cách: " .. AimLockConfig.MaxDistance .. " studs")
        status.Text = "STATUS : AIM LOCK ACTIVE"
    else
        StopAimLockLoop()
        AimState.CurrentTarget = nil
        ShowNotification("AIM LOCK: TẮT")
        status.Text = "STATUS : READY"
    end
    
    -- Cập nhật nút GUI
    if aimBtn then
        if AimLockConfig.Enabled then
            aimBtn.Text = "AIM LOCK [ON]"
            aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        else
            aimBtn.Text = "AIM LOCK"
            aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
    end
end

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == AimLockConfig.ToggleKey then
            if AimLockConfig.ToggleKeyModifier then
                local isModifierPressed = false
                if AimLockConfig.ToggleKeyModifier == "Shift" and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    isModifierPressed = true
                elseif AimLockConfig.ToggleKeyModifier == "Ctrl" and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    isModifierPressed = true
                elseif AimLockConfig.ToggleKeyModifier == "Alt" and UserInputService:IsKeyDown(Enum.KeyCode.LeftAlt) then
                    isModifierPressed = true
                end
                
                if isModifierPressed then
                    ToggleAimLock()
                end
            else
                ToggleAimLock()
            end
        end
    end)
end

-- ==================== XỬ LÝ RESPAWN ====================
local function OnCharacterRespawn()
    if AimLockConfig.Enabled then
        AimState.CurrentTarget = nil
        AimState.FailedAttempts = 0
        ShowNotification("AIM LOCK: ĐÃ RESPAWN - Tiếp tục theo dõi")
    end
end

player.CharacterAdded:Connect(OnCharacterRespawn)

-- ==================== XỬ LÝ THOÁT GAME ====================
local function OnPlayerRemoving(leavingPlayer)
    if AimLockConfig.Enabled and AimState.CurrentTarget == leavingPlayer then
        AimState.CurrentTarget = nil
    end
end

Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- ==================== KHỞI TẠO ====================
local function InitializeAimLock()
    SetupHotkeys()
    print("[AIM LOCK] Đã khởi tạo thành công!")
    print("   - Khoảng cách tối đa: " .. AimLockConfig.MaxDistance .. " studs")
    print("   - Ưu tiên: " .. AimLockConfig.Priority)
    print("   - Phím tắt: " .. tostring(AimLockConfig.ToggleKey))
    print("   - Lock mượt: " .. (AimLockConfig.LockSmoothness > 0 and "Có" or "Không"))
end

-- ==================== EXPORT HÀM ====================
-- Hàm để GUI có thể gọi
local function GetAimLockStatus()
    return AimLockConfig.Enabled
end

local function SetAimLockConfig(configTable)
    for key, value in pairs(configTable) do
        if AimLockConfig[key] ~= nil then
            AimLockConfig[key] = value
        end
    end
end

-- Tạo nút GUI
local aimBtn = makeButton("AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))
aimBtn.MouseButton1Click:Connect(ToggleAimLock)

-- Khởi tạo
InitializeAimLock()
--========================
-- SYSTEM: ESP PLAYER PRO MAX (KHÔNG GOTO)
--========================

local espEnabled = false
local espObjects = {}
local espBtn = makeButton("ESP PLAYER", 1, 2, Color3.fromRGB(50, 100, 150))

local ESPConfig = {
    MaxDistance = 250,
    ShowName = true,
    ShowHealthBar = true,
    ShowHealthText = true,
    ShowDistance = true,
    ShowBox = true,
    NameSize = 14,
    HealthTextSize = 11,
    DistanceSize = 10,
    BoxThickness = 0.08,
    BoxTransparency = 0.4,
}

local function getHealthColor(health, maxHealth)
    local percent = health / maxHealth
    if percent > 0.7 then return Color3.fromRGB(0, 255, 0)
    elseif percent > 0.3 then return Color3.fromRGB(255, 255, 0)
    else return Color3.fromRGB(255, 0, 0) end
end

local function getBoxColor(distance)
    if distance < 50 then return Color3.fromRGB(255, 50, 50)
    elseif distance < 100 then return Color3.fromRGB(255, 150, 50)
    else return Color3.fromRGB(255, 255, 100) end
end

local function isValidTarget(targetPlayer)
    if not targetPlayer or targetPlayer == player then return false end
    local char = targetPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return false end
    if not char:FindFirstChild("Head") or not char:FindFirstChild("HumanoidRootPart") then return false end
    return true, hum, char
end

local function createESP(targetPlayer)
    if espObjects[targetPlayer] then
        if espObjects[targetPlayer].billboard then espObjects[targetPlayer].billboard:Destroy() end
        if espObjects[targetPlayer].box then espObjects[targetPlayer].box:Destroy() end
        espObjects[targetPlayer] = nil
    end

    local isValid, hum, char = isValidTarget(targetPlayer)
    if not isValid then return false end

    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not head or not root then return false end

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 180, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local nameLabel = nil
    if ESPConfig.ShowName then
        nameLabel = Instance.new("TextLabel")
        nameLabel.Size = UDim2.new(1, 0, 0, 20)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = targetPlayer.Name
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.Font = Enum.Font.GothamBold
        nameLabel.TextSize = ESPConfig.NameSize
        nameLabel.TextXAlignment = Enum.TextXAlignment.Center
        nameLabel.Parent = billboard
    end

    local healthBarFill = nil
    if ESPConfig.ShowHealthBar then
        local barBg = Instance.new("Frame")
        barBg.Size = UDim2.new(0.85, 0, 0, 6)
        barBg.Position = UDim2.new(0.075, 0, 0.4, 0)
        barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        barBg.BorderSizePixel = 0
        barBg.Parent = billboard
        healthBarFill = Instance.new("Frame")
        healthBarFill.Size = UDim2.new(1, 0, 1, 0)
        healthBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        healthBarFill.BorderSizePixel = 0
        healthBarFill.Parent = barBg
    end

    local healthText = nil
    if ESPConfig.ShowHealthText then
        healthText = Instance.new("TextLabel")
        healthText.Size = UDim2.new(1, 0, 0, 16)
        healthText.Position = UDim2.new(0, 0, 0.55, 0)
        healthText.BackgroundTransparency = 1
        healthText.Font = Enum.Font.Gotham
        healthText.TextSize = ESPConfig.HealthTextSize
        healthText.TextXAlignment = Enum.TextXAlignment.Center
        healthText.Parent = billboard
    end

    local distLabel = nil
    if ESPConfig.ShowDistance then
        distLabel = Instance.new("TextLabel")
        distLabel.Size = UDim2.new(1, 0, 0, 14)
        distLabel.Position = UDim2.new(0, 0, 0.75, 0)
        distLabel.BackgroundTransparency = 1
        distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLabel.Font = Enum.Font.Gotham
        distLabel.TextSize = ESPConfig.DistanceSize
        distLabel.TextXAlignment = Enum.TextXAlignment.Center
        distLabel.Parent = billboard
    end

    local box = nil
    if ESPConfig.ShowBox then
        box = Instance.new("SelectionBox")
        box.Adornee = root
        box.Color3 = Color3.fromRGB(255, 0, 0)
        box.LineThickness = ESPConfig.BoxThickness
        box.Transparency = ESPConfig.BoxTransparency
        box.Parent = char
    end

    espObjects[targetPlayer] = {
        billboard = billboard,
        box = box,
        healthText = healthText,
        distLabel = distLabel,
        healthBarFill = healthBarFill,
        humanoid = hum,
        root = root,
        nameLabel = nameLabel
    }
    return true
end

local function destroyESP(target)
    local data = espObjects[target]
    if data then
        if data.billboard then pcall(function() data.billboard:Destroy() end) end
        if data.box then pcall(function() data.box:Destroy() end) end
        espObjects[target] = nil
    end
end

local function destroyAllESP()
    for target, _ in pairs(espObjects) do
        destroyESP(target)
    end
    espObjects = {}
end

local function updateESP()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    for target, data in pairs(espObjects) do
        local character = target.Character
        if not character or not data.humanoid or data.humanoid.Health <= 0 then
            destroyESP(target)
        else
            local health = data.humanoid.Health
            local maxHealth = data.humanoid.MaxHealth
            local healthColor = getHealthColor(health, maxHealth)
            if data.healthBarFill then
                data.healthBarFill.Size = UDim2.new(health / maxHealth, 0, 1, 0)
                data.healthBarFill.BackgroundColor3 = healthColor
            end
            if data.healthText then
                data.healthText.Text = string.format("%.0f / %.0f", health, maxHealth)
                data.healthText.TextColor3 = healthColor
            end
            if myRoot and data.root then
                local dist = (myRoot.Position - data.root.Position).Magnitude
                if data.distLabel then
                    data.distLabel.Text = string.format("%.1f m", dist)
                end
                local visible = dist <= ESPConfig.MaxDistance
                if data.billboard then data.billboard.Enabled = visible end
                if data.box then
                    data.box.Visible = visible
                    data.box.Color3 = getBoxColor(dist)
                end
            end
        end
    end
end

local function createAllESP()
    destroyAllESP()
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            createESP(other)
        end
    end
end

local espUpdateLoop = nil
local function startESP()
    if espUpdateLoop then espUpdateLoop:Disconnect() end
    espUpdateLoop = RunService.RenderStepped:Connect(updateESP)
end

local function stopESP()
    if espUpdateLoop then espUpdateLoop:Disconnect() espUpdateLoop = nil end
    destroyAllESP()
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        createAllESP()
        startESP()
        espBtn.Text = "ESP PLAYER [ON]"
        espBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 180)
        status.Text = "STATUS : ESP ON"
    else
        stopESP()
        espBtn.Text = "ESP PLAYER"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

espBtn.MouseButton1Click:Connect(toggleESP)

Players.PlayerAdded:Connect(function(newPlayer)
    if espEnabled then task.wait(0.5) createESP(newPlayer) end
end)

Players.PlayerRemoving:Connect(function(leaving)
    destroyESP(leaving)
end)

player.CharacterAdded:Connect(function()
    if espEnabled then task.wait(1) createAllESP() end
end)--========================
-- SYSTEM: POV PLAYER PRO MAX (GÓC NHÌN THỨ 3)
-- Version: 4.0
-- Tác giả: Sidbuddb
-- Mô tả: Xem người chơi khác ở góc nhìn thứ 3, có thể tùy chỉnh khoảng cách, góc, độ mượt
-- Tối ưu: Xử lý khi target chết, respawn, mất kết nối
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH POV ====================
local POVConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    CurrentTarget = nil,
    
    -- Cài đặt camera
    CameraDistance = 8,             -- Khoảng cách từ camera đến target (studs)
    CameraHeight = 3,               -- Độ cao so với target (studs)
    CameraOffset = Vector3.new(0, 0, 0),  -- Offset bổ sung (X: trái/phải, Y: lên/xuống, Z: tới/lùi)
    Smoothness = 0.2,               -- Độ mượt khi camera di chuyển (0=không, 1=rất mượt)
    
    -- Cài đặt góc nhìn
    FollowRotation = true,          -- Camera xoay theo hướng mặt của target
    RotationSpeed = 5,              -- Tốc độ xoay camera khi follow rotation
    
    -- Cài đặt giới hạn
    MaxDistance = 200,              -- Khoảng cách tối đa để có thể xem (studs)
    AutoStopOnDeath = true,         -- Tự động dừng khi target chết
    AutoStopOnTooFar = true,        -- Tự động dừng khi target quá xa
    AutoStopOnLeave = true,         -- Tự động dừng khi target rời game
    
    -- Cài đặt hiển thị
    ShowStatus = true,              -- Hiển thị trạng thái trên GUI
    ShowCrosshair = false,          -- Hiển thị chấm giữa màn hình khi đang xem
    
    -- Cài đặt phím tắt
    ToggleKey = Enum.KeyCode.P,     -- Phím bật/tắt POV
    ExitKey = Enum.KeyCode.X,       -- Phím thoát POV về bản thân
    ZoomInKey = Enum.KeyCode.Equals, -- Phím tăng khoảng cách ( + )
    ZoomOutKey = Enum.KeyCode.Minus, -- Phím giảm khoảng cách ( - )
    ZoomStep = 1,                   -- Bước tăng/giảm khoảng cách
    MinDistance = 2,                -- Khoảng cách tối thiểu
    MaxDistanceLimit = 20,          -- Khoảng cách tối đa (giới hạn cài đặt)
    
    -- Cài đặt nâng cao
    RestoreOnExit = true,           -- Khôi phục camera gốc khi thoát
    AllowWhileDead = false,         -- Cho phép xem khi bản thân đang chết
    BlockUserInput = false,         -- Chặn input di chuyển của người chơi khi đang xem
}

-- ==================== BIẾN TOÀN CỤC ====================
local POVState = {
    IsActive = false,
    TargetPlayer = nil,
    OriginalCameraSubject = nil,
    OriginalCameraCFrame = nil,
    OriginalHumanoidState = nil,
    UpdateConnection = nil,
    LastTargetPosition = nil,
    LastCameraCFrame = nil,
    ZoomConnection = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function IsValidTarget(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == player then return false end
    
    -- Kiểm tra bản thân còn sống (nếu cần)
    if not POVConfig.AllowWhileDead then
        local myChar = player.Character
        local myHum = myChar and myChar:FindFirstChild("Humanoid")
        if not myHum or myHum.Health <= 0 then
            return false
        end
    end
    
    -- Kiểm tra target còn sống
    local character = targetPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return false
    end
    
    -- Kiểm tra các bộ phận cần thiết
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    -- Kiểm tra khoảng cách
    if POVConfig.AutoStopOnTooFar then
        local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if myRoot then
            local distance = (myRoot.Position - root.Position).Magnitude
            if distance > POVConfig.MaxDistance then
                return false
            end
        end
    end
    
    return true, character, humanoid, root
end

local function GetCameraOffset()
    -- Tính toán offset dựa trên khoảng cách, độ cao, và offset tùy chỉnh
    local offset = Vector3.new(
        POVConfig.CameraOffset.X,
        POVConfig.CameraHeight + POVConfig.CameraOffset.Y,
        POVConfig.CameraDistance + POVConfig.CameraOffset.Z
    )
    return offset
end

local function CalculateCameraCFrame(targetRoot, targetHumanoid)
    if not targetRoot then return nil end
    
    local targetPos = targetRoot.Position
    local offset = GetCameraOffset()
    
    -- Tính toán hướng camera
    local cameraCFrame
    
    if POVConfig.FollowRotation and targetHumanoid then
        -- Lấy hướng mặt của target (dựa trên HumanoidRootPart hoặc Head)
        local targetCFrame = targetRoot.CFrame
        local lookVector = targetCFrame.LookVector
        -- Tạo CFrame dựa trên vị trí target và hướng nhìn
        local backOffset = -lookVector * offset.Z
        local upOffset = Vector3.new(0, offset.Y, 0)
        local rightOffset = targetCFrame.RightVector * offset.X
        
        local cameraPos = targetPos + backOffset + upOffset + rightOffset
        cameraCFrame = CFrame.new(cameraPos, targetPos)
    else
        -- Camera cố định từ phía sau theo hướng cố định (góc nhìn thứ 3 mặc định)
        local cameraPos = targetPos + Vector3.new(offset.X, offset.Y, offset.Z)
        cameraCFrame = CFrame.new(cameraPos, targetPos)
    end
    
    return cameraCFrame
end

-- ==================== LƯU / KHÔI PHỤC CAMERA GỐC ====================
local function SaveOriginalCamera()
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then return end
    
    POVState.OriginalCameraSubject = currentCamera.CameraSubject
    POVState.OriginalCameraCFrame = currentCamera.CFrame
end

local function RestoreOriginalCamera()
    local currentCamera = workspace.CurrentCamera
    if not currentCamera then return end
    
    if POVState.OriginalCameraSubject then
        currentCamera.CameraSubject = POVState.OriginalCameraSubject
    end
    if POVState.OriginalCameraCFrame then
        currentCamera.CFrame = POVState.OriginalCameraCFrame
    end
end

-- ==================== ĐIỀU KHIỂN CAMERA ====================
local function UpdateCamera()
    if not POVState.IsActive or not POVState.TargetPlayer then
        return
    end
    
    local isValid, character, humanoid, root = IsValidTarget(POVState.TargetPlayer)
    if not isValid then
        -- Dừng POV nếu target không hợp lệ
        if POVConfig.AutoStopOnDeath or POVConfig.AutoStopOnTooFar or POVConfig.AutoStopOnLeave then
            StopPOV()
            if POVConfig.ShowStatus then
                status.Text = "STATUS : POV STOPPED - Target lost"
            end
        end
        return
    end
    
    -- Tính toán CFrame mới cho camera
    local newCFrame = CalculateCameraCFrame(root, humanoid)
    if not newCFrame then return end
    
    -- Áp dụng độ mượt
    local currentCamera = workspace.CurrentCamera
    if currentCamera then
        if POVConfig.Smoothness > 0 and POVState.LastCameraCFrame then
            local alpha = math.min(1, POVConfig.Smoothness)
            local smoothCFrame = POVState.LastCameraCFrame:Lerp(newCFrame, alpha)
            currentCamera.CFrame = smoothCFrame
            POVState.LastCameraCFrame = smoothCFrame
        else
            currentCamera.CFrame = newCFrame
            POVState.LastCameraCFrame = newCFrame
        end
        
        -- Đặt CameraSubject để game tự động theo dõi (nếu cần)
        currentCamera.CameraSubject = humanoid
    end
    
    -- Lưu vị trí target để debug
    POVState.LastTargetPosition = root.Position
end

-- ==================== BẮT ĐẦU / DỪNG POV ====================
local function StartPOV(targetPlayer)
    if not targetPlayer then return false end
    
    local isValid = IsValidTarget(targetPlayer)
    if not isValid then
        if POVConfig.ShowStatus then
            status.Text = "STATUS : Cannot view " .. (targetPlayer.Name or "player")
        end
        return false
    end
    
    -- Lưu camera gốc nếu chưa có
    if POVConfig.RestoreOnExit and not POVState.IsActive then
        SaveOriginalCamera()
    end
    
    -- Chặn input người chơi nếu cấu hình
    if POVConfig.BlockUserInput then
        local myChar = player.Character
        if myChar then
            local myHum = myChar:FindFirstChild("Humanoid")
            if myHum then
                POVState.OriginalHumanoidState = myHum.AutoRotate
                myHum.AutoRotate = false
            end
        end
    end
    
    -- Thiết lập trạng thái
    POVState.IsActive = true
    POVState.TargetPlayer = targetPlayer
    POVState.LastCameraCFrame = nil
    
    -- Cập nhật CameraSubject ngay lập tức
    local character = targetPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            workspace.CurrentCamera.CameraSubject = humanoid
        end
    end
    
    -- Hiển thị status
    if POVConfig.ShowStatus then
        status.Text = "STATUS : VIEWING " .. string.upper(targetPlayer.Name)
    end
    
    -- Cập nhật nút GUI nếu có
    if povBtn then
        povBtn.Text = "POV PLAYER [ON]"
        povBtn.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    end
    
    return true
end

local function StopPOV()
    if not POVState.IsActive then
        return
    end
    
    -- Khôi phục camera gốc
    if POVConfig.RestoreOnExit then
        RestoreOriginalCamera()
    end
    
    -- Khôi phục input người chơi
    if POVConfig.BlockUserInput and POVState.OriginalHumanoidState ~= nil then
        local myChar = player.Character
        if myChar then
            local myHum = myChar:FindFirstChild("Humanoid")
            if myHum then
                myHum.AutoRotate = POVState.OriginalHumanoidState
            end
        end
        POVState.OriginalHumanoidState = nil
    end
    
    -- Reset trạng thái
    POVState.IsActive = false
    POVState.TargetPlayer = nil
    POVState.LastCameraCFrame = nil
    
    -- Hiển thị status
    if POVConfig.ShowStatus then
        status.Text = "STATUS : READY"
    end
    
    -- Cập nhật nút GUI
    if povBtn then
        povBtn.Text = "POV PLAYER"
        povBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end

-- ==================== VÒNG LẶP CẬP NHẬT ====================
local function StartPOVLoop()
    if POVState.UpdateConnection then
        POVState.UpdateConnection:Disconnect()
    end
    
    POVState.UpdateConnection = RunService.RenderStepped:Connect(function()
        if POVState.IsActive then
            UpdateCamera()
        end
    end)
end

local function StopPOVLoop()
    if POVState.UpdateConnection then
        POVState.UpdateConnection:Disconnect()
        POVState.UpdateConnection = nil
    end
end

-- ==================== PHÓNG TO / THU NHỎ KHOẢNG CÁCH ====================
local function ZoomIn()
    local newDist = POVConfig.CameraDistance - POVConfig.ZoomStep
    if newDist >= POVConfig.MinDistance then
        POVConfig.CameraDistance = newDist
        if POVConfig.ShowStatus and POVState.IsActive then
            status.Text = "STATUS : DISTANCE " .. string.format("%.1f", POVConfig.CameraDistance)
        end
    end
end

local function ZoomOut()
    local newDist = POVConfig.CameraDistance + POVConfig.ZoomStep
    if newDist <= POVConfig.MaxDistanceLimit then
        POVConfig.CameraDistance = newDist
        if POVConfig.ShowStatus and POVState.IsActive then
            status.Text = "STATUS : DISTANCE " .. string.format("%.1f", POVConfig.CameraDistance)
        end
    end
end

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupPOVHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Phím bật/tắt POV
        if input.KeyCode == POVConfig.ToggleKey then
            if POVState.IsActive then
                StopPOV()
            else
                -- Nếu chưa active, cần có target để bắt đầu (sẽ được xử lý qua menu GUI)
                -- Hoặc có thể tự động chọn người gần nhất?
                if POVConfig.ShowStatus then
                    status.Text = "STATUS : Select a player from menu"
                end
            end
        end
        
        -- Phím thoát khẩn cấp
        if input.KeyCode == POVConfig.ExitKey then
            if POVState.IsActive then
                StopPOV()
            end
        end
        
        -- Phóng to / thu nhỏ khi đang xem
        if POVState.IsActive then
            if input.KeyCode == POVConfig.ZoomInKey then
                ZoomIn()
            elseif input.KeyCode == POVConfig.ZoomOutKey then
                ZoomOut()
            end
        end
    end)
end

-- ==================== XỬ LÝ SỰ KIỆN RESPAWN / RỜI GAME ====================
local function OnPlayerRemoving(leavingPlayer)
    if POVState.IsActive and POVState.TargetPlayer == leavingPlayer then
        StopPOV()
        if POVConfig.ShowStatus then
            status.Text = "STATUS : Target left game"
        end
    end
end

local function OnCharacterAdded(character)
    if POVState.IsActive and POVState.TargetPlayer then
        -- Kiểm tra lại target có hợp lệ không sau khi respawn
        task.wait(0.5)
        local isValid, _, _, root = IsValidTarget(POVState.TargetPlayer)
        if not isValid then
            StopPOV()
            if POVConfig.ShowStatus then
                status.Text = "STATUS : Target died or too far"
            end
        end
    end
end

-- Đăng ký sự kiện
Players.PlayerRemoving:Connect(OnPlayerRemoving)
player.CharacterAdded:Connect(OnCharacterAdded)

-- ==================== TẠO MENU CHỌN NGƯỜI CHƠI ====================
local povFrame = nil
local povList = nil

local function CreatePOVMenu()
    povFrame = Instance.new("Frame")
    povFrame.Parent = frame  -- frame là main GUI frame
    povFrame.Size = UDim2.new(0, 200, 0, 300)
    povFrame.Position = UDim2.new(1, 10, 0, 60)
    povFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    povFrame.BackgroundTransparency = 0.1
    povFrame.BorderSizePixel = 0
    povFrame.Visible = false
    povFrame.Active = true
    povFrame.Draggable = true
    Instance.new("UICorner", povFrame).CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Parent = povFrame
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    title.Text = "CHỌN NGƯỜI ĐỂ XEM"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    
    povList = Instance.new("ScrollingFrame")
    povList.Parent = povFrame
    povList.Size = UDim2.new(1, -10, 1, -40)
    povList.Position = UDim2.new(0, 5, 0, 35)
    povList.BackgroundTransparency = 1
    povList.CanvasSize = UDim2.new(0, 0, 0, 0)
    povList.ScrollBarThickness = 5
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = povList
    layout.SortOrder = Enum.SortOrder.Name
    layout.Padding = UDim.new(0, 5)
end

local function UpdatePlayerList()
    if not povList then return end
    
    -- Xóa các nút cũ
    for _, child in pairs(povList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local ySize = 0
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Text = other.Name
            btn.TextSize = 12
            btn.Font = Enum.Font.Gotham
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BorderSizePixel = 0
            btn.Parent = povList
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                if StartPOV(other) then
                    povFrame.Visible = false
                    StartPOVLoop()
                end
            end)
            
            ySize = ySize + 40
        end
    end
    povList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

-- ==================== NÚT GUI POV ====================
local povBtn = makeButton("POV PLAYER", 2, 1, Color3.fromRGB(80, 150, 200))
povBtn.MouseButton1Click:Connect(function()
    if POVState.IsActive then
        StopPOV()
        StopPOVLoop()
    else
        if not povFrame then
            CreatePOVMenu()
        end
        UpdatePlayerList()
        povFrame.Visible = not povFrame.Visible
    end
end)

-- Cập nhật danh sách khi có người mới vào/ra
Players.PlayerAdded:Connect(function()
    if povFrame and povFrame.Visible then
        UpdatePlayerList()
    end
end)

Players.PlayerRemoving:Connect(function()
    if povFrame and povFrame.Visible then
        UpdatePlayerList()
    end
end)

-- ==================== KHỞI TẠO ====================
local function InitializePOV()
    SetupPOVHotkeys()
    CreatePOVMenu()
    print("[POV PLAYER] Đã khởi tạo thành công!")
    print("   - Phím bật/tắt menu: Nhấn nút GUI")
    print("   - Phím tắt bật/tắt (nếu có): " .. tostring(POVConfig.ToggleKey))
    print("   - Phím thoát: " .. tostring(POVConfig.ExitKey))
    print("   - Phóng to / thu nhỏ: " .. tostring(POVConfig.ZoomInKey) .. " / " .. tostring(POVConfig.ZoomOutKey))
end

InitializePOV()
--========================
-- SYSTEM: INFINITE JUMP PRO MAX
-- Version: 4.0
-- Tác giả: Sidbuddb
-- Mô tả: Cho phép nhảy vô hạn trên không, tùy chỉnh độ cao, phím tắt, chế độ hoạt động
-- Tối ưu: Hoạt động mượt, tránh anti-cheat cơ bản, có thể bật/tắt dễ dàng
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH INFINITE JUMP ====================
local InfiniteJumpConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    JumpPower = 60,                 -- Lực nhảy (mặc định 50, tăng lên để nhảy cao hơn)
    MaxJumpPower = 120,             -- Giới hạn lực nhảy tối đa
    MinJumpPower = 40,              -- Giới hạn lực nhảy tối thiểu
    
    -- Cài đặt chế độ nhảy
    Mode = "Infinite",              -- Chế độ: "Infinite" (nhảy liên tục), "SuperJump" (mỗi lần nhảy cực cao)
    GroundDetection = true,         -- Chỉ cho nhảy trên không khi đã bật (vẫn nhảy được khi trên không)
    AntiStuck = true,               -- Chống kẹt khi nhảy vào tường/trần
    
    -- Cài đặt phím tắt
    ToggleKey = Enum.KeyCode.J,     -- Phím bật/tắt (mặc định J)
    JumpKey = Enum.KeyCode.Space,   -- Phím nhảy (mặc định Space)
    IncreaseKey = Enum.KeyCode.RightBracket,   -- Phím tăng lực nhảy (])
    DecreaseKey = Enum.KeyCode.LeftBracket,    -- Phím giảm lực nhảy ([)
    
    -- Cài đặt hiển thị
    ShowStatus = true,              -- Hiển thị trạng thái trên GUI
    ShowJumpPower = true,           -- Hiển thị lực nhảy hiện tại
    ShowNotification = true,        -- Hiển thị thông báo khi bật/tắt bằng phím
    
    -- Cài đặt nâng cao
    PreserveVelocity = true,        -- Giữ vận tốc khi nhảy (tạo cảm giác mượt)
    AntiCheatBypass = true,         -- Cố gắng tránh phát hiện (set lại JumpPower sau mỗi lần nhảy)
    ResetOnRespawn = true,          -- Reset trạng thái khi chết/respawn
}

-- ==================== BIẾN TOÀN CỤC ====================
local InfiniteJumpState = {
    IsActive = false,
    OriginalJumpPower = nil,        -- Lưu lực nhảy gốc để khôi phục
    LastJumpTime = 0,
    JumpCount = 0,
    UpdateConnection = nil,
    JumpRequestConnection = nil,
    ActiveModifier = 1,             -- Hệ số nhân cho lực nhảy (chưa dùng)
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function SaveOriginalJumpPower()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum and InfiniteJumpState.OriginalJumpPower == nil then
        InfiniteJumpState.OriginalJumpPower = hum.JumpPower
    end
end

local function RestoreOriginalJumpPower()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum and InfiniteJumpState.OriginalJumpPower then
        hum.JumpPower = InfiniteJumpState.OriginalJumpPower
    end
end

local function SetJumpPower(value)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        hum.JumpPower = math.clamp(value, InfiniteJumpConfig.MinJumpPower, InfiniteJumpConfig.MaxJumpPower)
    end
end

local function GetCurrentJumpPower()
    local char = player.Character
    if not char then return InfiniteJumpConfig.JumpPower
    end
    local hum = char:FindFirstChild("Humanoid")
    return hum and hum.JumpPower or InfiniteJumpConfig.JumpPower
end

-- ==================== CƠ CHẾ NHẢY CHÍNH ====================
local function PerformInfiniteJump()
    if not InfiniteJumpState.IsActive then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return end
    
    -- Lưu lực nhảy gốc nếu chưa có
    SaveOriginalJumpPower()
    
    -- Thiết lập lực nhảy theo cấu hình
    if InfiniteJumpConfig.AntiCheatBypass then
        -- Cách anti-cheat: set JumpPower trước khi nhảy, sau đó khôi phục
        local targetJumpPower = InfiniteJumpConfig.JumpPower
        if InfiniteJumpConfig.Mode == "SuperJump" then
            targetJumpPower = InfiniteJumpConfig.MaxJumpPower
        end
        hum.JumpPower = targetJumpPower
    else
        -- Set trực tiếp (dễ bị phát hiện hơn)
        if InfiniteJumpConfig.Mode == "Infinite" then
            hum.JumpPower = InfiniteJumpConfig.JumpPower
        elseif InfiniteJumpConfig.Mode == "SuperJump" then
            hum.JumpPower = InfiniteJumpConfig.MaxJumpPower
        end
    end
    
    -- Kích hoạt nhảy
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    
    -- Ghi nhận thời gian
    InfiniteJumpState.LastJumpTime = GetCurrentTime()
    InfiniteJumpState.JumpCount = InfiniteJumpState.JumpCount + 1
    
    -- Nếu dùng anti-cheat, sau khi nhảy sẽ khôi phục lại lực nhảy gốc
    if InfiniteJumpConfig.AntiCheatBypass then
        task.spawn(function()
            task.wait(0.05)
            if hum and InfiniteJumpState.OriginalJumpPower then
                hum.JumpPower = InfiniteJumpState.OriginalJumpPower
            end
        end)
    end
end

-- ==================== XỬ LÝ SỰ KIỆN NHẢY ====================
local function OnJumpRequest()
    if not InfiniteJumpState.IsActive then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum or hum.Health <= 0 then return end
    
    -- Cho phép nhảy ngay cả khi đang ở trên không (nếu đã bật infinite)
    if InfiniteJumpConfig.GroundDetection then
        -- Luôn cho phép nhảy, không cần kiểm tra chạm đất
        PerformInfiniteJump()
    else
        -- Chỉ nhảy khi đang ở trên không (giống vô hạn nhưng có thể kiểm soát)
        if hum.FloorMaterial == Enum.Material.Air then
            PerformInfiniteJump()
        end
    end
end

-- ==================== TĂNG / GIẢM LỰC NHẢY ====================
local function IncreaseJumpPower()
    local newPower = math.min(InfiniteJumpConfig.MaxJumpPower, InfiniteJumpConfig.JumpPower + 5)
    InfiniteJumpConfig.JumpPower = newPower
    if InfiniteJumpState.IsActive then
        SetJumpPower(newPower)
    end
    if InfiniteJumpConfig.ShowJumpPower and InfiniteJumpConfig.ShowStatus then
        status.Text = "STATUS : JUMP POWER = " .. tostring(newPower)
        task.wait(1)
        if InfiniteJumpState.IsActive then
            status.Text = "STATUS : INFINITE JUMP ON (Power: " .. newPower .. ")"
        else
            status.Text = "STATUS : READY"
        end
    end
end

local function DecreaseJumpPower()
    local newPower = math.max(InfiniteJumpConfig.MinJumpPower, InfiniteJumpConfig.JumpPower - 5)
    InfiniteJumpConfig.JumpPower = newPower
    if InfiniteJumpState.IsActive then
        SetJumpPower(newPower)
    end
    if InfiniteJumpConfig.ShowJumpPower and InfiniteJumpConfig.ShowStatus then
        status.Text = "STATUS : JUMP POWER = " .. tostring(newPower)
        task.wait(1)
        if InfiniteJumpState.IsActive then
            status.Text = "STATUS : INFINITE JUMP ON (Power: " .. newPower .. ")"
        else
            status.Text = "STATUS : READY"
        end
    end
end

-- ==================== BẬT / TẮT INFINITE JUMP ====================
local function ShowNotification(message, isError)
    if not InfiniteJumpConfig.ShowNotification then return end
    
    local notif = Instance.new("TextLabel")
    notif.Parent = game.CoreGui
    notif.Size = UDim2.new(0, 200, 0, 40)
    notif.Position = UDim2.new(0.5, -100, 0.85, 0)
    notif.BackgroundColor3 = isError and Color3.fromRGB(80, 0, 0) or Color3.fromRGB(0, 0, 0)
    notif.BackgroundTransparency = 0.3
    notif.TextColor3 = isError and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(100, 255, 100)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 14
    notif.Text = message
    notif.TextStrokeTransparency = 0.3
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    
    task.wait(1.5)
    notif:Destroy()
end

local function EnableInfiniteJump()
    if InfiniteJumpState.IsActive then return end
    
    -- Lưu lực nhảy gốc
    SaveOriginalJumpPower()
    
    -- Set lực nhảy hiện tại
    SetJumpPower(InfiniteJumpConfig.JumpPower)
    
    -- Kết nối sự kiện JumpRequest
    if not InfiniteJumpState.JumpRequestConnection then
        InfiniteJumpState.JumpRequestConnection = UserInputService.JumpRequest:Connect(OnJumpRequest)
    end
    
    InfiniteJumpState.IsActive = true
    if InfiniteJumpConfig.ShowStatus then
        status.Text = "STATUS : INFINITE JUMP ON (Power: " .. InfiniteJumpConfig.JumpPower .. ")"
    end
    ShowNotification("INFINITE JUMP: BẬT - Lực nhảy " .. InfiniteJumpConfig.JumpPower)
    
    -- Cập nhật nút GUI
    if jumpBtn then
        jumpBtn.Text = "INFINITE JUMP [ON]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(130, 180, 130)
    end
end

local function DisableInfiniteJump()
    if not InfiniteJumpState.IsActive then return end
    
    -- Ngắt kết nối JumpRequest
    if InfiniteJumpState.JumpRequestConnection then
        InfiniteJumpState.JumpRequestConnection:Disconnect()
        InfiniteJumpState.JumpRequestConnection = nil
    end
    
    -- Khôi phục lực nhảy gốc
    RestoreOriginalJumpPower()
    
    InfiniteJumpState.IsActive = false
    if InfiniteJumpConfig.ShowStatus then
        status.Text = "STATUS : READY"
    end
    ShowNotification("INFINITE JUMP: TẮT")
    
    -- Cập nhật nút GUI
    if jumpBtn then
        jumpBtn.Text = "INFINITE JUMP"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end
end

local function ToggleInfiniteJump()
    if InfiniteJumpState.IsActive then
        DisableInfiniteJump()
    else
        EnableInfiniteJump()
    end
end

-- ==================== XỬ LÝ RESPAWN ====================
local function OnCharacterAdded(character)
    if InfiniteJumpConfig.ResetOnRespawn then
        if InfiniteJumpState.IsActive then
            -- Tạm thời tắt rồi bật lại để reset trạng thái
            local wasActive = InfiniteJumpState.IsActive
            if wasActive then
                DisableInfiniteJump()
                task.wait(0.2)
                EnableInfiniteJump()
            end
        else
            -- Đảm bảo lực nhảy gốc được lưu khi respawn
            SaveOriginalJumpPower()
        end
    end
end

player.CharacterAdded:Connect(OnCharacterAdded)

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Phím bật/tắt Infinite Jump
        if input.KeyCode == InfiniteJumpConfig.ToggleKey then
            ToggleInfiniteJump()
        end
        
        -- Phím tăng lực nhảy
        if input.KeyCode == InfiniteJumpConfig.IncreaseKey then
            IncreaseJumpPower()
        end
        
        -- Phím giảm lực nhảy
        if input.KeyCode == InfiniteJumpConfig.DecreaseKey then
            DecreaseJumpPower()
        end
    end)
end

-- ==================== TẠO NÚT GUI ====================
local jumpBtn = makeButton("INFINITE JUMP", 2, 2, Color3.fromRGB(100, 150, 100))
jumpBtn.MouseButton1Click:Connect(ToggleInfiniteJump)

-- ==================== KHỞI TẠO ====================
local function InitializeInfiniteJump()
    SetupHotkeys()
    -- Lưu lực nhảy gốc khi script chạy lần đầu
    task.wait(0.5)
    SaveOriginalJumpPower()
    
    print("[INFINITE JUMP] Đã khởi tạo thành công!")
    print("   - Chế độ: " .. InfiniteJumpConfig.Mode)
    print("   - Lực nhảy mặc định: " .. InfiniteJumpConfig.JumpPower)
    print("   - Phím bật/tắt: " .. tostring(InfiniteJumpConfig.ToggleKey))
    print("   - Phím tăng/giảm lực nhảy: " .. tostring(InfiniteJumpConfig.IncreaseKey) .. " / " .. tostring(InfiniteJumpConfig.DecreaseKey))
end

InitializeInfiniteJump()
