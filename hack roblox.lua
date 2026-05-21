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
-- Version: 5.0
-- Tác giả: Sidbuddb
-- Mô tả: Tự động xoay camera vào đầu người chơi gần nhất hoặc ít máu nhất, nhiều tùy chỉnh
--========================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

-- ==================== CẤU HÌNH AIM LOCK ====================
local AimLockConfig = {
    Enabled = false,
    MaxDistance = 250,              -- Khoảng cách tối đa (studs)
    PriorityMode = "Closest",       -- "Closest" hoặc "LowestHealth"
    AimPart = "Head",               -- "Head", "UpperTorso", "HumanoidRootPart"
    LockSmoothness = 0,             -- 0 = cứng, 1-10 = mượt
    SmoothnessSpeed = 5,            -- Tốc độ mượt (nếu LockSmoothness > 0)
    VerticalOffset = 0,             -- Độ lệch dọc (studs)
    HorizontalOffset = 0,           -- Độ lệch ngang (studs)
    CheckLineOfSight = false,       -- Chỉ aim nếu không bị vật cản
    AutoSwitchTarget = true,        -- Tự chuyển khi target chết
    RequireTool = false,            -- Chỉ aim khi cầm tool
    AllowedTools = {},              -- Tên tool được phép
    IgnoreTeam = false,             -- Bỏ qua đồng đội
    TeamCheck = false,              -- Bật để dùng team color
    TargetTeamColor = nil,          -- Màu team cần aim (nếu có)
    ShowDebug = false,              -- In thông tin debug ra console
    ShowDistance = false,           -- Hiển thị khoảng cách trên status
    ShowTargetName = false,         -- Hiển thị tên target trên status
    ToggleKey = Enum.KeyCode.K,     -- Phím bật/tắt
    IncreaseDistanceKey = Enum.KeyCode.RightBracket,   -- Tăng khoảng cách tối đa
    DecreaseDistanceKey = Enum.KeyCode.LeftBracket,    -- Giảm khoảng cách tối đa
    DistanceStep = 10,              -- Bước tăng/giảm
    MinDistance = 50,
    MaxDistanceLimit = 500,
}

-- ==================== BIẾN TOÀN CỤC ====================
local AimLockState = {
    IsActive = false,
    CurrentTarget = nil,
    LastTarget = nil,
    LockConnection = nil,
    LastUpdateTime = 0,
    FrameCounter = 0,
    DebugInfo = "",
}

-- ==================== HÀM TIỆN ÍCH ====================
local function GetCurrentTime()
    return tick()
end

local function GetDistance(pointA, pointB)
    return (pointA - pointB).Magnitude
end

local function GetHealthPercent(humanoid)
    if not humanoid then return 0 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

-- Kiểm tra tool
local function HasRequiredTool()
    if not AimLockConfig.RequireTool then return true end
    local char = player.Character
    if not char then return false end
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            if #AimLockConfig.AllowedTools == 0 then return true end
            for _, allowed in pairs(AimLockConfig.AllowedTools) do
                if tool.Name:lower():find(allowed:lower()) then return true end
            end
        end
    end
    return false
end

-- Kiểm tra team
local function IsValidTeam(targetPlayer)
    if not AimLockConfig.IgnoreTeam then return true end
    if not player.Team or not targetPlayer.Team then return true end
    if AimLockConfig.TeamCheck then
        return targetPlayer.Team == AimLockConfig.TargetTeamColor
    end
    return targetPlayer.Team ~= player.Team
end

-- Kiểm tra line of sight (vật cản)
local function HasLineOfSight(targetPosition)
    if not AimLockConfig.CheckLineOfSight then return true end
    local camera = workspace.CurrentCamera
    if not camera then return true end
    local origin = camera.CFrame.Position
    local direction = (targetPosition - origin).Unit
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {player.Character, workspace.CurrentCamera}
    local result = workspace:Raycast(origin, direction * AimLockConfig.MaxDistance, raycastParams)
    if result then
        local hitDist = GetDistance(origin, result.Position)
        local targetDist = GetDistance(origin, targetPosition)
        return hitDist >= targetDist - 2
    end
    return true
