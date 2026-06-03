--========================
-- SPEED HUB - DÀNH CHO GAME XE MÁY ĐỘ
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
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
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -210)
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
header.Size = UDim2.new(1, 0, 0, 45)
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
title.Text = "⚡ SPEED HUB - XE MÁY"
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

-- Khu vực nội dung
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -20, 1, -60)
content.Position = UDim2.new(0, 10, 0, 55)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.Padding = UDim.new(0, 10)

-- Thanh trạng thái
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 26)
statusBar.Position = UDim2.new(0, 0, 1, -26)
statusBar.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -12, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 11
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

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
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    
    return btn
end

--========================
-- TÌM XE ĐANG ĐI
--========================
local vehicleParts = {"VehicleSeat", "Seat", "Vehicle", "Car", "Bike", "Motorcycle", "Chassis", "Body"}

local function findCurrentVehicle()
    local char = player.Character
    if not char then return nil end
    
    -- Kiểm tra xem có đang ngồi trên xe không
    local hum = char:FindFirstChild("Humanoid")
    if hum and hum.SeatPart then
        local seat = hum.SeatPart
        local parent = seat.Parent
        if parent then
            return parent
        end
    end
    
    -- Tìm xe xung quanh
    local root = char:FindFirstChild("HumanoidRootPart")
    if root then
        for _, part in pairs(root:GetTouchingParts()) do
            if part and part.Parent then
                for _, vp in pairs(vehicleParts) do
                    if part.Name:find(vp) or part.Parent.Name:find(vp) then
                        return part.Parent
                    end
                end
            end
        end
    end
    
    return nil
end

-- Tìm tất cả các bộ phận của xe có thể thay đổi vận tốc
local function getVehicleParts(vehicle)
    if not vehicle then return {} end
    
    local parts = {}
    local function scan(obj)
        if obj:IsA("BasePart") then
            table.insert(parts, obj)
        end
        for _, child in pairs(obj:GetChildren()) do
            scan(child)
        end
    end
    scan(vehicle)
    return parts
end

--========================
-- SPEED CONTROL (CHO XE)
--========================
local speedEnabled = false
local speedConnection = nil
local currentSpeed = 100
local originalVelocities = {}

-- Lưu vận tốc gốc của các bộ phận xe
local function saveOriginalVelocities(vehicle)
    local parts = getVehicleParts(vehicle)
    for _, part in pairs(parts) do
        if not originalVelocities[part] then
            originalVelocities[part] = {
                Velocity = part.Velocity,
                AssemblyLinearVelocity = part.AssemblyLinearVelocity,
                RotVelocity = part.RotVelocity
            }
        end
    end
end

-- Khôi phục vận tốc gốc
local function restoreOriginalVelocities(vehicle)
    for part, orig in pairs(originalVelocities) do
        if part and part.Parent then
            pcall(function()
                part.Velocity = orig.Velocity
                part.RotVelocity = orig.RotVelocity
            end)
        end
    end
    originalVelocities = {}
end

-- Tăng tốc cho xe
local function boostVehicle(vehicle, speed)
    if not vehicle then return end
    
    local parts = getVehicleParts(vehicle)
    local direction = nil
    
    -- Tìm hướng di chuyển hiện tại
    for _, part in pairs(parts) do
        if part.AssemblyLinearVelocity.Magnitude > 1 then
            direction = part.AssemblyLinearVelocity.Unit
            break
        end
    end
    
    if not direction then
        -- Nếu chưa có vận tốc, lấy hướng nhìn của người chơi
        local cam = workspace.CurrentCamera
        if cam then
            direction = cam.CFrame.LookVector
        else
            direction = Vector3.new(1, 0, 0)
        end
    end
    
    -- Áp dụng vận tốc mới cho tất cả các bộ phận
    for _, part in pairs(parts) do
        pcall(function()
            -- Tạo BodyVelocity để đẩy xe
            local bv = part:FindFirstChild("SpeedBoost_BV")
            if not bv then
                bv = Instance.new("BodyVelocity")
                bv.Name = "SpeedBoost_BV"
                bv.MaxForce = Vector3.new(1, 1, 1) * 100000
            end
            bv.Velocity = direction * speed
            bv.Parent = part
            
            -- Cũng set trực tiếp velocity
            part.Velocity = direction * speed
            part.AssemblyLinearVelocity = direction * speed
        end)
    end
