--========================
-- FLY TOOL PRO MAX (CHỐNG ANTI CHEAT + NHẬP TỐC ĐỘ)
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--========================
-- TẠO GUI
--========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyToolPro"
screenGui.Parent = game.CoreGui

-- Nút mở GUI
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "✈️"
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
mainFrame.Size = UDim2.new(0, 320, 0, 300)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -150)
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
title.Text = "✈️ FLY TOOL PRO MAX"
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
-- NÚT FLY
--========================
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1, 0, 0, 50)
flyBtn.Position = UDim2.new(0, 0, 0, 0)
flyBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
flyBtn.BackgroundTransparency = 0.2
flyBtn.Text = "✈️ FLY [OFF]"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.TextSize = 16
flyBtn.Font = Enum.Font.GothamBold
flyBtn.BorderSizePixel = 0
flyBtn.Parent = content

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyBtn

--========================
-- BẢNG NHẬP TỐC ĐỘ
--========================
local speedBoxFrame = Instance.new("Frame")
speedBoxFrame.Size = UDim2.new(1, 0, 0, 80)
speedBoxFrame.Position = UDim2.new(0, 0, 0, 60)
speedBoxFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
speedBoxFrame.BackgroundTransparency = 0.2
speedBoxFrame.BorderSizePixel = 0
speedBoxFrame.Parent = content

local speedBoxCorner = Instance.new("UICorner")
speedBoxCorner.CornerRadius = UDim.new(0, 10)
speedBoxCorner.Parent = speedBoxFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 25)
speedLabel.Position = UDim2.new(0, 0, 0, 5)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ NHẬP TỐC ĐỘ BAY"
speedLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = speedBoxFrame

-- Ô nhập số
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.6, 0, 0, 35)
speedInput.Position = UDim2.new(0.05, 0, 0.45, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
speedInput.TextColor3 = Color3.fromRGB(0, 200, 255)
speedInput.TextSize = 18
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "999999"
speedInput.PlaceholderText = "NHẬP TỐC ĐỘ"
speedInput.BorderSizePixel = 0

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = speedInput

speedInput.Parent = speedBoxFrame

-- Nút áp dụng tốc độ
local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0.25, 0, 0, 35)
applyBtn.Position = UDim2.new(0.7, 0, 0.45, 0)
applyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
applyBtn.Text = "ÁP DỤNG"
applyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
applyBtn.TextSize = 13
applyBtn.Font = Enum.Font.GothamBold
applyBtn.BorderSizePixel = 0

local applyCorner = Instance.new("UICorner")
applyCorner.CornerRadius = UDim.new(0, 8)
applyCorner.Parent = applyBtn

applyBtn.Parent = speedBoxFrame

-- Hiển thị tốc độ hiện tại
local currentSpeedLabel = Instance.new("TextLabel")
currentSpeedLabel.Size = UDim2.new(1, 0, 0, 25)
currentSpeedLabel.Position = UDim2.new(0, 0, 0.85, 0)
currentSpeedLabel.BackgroundTransparency = 1
currentSpeedLabel.Text = "📊 TỐC ĐỘ HIỆN TẠI: 50"
currentSpeedLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
currentSpeedLabel.TextSize = 11
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.Parent = speedBoxFrame

--========================
-- BIẾN FLY
--========================
local flyEnabled = false
local flySpeed = 50
local flyBodyVel = nil
local flyBodyGyro = nil
local flyConnection = nil

-- Hàm cập nhật hiển thị tốc độ
local function updateSpeedDisplay()
    currentSpeedLabel.Text = "📊 TỐC ĐỘ HIỆN TẠI: " .. flySpeed
end

-- Xử lý nhập tốc độ (hỗ trợ số siêu lớn)
applyBtn.MouseButton1Click:Connect(function()
    local inputText = speedInput.Text
    -- Xóa dấu phẩy và khoảng trắng
    inputText = inputText:gsub("[%,%s]", "")
    -- Chuyển thành số (hỗ trợ số lớn)
    local success, result = pcall(function()
        return tonumber(inputText) or flySpeed
    end)
    if success and result then
        flySpeed = math.floor(result)
        if flySpeed < 10 then flySpeed = 10 end
        if flySpeed > 999999999 then flySpeed = 999999999 end
        updateSpeedDisplay()
        speedInput.Text = tostring(flySpeed)
        print("[FLY] Tốc độ đã set: " .. flySpeed)
        -- Thông báo
        local notif = Instance.new("TextLabel")
        notif.Parent = screenGui
        notif.Size = UDim2.new(0, 200, 0, 35)
        notif.Position = UDim2.new(0.5, -100, 0.85, 0)
        notif.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        notif.BackgroundTransparency = 0.4
        notif.TextColor3 = Color3.fromRGB(100, 255, 100)
        notif.Font = Enum.Font.GothamBold
        notif.TextSize = 12
        notif.Text = "⚡ TỐC ĐỘ: " .. flySpeed
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    else
        speedInput.Text = tostring(flySpeed)
    end
end)