end

-- Lấy vị trí cần aim (dựa trên AimPart)
local function GetAimPosition(character)
    if not character then return nil end
    local part = character:FindFirstChild(AimLockConfig.AimPart)
    if not part then
        part = character:FindFirstChild("Head") or 
               character:FindFirstChild("UpperTorso") or 
               character:FindFirstChild("HumanoidRootPart")
    end
    if part and part:IsA("BasePart") then
        return part.Position + Vector3.new(AimLockConfig.HorizontalOffset, AimLockConfig.VerticalOffset, 0)
    end
    return nil
end

-- Kiểm tra target có hợp lệ không
local function IsValidTarget(targetPlayer)
    if not targetPlayer or targetPlayer == player then return false end
    if not IsValidTeam(targetPlayer) then return false end
    local character = targetPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    local aimPos = GetAimPosition(character)
    if not aimPos then return false end
    if not HasLineOfSight(aimPos) then return false end
    return true, humanoid, character, aimPos
end

-- Tìm mục tiêu theo chế độ
local function FindBestTarget()
    if not HasRequiredTool() then return nil, nil end
    
    local myChar = player.Character
    if not myChar then return nil, nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, nil end
    local myPos = myRoot.Position
    
    local bestTarget = nil
    local bestValue = (AimLockConfig.PriorityMode == "Closest") and (AimLockConfig.MaxDistance + 1) or 101
    local bestDistance = AimLockConfig.MaxDistance + 1
    local bestHealth = 101
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local isValid = IsValidTarget(other)
            if isValid then
                local character = other.Character
                local root = character:FindFirstChild("HumanoidRootPart")
                if root then
                    local distance = GetDistance(myPos, root.Position)
                    if distance <= AimLockConfig.MaxDistance then
                        local humanoid = character:FindFirstChild("Humanoid")
                        local healthPercent = GetHealthPercent(humanoid)
                        
                        if AimLockConfig.PriorityMode == "Closest" then
                            if distance < bestValue then
                                bestValue = distance
                                bestTarget = other
                                bestDistance = distance
                                bestHealth = healthPercent
                            end
                        else -- LowestHealth
                            if healthPercent < bestValue then
                                bestValue = healthPercent
                                bestTarget = other
                                bestDistance = distance
                                bestHealth = healthPercent
                            elseif healthPercent == bestValue and distance < bestDistance then
                                bestTarget = other
                                bestDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    
    if bestTarget then
        if AimLockConfig.ShowDebug then
            print(string.format("[AIM] Target: %s | Distance: %.1f | Health: %.1f%%", 
                  bestTarget.Name, bestDistance, bestHealth))
        end
        return bestTarget, bestDistance
    end
    return nil, nil
end

-- ==================== LOCK CAMERA ====================
local function LockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    local cameraPos = camera.CFrame.Position
    camera.CFrame = CFrame.new(cameraPos, targetPosition)
    return true
end

local function LockCameraSmooth(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPosition)
    local alpha = math.min(1, AimLockConfig.SmoothnessSpeed / 10)
    camera.CFrame = currentCF:Lerp(targetCF, alpha)
    return true
end

