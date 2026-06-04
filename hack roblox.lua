--========================
-- SPEED HUB - TĂNG VÔ HẠN (0.5 GIÂY +2)
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--========================
-- TẠO GUI
--========================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedHub"
screenGui.Parent = game.CoreGui

-- Nút mở GUI
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 55, 0, 55)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -27)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "⚡"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 28
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Draggable = true
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- Cửa sổ chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainFrame

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
title.Size = UDim2.new(1, -55, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ SPEED HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
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

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 50)
content.BackgroundTransparency = 1
content.Parent = mainFrame

--========================
-- HÀM TẠO NÚT
--========================
local function makeButton(text, row, col, color)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(0, 130, 0, 45)
    btn.Position = UDim2.new(0, 10 + (col - 1) * 145, 0, 10 + (row - 1) * 55)
    btn.Text = text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    btn.BackgroundTransparency = 0.2
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0.05
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.2
    end)
    
    return btn
end

--========================
-- TÌM XE
--========================
local currentVehicle = nil

local function findCurrentVehicle()
    local char = player.Character
    if not char then return nil end
    
    local hum = char:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then
        return hum.SeatPart.Parent
    end
    return nil
end

-- Tăng tốc xe (set vận tốc trực tiếp)
local function setVehicleSpeed(vehicle, speedKMH)
    if not vehicle then return end
    
    local targetParts = {}
    local function scan(obj)
        if obj:IsA("BasePart") then
            local name = obj.Name:lower()
            if name:find("wheel") or name:find("banh") or name:find("tire") then
                table.insert(targetParts, obj)
            end
        end
        for _, child in pairs(obj:GetChildren()) do
            scan(child)
        end
    end
    scan(vehicle)
    
    if #targetParts == 0 then
        local function scanAll(obj)
            if obj:IsA("BasePart") then
                table.insert(targetParts, obj)
            end
            for _, child in pairs(obj:GetChildren()) do
                scanAll(child)
            end
        end
        scanAll(vehicle)
    end
    
    -- Tìm hướng
    local direction = nil
    for _, part in pairs(targetParts) do
        if part.AssemblyLinearVelocity.Magnitude > 5 then
            direction = part.AssemblyLinearVelocity.Unit
            break
        end
    end
    
    if not direction then
        local seat = vehicle:FindFirstChildWhichIsA("VehicleSeat") or vehicle:FindFirstChild("Seat")
        if seat then
            direction = seat.CFrame.LookVector
        else
            direction = Vector3.new(1, 0, 0)
        end
    end
    
    local targetVelocity = direction * (speedKMH / 3.6)
    
    for _, part in pairs(targetParts) do
        part.AssemblyLinearVelocity = targetVelocity
        part.Velocity = targetVelocity
    end
end

--========================
-- BIẾN SPEED (TĂNG VÔ HẠN)
--========================
local speedEnabled = false
local currentSpeed = 0
local timerConnection = nil
local speedDisplay = nil

local function createSpeedDisplay()
    speedDisplay = Instance.new("TextLabel")
    speedDisplay.Size = UDim2.new(0, 250, 0, 80)
    speedDisplay.Position = UDim2.new(0.5, -125, 0.85, 0)
    speedDisplay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    speedDisplay.BackgroundTransparency = 0.5
    speedDisplay.TextColor3 = Color3.fromRGB(0, 200, 255)
    speedDisplay.TextSize = 40
    speedDisplay.Font = Enum.Font.GothamBold
    speedDisplay.Text = "0 KM/H"
    speedDisplay.BorderSizePixel = 0
    speedDisplay.Parent = screenGui
    Instance.new("UICorner", speedDisplay).CornerRadius = UDim.new(0, 10)
    speedDisplay.Visible = false
end

local function updateSpeedDisplay()
    if speedDisplay then
        speedDisplay.Text = math.floor(currentSpeed) .. " KM/H"
        
        if currentSpeed < 200 then
            speedDisplay.TextColor3 = Color3.fromRGB(100, 255, 100)
        elseif currentSpeed < 400 then
            speedDisplay.TextColor3 = Color3.fromRGB(255, 200, 0)
        else
            speedDisplay.TextColor3 = Color3.fromRGB(255, 50, 50)
        end
    end
end

-- Timer: mỗi 0.5 giây tăng 2 (vô hạn)
local function startTimer()
    if timerConnection then
        timerConnection:Disconnect()
    end
    
    timerConnection = RunService.Heartbeat:Connect(function()
        if not speedEnabled then return end
        
        local vehicle = findCurrentVehicle()
        if vehicle then
            -- Tăng vô hạn, không giới hạn
            currentSpeed = currentSpeed + 45
            setVehicleSpeed(vehicle, currentSpeed)
            updateSpeedDisplay()
        end
    end)
end

-- Bật boost
local function enableSpeed()
    if speedEnabled then return end
    speedEnabled = true
    currentSpeed = 0
    
    if not speedDisplay then
        createSpeedDisplay()
    end
    speedDisplay.Visible = true
    updateSpeedDisplay()
    
    startTimer()
    
    if speedBtn then
        speedBtn.Text = " BOOST [ON]"
        speedBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    end
    print("[BOOST] ĐÃ BẬT - Mỗi 0.5 giây tăng 2 (vô hạn)")
end

-- Tắt boost
local function disableSpeed()
    if not speedEnabled then return end
    speedEnabled = false
    
    if timerConnection then
        timerConnection:Disconnect()
        timerConnection = nil
    end
    
    if speedDisplay then
        speedDisplay.Visible = false
    end
    
    currentSpeed = 0
    
    if speedBtn then
        speedBtn.Text = " BOOST [OFF]"
        speedBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
    end
    print("[BOOST] ĐÃ TẮT")
end

local function toggleSpeed()
    if speedEnabled then
        disableSpeed()
    else
        enableSpeed()
    end
end

-- Phím tắt L
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.L then
        toggleSpeed()
    end
end)

-- Respawn: reset speed
player.CharacterAdded:Connect(function()
    if speedEnabled then
        disableSpeed()
    end
    currentSpeed = 0
end)

--========================
-- TẠO NÚT
--========================
local speedBtn = makeButton("BOOST XE", 1, 1, Color3.fromRGB(60, 100, 140))
speedBtn.MouseButton1Click:Connect(toggleSpeed)

--========================
-- MỞ/ĐÓNG GUI
--========================
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)
