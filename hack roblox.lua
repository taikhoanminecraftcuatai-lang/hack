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
