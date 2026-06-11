local gui = Instance.new("ScreenGui")
gui.Name = "SimpleGUI"
gui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.5, -150, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.Text = "MENU"
title.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame
Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 28, 0, 28)
close.Position = UDim2.new(1, -32, 0, 4)
close.Text = "X"
close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
close.TextColor3 = Color3.fromRGB(255, 255, 255)
close.Font = Enum.Font.GothamBold
close.TextSize = 14
close.Parent = title
Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)

local container = Instance.new("ScrollingFrame")
container.Size = UDim2.new(1, -20, 1, -55)
container.Position = UDim2.new(0, 10, 0, 45)
container.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
container.Parent = frame
Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = container

function makeButton(name, color, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = container
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(cb)
    task.wait(0.05)
    container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end

close.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

frame.Visible = true
--==========================================
-- TÍNH NĂNG LƯU TOẠ ĐỘ & DỊCH CHUYỂN
-- Thêm vào GUI có sẵn của bạn
--==========================================

local player = game.Players.LocalPlayer
local savedPoints = {}  -- Lưu các điểm {name = "đảo 1", pos = Vector3}

-- Hàm lưu toạ độ hiện tại
local function saveCurrentPosition()
    local char = player.Character
    if not char then
        print("❌ Không có nhân vật")
        return
    end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then
        print("❌ Không tìm thấy vị trí")
        return
    end
    
    local pos = hrp.Position
    local name = "Điểm " .. (#savedPoints + 1)
    
    -- Hỏi tên (dùng input dialog)
    local success, result = pcall(function()
        return game:GetService("StarterGui"):SetCore("PromptInput", {
            Title = "Lưu toạ độ",
            Text = "Nhập tên cho điểm này:",
            DefaultText = name
        })
    end)
    
    if success and result and result ~= "" then
        name = result
    end
    
    table.insert(savedPoints, {name = name, pos = pos})
    print("✅ Đã lưu: " .. name .. " | X: " .. math.floor(pos.X) .. " Y: " .. math.floor(pos.Y) .. " Z: " .. math.floor(pos.Z))
    
    -- Cập nhật menu dịch chuyển
    updateTeleportMenu()
end

-- Hàm hiển thị menu chọn điểm để dịch chuyển
local teleportMenu = nil
local teleportFrame = nil

local function updateTeleportMenu()
    if teleportMenu then
        teleportMenu:Destroy()
        teleportMenu = nil
    end
    
    if #savedPoints == 0 then
        print("📌 Chưa có điểm nào được lưu")
        return
    end
    
    -- Tạo menu thả xuống
    teleportMenu = Instance.new("ScreenGui")
    teleportMenu.Name = "TeleportMenu"
    teleportMenu.Parent = game.CoreGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, math.min(#savedPoints * 40 + 50, 300))
    frame.Position = UDim2.new(0.5, -100, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
    frame.Parent = teleportMenu
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "📌 CHỌN ĐIỂM DỊCH CHUYỂN"
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 70)
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 12
    title.Parent = frame
    Instance.new("UICorner", title).CornerRadius = UDim.new(0, 10)
    
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 28, 0, 28)
    close.Position = UDim2.new(1, -32, 0, 4)
    close.Text = "X"
    close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 14
    close.Parent = title
    Instance.new("UICorner", close).CornerRadius = UDim.new(1, 0)
    close.MouseButton1Click:Connect(function()
        teleportMenu:Destroy()
        teleportMenu = nil
    end)
    
    local container = Instance.new("ScrollingFrame")
    container.Size = UDim2.new(1, -10, 1, -50)
    container.Position = UDim2.new(0, 5, 0, 45)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    container.Parent = frame
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 8)
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = container
    
    for i, point in pairs(savedPoints) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.Text = "📍 " .. point.name
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.Parent = container
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseButton1Click:Connect(function()
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(point.pos)
                    print("✅ Đã dịch chuyển đến: " .. point.name)
                end
            end
            teleportMenu:Destroy()
            teleportMenu = nil
        end)
    end
    
    container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end

-- Hàm hiển thị menu dịch chuyển
local function showTeleportMenu()
    if #savedPoints == 0 then
        print("📌 Chưa có điểm nào được lưu. Hãy dùng 'Lưu toạ độ' trước.")
        return
    end
    updateTeleportMenu()
end

-- ===== THÊM NÚT VÀO GUI CỦA BẠN =====
-- Gọi makeButton hoặc tạo nút thủ công:

-- Nếu bạn dùng hàm makeButton:
-- makeButton(" LƯU TOẠ ĐỘ", Color3.fromRGB(0, 120, 150), saveCurrentPosition)
-- makeButton(" DỊCH CHUYỂN", Color3.fromRGB(150, 80, 0), showTeleportMenu)

-- Nếu bạn tạo nút thủ công:
local btnSave = Instance.new("TextButton")
btnSave.Size = UDim2.new(1, -10, 0, 40)
btnSave.Text = " LƯU TOẠ ĐỘ"
btnSave.BackgroundColor3 = Color3.fromRGB(0, 120, 150)
btnSave.TextColor3 = Color3.fromRGB(255, 255, 255)
btnSave.Font = Enum.Font.GothamBold
btnSave.TextSize = 13
btnSave.Parent = container  -- Thay "container" bằng tên container GUI của bạn
Instance.new("UICorner", btnSave).CornerRadius = UDim.new(0, 6)
btnSave.MouseButton1Click:Connect(saveCurrentPosition)

local btnTeleport = Instance.new("TextButton")
btnTeleport.Size = UDim2.new(1, -10, 0, 40)
btnTeleport.Text = " DỊCH CHUYỂN"
btnTeleport.BackgroundColor3 = Color3.fromRGB(150, 80, 0)
btnTeleport.TextColor3 = Color3.fromRGB(255, 255, 255)
btnTeleport.Font = Enum.Font.GothamBold
btnTeleport.TextSize = 13
btnTeleport.Parent = container  -- Thay "container" bằng tên container GUI của bạn
Instance.new("UICorner", btnTeleport).CornerRadius = UDim.new(0, 6)
btnTeleport.MouseButton1Click:Connect(showTeleportMenu)
