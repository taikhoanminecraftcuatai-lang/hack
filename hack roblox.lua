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
-- SYSTEM: ESP PLAYER PRO MAX
-- Version: 4.0
-- Tác giả: Sidbuddb
-- Mô tả: Hiển thị thông tin người chơi qua tường (tên, máu, khoảng cách, khung viền)
-- Tối ưu: Không lag, xử lý lỗi, tự động cập nhật
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH ESP ====================
local ESPConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    MaxDistance = 300,              -- Khoảng cách tối đa hiển thị ESP (studs)
    UpdateRate = 0.03,              -- Tốc độ cập nhật (giây)
    
    -- Cài đặt hiển thị
    ShowName = true,                -- Hiển thị tên người chơi
    ShowHealthBar = true,           -- Hiển thị thanh máu
    ShowHealthText = true,          -- Hiển thị số máu
    ShowDistance = true,            -- Hiển thị khoảng cách
    ShowBox = true,                 -- Hiển thị khung viền
    ShowLine = false,               -- Hiển thị đường kẻ từ camera (có thể gây lag)
    
    -- Cài đặt màu sắc
    ColorByHealth = true,           -- Đổi màu theo máu
    ColorByDistance = true,         -- Đổi màu khung theo khoảng cách
    HealthHighColor = Color3.fromRGB(0, 255, 0),    -- Xanh: máu cao
    HealthMidColor = Color3.fromRGB(255, 255, 0),   -- Vàng: máu trung bình
    HealthLowColor = Color3.fromRGB(255, 0, 0),     -- Đỏ: máu thấp
    BoxCloseColor = Color3.fromRGB(255, 50, 50),    -- Đỏ: rất gần
    BoxMidColor = Color3.fromRGB(255, 150, 50),     -- Cam: gần
    BoxFarColor = Color3.fromRGB(255, 255, 100),    -- Vàng: xa
    
    -- Cài đặt kích thước
    NameSize = 14,                  -- Cỡ chữ tên
    HealthTextSize = 11,            -- Cỡ chữ số máu
    DistanceSize = 10,              -- Cỡ chữ khoảng cách
    BoxThickness = 0.08,            -- Độ dày khung viền
    BoxTransparency = 0.4,          -- Độ trong suốt khung viền
    BillboardWidth = 180,           -- Chiều rộng billboard
    BillboardHeight = 55,           -- Chiều cao billboard
    StudsOffset = 2.5,              -- Độ cao hiển thị trên đầu
    
    -- Cài đặt lọc
    IgnoreTeam = false,             -- Bỏ qua đồng đội
    IgnoreFriends = false,          -- Bỏ qua bạn bè
    IgnoreSelf = true,              -- Bỏ qua chính mình
    OnlyShowLowHealth = false,      -- Chỉ hiển thị người có máu thấp
    LowHealthThreshold = 50,        -- Ngưỡng máu thấp (phần trăm)
    
    -- Cài đặt hiệu suất
    CacheEnabled = true,            -- Lưu cache để giảm lag
    MaxRetries = 3,                 -- Số lần thử lại khi tạo ESP thất bại
    RetryDelay = 0.5,               -- Thời gian chờ giữa các lần thử (giây)
}

