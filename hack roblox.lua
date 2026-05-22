--========================
-- MINI GUI PRO + AIM LOCK + INFINITE JUMP
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

-- === NÚT MỞ GUI ===
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
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -210)
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

-- === KHU VỰC NỘI DUNG ===
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
-- AIM LOCK PRO MAX
-- Version: 5.0
-- Mô tả: Tự động khóa camera vào đầu người chơi gần nhất
-- Độ chính xác: Cực cao, không rung, lock cứng
-- Không dùng goto
--========================

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- ==================== CẤU HÌNH ====================
local config = {
    enabled = false,
    maxDistance = 300,              -- Khoảng cách tối đa (studs)
    priorityMode = "Closest",       -- "Closest" hoặc "LowestHealth"
    aimPart = "Head",               -- "Head", "UpperTorso", "HumanoidRootPart"
    lockSmoothness = 0,             -- 0 = cứng, 1-10 = mượt
    verticalOffset = 0,
    horizontalOffset = 0,
    checkLineOfSight = false,
    autoSwitchTarget = true,
    ignoreTeam = false,
    showDistance = false,
    toggleKey = Enum.KeyCode.K,
}

-- ==================== BIẾN ====================
local state = {
    isActive = false,
    currentTarget = nil,
    currentDistance = 0,
    lockConnection = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function getHealthPercent(humanoid)
    if not humanoid then return 100 end
    return (humanoid.Health / humanoid.MaxHealth) * 100
end

local function isValidTarget(targetPlayer)
    if not targetPlayer then return false end
    if targetPlayer == player then return false end
    
    if config.ignoreTeam and targetPlayer.Team and player.Team then
        if targetPlayer.Team == player.Team then
            return false
        end
    end
    
    local character = targetPlayer.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    
    local aimPart = character:FindFirstChild(config.aimPart)
    if not aimPart then
        aimPart = character:FindFirstChild("Head")
        if not aimPart then
            return false
        end
    end
    
    return true, humanoid, aimPart
end

local function getAimPosition(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return nil
    end
    
    local aimPart = targetPlayer.Character:FindFirstChild(config.aimPart)
    if not aimPart then
        aimPart = targetPlayer.Character:FindFirstChild("Head")
        if not aimPart then
            return nil
        end
    end
    
    if not aimPart:IsA("BasePart") then
        return nil
    end
    
    return aimPart.Position + Vector3.new(config.horizontalOffset, config.verticalOffset, 0)
end

-- ==================== TÌM MỤC TIÊU ====================
local function findClosestPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPos = myRoot.Position
    local closest = nil
    local closestDist = config.maxDistance + 1
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local isValid = isValidTarget(other)
            if isValid then
                local otherChar = other.Character
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local dist = getDistance(myPos, otherRoot.Position)
                    if dist < closestDist and dist <= config.maxDistance then
                        closestDist = dist
                        closest = other
                    end
                end
            end
        end
    end
    
    return closest, closestDist
end

local function findLowestHealthPlayer()
    local myChar = player.Character
    if not myChar then return nil, 0 end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPos = myRoot.Position
    local lowest = nil
    local lowestHealth = 101
    local lowestDist = config.maxDistance + 1
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local isValid, humanoid = isValidTarget(other)
            if isValid then
                local otherChar = other.Character
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                if otherRoot then
                    local dist = getDistance(myPos, otherRoot.Position)
                    if dist <= config.maxDistance then
                        local healthPercent = getHealthPercent(humanoid)
                        if healthPercent < lowestHealth then
                            lowestHealth = healthPercent
                            lowest = other
                            lowestDist = dist
                        end
                    end
                end
            end
        end
    end
    
    return lowest, lowestDist
end

local function findBestTarget()
    if config.priorityMode == "Closest" then
        return findClosestPlayer()
    else
        return findLowestHealthPlayer()
    end
end

-- ==================== LOCK CAMERA ====================
local function lockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then
        return false
    end
    
    local cameraPos = camera.CFrame.Position
    camera.CFrame = CFrame.new(cameraPos, targetPosition)
    return true
end

local function lockCameraSmooth(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then
        return false
    end
    
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPosition)
    local smoothFactor = config.lockSmoothness / 10
    camera.CFrame = currentCF:Lerp(targetCF, smoothFactor)
    return true
end

local function lockOntoTarget(targetPlayer)
    if not targetPlayer then
        return false
    end
    
    local aimPos = getAimPosition(targetPlayer)
    if not aimPos then
        return false
    end
    
    if config.lockSmoothness <= 0 then
        return lockCameraHard(aimPos)
    else
        return lockCameraSmooth(aimPos)
    end
end

-- ==================== QUẢN LÝ TARGET ====================
local function isCurrentTargetValid()
    if not state.currentTarget then
        return false
    end
    return isValidTarget(state.currentTarget)
end

local function switchToNewTarget()
    local newTarget, distance = findBestTarget()
    if newTarget then
        state.currentTarget = newTarget
        state.currentDistance = distance
        return true
    end
    state.currentTarget = nil
    return false
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function updateAimLock()
    if not state.isActive then
        return
    end
    
    if not isCurrentTargetValid() then
        switchToNewTarget()
    end
    
    if state.currentTarget then
        lockOntoTarget(state.currentTarget)
    end
end

local function startAimLock()
    if state.lockConnection then
        state.lockConnection:Disconnect()
    end
    state.lockConnection = RunService.RenderStepped:Connect(updateAimLock)
end

local function stopAimLock()
    if state.lockConnection then
        state.lockConnection:Disconnect()
        state.lockConnection = nil
    end
    state.currentTarget = nil
end

-- ==================== BẬT/TẮT ====================
local function enable()
    if state.isActive then
        return
    end
    
    state.isActive = true
    switchToNewTarget()
    startAimLock()
    
    print("[AIM LOCK] ĐÃ BẬT | Chế độ: " .. config.priorityMode .. " | Khoảng cách: " .. config.maxDistance)
end

local function disable()
    if not state.isActive then
        return
    end
    
    state.isActive = false
    stopAimLock()
    
    print("[AIM LOCK] ĐÃ TẮT")
end

local function toggle()
    if state.isActive then
        disable()
    else
        enable()
    end
end

-- ==================== PHÍM TẮT ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    
    if input.KeyCode == config.toggleKey then
        toggle()
        
        -- Hiển thị thông báo
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 150, 0, 35)
        notif.Position = UDim2.new(0.5, -75, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = state.isActive and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = state.isActive and "AIM LOCK ON" or "AIM LOCK OFF"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1)
        notif:Destroy()
    end
end)

