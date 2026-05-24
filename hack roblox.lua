--========================
--Hack roblox tổng hợp
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--========================
-- TẠO GUI
--========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHubPro"
screenGui.Parent = game.CoreGui

-- Nút mở GUI
local openBtn = Instance.new("TextButton")
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
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- Cửa sổ chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 320)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

-- Thanh tiêu đề
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
header.BackgroundTransparency = 0.2
header.Draggable = true
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED HUB PRO MAX"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -34, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

-- Khu vực nội dung
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.Parent = mainFrame

--========================
-- AIM LOCK PRO MAX (CỰC MẠNH + MƯỢT)
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

--========================
-- CẤU HÌNH AIM LOCK
--========================
local aimLockEnabled = false
local currentTarget = nil
local aimConnection = nil
local lockDistance = 300
local smoothness = 0.25  -- Độ mượt (0 = cứng, 1 = rất mượt)

--========================
-- TÌM NGƯỜI GẦN NHẤT
--========================
local function findClosestPlayer()
    local character = player.Character
    if not character then return nil end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local myPos = root.Position
    local closest = nil
    local closestDist = lockDistance
    
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

--========================
-- LOCK CAMERA (MƯỢT HOẶC CỨNG)
--========================
local function lockCameraHard(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return end
    camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
end

local function lockCameraSmooth(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return end
    
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPosition)
    local newCF = currentCF:Lerp(targetCF, smoothness)
    camera.CFrame = newCF
end

local function aimAt(target)
    if not target then return end
    
    local targetChar = target.Character
    if not targetChar then return end
    
    local head = targetChar:FindFirstChild("Head")
    if not head then return end
    
    local headPos = head.Position
    
    if smoothness <= 0 then
        lockCameraHard(headPos)
    else
        lockCameraSmooth(headPos)
    end
end

--========================
-- VÒNG LẶP CHÍNH
--========================
local function updateAimLock()
    if not aimLockEnabled then return end
    
    local target = findClosestPlayer()
    if target then
        currentTarget = target
        aimAt(target)
    else
        currentTarget = nil
    end
end

local function startAimLock()
    if aimConnection then aimConnection:Disconnect() end
    aimConnection = RunService.RenderStepped:Connect(updateAimLock)
end

local function stopAimLock()
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    currentTarget = nil
end

--========================
-- BẬT/TẮT AIM LOCK
--========================
local function enableAimLock()
    if aimLockEnabled then return end
    aimLockEnabled = true
    startAimLock()
    print("[AIM LOCK] ĐÃ BẬT | Độ mượt: " .. smoothness)
end

local function disableAimLock()
    if not aimLockEnabled then return end
    aimLockEnabled = false
    stopAimLock()
    print("[AIM LOCK] ĐÃ TẮT")
end

local function toggleAimLock()
    if aimLockEnabled then
        disableAimLock()
    else
        enableAimLock()
    end
end

--========================
-- PHÍM TẮT (PHÍM K)
--========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        toggleAimLock()
        
        -- Hiển thị thông báo
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 180, 0, 35)
        notif.Position = UDim2.new(0.5, -90, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = aimLockEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = aimLockEnabled and " AIM LOCK [ON]" or " AIM LOCK [OFF]"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1)
        notif:Destroy()
    end
end)

--========================
-- XỬ LÝ RESPAWN
--========================
player.CharacterAdded:Connect(function()
    if aimLockEnabled then
        currentTarget = nil
    end
end)

--========================
-- XỬ LÝ NGƯỜI CHƠI RỜI GAME
--========================
Players.PlayerRemoving:Connect(function(leavingPlayer)
    if aimLockEnabled and currentTarget == leavingPlayer then
        currentTarget = nil
    end
end)

--========================
-- HÀM EXPORT (DÙNG CHO NÚT GUI)
--========================
return {
    toggle = toggleAimLock,
    enable = enableAimLock,
    disable = disableAimLock,
    isEnabled = function() return aimLockEnabled end,
    getCurrentTarget = function() return currentTarget end,
    setSmoothness = function(value)
        smoothness = math.clamp(value, 0, 1)
        print("[AIM LOCK] Độ mượt: " .. smoothness)
    end,
    setDistance = function(value)
        lockDistance = math.max(50, value)
        print("[AIM LOCK] Khoảng cách lock: " .. lockDistance)
    end
}