--========================
-- CƠ CHẾ BAY (CHỐNG ANTI CHEAT)
--========================
local lastPosition = nil
local positionHistory = {}
local maxHistory = 5

-- Hàm phát hiện và sửa lỗi delay
local function antiCheatFix()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local currentPos = root.Position
    table.insert(positionHistory, currentPos)
    if #positionHistory > maxHistory then
        table.remove(positionHistory, 1)
    end
    
    -- Nếu có ít nhất 2 điểm, tính vận tốc thực tế
    if #positionHistory >= 2 then
        local prevPos = positionHistory[#positionHistory - 1]
        local actualVelocity = (currentPos - prevPos).Magnitude / (1/60)
        
        -- Nếu vận tốc thực tế quá thấp so với tốc độ set (bị delay)
        if actualVelocity < flySpeed * 0.3 and flySpeed > 100 then
            -- Force reposition để tránh bị kéo về
            local direction = (currentPos - prevPos).Unit
            if direction.Magnitude > 0 then
                root.CFrame = root.CFrame + direction * (flySpeed / 30)
            end
        end
    end
    lastPosition = currentPos
end

local function startFly()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso")
    
    if not hum or not root then return end
    
    if flyBodyVel then flyBodyVel:Destroy() end
    if flyBodyGyro then flyBodyGyro:Destroy() end
    
    flyBodyVel = Instance.new("BodyVelocity")
    flyBodyVel.MaxForce = Vector3.new(1, 1, 1) * math.huge
    flyBodyVel.Velocity = Vector3.new(0, 0, 0)
    flyBodyVel.Parent = root
    
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(1, 1, 1) * math.huge
    flyBodyGyro.Parent = root
    
    hum.PlatformStand = true
    hum.AutoRotate = false
    
    -- Reset position history
    positionHistory = {}
    lastPosition = root.Position
    
    if flyConnection then flyConnection:Disconnect() end
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end
        if not root or not root.Parent then return end
        
        local cam = workspace.CurrentCamera
        local moveDir = Vector3.new()
        
        -- Điều khiển bằng bàn phím
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDir = moveDir + cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDir = moveDir - cam.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDir = moveDir - cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDir = moveDir + cam.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDir = moveDir + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDir = moveDir - Vector3.new(0, 1, 0)
        end
        
        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit
        end
        
        -- Áp dụng vận tốc
        local targetVelocity = moveDir * flySpeed
        flyBodyVel.Velocity = targetVelocity
        flyBodyGyro.CFrame = cam.CFrame
        
        -- Chống anti-cheat: liên tục set vị trí
        if flySpeed > 500 then
            -- Với tốc độ siêu cao, cập nhật CFrame liên tục
            local step = targetVelocity / 60
            root.CFrame = root.CFrame + step
        end
        
        -- Gọi hàm chống delay
        antiCheatFix()
    end)
end

local function stopFly()
    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end
    if flyBodyVel then
        flyBodyVel:Destroy()
        flyBodyVel = nil
    end
    if flyBodyGyro then
        flyBodyGyro:Destroy()
        flyBodyGyro = nil
    end
    
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
    end
    positionHistory = {}
end

-- Bật/tắt Fly
flyBtn.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    
    if flyEnabled then
        flyBtn.Text = "✈️ FLY [ON]"
        flyBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
        startFly()
        print("[FLY] ĐÃ BẬT | Tốc độ: " .. flySpeed)
    else
        flyBtn.Text = "✈️ FLY [OFF]"
        flyBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
        stopFly()
        print("[FLY] ĐÃ TẮT")
    end
end)

-- Xử lý khi nhân vật respawn
player.CharacterAdded:Connect(function()
    if flyEnabled then
        task.wait(0.5)
        startFly()
    end
end)

-- Tự động set tốc độ mới khi bay đang bật
local oldSpeed = flySpeed
RunService.RenderStepped:Connect(function()
    if flyEnabled and flySpeed ~= oldSpeed then
        oldSpeed = flySpeed
        -- Cập nhật vận tốc realtime
    end
end)

updateSpeedDisplay()

--========================
-- MỞ/ĐÓNG GUI
--========================
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