-- ==================== XỬ LÝ RESPAWN ====================
player.CharacterAdded:Connect(function()
    if state.isActive then
        task.wait(0.5)
        switchToNewTarget()
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if state.isActive and state.currentTarget == leavingPlayer then
        switchToNewTarget()
    end
end)

-- ==================== KHỞI TẠO ====================
print("=" .. string.rep("=", 50))
print("AIM LOCK PRO MAX LOADED")
print("Version: 5.0")
print("Ưu tiên: " .. config.priorityMode)
print("Khoảng cách: " .. config.maxDistance)
print("Bộ phận aim: " .. config.aimPart)
print("Phím tắt: " .. tostring(config.toggleKey))
print("=" .. string.rep("=", 50))

-- ==================== EXPORT ====================
return {
    toggle = toggle,
    enable = enable,
    disable = disable,
    isEnabled = function() return state.isActive end,
    getCurrentTarget = function() return state.currentTarget end,
    setConfig = function(newConfig)
        for k, v in pairs(newConfig) do
            if config[k] ~= nil then
                config[k] = v
            end
        end
    end,
    getConfig = function() return config end,
}
--========================
-- INFINITE JUMP PRO MAX
-- Version: 2.0
-- Mô tả: Cho phép nhảy vô hạn trên không, có thể bật/tắt, tùy chỉnh lực nhảy
-- Không dùng goto, chạy được trên mọi executor
--========================

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ==================== CẤU HÌNH ====================
local config = {
    enabled = false,
    jumpPower = 60,              -- Lực nhảy (mặc định 50, tăng lên để nhảy cao hơn)
    maxJumpPower = 120,          -- Giới hạn tối đa
    minJumpPower = 40,           -- Giới hạn tối thiểu
    antiCheatBypass = true,      -- Chế độ tránh anti-cheat
    airJumpOnly = true,          -- Chỉ nhảy khi đang ở trên không
}

-- ==================== BIẾN ====================
local state = {
    isActive = false,
    originalJumpPower = nil,
    jumpConnection = nil,
    antiCheatTimer = nil,
}

-- ==================== HÀM TIỆN ÍCH ====================
local function getHumanoid()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

local function saveOriginalJumpPower()
    local hum = getHumanoid()
    if hum and state.originalJumpPower == nil then
        state.originalJumpPower = hum.JumpPower
    end
end

local function restoreOriginalJumpPower()
    local hum = getHumanoid()
    if hum and state.originalJumpPower then
        hum.JumpPower = state.originalJumpPower
    end
end

local function setJumpPower(value)
    local hum = getHumanoid()
    if hum then
        local newValue = math.clamp(value, config.minJumpPower, config.maxJumpPower)
        hum.JumpPower = newValue
    end
end

-- ==================== CƠ CHẾ NHẢY ====================
local function performJump()
    local hum = getHumanoid()
    if not hum then return end
    if hum.Health <= 0 then return end
    
    -- Chỉ nhảy khi đang ở trên không
    if config.airJumpOnly then
        if hum.FloorMaterial == Enum.Material.Air then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    else
        -- Luôn cho phép nhảy (kể cả khi đang trên mặt đất)
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Chế độ tránh anti-cheat: set lực nhảy trước khi nhảy, sau đó khôi phục
local function antiCheatJump()
    local hum = getHumanoid()
    if not hum then return end
    
    -- Lưu lực nhảy gốc
    saveOriginalJumpPower()
    
    -- Set lực nhảy theo cấu hình
    hum.JumpPower = config.jumpPower
    
    -- Thực hiện nhảy
    performJump()
    
    -- Khôi phục lực nhảy gốc sau 0.05 giây
    task.spawn(function()
        task.wait(0.05)
        if hum and state.originalJumpPower then
            hum.JumpPower = state.originalJumpPower
        end
    end)
