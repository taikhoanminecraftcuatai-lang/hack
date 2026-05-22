--========================
-- GUI RỖNG (CHƯA CÓ NÚT)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGUI"
screenGui.Parent = game.CoreGui

-- Nút mở GUI (có thể kéo thả)
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
mainFrame.Size = UDim2.new(0, 260, 0, 340)
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
title.Text = "⚡ MY TOOL"
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

-- Khu vực chứa nút (dạng cuộn)
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

-- Cập nhật chiều cao cuộn
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)

-- Mở/đóng GUI
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
-- Hàm tạo nút (thêm vào cuối script)
local function createButton(name, icon, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
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
    
    if callback then
        btn.MouseButton1Click:Connect(callback)
    end
    
    return btn
end
--========================
-- AIM LOCK PRO MAX (KHÔNG GOTO)
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local aimLockEnabled = false
local aimConnection = nil
local currentTarget = nil

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

-- Lock camera vào đầu mục tiêu
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

-- Vòng lặp chính
local function updateAimLock()
    if not aimLockEnabled then return end
    local target = findClosestPlayer()
    if target then
        currentTarget = target
        lockOntoHead(target)
    else
        currentTarget = nil
    end
end

-- Khởi động và dừng
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

-- Bật/tắt
local function enableAimLock()
    if aimLockEnabled then return end
    aimLockEnabled = true
    startAimLock()
    print("[AIM LOCK] ĐÃ BẬT")
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

-- Phím tắt K
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.K then
        toggleAimLock()
        local notif = Instance.new("TextLabel")
        notif.Parent = game.CoreGui
        notif.Size = UDim2.new(0, 150, 0, 35)
        notif.Position = UDim2.new(0.5, -75, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = aimLockEnabled and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = aimLockEnabled and "AIM LOCK ON" or "AIM LOCK OFF"
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1)
        notif:Destroy()
    end
end)

-- Xử lý respawn
player.CharacterAdded:Connect(function()
    if aimLockEnabled then
        currentTarget = nil
    end
end)
--========================
-- INFINITE JUMP PRO MAX (KHÔNG GOTO)
--========================
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local jumpEnabled = false
local jumpConnection = nil
local originalJumpPower = nil
local currentJumpPower = 60

-- Lấy Humanoid
local function getHumanoid()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

-- Lưu lực nhảy gốc
local function saveOriginalJumpPower()
    local hum = getHumanoid()
    if hum and originalJumpPower == nil then
        originalJumpPower = hum.JumpPower
    end
end

-- Khôi phục lực nhảy gốc
local function restoreOriginalJumpPower()
    local hum = getHumanoid()
    if hum and originalJumpPower then
        hum.JumpPower = originalJumpPower
    end
end

-- Xử lý nhảy
local function onJumpRequest()
    if not jumpEnabled then return end
    
    local hum = getHumanoid()
    if not hum then return end
    if hum.Health <= 0 then return end
    
    -- Set lực nhảy
    hum.JumpPower = currentJumpPower
    
    -- Nhảy nếu đang ở trên không
    if hum.FloorMaterial == Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Bật/tắt
local function enableJump()
    if jumpEnabled then return end
    
    jumpEnabled = true
    saveOriginalJumpPower()
    
    if jumpConnection then
        jumpConnection:Disconnect()
    end
    jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    
    print("[INFINITE JUMP] ĐÃ BẬT | Lực nhảy: " .. currentJumpPower)
end

local function disableJump()
    if not jumpEnabled then return end
    
    jumpEnabled = false
    
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    
    restoreOriginalJumpPower()
    
    print("[INFINITE JUMP] ĐÃ TẮT")
end

local function toggleJump()
    if jumpEnabled then
        disableJump()
    else
        enableJump()
    end
end

-- Tăng/giảm lực nhảy
local function increasePower()
    currentJumpPower = math.min(120, currentJumpPower + 5)
    if jumpEnabled then
        local hum = getHumanoid()
        if hum then
            hum.JumpPower = currentJumpPower
        end
    end
    print("[INFINITE JUMP] Lực nhảy: " .. currentJumpPower)
    return currentJumpPower
end

local function decreasePower()
    currentJumpPower = math.max(40, currentJumpPower - 5)
    if jumpEnabled then
        local hum = getHumanoid()
        if hum then
            hum.JumpPower = currentJumpPower
        end
    end
    print("[INFINITE JUMP] Lực nhảy: " .. currentJumpPower)
    return currentJumpPower
end

-- Xử lý respawn
player.CharacterAdded:Connect(function()
    if jumpEnabled then
        task.wait(0.5)
        saveOriginalJumpPower()
        if jumpConnection then
            jumpConnection:Disconnect()
        end
        jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    end
end)
--========================
-- TẠO NÚT TRONG GUI
--========================

-- Nút AIM LOCK
local aimBtn = createButton("AIM LOCK", "🎯", function()
    toggleAimLock()
    if aimLockEnabled then
        statusText.Text = "● AIM LOCK: ON"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
    else
        statusText.Text = "● AIM LOCK: OFF"
        aimBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end
    task.wait(1.5)
    statusText.Text = "● READY"
end)

-- Nút INFINITE JUMP
local jumpBtn = createButton("INFINITE JUMP", "🦘", function()
    toggleJump()
    if jumpEnabled then
        statusText.Text = "● INFINITE JUMP: ON"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(100, 140, 100)
    else
        statusText.Text = "● INFINITE JUMP: OFF"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    end
    task.wait(1.5)
    statusText.Text = "● READY"
end)

-- Nút tăng lực nhảy
local plusBtn = createButton("+ JUMP POWER", "⬆️", function()
    increasePower()
    statusText.Text = "● JUMP POWER: " .. currentJumpPower
    task.wait(1)
    statusText.Text = "● READY"
end)

-- Nút giảm lực nhảy
local minusBtn = createButton("- JUMP POWER", "⬇️", function()
    decreasePower()
    statusText.Text = "● JUMP POWER: " .. currentJumpPower
    task.wait(1)
    statusText.Text = "● READY"
end)