local function LockOntoTarget(targetPlayer)
    if not targetPlayer then return false end
    local character = targetPlayer.Character
    if not character then return false end
    local aimPos = GetAimPosition(character)
    if not aimPos then return false end
    
    if AimLockConfig.LockSmoothness <= 0 then
        return LockCameraHard(aimPos)
    else
        return LockCameraSmooth(aimPos)
    end
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function AimLockUpdate()
    if not AimLockState.IsActive then return end
    
    -- Kiểm tra target hiện tại còn hợp lệ không
    local targetValid = false
    if AimLockState.CurrentTarget then
        targetValid = IsValidTarget(AimLockState.CurrentTarget)
    end
    
    -- Nếu target không hợp lệ hoặc tự động chuyển, tìm target mới
    if not targetValid or (AimLockConfig.AutoSwitchTarget and AimLockState.CurrentTarget) then
        local newTarget, distance = FindBestTarget()
        if newTarget then
            AimLockState.CurrentTarget = newTarget
            if AimLockConfig.ShowTargetName then
                status.Text = "AIMING: " .. newTarget.Name
            elseif AimLockConfig.ShowDistance then
                status.Text = string.format("DISTANCE: %.1f m", distance)
            end
        else
            AimLockState.CurrentTarget = nil
            if AimLockConfig.ShowTargetName or AimLockConfig.ShowDistance then
                status.Text = "AIM LOCK: NO TARGET"
            end
        end
    end
    
    -- Lock vào target
    if AimLockState.CurrentTarget then
        LockOntoTarget(AimLockState.CurrentTarget)
    end
end

-- Khởi động vòng lặp
local function StartAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
    end
    AimLockState.LockConnection = RunService.RenderStepped:Connect(AimLockUpdate)
end

local function StopAimLock()
    if AimLockState.LockConnection then
        AimLockState.LockConnection:Disconnect()
        AimLockState.LockConnection = nil
    end
    AimLockState.CurrentTarget = nil
end

-- ==================== ĐIỀU KHIỂN PHÍM TẮT ====================
local function SetupHotkeys()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        -- Phím bật/tắt
        if input.KeyCode == AimLockConfig.ToggleKey then
            ToggleAimLock()
        end
        
        -- Phím tăng khoảng cách tối đa
        if input.KeyCode == AimLockConfig.IncreaseDistanceKey then
            local newDist = math.min(AimLockConfig.MaxDistanceLimit, AimLockConfig.MaxDistance + AimLockConfig.DistanceStep)
            AimLockConfig.MaxDistance = newDist
            if AimLockState.IsActive then
                status.Text = "MAX DISTANCE: " .. newDist
                task.wait(1)
                if AimLockState.IsActive and AimLockState.CurrentTarget then
                    status.Text = "AIMING: " .. (AimLockState.CurrentTarget.Name or "?")
                end
            end
        end
        
        -- Phím giảm khoảng cách tối đa
        if input.KeyCode == AimLockConfig.DecreaseDistanceKey then
            local newDist = math.max(AimLockConfig.MinDistance, AimLockConfig.MaxDistance - AimLockConfig.DistanceStep)
            AimLockConfig.MaxDistance = newDist
            if AimLockState.IsActive then
                status.Text = "MAX DISTANCE: " .. newDist
                task.wait(1)
                if AimLockState.IsActive and AimLockState.CurrentTarget then
                    status.Text = "AIMING: " .. (AimLockState.CurrentTarget.Name or "?")
                end
            end
        end
    end)
end

-- ==================== BẬT / TẮT ====================
local function ShowNotification(message, isSuccess)
    local notif = Instance.new("TextLabel")
    notif.Parent = game.CoreGui
    notif.Size = UDim2.new(0, 250, 0, 40)
    notif.Position = UDim2.new(0.5, -125, 0.85, 0)
    notif.BackgroundColor3 = isSuccess and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(80, 0, 0)
    notif.BackgroundTransparency = 0.3
    notif.TextColor3 = isSuccess and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 14
    notif.Text = message
    notif.TextStrokeTransparency = 0.3
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    task.wait(1.5)
    notif:Destroy()
end

local function ToggleAimLock()
    AimLockState.IsActive = not AimLockState.IsActive
    
    if AimLockState.IsActive then
        StartAimLock()
        if aimBtn then
            aimBtn.Text = "AIM LOCK [ON]"
            aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        end
        status.Text = "AIM LOCK: ACTIVE (MaxDist=" .. AimLockConfig.MaxDistance .. ")"
        ShowNotification("AIM LOCK ON - Khoảng cách " .. AimLockConfig.MaxDistance, true)
    else
        StopAimLock()
        if aimBtn then
            aimBtn.Text = "AIM LOCK"
            aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        end
        status.Text = "STATUS : READY"
        ShowNotification("AIM LOCK OFF", true)
    end