end

-- Chế độ bình thường
local function normalJump()
    local hum = getHumanoid()
    if not hum then return end
    
    -- Set lực nhảy
    hum.JumpPower = config.jumpPower
    
    -- Thực hiện nhảy
    performJump()
end

-- ==================== XỬ LÝ SỰ KIỆN NHẢY ====================
local function onJumpRequest()
    if not state.isActive then return end
    
    if config.antiCheatBypass then
        antiCheatJump()
    else
        normalJump()
    end
end

-- ==================== BẬT/TẮT ====================
local function enable()
    if state.isActive then return end
    
    state.isActive = true
    
    -- Lưu lực nhảy gốc
    saveOriginalJumpPower()
    
    -- Kết nối sự kiện nhảy
    if state.jumpConnection then
        state.jumpConnection:Disconnect()
    end
    state.jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    
    print("[INFINITE JUMP] ĐÃ BẬT | Lực nhảy: " .. config.jumpPower)
end

local function disable()
    if not state.isActive then return end
    
    state.isActive = false
    
    -- Ngắt kết nối
    if state.jumpConnection then
        state.jumpConnection:Disconnect()
        state.jumpConnection = nil
    end
    
    -- Khôi phục lực nhảy gốc
    restoreOriginalJumpPower()
    
    print("[INFINITE JUMP] ĐÃ TẮT")
end

local function toggle()
    if state.isActive then
        disable()
    else
        enable()
    end
end

-- ==================== TĂNG/GIẢM LỰC NHẢY ====================
local function increasePower(amount)
    amount = amount or 5
    config.jumpPower = math.min(config.maxJumpPower, config.jumpPower + amount)
    
    if state.isActive then
        -- Nếu đang bật, áp dụng ngay
        local hum = getHumanoid()
        if hum then
            hum.JumpPower = config.jumpPower
        end
    end
    
    print("[INFINITE JUMP] Lực nhảy: " .. config.jumpPower)
    return config.jumpPower
end

local function decreasePower(amount)
    amount = amount or 5
    config.jumpPower = math.max(config.minJumpPower, config.jumpPower - amount)
    
    if state.isActive then
        local hum = getHumanoid()
        if hum then
            hum.JumpPower = config.jumpPower
        end
    end
    
    print("[INFINITE JUMP] Lực nhảy: " .. config.jumpPower)
    return config.jumpPower
end

-- ==================== XỬ LÝ RESPAWN ====================
player.CharacterAdded:Connect(function()
    if state.isActive then
        -- Lưu lại lực nhảy gốc mới
        task.wait(0.5)
        saveOriginalJumpPower()
        
        -- Đảm bảo connection vẫn hoạt động
        if state.jumpConnection then
            state.jumpConnection:Disconnect()
        end
        state.jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    end
end)

-- ==================== KHỞI TẠO ====================
print("=" .. string.rep("=", 50))
print("INFINITE JUMP PRO MAX LOADED")
print("Version: 2.0")
print("Lực nhảy mặc định: " .. config.jumpPower)
print("Chế độ anti-cheat: " .. (config.antiCheatBypass and "BẬT" or "TẮT"))
print("=" .. string.rep("=", 50))

-- ==================== EXPORT ====================
return {
    toggle = toggle,
    enable = enable,
    disable = disable,
    increasePower = increasePower,
    decreasePower = decreasePower,
    setPower = function(value)
        config.jumpPower = math.clamp(value, config.minJumpPower, config.maxJumpPower)
        if state.isActive then
            local hum = getHumanoid()
            if hum then
                hum.JumpPower = config.jumpPower
            end
        end
    end,
    getPower = function() return config.jumpPower end,
    isEnabled = function() return state.isActive end,
    setConfig = function(newConfig)
        for k, v in pairs(newConfig) do
            if config[k] ~= nil then
                config[k] = v
            end
        end
    end
}
--========================
-- TẠO NÚT
--========================
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

local infiniteJumpBtn = createButton("INFINITE JUMP", "🦘", Color3.fromRGB(80, 110, 70), function(active)
    infiniteJumpActive = active
    if active then
        startInfiniteJump()
        statusText.Text = "● INFINITE JUMP: ACTIVATED"
    else
        stopInfiniteJump()
        statusText.Text = "● INFINITE JUMP: DEACTIVATED"
    end
    task.wait(1.5)
    if not infiniteJumpActive and not aimLockActive then
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

-- === XỬ LÝ RESPAWN ===
player.CharacterAdded:Connect(function()
    if aimLockActive then
        currentTarget = nil
    end
    if infiniteJumpActive then
        -- Không cần reset gì cả
    end
end)