-- ==================== BIẾN TOÀN CỤC ====================
local ESPState = {
    IsRunning = false,
    ActiveObjects = {},      -- player -> {billboard, box, line, ...}
    RetryCount = {},         -- player -> số lần thử
    Cache = {},              -- cache dữ liệu
    UpdateConnection = nil,
    LastUpdateTime = 0,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetHealthPercent(humanoid)
    if not humanoid then return 0 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

local function GetHealthColor(healthPercent)
    if not ESPConfig.ColorByHealth then
        return Color3.fromRGB(255, 255, 255)
    end
    
    if healthPercent >= 70 then
        return ESPConfig.HealthHighColor
    elseif healthPercent >= 30 then
        return ESPConfig.HealthMidColor
    else
        return ESPConfig.HealthLowColor
    end
end

local function GetBoxColorByDistance(distance)
    if not ESPConfig.ColorByDistance then
        return Color3.fromRGB(255, 0, 0)
    end
    
    if distance < 50 then
        return ESPConfig.BoxCloseColor
    elseif distance < 100 then
        return ESPConfig.BoxMidColor
    else
        return ESPConfig.BoxFarColor
    end
end

local function IsValidForESP(targetPlayer)
    -- Kiểm tra cơ bản
    if not targetPlayer then return false end
    if ESPConfig.IgnoreSelf and targetPlayer == player then return false end
    
    -- Kiểm tra nhân vật
    local character = targetPlayer.Character
    if not character then return false end
    
    -- Kiểm tra Humanoid
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    
    -- Kiểm tra các bộ phận cần thiết
    local head = character:FindFirstChild("Head")
    local root = character:FindFirstChild("HumanoidRootPart")
    if not head or not root then return false end
    
    -- Kiểm tra đội
    if ESPConfig.IgnoreTeam and targetPlayer.Team and player.Team and targetPlayer.Team == player.Team then
        return false
    end
    
    -- Kiểm tra máu thấp
    if ESPConfig.OnlyShowLowHealth then
        local healthPercent = GetHealthPercent(humanoid)
        if healthPercent > ESPConfig.LowHealthThreshold then
            return false
        end
    end
    
    -- Kiểm tra khoảng cách
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if myRoot then
        local distance = (myRoot.Position - root.Position).Magnitude
        if distance > ESPConfig.MaxDistance then
            return false
        end
    end
    
    return true, humanoid, head, root
end

local function GetDistanceToTarget(targetRoot)
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot or not targetRoot then return ESPConfig.MaxDistance + 1
    end
    return (myRoot.Position - targetRoot.Position).Magnitude
end

-- ==================== TẠO ESP COMPONENTS ====================
local function CreateBillboard(targetPlayer, head)
    if not head then return nil end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard_" .. targetPlayer.Name
    billboard.Size = UDim2.new(0, ESPConfig.BillboardWidth, 0, ESPConfig.BillboardHeight)
    billboard.StudsOffset = Vector3.new(0, ESPConfig.StudsOffset, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = ESPConfig.MaxDistance
    billboard.ExtentsOffsetWorldSpace = Vector3.new(0, 3, 0)
    billboard.Parent = head
    
    return billboard
end

local function CreateNameLabel(parent)
    if not ESPConfig.ShowName then return nil end
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = ESPConfig.NameSize
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.Parent = parent
    
    return nameLabel
end

local function CreateHealthBar(parent)
    if not ESPConfig.ShowHealthBar then return nil, nil end
    
    local barBg = Instance.new("Frame")
    barBg.Name = "HealthBarBg"
    barBg.Size = UDim2.new(0.85, 0, 0, 6)
    barBg.Position = UDim2.new(0.075, 0, 0.4, 0)
    barBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    barBg.BorderSizePixel = 0
    barBg.Parent = parent
    
    local barFill = Instance.new("Frame")
    barFill.Name = "HealthBarFill"
    barFill.Size = UDim2.new(1, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    return barBg, barFill
end

local function CreateHealthText(parent)
    if not ESPConfig.ShowHealthText then return nil end
    
    local healthText = Instance.new("TextLabel")
    healthText.Name = "HealthText"
    healthText.Size = UDim2.new(1, 0, 0, 16)
    healthText.Position = UDim2.new(0, 0, 0.55, 0)
    healthText.BackgroundTransparency = 1
    healthText.Font = Enum.Font.Gotham
    healthText.TextSize = ESPConfig.HealthTextSize
    healthText.TextXAlignment = Enum.TextXAlignment.Center
    healthText.Parent = parent
    
    return healthText
end

local function CreateDistanceLabel(parent)
    if not ESPConfig.ShowDistance then return nil end
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Name = "DistanceLabel"
    distLabel.Size = UDim2.new(1, 0, 0, 14)
    distLabel.Position = UDim2.new(0, 0, 0.75, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = ESPConfig.DistanceSize
    distLabel.TextXAlignment = Enum.TextXAlignment.Center
    distLabel.Parent = parent
    
    return distLabel
end

local function CreateSelectionBox(targetPlayer, root)
    if not ESPConfig.ShowBox then return nil end
    if not root then return nil end
    
    local box = Instance.new("SelectionBox")
    box.Name = "ESP_Box_" .. targetPlayer.Name
    box.Adornee = root
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.LineThickness = ESPConfig.BoxThickness
    box.Transparency = ESPConfig.BoxTransparency
    box.Parent = targetPlayer.Character
    
    return box
end

local function CreateLine(targetPlayer, root, humanoid)
    if not ESPConfig.ShowLine then return nil end
    if not root or not humanoid then return nil end
    
    local line = Instance.new("SelectionPartLasso")
    line.Name = "ESP_Line_" .. targetPlayer.Name
    line.Humanoid = humanoid
    line.Part = root
    line.Color3 = Color3.fromRGB(255, 255, 255)
    line.Transparency = 0.5
    line.Visible = true
    line.Parent = targetPlayer.Character
    
    return line
end

-- ==================== TẠO ESP CHO 1 NGƯỜI ====================
local function CreateESPForPlayer(targetPlayer)
    -- Kiểm tra và xóa cũ
    if ESPState.ActiveObjects[targetPlayer] then
        DestroyESP(targetPlayer)
    end
    
    -- Kiểm tra hợp lệ
    local isValid, humanoid, head, root = IsValidForESP(targetPlayer)
    if not isValid then
        -- Thử lại nếu cần
        ESPState.RetryCount[targetPlayer] = (ESPState.RetryCount[targetPlayer] or 0) + 1
        if ESPState.RetryCount[targetPlayer] <= ESPConfig.MaxRetries then
            task.wait(ESPConfig.RetryDelay)
            CreateESPForPlayer(targetPlayer)
        end
        return false
    end
    
    -- Reset retry count
    ESPState.RetryCount[targetPlayer] = nil
    
    -- Tạo các component
    local billboard = CreateBillboard(targetPlayer, head)
    local nameLabel = CreateNameLabel(billboard)
    local healthBarBg, healthBarFill = CreateHealthBar(billboard)
    local healthText = CreateHealthText(billboard)
    local distanceLabel = CreateDistanceLabel(billboard)
    local box = CreateSelectionBox(targetPlayer, root)
    local line = CreateLine(targetPlayer, root, humanoid)
    
    -- Lưu vào state
    ESPState.ActiveObjects[targetPlayer] = {
        Character = targetPlayer.Character,
        Billboard = billboard,
        NameLabel = nameLabel,
        HealthBarBg = healthBarBg,
        HealthBarFill = healthBarFill,
        HealthText = healthText,
        DistanceLabel = distanceLabel,
        Box = box,
        Line = line,
        Humanoid = humanoid,
        Root = root,
        Head = head,
        LastHealth = humanoid.Health,
        LastDistance = 0
    }
    
    return true
end

-- ==================== XÓA ESP ====================
local function DestroyESP(targetPlayer)
    local data = ESPState.ActiveObjects[targetPlayer]
    if not data then return end
    
    if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
    if data.Box then pcall(function() data.Box:Destroy() end) end
    if data.Line then pcall(function() data.Line:Destroy() end) end
    
    ESPState.ActiveObjects[targetPlayer] = nil
end

local function DestroyAllESP()
    for targetPlayer, _ in pairs(ESPState.ActiveObjects) do
        DestroyESP(targetPlayer)
    end
    ESPState.ActiveObjects = {}
    ESPState.RetryCount = {}
end

-- ==================== CẬP NHẬT ESP ====================
local function UpdateESPData()
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    for targetPlayer, data in pairs(ESPState.ActiveObjects) do
        -- Kiểm tra xem target còn tồn tại không
        if not targetPlayer or not targetPlayer.Character then
            DestroyESP(targetPlayer)
            goto continue
        end
        
        local character = targetPlayer.Character
        local humanoid = data.Humanoid
        local root = data.Root
        
        if not humanoid or not root or humanoid.Health <= 0 then
            DestroyESP(targetPlayer)
            goto continue
        end
        
        -- Lấy dữ liệu
        local currentHealth = humanoid.Health
        local maxHealth = humanoid.MaxHealth
        local healthPercent = GetHealthPercent(humanoid)
        local healthColor = GetHealthColor(healthPercent)
        
        local distance = GetDistanceToTarget(root)
        local isVisible = distance <= ESPConfig.MaxDistance
        
        -- Cập nhật tên
        if data.NameLabel and ESPConfig.ShowName then
            data.NameLabel.Text = targetPlayer.Name
        end
        
        -- Cập nhật thanh máu
        if data.HealthBarFill and ESPConfig.ShowHealthBar then
            local healthRatio = currentHealth / maxHealth
            data.HealthBarFill.Size = UDim2.new(healthRatio, 0, 1, 0)
            data.HealthBarFill.BackgroundColor3 = healthColor
        end
        
        -- Cập nhật số máu
        if data.HealthText and ESPConfig.ShowHealthText then
            data.HealthText.Text = string.format("%.0f / %.0f", currentHealth, maxHealth)
            data.HealthText.TextColor3 = healthColor
        end
        
        -- Cập nhật khoảng cách
        if data.DistanceLabel and ESPConfig.ShowDistance then
            data.DistanceLabel.Text = string.format("%.1f m", distance)
        end
        
        -- Cập nhật khung viền
        if data.Box and ESPConfig.ShowBox then
            data.Box.Visible = isVisible
            data.Box.Color3 = GetBoxColorByDistance(distance)
        end
        
        -- Cập nhật đường line
        if data.Line and ESPConfig.ShowLine then
            data.Line.Visible = isVisible
        end
        
        -- Ẩn/hiện billboard
        if data.Billboard then
            data.Billboard.Enabled = isVisible
        end
        
        -- Cập nhật cache
        if ESPConfig.CacheEnabled then
            data.LastHealth = currentHealth
            data.LastDistance = distance
        end
        
        ::continue::
    end
end

-- ==================== TẠO ESP CHO TẤT CẢ ====================
local function CreateAllESP()
    DestroyAllESP()
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            -- Tạo ngay nếu có nhân vật
            if otherPlayer.Character then
                CreateESPForPlayer(otherPlayer)
            else
                -- Chờ nhân vật xuất hiện
                local conn
                conn = otherPlayer.CharacterAdded:Connect(function()
                    if ESPConfig.Enabled then
                        task.wait(0.3)
                        CreateESPForPlayer(otherPlayer)
                    end
                    conn:Disconnect()
                end)
            end
        end
    end
end

-- ==================== XỬ LÝ SỰ KIỆN ====================
local function OnPlayerAdded(newPlayer)
    if not ESPConfig.Enabled then return end
    if newPlayer == player then return end
    
    task.wait(0.5)
    if newPlayer.Character then
        CreateESPForPlayer(newPlayer)
    else
        local conn
        conn = newPlayer.CharacterAdded:Connect(function()
            if ESPConfig.Enabled then
                task.wait(0.3)
                CreateESPForPlayer(newPlayer)
            end
            conn:Disconnect()
        end)
    end
end

local function OnPlayerRemoving(leavingPlayer)
    DestroyESP(leavingPlayer)
end

local function OnCharacterAdded(targetPlayer)
    if not ESPConfig.Enabled then return end
    if targetPlayer == player then
        -- Người chơi respawn, tạo lại ESP cho tất cả
        task.wait(1)
        CreateAllESP()
    else
        task.wait(0.5)
        CreateESPForPlayer(targetPlayer)
    end
end

-- Đăng ký sự kiện cho từng người chơi
local function SetupPlayerEvents(targetPlayer)
    if targetPlayer == player then return end
    
    targetPlayer.CharacterAdded:Connect(function()
        OnCharacterAdded(targetPlayer)
    end)
end

-- ==================== BẬT/TẮT ESP ====================
local function StartESP()
    if ESPState.UpdateConnection then
        ESPState.UpdateConnection:Disconnect()
    end
    
    ESPState.UpdateConnection = RunService.RenderStepped:Connect(function()
        if ESPConfig.Enabled then
            UpdateESPData()
        end
    end)
end

local function StopESP()
    if ESPState.UpdateConnection then
        ESPState.UpdateConnection:Disconnect()
        ESPState.UpdateConnection = nil
    end
    DestroyAllESP()
end

local function ToggleESP()
    ESPConfig.Enabled = not ESPConfig.Enabled
    
    if ESPConfig.Enabled then
        CreateAllESP()
        StartESP()
        if espBtn then
            espBtn.Text = "ESP PLAYER [ON]"
            espBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 180)
        end
        status.Text = "STATUS : ESP PLAYER ON (Range: " .. ESPConfig.MaxDistance .. ")"
    else
        StopESP()
        if espBtn then
            espBtn.Text = "ESP PLAYER"
            espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
        status.Text = "STATUS : READY"
    end
end

-- ==================== KHỞI TẠO ====================
local function InitializeESP()
    -- Đăng ký sự kiện toàn cục
    Players.PlayerAdded:Connect(OnPlayerAdded)
    Players.PlayerRemoving:Connect(OnPlayerRemoving)
    player.CharacterAdded:Connect(OnCharacterAdded)
    
    -- Đăng ký sự kiện cho người chơi hiện tại
    for _, other in pairs(Players:GetPlayers()) do
        SetupPlayerEvents(other)
    end
    
    print("[ESP PLAYER] Đã khởi tạo thành công!")
    print("   - Khoảng cách tối đa: " .. ESPConfig.MaxDistance .. " studs")
    print("   - Hiển thị: Tên|Máu|Khoảng cách|Khung")
    print("   - Màu sắc: Theo máu và khoảng cách")
end

-- ==================== TẠO NÚT GUI ====================
local espBtn = makeButton("ESP PLAYER", 1, 2, Color3.fromRGB(50, 100, 150))
espBtn.MouseButton1Click:Connect(ToggleESP)

-- Khởi tạo
InitializeESP()--========================
-- POV PLAYER
--========================

local povEnabled = false
local povTarget = nil
local originalCamera = nil

local povBtn = makeButton("POV PLAYER", 2, 1, Color3.fromRGB(80, 150, 200))

local povFrame = Instance.new("Frame")
povFrame.Parent = frame
povFrame.Size = UDim2.new(0, 200, 0, 300)
povFrame.Position = UDim2.new(1, 10, 0, 60)
povFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
povFrame.BackgroundTransparency = 0.1
povFrame.BorderSizePixel = 0
povFrame.Visible = false
povFrame.Active = true
povFrame.Draggable = true

Instance.new("UICorner", povFrame).CornerRadius = UDim.new(0, 10)

local povTitle = Instance.new("TextLabel")
povTitle.Parent = povFrame
povTitle.Size = UDim2.new(1, 0, 0, 30)
povTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
povTitle.Text = "CHON NGUOI XEM"
povTitle.TextColor3 = Color3.new(1, 1, 1)
povTitle.Font = Enum.Font.GothamBold
povTitle.TextSize = 12

local povList = Instance.new("ScrollingFrame")
povList.Parent = povFrame
povList.Size = UDim2.new(1, -10, 1, -40)
povList.Position = UDim2.new(0, 5, 0, 35)
povList.BackgroundTransparency = 1
povList.CanvasSize = UDim2.new(0, 0, 0, 0)
povList.ScrollBarThickness = 5

local povLayout = Instance.new("UIListLayout")
povLayout.Parent = povList
povLayout.SortOrder = Enum.SortOrder.Name
povLayout.Padding = UDim.new(0, 5)

local function saveOriginalCamera()
    originalCamera = workspace.CurrentCamera.CFrame
end

local function returnToOwnCamera()
    if not originalCamera then return end
    local myChar = player.Character
    if myChar and myChar:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = myChar.Humanoid
    end
    workspace.CurrentCamera.CFrame = originalCamera
end

local function spectateThirdPerson(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        status.Text = "STATUS : KHONG TIM THAY NGUOI CHOI"
        return false
    end
    
    local targetChar = targetPlayer.Character
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
    
    if not targetRoot or not targetHumanoid then
        status.Text = "STATUS : KHONG THE XEM"
        return false
    end
    
    if not povEnabled then
        saveOriginalCamera()
    end
    
    workspace.CurrentCamera.CameraSubject = targetHumanoid
    local offset = Vector3.new(5, 3, 8)
    workspace.CurrentCamera.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
    
    povTarget = targetPlayer
    povEnabled = true
    povBtn.Text = "POV PLAYER [ON]"
    povBtn.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    status.Text = "STATUS : DANG XEM " .. targetPlayer.Name
    povFrame.Visible = false
    
    return true
end

local function stopSpectate()
    if povEnabled then
        returnToOwnCamera()
        povEnabled = false
        povTarget = nil
        povBtn.Text = "POV PLAYER"
        povBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

RunService.RenderStepped:Connect(function()
    if povEnabled and povTarget then
        local targetChar = povTarget.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            local targetRoot = targetChar.HumanoidRootPart
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            if targetHumanoid and targetHumanoid.Health > 0 then
                workspace.CurrentCamera.CameraSubject = targetHumanoid
                local offset = Vector3.new(5, 3, 8)
                workspace.CurrentCamera.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
            else
                stopSpectate()
                status.Text = "STATUS : NGUOI CHOI DA CHET"
            end
        else
            stopSpectate()
            status.Text = "STATUS : MAT KET NOI"
        end
    end
end)

local function updatePOVList()
    for _, child in pairs(povList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
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
                spectateThirdPerson(other)
            end)
            
            ySize = ySize + 40
        end
    end
    povList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

povBtn.MouseButton1Click:Connect(function()
    if povEnabled then
        stopSpectate()
    else
        povFrame.Visible = not povFrame.Visible
        if povFrame.Visible then
            updatePOVList()
        end
    end
end)

Players.PlayerAdded:Connect(function()
    if povFrame.Visible then updatePOVList() end
end)

Players.PlayerRemoving:Connect(function()
    if povFrame.Visible then updatePOVList() end
end)

player.CharacterAdded:Connect(function()
    if povEnabled then
        stopSpectate()
    end
end)

--========================
-- INFINITE JUMP
--========================

local infiniteJumpEnabled = false
local jumpBtn = makeButton("INFINITE JUMP", 2, 2, Color3.fromRGB(100, 150, 100))

local function onJumpRequest()
    if not infiniteJumpEnabled then return end
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if hum.FloorMaterial == Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

local jumpConnection = nil

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    
    if infiniteJumpEnabled then
        jumpBtn.Text = "INFINITE JUMP [ON]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(130, 180, 130)
        status.Text = "STATUS : INFINITE JUMP ON"
        if not jumpConnection then
            jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
        end
    else
        jumpBtn.Text = "INFINITE JUMP"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end

jumpBtn.MouseButton1Click:Connect(toggleInfiniteJump)
