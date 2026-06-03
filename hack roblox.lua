-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VehicleSpeedGUI"
screenGui.Parent = game:GetService("PlayerGui")

-- Frame chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 200)
mainFrame.Position = UDim2.new(0.5, -140, 0.7, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.15
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
title.Text = "🎮 ĐIỀU KHIỂN TỐC ĐỘ XE 🎮"
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = mainFrame

-- Thanh trượt
local speedSlider = Instance.new("TextBox")
speedSlider.Size = UDim2.new(0.7, 0, 0, 40)
speedSlider.Position = UDim2.new(0.15, 0, 0.3, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.PlaceholderText = "Nhập tốc độ tối đa"
speedSlider.Text = "100"
speedSlider.Font = Enum.Font.Gotham
speedSlider.TextSize = 16
speedSlider.Parent = mainFrame

-- Nút Boost
local boostButton = Instance.new("TextButton")
boostButton.Size = UDim2.new(0.7, 0, 0, 45)
boostButton.Position = UDim2.new(0.15, 0, 0.55, 0)
boostButton.BackgroundColor3 = Color3.fromRGB(255, 100, 50)
boostButton.Text = " BOOST XE "
boostButton.TextColor3 = Color3.fromRGB(255, 255, 255)
boostButton.Font = Enum.Font.GothamBold
boostButton.TextSize = 16
boostButton.Parent = mainFrame

-- Hiển thị tốc độ hiện tại của xe
local speedDisplay = Instance.new("TextLabel")
speedDisplay.Size = UDim2.new(1, 0, 0, 30)
speedDisplay.Position = UDim2.new(0, 0, 0.85, 0)
speedDisplay.BackgroundTransparency = 1
speedDisplay.Text = " Tốc độ xe: 0"
speedDisplay.TextColor3 = Color3.fromRGB(100, 255, 100)
speedDisplay.Font = Enum.Font.GothamBold
speedDisplay.TextSize = 14
speedDisplay.Parent = mainFrame

-- Remote event
local remote = Instance.new("RemoteEvent")
remote.Name = "VehicleBoostEvent"
remote.Parent = game:GetService("ReplicatedStorage")

-- Xử lý boost
boostButton.MouseButton1Click:Connect(function()
    local targetSpeed = tonumber(speedSlider.Text)
    if targetSpeed and targetSpeed >= 50 and targetSpeed <= 500 then
        remote:FireServer(targetSpeed)
        speedDisplay.Text = " Đã gửi yêu cầu: " .. targetSpeed .. " 🚀"
        task.wait(1)
    else
        speedDisplay.Text = " Nhập số từ 50-500 "
        speedSlider.Text = "100"
    end
end)

-- Cập nhật hiển thị tốc độ thực tế
local function updateSpeedDisplay()
    local vehicle = game:GetService("Players").LocalPlayer.Character
    if vehicle and vehicle:FindFirstChild("Humanoid") then
        local speed = vehicle.Humanoid.WalkSpeed  -- Hoặc dùng VehicleSeat.Throttle
        speedDisplay.Text = " Tốc độ xe: " .. math.floor(speed) .. " 🚗"
    end
end

while task.wait(0.2) do
    updateSpeedDisplay()
end