end

-- ==================== XỬ LÝ SỰ KIỆN ====================
local function OnCharacterRespawn()
    if AimLockState.IsActive then
        AimLockState.CurrentTarget = nil
        ShowNotification("AIM LOCK: Respawn - Tiếp tục theo dõi", true)
    end
end

local function OnPlayerRemoving(leavingPlayer)
    if AimLockState.IsActive and AimLockState.CurrentTarget == leavingPlayer then
        AimLockState.CurrentTarget = nil
    end
end

player.CharacterAdded:Connect(OnCharacterRespawn)
Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- ==================== TẠO NÚT GUI ====================
local aimBtn = makeButton("AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))
aimBtn.MouseButton1Click:Connect(ToggleAimLock)

-- ==================== KHỞI TẠO ====================
SetupHotkeys()
print("[AIM LOCK PRO MAX] Đã sẵn sàng")
print("   - Ưu tiên: " .. AimLockConfig.PriorityMode)
print("   - Khoảng cách: " .. AimLockConfig.MaxDistance)
print("   - Phím bật/tắt: " .. tostring(AimLockConfig.ToggleKey))
print("   - Phím tăng/giảm khoảng cách: ] / [")
--========================
-- ESP PLAYER PRO MAX (KHÔNG GOTO)
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
    local old = espObjects[targetPlayer]
    if old then
        if old.billboard then pcall(function() old.billboard:Destroy() end) end
        if old.box then pcall(function() old.box:Destroy() end) end
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
        nameLabel = nameLabel,
        character = char
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
end)
end)
--========================
-- AUTO CLICKER SIÊU NHANH (LÊN TỚI 100 CPS)
--========================
local autoClickerEnabled = false
local clickCPS = 200               -- mặc định 30 clicks/giây (rất nhanh)
local clickInterval = 1 / clickCPS
local clickThread = nil
local isRunning = false

local autoClickerBtn = makeButton("AUTO CLICKER", 2, 1, Color3.fromRGB(200, 150, 50))
local incBtn = makeButton("+", 3, 2, Color3.fromRGB(80, 80, 100))
local decBtn = makeButton("-", 4, 1, Color3.fromRGB(80, 80, 100))
local cpsLabel = makeButton("CPS:30", 4, 2, Color3.fromRGB(60, 60, 80))

-- Hàm thực hiện click (tối ưu, bỏ qua kiểm tra không cần thiết)
local function doClick()
    local char = player.Character
    if not char then return end
    
    -- Duyệt tool nhanh, chỉ lấy remote cần thiết
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            -- ClickEvent phổ biến nhất
            local clickEvent = tool:FindFirstChild("ClickEvent")
            if clickEvent and clickEvent:IsA("RemoteEvent") then
                clickEvent:FireServer()
            end
            -- Activate
            local activate = tool:FindFirstChild("Activate")
            if activate and activate:IsA("RemoteEvent") then
                activate:FireServer()
            end
            -- Xử lý Handle + ClickDetector nhanh
            local handle = tool:FindFirstChild("Handle")
            if handle then
                local detector = handle:FindFirstChild("ClickDetector")
                if detector then
                    detector:Click()
                end
            end
        end
    end
end

-- Vòng lặp click riêng (chạy ngầm, không ảnh hưởng FPS)
local function clickLoop()
    while isRunning do
        local startTick = os.clock()
        if autoClickerEnabled then
            doClick()
        end
        local elapsed = os.clock() - startTick
        local sleepTime = clickInterval - elapsed
        if sleepTime > 0 then
            task.wait(sleepTime)
        else
            task.wait(0)  -- nhường thời gian thực thi
        end
    end
end

local function startClickThread()
    if clickThread then return end
    isRunning = true
    clickThread = task.spawn(clickLoop)
