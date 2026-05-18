-- Tạo GUI chính
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ToolGUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- === ICON MỞ GUI ===
local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 45, 0, 45)
icon.Position = UDim2.new(0.85, 0, 0.05, 0)
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
icon.Text = "⚙️"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextSize = 24
icon.Font = Enum.Font.GothamBold
icon.BorderSizePixel = 0
icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

-- === MAIN GUI (ẩn ban đầu) ===
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 340)
mainFrame.Position = UDim2.new(0.5, -130, 0.45, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- === THANH TIÊU ĐỀ ===
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -30, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Tool Hub"
titleText.TextColor3 = Color3.fromRGB(230, 230, 255)
titleText.Font = Enum.Font.GothamSemibold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Nút đóng
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- === KHU VỰC ĐỂ NÚT (ĐỂ TRỐNG) ===
-- Bạn tự thêm nút vào đây, ví dụ:

-- local myButton = Instance.new("TextButton")
-- myButton.Size = UDim2.new(0, 220, 0, 40)
-- myButton.Position = UDim2.new(0.5, -110, 0.2, 0)
-- myButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
-- myButton.Text = "Nút của bạn"
-- myButton.TextColor3 = Color3.fromRGB(255, 255, 255)
-- myButton.Font = Enum.Font.Gotham
-- myButton.TextSize = 13
-- myButton.Parent = mainFrame
-- 
-- local btnCorner = Instance.new("UICorner")
-- btnCorner.CornerRadius = UDim.new(0, 6)
-- btnCorner.Parent = myButton

-- === MỞ GUI KHI NHẤN ICON ===
icon.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

print("✅ GUI rỗng đã sẵn sàng! Bạn tự thêm nút tính năng vào nhé.")
