--==============================
-- GUI KÉO THẢ - BẢN CHUẨN CHO DELTA
--==============================
local gui = Instance.new("ScreenGui")
gui.Name = "MyGUI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- ===== NÚT MỞ GUI (GÓC TRÊN PHẢI) =====
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(1, -60, 0, 10)
openBtn.Text = "⚙️"
openBtn.TextSize = 24
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
openBtn.Active = true   -- Quan trọng: cho phép kéo
openBtn.Draggable = true -- Quan trọng: bật kéo thả
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.BorderSizePixel = 0
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)

-- ===== MAIN FRAME (CÓ THỂ KÉO) =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 350)
mainFrame.Position = UDim2.new(0.5, -140, 0.2, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true   -- Quan trọng: cho phép kéo
mainFrame.Draggable = true -- Quan trọng: bật kéo thả
mainFrame.Parent = gui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- ===== THANH TIÊU ĐỀ =====
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -40, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.Text = "MENU"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 16
titleText.Parent = titleBar

-- ===== NÚT ĐÓNG (X) =====
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 2.5)
closeBtn.Text = "✕"
closeBtn.TextSize = 18
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- ===== CONTAINER CHỨA NÚT =====
local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -10, 1, -50)
container.Position = UDim2.new(0, 5, 0, 45)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 0, 0)
container.ScrollBarThickness = 6
container.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 8)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = container

-- ===== HÀM TẠO NÚT =====
function makeButton(buttonName, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = buttonName
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = container
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    
    task.wait(0.05)
    container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

-- ===== SỰ KIỆN MỞ/ĐÓNG =====
openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    mainFrame.BackgroundTransparency = 0
    openBtn.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    openBtn.Visible = true
end)
--==============================
-- TÍNH NĂNG AUTO Z
--==============================

-- Tạo khung riêng cho Auto Z (gọn nhẹ)
local autoFrame = Instance.new("Frame")
autoFrame.Size = UDim2.new(1, -10, 0, 45)
autoFrame.Position = UDim2.new(0, 5, 0, 45 + (listLayout.AbsoluteContentSize.Y + 10))
autoFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
autoFrame.BackgroundTransparency = 0
autoFrame.BorderSizePixel = 0
autoFrame.Visible = true
autoFrame.Parent = container
Instance.new("UICorner", autoFrame).CornerRadius = UDim.new(0, 8)

-- Nút Auto Z (bật/tắt)
local autoZBtn = Instance.new("TextButton")
autoZBtn.Size = UDim2.new(0, 80, 1, -10)
autoZBtn.Position = UDim2.new(0, 5, 0, 5)
autoZBtn.Text = "Auto Z 🔴"
autoZBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
autoZBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoZBtn.BorderSizePixel = 0
autoZBtn.Font = Enum.Font.Gotham
autoZBtn.TextSize = 12
autoZBtn.Parent = autoFrame
Instance.new("UICorner", autoZBtn).CornerRadius = UDim.new(0, 6)

-- Ô nhập thời gian
local timeBox = Instance.new("TextBox")
timeBox.Size = UDim2.new(0, 70, 1, -10)
timeBox.Position = UDim2.new(1, -85, 0, 5)
timeBox.PlaceholderText = "0.5"
timeBox.Text = "0.5"
timeBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
timeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
timeBox.BorderSizePixel = 0
timeBox.Font = Enum.Font.Gotham
timeBox.TextSize = 12
timeBox.TextXAlignment = Enum.TextXAlignment.Center
timeBox.Parent = autoFrame
Instance.new("UICorner", timeBox).CornerRadius = UDim.new(0, 6)

-- Nhãn "giây"
local secLabel = Instance.new("TextLabel")
secLabel.Size = UDim2.new(0, 30, 1, -10)
secLabel.Position = UDim2.new(1, -120, 0, 5)
secLabel.Text = "giây"
secLabel.BackgroundTransparency = 1
secLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
secLabel.TextSize = 11
secLabel.Font = Enum.Font.Gotham
secLabel.TextXAlignment = Enum.TextXAlignment.Right
secLabel.Parent = autoFrame

-- Biến điều khiển
local autoZRunning = false
local autoZConnection = nil

-- Hàm gửi phím Z (simulate)
local function pressZ()
    -- Gửi sự kiện phím Z đến game
    local VirtualUser = game:GetService("VirtualUser")
    if VirtualUser then
        VirtualUser:ClickButton1(Vector2.new(0, 0))
    end
    
    -- Cách 2: dùng fire click (thử nếu cách trên không dùng được)
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.Z, false, game)
    task.wait(0.05)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.Z, false, game)
end

-- Nút bật/tắt Auto Z
autoZBtn.MouseButton1Click:Connect(function()
    autoZRunning = not autoZRunning
    
    if autoZRunning then
        -- Đọc thời gian từ ô nhập
        local interval = tonumber(timeBox.Text)
        if not interval or interval <= 0 then
            interval = 0.5
            timeBox.Text = "0.5"
        end
        
        autoZBtn.Text = "Auto Z 🟢"
        autoZBtn.BackgroundColor3 = Color3.fromRGB(40, 80, 40)
        
        -- Chạy vòng lặp auto Z
        autoZConnection = game:GetService("RunService").Stepped:Connect(function()
            if autoZRunning then
                pressZ()
                task.wait(interval)
            end
        end)
        
        print(" Auto Z on | Khoảng cách: " .. interval .. " giây")
    else
        autoZBtn.Text = "Auto Z 🔴"
        autoZBtn.BackgroundColor3 = Color3.fromRGB(80, 40, 40)
        
        if autoZConnection then
            autoZConnection:Disconnect()
            autoZConnection = nil
        end
        
        print(" Auto Z off")
    end
end)

-- Cập nhật lại canvas size của container
task.wait(0.1)
container.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 55)

-- Thêm dòng trạng thái hiển thị thời gian hiện tại (tùy chọn)
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -10, 0, 20)
statusLabel.Position = UDim2.new(0, 5, 1, -25)
statusLabel.Text = " Auto Z on"
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.TextSize = 10
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = mainFrame

-- Cập nhật status label khi auto Z chạy/dừng
local oldCallback = autoZBtn.MouseButton1Click
autoZBtn.MouseButton1Click:Connect(function()
    if autoZRunning then
        statusLabel.Text = "⏱️ Auto Z on | " .. timeBox.Text .. " giây/lần"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        statusLabel.Text = "Auto Z off"
        statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    end
end)
