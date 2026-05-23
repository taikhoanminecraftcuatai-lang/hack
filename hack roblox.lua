--========================
-- SPEED HUB PRO MAX (CHỐNG ANTI CHEAT CỰC MẠNH)
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
-- NÚT SPEED
--========================
local speedBtn = Instance.new("TextButton")
speedBtn.Size = UDim2.new(1, 0, 0, 50)
speedBtn.Position = UDim2.new(0, 0, 0, 0)
speedBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
speedBtn.BackgroundTransparency = 0.2
speedBtn.Text = "⚡ SPEED [OFF]"
speedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBtn.TextSize = 16
speedBtn.Font = Enum.Font.GothamBold
speedBtn.BorderSizePixel = 0
speedBtn.Parent = content

local speedCorner = Instance.new("UICorner")
speedCorner.CornerRadius = UDim.new(0, 10)
speedCorner.Parent = speedBtn

--========================
-- BẢNG NHẬP TỐC ĐỘ
--========================
local speedBoxFrame = Instance.new("Frame")
speedBoxFrame.Size = UDim2.new(1, 0, 0, 100)
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
speedLabel.Text = "⚡ NHẬP TỐC ĐỘ CHẠY"
speedLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
speedLabel.TextSize = 12
speedLabel.Font = Enum.Font.GothamBold
speedLabel.Parent = speedBoxFrame

-- Ô nhập số
local speedInput = Instance.new("TextBox")
speedInput.Size = UDim2.new(0.6, 0, 0, 40)
speedInput.Position = UDim2.new(0.05, 0, 0.4, 0)
speedInput.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
speedInput.TextColor3 = Color3.fromRGB(0, 200, 255)
speedInput.TextSize = 18
speedInput.Font = Enum.Font.GothamBold
speedInput.Text = "100"
speedInput.PlaceholderText = "NHẬP TỐC ĐỘ"
speedInput.BorderSizePixel = 0

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = speedInput

speedInput.Parent = speedBoxFrame

-- Nút áp dụng tốc độ
local applyBtn = Instance.new("TextButton")
applyBtn.Size = UDim2.new(0.25, 0, 0, 40)
applyBtn.Position = UDim2.new(0.7, 0, 0.4, 0)
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
currentSpeedLabel.Text = "📊 TỐC ĐỘ HIỆN TẠI: 16"
currentSpeedLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
currentSpeedLabel.TextSize = 11
currentSpeedLabel.Font = Enum.Font.Gotham
currentSpeedLabel.Parent = speedBoxFrame

--========================
-- CẢNH BÁO TỐC ĐỘ CAO
--========================
local warningFrame = Instance.new("Frame")
warningFrame.Size = UDim2.new(1, 0, 0, 35)
warningFrame.Position = UDim2.new(0, 0, 0, 170)
warningFrame.BackgroundColor3 = Color3.fromRGB(100, 50, 50)
warningFrame.BackgroundTransparency = 0.3
warningFrame.BorderSizePixel = 0
warningFrame.Visible = false
warningFrame.Parent = content

local warningCorner = Instance.new("UICorner")
warningCorner.CornerRadius = UDim.new(0, 8)
warningCorner.Parent = warningFrame

local warningText = Instance.new("TextLabel")
warningText.Size = UDim2.new(1, 0, 1, 0)
warningText.BackgroundTransparency = 1
warningText.Text = "⚠️ TỐC ĐỘ CAO DỄ BỊ ANTI CHEAT PHÁT HIỆN!"
warningText.TextColor3 = Color3.fromRGB(255, 100, 100)
warningText.TextSize = 11
warningText.Font = Enum.Font.GothamBold
warningText.Parent = warningFrame

--========================
-- BIẾN SPEED
--========================
local speedEnabled = false
local currentSpeed = 16
local originalSpeed = nil
local speedConnection = nil
local lastSpeedCheck = 0

-- Lưu tốc độ gốc
local function saveOriginalSpeed()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum and originalSpeed == nil then
        originalSpeed = hum.WalkSpeed
    end
end