end

-- Dừng boost
local function stopBoost(vehicle)
    if not vehicle then return end
    
    local parts = getVehicleParts(vehicle)
    for _, part in pairs(parts) do
        local bv = part:FindFirstChild("SpeedBoost_BV")
        if bv then
            bv:Destroy()
        end
    end
end

--========================
-- BẬT/TẮT SPEED BOOST
--========================
local function enableSpeed()
    if speedEnabled then return end
    speedEnabled = true
    
    if speedConnection then
        speedConnection:Disconnect()
    end
    
    speedConnection = RunService.RenderStepped:Connect(function()
        if speedEnabled then
            local vehicle = findCurrentVehicle()
            if vehicle then
                boostVehicle(vehicle, currentSpeed)
                statusText.Text = "● SPEED: " .. currentSpeed .. " - ĐANG BAY"
            else
                statusText.Text = "● SPEED: " .. currentSpeed .. " - KHÔNG CÓ XE"
            end
        end
    end)
    
    if speedBtn then
        speedBtn.Text = " BOOST [ON]"
        speedBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 200)
    end
    print("[BOOST] ĐÃ BẬT - Tốc độ: " .. currentSpeed)
end

local function disableSpeed()
    if not speedEnabled then return end
    speedEnabled = false
    
    if speedConnection then
        speedConnection:Disconnect()
        speedConnection = nil
    end
    
    local vehicle = findCurrentVehicle()
    if vehicle then
        stopBoost(vehicle)
    end
    
    if speedBtn then
        speedBtn.Text = " BOOST [OFF]"
        speedBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 140)
    end
    statusText.Text = "● BOOST: OFF"
    print("[BOOST] ĐÃ TẮT")
end

local function toggleSpeed()
    if speedEnabled then
        disableSpeed()
    else
        enableSpeed()
    end
end

-- Tăng/giảm tốc độ
local function increaseSpeed()
    currentSpeed = math.min(1000, currentSpeed + 50)
    statusText.Text = "● SPEED: " .. currentSpeed
    print("[BOOST] Tốc độ: " .. currentSpeed)
end

local function decreaseSpeed()
    currentSpeed = math.max(50, currentSpeed - 50)
    statusText.Text = "● SPEED: " .. currentSpeed
    print("[BOOST] Tốc độ: " .. currentSpeed)
end

--========================
-- PHÍM TẮT
--========================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.L then
        toggleSpeed()
    end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        increaseSpeed()
    end
    if input.KeyCode == Enum.KeyCode.LeftBracket then
        decreaseSpeed()
    end
end)

--========================
-- TẠO NÚT TRONG GUI
--========================
local speedBtn = makeButton(" BOOST XE", 1, 1, Color3.fromRGB(60, 100, 140))
speedBtn.MouseButton1Click:Connect(toggleSpeed)

local plusBtn = makeButton("➕ TĂNG", 1, 2, Color3.fromRGB(80, 80, 100))
plusBtn.MouseButton1Click:Connect(increaseSpeed)

local minusBtn = makeButton("➖ GIẢM", 2, 1, Color3.fromRGB(80, 80, 100))
minusBtn.MouseButton1Click:Connect(decreaseSpeed)

local infoBtn = makeButton(" INFO", 2, 2, Color3.fromRGB(100, 80, 60))
infoBtn.MouseButton1Click:Connect(function()
    statusText.Text = "● TÌM XE -> NGỒI LÊN -> BẬT BOOST"
    task.wait(2)
    statusText.Text = "● READY"
end)

--========================
-- CẬP NHẬT CANVAS
--========================
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)
task.wait(0.2)
updateCanvas()

--========================
-- MỞ/ĐÓNG GUI
--========================
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        updateCanvas()
    end
end)
