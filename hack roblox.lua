--========================
-- GUI RỖNG (DÙNG makeButton)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGUI"
screenGui.Parent = game.CoreGui

-- Nút mở GUI
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "🇻🇳"
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
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Thanh tiêu đề
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.BackgroundTransparency = 0.2
header.Draggable = true
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = " MY TOOL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -36, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

-- Khu vực chứa nút
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -80)
content.Position = UDim2.new(0, 8, 0, 50)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.Padding = UDim.new(0, 8)

-- Thanh trạng thái
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 24)
statusBar.Position = UDim2.new(0, 0, 1, -24)
statusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -12, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 10
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

-- Cập nhật canvas
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)

-- HÀM makeButton (giống hồi trước)
local function makeButton(text, row, col, color)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, 10 + (col - 1) * 130, 0, 10 + (row - 1) * 45)
    btn.Text = text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    
    return btn
end

-- Mở/đóng GUI
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        updateCanvas()
    end
end)
--========================
-- AIM LOCK PRO MAX - SIÊU PHẨM
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- ==================== CẤU HÌNH ====================
local aimLockEnabled = false
local currentTarget = nil
local aimConnection = nil
local lockDistance = 350
local smoothness = 0.12
local lastTargetTime = 0
local targetLockedTime = 0
local frameCount = 0

-- ==================== HÀM TÌM NGƯỜI GẦN NHẤT ====================
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function isTargetAlive(target)
    if not target then return false end
    local char = target.Character
    if not char then return false end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return false end
    if hum.Health <= 0 then return false end
    return true
end

local function findClosestEnemy()
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
                    local dist = getDistance(myPos, otherRoot.Position)
                    if dist < closestDist then
                        closestDist = dist
                        closest = other
                    end
                end
            end
        end
    end
    return closest, closestDist
end

-- ==================== HÀM LOCK CAMERA ====================
local function getHeadPosition(target)
    if not target then return nil end
    local char = target.Character
    if not char then return nil end
    local head = char:FindFirstChild("Head")
    if not head then return nil end
    return head.Position
end

local function lockCameraHard(targetPos)
    local camera = workspace.CurrentCamera
    if not camera or not targetPos then return false end
    local cameraPos = camera.CFrame.Position
    camera.CFrame = CFrame.new(cameraPos, targetPos)
    return true
end

local function lockCameraSmooth(targetPos)
    local camera = workspace.CurrentCamera
    if not camera or not targetPos then return false end
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPos)
    local newCF = currentCF:Lerp(targetCF, smoothness)
    camera.CFrame = newCF
    return true
end

local function aimAtTarget(target)
    if not target then return false end
    local headPos = getHeadPosition(target)
    if not headPos then return false end
    
    if smoothness <= 0 then
        return lockCameraHard(headPos)
    else
        return lockCameraSmooth(headPos)
    end
end

-- ==================== QUẢN LÝ MỤC TIÊU ====================
local function switchToNewTarget()
    local newTarget, distance = findClosestEnemy()
    if newTarget then
        currentTarget = newTarget
        targetLockedTime = tick()
        return true
    end
    currentTarget = nil
    return false
end

local function isCurrentTargetValid()
    if not currentTarget then return false end
    if not isTargetAlive(currentTarget) then return false end
    
    local char = player.Character
    local myRoot = char and char:FindFirstChild("HumanoidRootPart")
    local targetRoot = currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart")
    
    if not myRoot or not targetRoot then return false end
    
    local dist = getDistance(myRoot.Position, targetRoot.Position)
    if dist > lockDistance then return false end
    
    return true
end

-- ==================== VÒNG LẶP CHÍNH ====================
local function updateAimLock()
    if not aimLockEnabled then return end
    
    frameCount = frameCount + 1
    
    if not isCurrentTargetValid() then
        switchToNewTarget()
    end
    
    if currentTarget then
        aimAtTarget(currentTarget)
    end
end

local function startAimLock()
    if aimConnection then
        aimConnection:Disconnect()
    end
    aimConnection = RunService.RenderStepped:Connect(updateAimLock)
end

local function stopAimLock()
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    currentTarget = nil
end

-- ==================== BẬT/TẮT ====================
local function enableAimLock()
    if aimLockEnabled then return end
    aimLockEnabled = true
    switchToNewTarget()
    startAimLock()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 120)
    end
    print("[AIM LOCK] ĐÃ BẬT - Khoảng cách lock: " .. lockDistance)
end

local function disableAimLock()
    if not aimLockEnabled then return end
    aimLockEnabled = false
    stopAimLock()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [OFF]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    end
    print("[AIM LOCK] ĐÃ TẮT")
end

local function toggleAimLock()
    if aimLockEnabled then
        disableAimLock()
    else
        enableAimLock()
    end
end

-- ==================== XỬ LÝ SỰ KIỆN ====================
player.CharacterAdded:Connect(function()
    if aimLockEnabled then
        task.wait(0.5)
        currentTarget = nil
        switchToNewTarget()
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if aimLockEnabled and currentTarget == leavingPlayer then
        currentTarget = nil
        switchToNewTarget()
    end
end)

-- ==================== TẠO NÚT TRONG GUI ====================
local aimBtn = makeButton(" AIM LOCK", 1, 1, Color3.fromRGB(80, 60, 100))
aimBtn.MouseButton1Click:Connect(toggleAimLock)