-- Khôi phục tốc độ gốc
local function restoreOriginalSpeed()
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum and originalSpeed then
        hum.WalkSpeed = originalSpeed
    end
end

-- Chống anti cheat: liên tục set lại speed
local function antiCheatSpeedFix()
    if not speedEnabled then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if hum.Health <= 0 then return end
    
    -- Set tốc độ liên tục mỗi frame để chống anti cheat
    if hum.WalkSpeed ~= currentSpeed then
        hum.WalkSpeed = currentSpeed
    end
end

-- Chống delay: phát hiện nếu speed bị đổi về
local function antiDelayFix()
    if not speedEnabled then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    local currentTime = tick()
    if currentTime - lastSpeedCheck > 0.1 then
        lastSpeedCheck = currentTime
        if hum.WalkSpeed < currentSpeed * 0.8 and currentSpeed > 50 then
            -- Bị anti cheat kéo speed xuống, force set lại
            hum.WalkSpeed = currentSpeed
            print("[ANTI CHEAT] Đã phát hiện và khắc phục giảm tốc độ!")
        end
    end
end

-- Hàm set speed chính
local function setSpeed(value)
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum then
        currentSpeed = math.floor(value)
        if currentSpeed < 16 then currentSpeed = 16 end
        if currentSpeed > 999999999 then currentSpeed = 999999999 end
        hum.WalkSpeed = currentSpeed
        currentSpeedLabel.Text = "📊 TỐC ĐỘ HIỆN TẠI: " .. currentSpeed
        speedInput.Text = tostring(currentSpeed)
        
        -- Hiển thị cảnh báo nếu tốc độ quá cao
        if currentSpeed > 300 then
            warningFrame.Visible = true
        else
            warningFrame.Visible = false
        end
    end
end

-- Xử lý nhập tốc độ
applyBtn.MouseButton1Click:Connect(function()
    local inputText = speedInput.Text
    inputText = inputText:gsub("[%,%s]", "")
    local success, result = pcall(function()
        return tonumber(inputText) or currentSpeed
    end)
    if success and result then
        local newSpeed = math.floor(result)
        if newSpeed < 16 then newSpeed = 16 end
        if newSpeed > 999999999 then newSpeed = 999999999 end
        setSpeed(newSpeed)
        print("[SPEED] Tốc độ đã set: " .. newSpeed)
        
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
        notif.Text = "⚡ TỐC ĐỘ: " .. newSpeed
        Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
        task.wait(1.5)
        notif:Destroy()
    else
        speedInput.Text = tostring(currentSpeed)
    end
end)

-- Bật/tắt Speed
local function enableSpeed()
    if speedEnabled then return end
    speedEnabled = true
    saveOriginalSpeed()
    setSpeed(currentSpeed)
    
    if not speedConnection then
        speedConnection = RunService.RenderStepped:Connect(function()
            if speedEnabled then
                antiCheatSpeedFix()
                antiDelayFix()
            end
        end)
    end
    
    speedBtn.Text = "⚡ SPEED [ON]"
    speedBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    print("[SPEED] ĐÃ BẬT | Tốc độ: " .. currentSpeed)
end

local function disableSpeed()
    if not speedEnabled then return end
    speedEnabled = false
    
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    restoreOriginalSpeed()
    
    speedBtn.Text = "⚡ SPEED [OFF]"
    speedBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
    print("[SPEED] ĐÃ TẮT")
end

speedBtn.MouseButton1Click:Connect(function()
    if speedEnabled then
        disableSpeed()
    else
        enableSpeed()
    end
end)

-- Xử lý khi nhân vật respawn
player.CharacterAdded:Connect(function()
    saveOriginalSpeed()
    if speedEnabled then
        task.wait(0.5)
        setSpeed(currentSpeed)
    end
end)

-- Lưu tốc độ gốc khi script chạy
task.wait(0.5)
saveOriginalSpeed()

--========================
-- PHÍM TẮT
--========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        if speedEnabled then
            disableSpeed()
        else
            enableSpeed()
        end
    end
end)

--========================
-- MỞ/ĐÓNG GUI
--========================
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
