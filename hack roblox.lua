--========================
-- SIMPLE TOOL - AIM LOCK & INFINITE JUMP
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

--========================
-- TẠO 2 NÚT TRÊN MÀN HÌNH
--========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleTool"
screenGui.Parent = game.CoreGui

-- Hàm tạo nút (có kéo thả)
local function createMoveButton(text, color, position)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 45)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.BackgroundTransparency = 0.15
    btn.Text = text .. " [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Draggable = true
    btn.Parent = screenGui
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.05
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.15
    end)
    
    return btn
end

-- Tạo 2 nút
local aimBtn = createMoveButton(" AIM LOCK", Color3.fromRGB(80, 50, 130), UDim2.new(0.02, 0, 0.3, -22))
--========================
-- AIM LOCK PRO MAX
-- Version: 5.0
-- Tác giả: Sidbuddb
-- Mô tả: Tự động khóa camera vào đầu người chơi gần nhất
-- Độ chính xác: Cực cao, không rung, lock cứng
-- Hỗ trợ: Phím tắt, tùy chỉnh khoảng cách, chế độ lock mượt/cứng
--========================

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- ==================== CẤU HÌNH AIM LOCK ====================
local AimLockConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    MaxDistance = 300,              -- Khoảng cách tối đa (studs)
    PriorityMode = "Closest",       -- "Closest" (gần nhất) hoặc "LowestHealth" (ít máu)
    AimPart = "Head",               -- "Head", "UpperTorso", "HumanoidRootPart"
    
    -- Cài đặt lock camera
    LockStyle = "Hard",             -- "Hard" (cứng, không rung) hoặc "Smooth" (mượt)
    SmoothnessSpeed = 0.3,          -- Tốc độ lock mượt (0.1 = nhanh, 0.5 = chậm)
    VerticalOffset = 0,             -- Độ lệch dọc (studs)
    HorizontalOffset = 0,           -- Độ lệch ngang (studs)
    
    -- Cài đặt lọc mục tiêu
    CheckLineOfSight = false,       -- Kiểm tra vật cản (tường, chướng ngại)
    AutoSwitchTarget = true,        -- Tự động chuyển target khi target hiện tại chết
    IgnoreTeam = false,             -- Bỏ qua đồng đội
    IgnoreFriends = false,          -- Bỏ qua bạn bè
    
    -- Cài đặt hiển thị
    ShowDistance = false,           -- Hiển thị khoảng cách (debug)
    ShowTargetName = false,         -- Hiển thị tên target (debug)
    ShowNotifications = true,       -- Hiển thị thông báo khi bật/tắt
    
    -- Cài đặt phím tắt
    ToggleKey = Enum.KeyCode.K,     -- Phím bật/tắt
    IncreaseDistanceKey = Enum.KeyCode.RightBracket,   -- Tăng khoảng cách (])
    DecreaseDistanceKey = Enum.KeyCode.LeftBracket,    -- Giảm khoảng cách ([)
    
    -- Giới hạn khoảng cách
    MinDistance = 50,
    MaxDistanceLimit = 500,
    DistanceStep = 25,              -- Bước tăng/giảm khoảng cách
}