end

local function stopClickThread()
    isRunning = false
    clickThread = nil
end

-- Cập nhật tốc độ
local function updateCPS()
    clickInterval = 1 / clickCPS
    cpsLabel.Text = "CPS:" .. clickCPS
    if autoClickerEnabled then
        stopClickThread()
        startClickThread()
    end
end

-- Tăng CPS
incBtn.MouseButton1Click:Connect(function()
    clickCPS = math.min(100, clickCPS + 5)
    updateCPS()
end)

-- Giảm CPS
decBtn.MouseButton1Click:Connect(function()
    clickCPS = math.max(10, clickCPS - 5)
    updateCPS()
end)

-- Bật/tắt
local function toggleAutoClicker()
    autoClickerEnabled = not autoClickerEnabled
    if autoClickerEnabled then
        autoClickerBtn.Text = "AUTO CLICKER [ON]"
        autoClickerBtn.BackgroundColor3 = Color3.fromRGB(230, 180, 70)
        status.Text = "STATUS : AUTO CLICKER (" .. clickCPS .. " CPS)"
        startClickThread()
    else
        autoClickerBtn.Text = "AUTO CLICKER"
        autoClickerBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        stopClickThread()
    end
end

autoClickerBtn.MouseButton1Click:Connect(toggleAutoClicker)

player.CharacterAdded:Connect(function()
    if autoClickerEnabled then
        stopClickThread()
        startClickThread()
    end
end)======================
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
--========================
-- HITBOX SHRINK (THU NHỎ CỰC NHỎ)
--========================
local shrinkEnabled = false
local scaleFactor = 0.2          -- tỷ lệ thu nhỏ (0.2 = còn 20% kích thước)
local originalSizes = {}          -- lưu kích thước gốc

local shrinkBtn = makeButton("SHRINK", 3, 2, Color3.fromRGB(150, 50, 200))

-- Danh sách các bộ phận cần thu nhỏ
local bodyParts = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand"
}

-- Thu nhỏ toàn bộ cơ thể
local function shrinkHitbox()
    local char = player.Character
    if not char then return end
    for _, partName in pairs(bodyParts) do
        local part = char:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            if not originalSizes[part] then
                originalSizes[part] = part.Size
            end
            local newSize = originalSizes[part] * scaleFactor
            -- Đảm bảo kích thước không nhỏ hơn 0.1 stud
            part.Size = Vector3.new(math.max(0.1, newSize.X), math.max(0.1, newSize.Y), math.max(0.1, newSize.Z))
        end
    end
    -- Cũng thu nhỏ tool đang cầm (tuỳ chọn)
    for _, tool in pairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            for _, part in pairs(tool:GetDescendants()) do
                if part:IsA("BasePart") and not originalSizes[part] then
                    originalSizes[part] = part.Size
                    local newSize = originalSizes[part] * scaleFactor
                    part.Size = Vector3.new(math.max(0.1, newSize.X), math.max(0.1, newSize.Y), math.max(0.1, newSize.Z))
                end
            end
        end
    end
end

-- Khôi phục kích thước gốc
local function restoreHitbox()
    for part, origSize in pairs(originalSizes) do
        if part and part.Parent then
            part.Size = origSize
        end
    end
    originalSizes = {}
end

-- Khi bật/tắt
local function toggleShrink()
    shrinkEnabled = not shrinkEnabled
    if shrinkEnabled then
        shrinkHitbox()
        shrinkBtn.Text = "SHRINK [ON]"
        shrinkBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 220)
        status.Text = "STATUS : HITBOX SHRINK ACTIVE"
    else
        restoreHitbox()
        shrinkBtn.Text = "SHRINK"
        shrinkBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

shrinkBtn.MouseButton1Click:Connect(toggleShrink)

-- Tự động áp dụng khi respawn
player.CharacterAdded:Connect(function()
    if shrinkEnabled then
        task.wait(0.3)
        shrinkHitbox()
    end
end)