-- ==================== BIẾN TOÀN CỤC ====================
local AimLockState = {
    IsActive = false,
    CurrentTarget = nil,
    CurrentDistance = 0,
    CurrentHealth = 0,
    LockConnection = nil,
    LastUpdateTime = 0,
    FrameCount = 0,
    TargetLockedTime = 0,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function GetDistance(pointA, pointB)
    return (pointA - pointB).Magnitude
end

local function GetHealthPercent(humanoid)
    if not humanoid then return 100 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

local function GetHealthColor(healthPercent)
    if healthPercent > 70 then
        return Color3.fromRGB(0, 255, 0)
    elseif healthPercent > 30 then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

-- Kiểm tra target có hợp lệ không
local function IsValidTarget(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == player then return false end
    
    -- Kiểm tra team (nếu bật)
    if AimLockConfig.IgnoreTeam and targetPlayer.Team and player.Team then
        if targetPlayer.Team == player.Team then
            return false
        end
    end
    
    -- Kiểm tra bạn bè (nếu bật)
    if AimLockConfig.IgnoreFriends then
        local isFriend = false
        local friends = player:GetFriends()
        for _, friendId in pairs(friends) do
            if friendId == targetPlayer.UserId then
                isFriend = true
                break
            end
        end
        if isFriend then return false end
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
        if not aimPart then
            return false
        end
    end
    
    return true, humanoid, aimPart
end

-- Lấy vị trí cần aim
local function GetAimPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return nil
    end
    
    local aimPart = targetPlayer.Character:FindFirstChild(AimLockConfig.AimPart)
    if not aimPart then
        aimPart = targetPlayer.Character:FindFirstChild("Head")
        if not aimPart then
            return nil
        end
    end
    
    if not aimPart:IsA("BasePart") then
        return nil
    end
    
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
    if not myChar then return nil, 0, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0, 0 end
    
    local myPos = myRoot.Position
    local closestPlayer = nil
    local shortestDistance = AimLockConfig.MaxDistance + 1
    local closestHealth = 100
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local isValid, humanoid = IsValidTarget(otherPlayer)
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
                            closestHealth = GetHealthPercent(humanoid)
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer, shortestDistance, closestHealth
end

-- Tìm người ít máu nhất (trong khoảng cách cho phép)
local function FindLowestHealthPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0, 0 end
    
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
    
    return lowestHealthPlayer, lowestDistance, lowestHealth
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
    local newCF = currentCF:Lerp(targetCF, AimLockConfig.SmoothnessSpeed)
    camera.CFrame = newCF
    
    return true
end

-- Hàm lock chính
local function LockOntoTarget(targetPlayer)
    if not targetPlayer then return false end
    
    local aimPosition = GetAimPosition(targetPlayer)
    if not aimPosition then return false end
    
    if AimLockConfig.LockStyle == "Hard" then
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
    local newTarget, distance, health = FindBestTarget()
    if newTarget then
        AimLockState.CurrentTarget = newTarget
        AimLockState.CurrentDistance = distance
        AimLockState.CurrentHealth = health
        AimLockState.TargetLockedTime = GetCurrentTime()
        
        if AimLockConfig.ShowTargetName then
            print("[AIM LOCK] New target: " .. newTarget.Name .. " | Distance: " .. math.floor(distance) .. " studs | Health: " .. math.floor(health) .. "%")
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
    if not targetValid and AimLockConfig.AutoSwitchTarget then
        SwitchToNewTarget()
    end
    
    -- Nếu target hợp lệ, lock vào
    if AimLockState.CurrentTarget then
        LockOntoTarget(AimLockState.CurrentTarget)
        
        -- Cập nhật debug (nếu bật)
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
    
    if AimLockConfig.ShowNotifications then
        print("[AIM LOCK] ENABLED - Mode: " .. AimLockConfig.PriorityMode .. " | Distance: " .. AimLockConfig.MaxDistance)
        
        -- Hiển thị thông báo trên màn hình
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(100, 255, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = " AIM LOCK ENABLED"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    end
end

local function DisableAimLock()
    if not AimLockState.IsActive then return end
    
    AimLockState.IsActive = false
    StopAimLock()
    
    if AimLockConfig.ShowNotifications then
        print("[AIM LOCK] DISABLED")
        
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(255, 100, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = " AIM LOCK DISABLED"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    end
end

local function ToggleAimLock()
    if AimLockState.IsActive then
        DisableAimLock()
    else
        EnableAimLock()
    end
end

-- ==================== ĐIỀU CHỈNH KHOẢNG CÁCH ====================
local function IncreaseMaxDistance()
    local newDist = math.min(AimLockConfig.MaxDistanceLimit, AimLockConfig.MaxDistance + AimLockConfig.DistanceStep)
    AimLockConfig.MaxDistance = newDist
    
    if AimLockConfig.ShowNotifications then
        print("[AIM LOCK] Max distance: " .. newDist)
        
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(255, 200, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = " DISTANCE: " .. newDist
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1)
        notif:Destroy()
    end
end

local function DecreaseMaxDistance()
    local newDist = math.max(AimLockConfig.MinDistance, AimLockConfig.MaxDistance - AimLockConfig.DistanceStep)
    AimLockConfig.MaxDistance = newDist
    
    if AimLockConfig.ShowNotifications then
        print("[AIM LOCK] Max distance: " .. newDist)
        
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(255, 200, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = " DISTANCE: " .. newDist
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1)
        notif:Destroy()
    end
end

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Phím bật/tắt AIM LOCK
        if input.KeyCode == AimLockConfig.ToggleKey then
            ToggleAimLock()
        end
        
        -- Phím tăng khoảng cách
        if input.KeyCode == AimLockConfig.IncreaseDistanceKey then
            IncreaseMaxDistance()
            if AimLockState.IsActive then
                -- Nếu đang bật, tìm lại target với khoảng cách mới
                SwitchToNewTarget()
            end
        end
        
        -- Phím giảm khoảng cách
        if input.KeyCode == AimLockConfig.DecreaseDistanceKey then
            DecreaseMaxDistance()
            if AimLockState.IsActive then
                SwitchToNewTarget()
            end
        end
    end)
end

-- ==================== XỬ LÝ SỰ KIỆN ====================
-- Xử lý khi nhân vật respawn
local function OnCharacterRespawn()
    if AimLockState.IsActive then
        task.wait(0.5)
        SwitchToNewTarget()
    end
end

player.CharacterAdded:Connect(OnCharacterRespawn)

-- Xử lý khi người chơi rời game
local function OnPlayerRemoving(leavingPlayer)
    if AimLockState.IsActive and AimLockState.CurrentTarget == leavingPlayer then
        SwitchToNewTarget()
    end
end

Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- Xử lý khi có người chơi mới vào
local function OnPlayerAdded(newPlayer)
    if AimLockState.IsActive then
        -- Có thể tìm lại target nếu cần
        task.wait(0.5)
        if not IsCurrentTargetValid() then
            SwitchToNewTarget()
        end
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)

-- ==================== HÀM EXPORT (DÙNG CHO NÚT GUI) ====================
local function GetAimLockStatus()
    return AimLockState.IsActive
end

local function GetCurrentTargetInfo()
    if not AimLockState.CurrentTarget then
        return nil, nil, nil
    end
    return AimLockState.CurrentTarget.Name, AimLockState.CurrentDistance, AimLockState.CurrentHealth
end

local function SetConfig(newConfig)
    for key, value in pairs(newConfig) do
        if AimLockConfig[key] ~= nil then
            AimLockConfig[key] = value
        end
    end
end

-- ==================== KHỞI TẠO ====================
local function InitializeAimLock()
    SetupHotkeys()
    
    print("=" .. string.rep("=", 60))
    print("AIM LOCK PRO MAX v5.0 LOADED SUCCESSFULLY!")
    print("=" .. string.rep("=", 60))
    print(" CẤU HÌNH HIỆN TẠI:")
    print("   - Priority Mode: " .. AimLockConfig.PriorityMode)
    print("   - Max Distance: " .. AimLockConfig.MaxDistance .. " studs")
    print("   - Aim Part: " .. AimLockConfig.AimPart)
    print("   - Lock Style: " .. AimLockConfig.LockStyle)
    print("   - Line of Sight: " .. (AimLockConfig.CheckLineOfSight and "ON" or "OFF"))
    print("=" .. string.rep("=", 60))
    print(" PHÍM TẮT:")
    print("   - " .. tostring(AimLockConfig.ToggleKey) .. ": Bật/Tắt AIM LOCK")
    print("   - " .. tostring(AimLockConfig.IncreaseDistanceKey) .. ": Tăng khoảng cách")
    print("   - " .. tostring(AimLockConfig.DecreaseDistanceKey) .. ": Giảm khoảng cách")
    print("=" .. string.rep("=", 60))
    
    -- Trả về API
    return {
        toggle = ToggleAimLock,
        enable = EnableAimLock,
        disable = DisableAimLock,
        isEnabled = GetAimLockStatus,
        getTarget = GetCurrentTargetInfo,
        setConfig = SetConfig,
        increaseDistance = IncreaseMaxDistance,
        decreaseDistance = DecreaseMaxDistance,
        getConfig = function() return AimLockConfig end,
    }
end

-- Chạy khởi tạo (nếu không muốn tự động, hãy comment dòng này và gọi thủ công)
local AimLockAPI = InitializeAimLock()

-- Ví dụ tạo nút đơn giản (nếu muốn dùng GUI, bỏ comment):
-- local screenGui = Instance.new("ScreenGui")
-- screenGui.Parent = game.CoreGui
-- local btn = Instance.new("TextButton")
-- btn.Size = UDim2.new(0, 150, 0, 45)
-- btn.Position = UDim2.new(0.02, 0, 0.3, 0)
-- btn.Text = "AIM LOCK"
-- btn.BackgroundColor3 = Color3.fromRGB(80, 50, 130)
-- btn.Parent = screenGui
-- btn.MouseButton1Click:Connect(function()
--     AimLockAPI.toggle()
--     btn.Text = AimLockAPI.isEnabled() and "AIM LOCK [ON]" or "AIM LOCK [OFF]"
--     btn.BackgroundColor3 = AimLockAPI.isEnabled() and Color3.fromRGB(130, 80, 180) or Color3.fromRGB(80, 50, 130)
-- end)
local jumpBtn = createMoveButton(" INFINITE JUMP", Color3.fromRGB(60, 100, 80), UDim2.new(0.02, 0, 0.4, -22))
--========================
-- INFINITE JUMP PRO MAX
-- Version: 4.0
-- Tác giả: Sidbuddb
-- Mô tả: Cho phép nhảy vô hạn trên không, tùy chỉnh lực nhảy, nhiều chế độ
-- Tính năng: Chống anti-cheat, tăng/giảm lực nhảy, phím tắt, thanh trượt GUI
--========================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- ==================== CẤU HÌNH INFINITE JUMP ====================
local JumpConfig = {
    -- Cài đặt cơ bản
    Enabled = false,
    JumpPower = 65,                 -- Lực nhảy hiện tại (mặc định 50)
    
    -- Giới hạn lực nhảy
    MinJumpPower = 40,              -- Lực nhảy tối thiểu
    MaxJumpPower = 150,             -- Lực nhảy tối đa
    JumpPowerStep = 5,              -- Bước tăng/giảm lực nhảy
    
    -- Chế độ hoạt động
    Mode = "Infinite",              -- "Infinite" (nhảy liên tục) hoặc "Super" (mỗi lần nhảy cực cao)
    AntiCheatBypass = true,         -- Chế độ tránh anti-cheat (set jump power trước khi nhảy)
    AirJumpOnly = true,             -- Chỉ nhảy khi đang ở trên không (true = nhảy vô hạn, false = nhảy kể cả trên đất)
    
    -- Cài đặt phím tắt
    ToggleKey = Enum.KeyCode.J,     -- Phím bật/tắt (J)
    IncreaseKey = Enum.KeyCode.RightBracket,  -- Tăng lực nhảy (])
    DecreaseKey = Enum.KeyCode.LeftBracket,   -- Giảm lực nhảy ([)
    
    -- Cài đặt hiển thị
    ShowNotifications = true,       -- Hiển thị thông báo
    ShowJumpPower = true,           -- Hiển thị lực nhảy hiện tại
    ShowStatus = true,              -- Hiển thị trạng thái
    
    -- Cài đặt nâng cao
    PreserveVelocity = true,        -- Giữ vận tốc khi nhảy (tạo cảm giác mượt)
    ResetOnRespawn = true,          -- Reset trạng thái khi chết/respawn
    AllowWhileDead = false,         -- Cho phép nhảy khi đang chết (không khuyến khích)
}

-- ==================== BIẾN TOÀN CỤC ====================
local JumpState = {
    IsActive = false,
    OriginalJumpPower = nil,        -- Lưu lực nhảy gốc để khôi phục
    JumpConnection = nil,
    LastJumpTime = 0,
    JumpCount = 0,
    LastGroundTime = 0,
    IsInAir = false,
    AntiCheatTimer = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function GetHumanoid()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

local function GetCharacterRoot()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
end

local function IsCharacterAlive()
    local hum = GetHumanoid()
    if not hum then return false end
    if hum.Health <= 0 then return false end
    return true
end

local function IsInAir()
    local hum = GetHumanoid()
    if not hum then return false end
    return hum.FloorMaterial == Enum.Material.Air
end

-- ==================== QUẢN LÝ LỰC NHẢY GỐC ====================
local function SaveOriginalJumpPower()
    local hum = GetHumanoid()
    if hum and JumpState.OriginalJumpPower == nil then
        JumpState.OriginalJumpPower = hum.JumpPower
        if JumpConfig.ShowNotifications then
            print("[INFINITE JUMP] Saved original jump power: " .. JumpState.OriginalJumpPower)
        end
    end
end

local function RestoreOriginalJumpPower()
    local hum = GetHumanoid()
    if hum and JumpState.OriginalJumpPower then
        hum.JumpPower = JumpState.OriginalJumpPower
        if JumpConfig.ShowNotifications then
            print("[INFINITE JUMP] Restored original jump power: " .. JumpState.OriginalJumpPower)
        end
    end
end

-- ==================== ĐIỀU CHỈNH LỰC NHẢY ====================
local function SetJumpPower(value)
    local hum = GetHumanoid()
    if hum then
        local clampedValue = math.clamp(value, JumpConfig.MinJumpPower, JumpConfig.MaxJumpPower)
        hum.JumpPower = clampedValue
        if JumpConfig.JumpPower ~= clampedValue then
            JumpConfig.JumpPower = clampedValue
        end
        return clampedValue
    end
    return JumpConfig.JumpPower
end

local function IncreaseJumpPower(amount)
    amount = amount or JumpConfig.JumpPowerStep
    local newPower = math.min(JumpConfig.MaxJumpPower, JumpConfig.JumpPower + amount)
    JumpConfig.JumpPower = newPower
    
    if JumpState.IsActive then
        SetJumpPower(newPower)
    end
    
    if JumpConfig.ShowJumpPower then
        print("[INFINITE JUMP] Jump power increased to: " .. newPower)
    end
    
    return newPower
end

local function DecreaseJumpPower(amount)
    amount = amount or JumpConfig.JumpPowerStep
    local newPower = math.max(JumpConfig.MinJumpPower, JumpConfig.JumpPower - amount)
    JumpConfig.JumpPower = newPower
    
    if JumpState.IsActive then
        SetJumpPower(newPower)
    end
    
    if JumpConfig.ShowJumpPower then
        print("[INFINITE JUMP] Jump power decreased to: " .. newPower)
    end
    
    return newPower
end

local function SetJumpPowerDirect(value)
    local newValue = math.clamp(value, JumpConfig.MinJumpPower, JumpConfig.MaxJumpPower)
    JumpConfig.JumpPower = newValue
    
    if JumpState.IsActive then
        SetJumpPower(newValue)
    end
    
    if JumpConfig.ShowJumpPower then
        print("[INFINITE JUMP] Jump power set to: " .. newValue)
    end
    
    return newValue
end

-- ==================== CƠ CHẾ NHẢY CHÍNH ====================
-- Chế độ bình thường
local function PerformNormalJump()
    local hum = GetHumanoid()
    if not hum then return false end
    if not IsCharacterAlive() then return false end
    
    -- Set lực nhảy
    hum.JumpPower = JumpConfig.JumpPower
    
    -- Thực hiện nhảy (chỉ khi ở trên không nếu bật AirJumpOnly)
    if JumpConfig.AirJumpOnly then
        if IsInAir() then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            return true
        end
    else
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        return true
    end
    
    return false
end

-- Chế độ siêu nhảy (lực nhảy tối đa)
local function PerformSuperJump()
    local hum = GetHumanoid()
    if not hum then return false end
    if not IsCharacterAlive() then return false end
    
    hum.JumpPower = JumpConfig.MaxJumpPower
    
    if JumpConfig.AirJumpOnly then
        if IsInAir() then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            return true
        end
    else
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        return true
    end
    
    return false
end

-- Chế độ chống anti-cheat: set lực nhảy, nhảy, sau đó khôi phục
local function AntiCheatJump()
    local hum = GetHumanoid()
    if not hum then return false end
    if not IsCharacterAlive() then return false end
    
    -- Lưu lực nhảy gốc nếu chưa có
    SaveOriginalJumpPower()
    
    -- Set lực nhảy theo chế độ
    if JumpConfig.Mode == "Super" then
        hum.JumpPower = JumpConfig.MaxJumpPower
    else
        hum.JumpPower = JumpConfig.JumpPower
    end
    
    -- Thực hiện nhảy
    local success = false
    if JumpConfig.AirJumpOnly then
        if IsInAir() then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
            success = true
        end
    else
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        success = true
    end
    
    -- Khôi phục lực nhảy gốc sau 0.05 giây
    task.spawn(function()
        task.wait(0.05)
        if hum and JumpState.OriginalJumpPower then
            hum.JumpPower = JumpState.OriginalJumpPower
        end
    end)
    
    return success
end

-- Hàm nhảy chính
local function PerformJump()
    if not JumpState.IsActive then return false end
    
    if JumpConfig.AntiCheatBypass then
        return AntiCheatJump()
    else
        if JumpConfig.Mode == "Super" then
            return PerformSuperJump()
        else
            return PerformNormalJump()
        end
    end
end

-- ==================== XỬ LÝ SỰ KIỆN NHẢY ====================
local function OnJumpRequest()
    if not JumpState.IsActive then return end
    
    local currentTime = GetCurrentTime()
    JumpState.LastJumpTime = currentTime
    JumpState.JumpCount = JumpState.JumpCount + 1
    
    PerformJump()
    
    if JumpConfig.ShowNotifications and JumpState.JumpCount % 10 == 0 then
        print("[INFINITE JUMP] Jump count: " .. JumpState.JumpCount)
    end
end

-- ==================== THEO DÕI TRẠNG THÁI TRÊN KHÔNG ====================
local function StartAirStatusMonitor()
    RunService.RenderStepped:Connect(function()
        if not JumpState.IsActive then return end
        
        local isInAir = IsInAir()
        if isInAir ~= JumpState.IsInAir then
            JumpState.IsInAir = isInAir
            if not isInAir then
                JumpState.LastGroundTime = GetCurrentTime()
            end
        end
    end)
end

-- ==================== BẬT/TẮT INFINITE JUMP ====================
local function EnableInfiniteJump()
    if JumpState.IsActive then return end
    
    JumpState.IsActive = true
    
    -- Lưu lực nhảy gốc
    SaveOriginalJumpPower()
    
    -- Set lực nhảy hiện tại
    SetJumpPower(JumpConfig.JumpPower)
    
    -- Kết nối sự kiện nhảy
    if JumpState.JumpConnection then
        JumpState.JumpConnection:Disconnect()
    end
    JumpState.JumpConnection = UserInputService.JumpRequest:Connect(OnJumpRequest)
    
    if JumpConfig.ShowNotifications then
        print("[INFINITE JUMP] ENABLED | Mode: " .. JumpConfig.Mode .. " | Power: " .. JumpConfig.JumpPower)
        
        -- Hiển thị thông báo trên màn hình
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(100, 255, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = "🦘 INFINITE JUMP ENABLED"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    end
end

local function DisableInfiniteJump()
    if not JumpState.IsActive then return end
    
    JumpState.IsActive = false
    
    -- Ngắt kết nối
    if JumpState.JumpConnection then
        JumpState.JumpConnection:Disconnect()
        JumpState.JumpConnection = nil
    end
    
    -- Khôi phục lực nhảy gốc
    RestoreOriginalJumpPower()
    
    if JumpConfig.ShowNotifications then
        print("[INFINITE JUMP] DISABLED")
        
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(255, 100, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = "🦘 INFINITE JUMP DISABLED"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    end
end

local function ToggleInfiniteJump()
    if JumpState.IsActive then
        DisableInfiniteJump()
    else
        EnableInfiniteJump()
    end
end

-- ==================== ĐỔI CHẾ ĐỘ ====================
local function SetMode(mode)
    if mode == "Infinite" or mode == "Super" then
        JumpConfig.Mode = mode
        if JumpConfig.ShowNotifications then
            print("[INFINITE JUMP] Mode changed to: " .. mode)
        end
        return true
    end
    return false
end

local function ToggleMode()
    if JumpConfig.Mode == "Infinite" then
        SetMode("Super")
    else
        SetMode("Infinite")
    end
end

-- ==================== THIẾT LẬP PHÍM TẮT ====================
local function SetupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Phím bật/tắt Infinite Jump (J)
        if input.KeyCode == JumpConfig.ToggleKey then
            ToggleInfiniteJump()
        end
        
        -- Phím tăng lực nhảy (])
        if input.KeyCode == JumpConfig.IncreaseKey then
            local newPower = IncreaseJumpPower()
            if JumpConfig.ShowNotifications then
                print("[INFINITE JUMP] Jump power: " .. newPower)
            end
        end
        
        -- Phím giảm lực nhảy ([)
        if input.KeyCode == JumpConfig.DecreaseKey then
            local newPower = DecreaseJumpPower()
            if JumpConfig.ShowNotifications then
                print("[INFINITE JUMP] Jump power: " .. newPower)
            end
        end
    end)
end

-- ==================== TẠO THANH TRƯỢT GUI ====================
local function CreateSliderGUI()
    -- Chỉ tạo nếu người dùng muốn
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "JumpPowerSlider"
    screenGui.Parent = game.CoreGui
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
    sliderFrame.Position = UDim2.new(0.02, 0, 0.5, 50)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    sliderFrame.BackgroundTransparency = 0.2
    sliderFrame.BorderSizePixel = 0
    sliderFrame.Parent = screenGui
    
    local sliderCorner = Instance.new("UICorner")
    sliderCorner.CornerRadius = UDim.new(0, 8)
    sliderCorner.Parent = sliderFrame
    
    local sliderLabel = Instance.new("TextLabel")
    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
    sliderLabel.BackgroundTransparency = 1
    sliderLabel.Text = "⚡ JUMP POWER: " .. JumpConfig.JumpPower
    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sliderLabel.TextSize = 11
    sliderLabel.Font = Enum.Font.GothamBold
    sliderLabel.Parent = sliderFrame
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(0.8, 0, 0, 6)
    sliderBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = sliderFrame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((JumpConfig.JumpPower - JumpConfig.MinJumpPower) / (JumpConfig.MaxJumpPower - JumpConfig.MinJumpPower), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 140, 200)
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBar
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 12, 0, 12)
    sliderButton.Position = UDim2.new(sliderFill.Size.X.Scale, -6, 0.5, -6)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.Parent = sliderBar
    
    local dragging = false
    
    local function UpdateSlider(input)
        local pos = input.Position.X - sliderBar.AbsolutePosition.X
        local percent = math.clamp(pos / sliderBar.AbsoluteSize.X, 0, 1)
        local newPower = math.floor(JumpConfig.MinJumpPower + percent * (JumpConfig.MaxJumpPower - JumpConfig.MinJumpPower))
        SetJumpPowerDirect(newPower)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderButton.Position = UDim2.new(percent, -6, 0.5, -6)
        sliderLabel.Text = "⚡ JUMP POWER: " .. JumpConfig.JumpPower
    end
    
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            UpdateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return sliderFrame
end

-- ==================== XỬ LÝ RESPAWN ====================
local function OnCharacterRespawn()
    if JumpConfig.ResetOnRespawn then
        if JumpState.IsActive then
            -- Tạm thời tắt và bật lại để reset
            local wasActive = JumpState.IsActive
            if wasActive then
                DisableInfiniteJump()
                task.wait(0.2)
                EnableInfiniteJump()
            end
        else
            -- Chỉ lưu lực nhảy gốc
            SaveOriginalJumpPower()
        end
    end
end

player.CharacterAdded:Connect(OnCharacterRespawn)

-- ==================== XỬ LÝ KHI THOÁT GAME ====================
local function OnPlayerShutdown()
    if JumpState.IsActive then
        RestoreOriginalJumpPower()
    end
end

game:BindToClose(OnPlayerShutdown)

-- ==================== KHỞI TẠO ====================
local function InitializeInfiniteJump()
    SetupHotkeys()
    StartAirStatusMonitor()
    
    print("=" .. string.rep("=", 60))
    print("INFINITE JUMP PRO MAX v4.0 LOADED SUCCESSFULLY!")
    print("=" .. string.rep("=", 60))
    print("📌 CẤU HÌNH HIỆN TẠI:")
    print("   - Mode: " .. JumpConfig.Mode)
    print("   - Jump Power: " .. JumpConfig.JumpPower)
    print("   - Anti-Cheat Bypass: " .. (JumpConfig.AntiCheatBypass and "ON" or "OFF"))
    print("   - Air Jump Only: " .. (JumpConfig.AirJumpOnly and "ON" (nhảy vô hạn) or "OFF" (nhảy kể cả trên đất)))
    print("=" .. string.rep("=", 60))
    print("🎮 PHÍM TẮT:")
    print("   - " .. tostring(JumpConfig.ToggleKey) .. ": Bật/Tắt INFINITE JUMP")
    print("   - " .. tostring(JumpConfig.IncreaseKey) .. ": Tăng lực nhảy")
    print("   - " .. tostring(JumpConfig.DecreaseKey) .. ": Giảm lực nhảy")
    print("=" .. string.rep("=", 60))
    
    -- Trả về API
    return {
        toggle = ToggleInfiniteJump,
        enable = EnableInfiniteJump,
        disable = DisableInfiniteJump,
        isEnabled = function() return JumpState.IsActive end,
        increasePower = IncreaseJumpPower,
        decreasePower = DecreaseJumpPower,
        setPower = SetJumpPowerDirect,
        getPower = function() return JumpConfig.JumpPower end,
        setMode = SetMode,
        toggleMode = ToggleMode,
        getMode = function() return JumpConfig.Mode end,
        createSlider = CreateSliderGUI,
        setConfig = function(newConfig)
            for key, value in pairs(newConfig) do
                if JumpConfig[key] ~= nil then
                    JumpConfig[key] = value
                end
            end
        end,
        getConfig = function() return JumpConfig end,
    }
end

-- Chạy khởi tạo
local JumpAPI = InitializeInfiniteJump()

-- Ví dụ tạo nút đơn giản (bỏ comment nếu muốn)
-- local screenGui = Instance.new("ScreenGui")
-- screenGui.Parent = game.CoreGui
-- local btn = Instance.new("TextButton")
-- btn.Size = UDim2.new(0, 150, 0, 45)
-- btn.Position = UDim2.new(0.02, 0, 0.4, 0)
-- btn.Text = "INFINITE JUMP"
-- btn.BackgroundColor3 = Color3.fromRGB(60, 100, 80)
-- btn.Parent = screenGui
-- btn.MouseButton1Click:Connect(function()
--     JumpAPI.toggle()
--     btn.Text = JumpAPI.isEnabled() and "INFINITE JUMP [ON]" or "INFINITE JUMP [OFF]"
--     btn.BackgroundColor3 = JumpAPI.isEnabled() and Color3.fromRGB(100, 150, 120) or Color3.fromRGB(60, 100, 80)
-- end)
