--// SIMPLE GUI + KEY SYSTEM + AIM LOCK
--// LocalScript
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--========================
-- MAIN GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "MAIN_GUI"
gui.Parent = game.CoreGui
gui.Enabled = false

--========================
-- OPEN BUTTON
--========================

local open = Instance.new("TextButton")
open.Parent = gui
open.Size = UDim2.new(0, 70, 0, 35)
open.Position = UDim2.new(0, 20, 0.5, -35)
open.Text = "MENU"
open.TextScaled = false
open.TextSize = 12
open.Font = Enum.Font.GothamBlack
open.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
open.TextColor3 = Color3.new(1, 1, 1)
open.BorderSizePixel = 0
open.Active = true
open.Draggable = true

Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

--========================
-- MAIN FRAME
--========================

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 450, 0, 400)
frame.Position = UDim2.new(0.5, -225, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "⚡ TOOL HUB"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.new(1, 1, 1)

-- STATUS
local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 40)
status.Position = UDim2.new(0, 0, 0.25, 0)
status.BackgroundTransparency = 1
status.Text = "STATUS : READY"
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.new(1, 1, 1)

-- KHU VỰC ĐỂ NÚT
local buttonContainer = Instance.new("Frame")
buttonContainer.Parent = frame
buttonContainer.Size = UDim2.new(1, -40, 0, 250)
buttonContainer.Position = UDim2.new(0, 20, 0.42, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Name = "ButtonContainer"

--========================
-- KEY SYSTEM
--========================

local correctKey = "tailovuong"

local whitelist = {
    ["sidbuddb"] = true
}

local keyGui = Instance.new("ScreenGui")
keyGui.Parent = game.CoreGui

local keyFrame = Instance.new("Frame")
keyFrame.Parent = keyGui
keyFrame.Size = UDim2.new(0, 350, 0, 220)
keyFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.BorderSizePixel = 0

Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 18)

local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 60)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "🔐 ENTER KEY"
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextColor3 = Color3.new(1, 1, 1)

local keyBox = Instance.new("TextBox")
keyBox.Parent = keyFrame
keyBox.Size = UDim2.new(0.8, 0, 0, 50)
keyBox.Position = UDim2.new(0.1, 0, 0.38, 0)
keyBox.PlaceholderText = "INPUT KEY..."
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.Font = Enum.Font.GothamBold
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BorderSizePixel = 0

Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 12)

local enter = Instance.new("TextButton")
enter.Parent = keyFrame
enter.Size = UDim2.new(0.5, 0, 0, 45)
enter.Position = UDim2.new(0.25, 0, 0.7, 0)
enter.Text = "UNLOCK"
enter.TextScaled = true
enter.Font = Enum.Font.GothamBlack
enter.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
enter.TextColor3 = Color3.new(1, 1, 1)
enter.BorderSizePixel = 0

Instance.new("UICorner", enter).CornerRadius = UDim.new(0, 12)

local keyStatus = Instance.new("TextLabel")
keyStatus.Parent = keyFrame
keyStatus.Size = UDim2.new(1, 0, 0, 30)
keyStatus.Position = UDim2.new(0, 0, 0.88, 0)
keyStatus.BackgroundTransparency = 1
keyStatus.Text = "STATUS : WAITING"
keyStatus.TextScaled = true
keyStatus.Font = Enum.Font.GothamBold
keyStatus.TextColor3 = Color3.new(1, 1, 1)

--========================
-- WHITELIST CHECK
--========================

if whitelist[player.Name] then
    gui.Enabled = true
    keyGui.Enabled = false
end

--========================
-- KEY CHECK
--========================

enter.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        keyStatus.Text = "STATUS : ACCESS GRANTED"
        task.wait(0.5)
        keyGui:Destroy()
        gui.Enabled = true
    else
        keyStatus.Text = "STATUS : WRONG KEY"
        keyFrame.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
        task.wait(0.3)
        keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    end
end)

--========================
-- OPEN / CLOSE
--========================

open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

--========================
-- CLICK EFFECT
--========================

local function click(button)
    local old = button.Size
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = old - UDim2.new(0, 4, 0, 4)
        }):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.08), {
            Size = old
        }):Play()
    end)
end

click(open)
click(enter)

--========================
-- HÀM TẠO NÚT
--========================

local function makeButton(text, row, col, color)
    local b = Instance.new("TextButton")
    b.Parent = buttonContainer
    b.Size = UDim2.new(0, 120, 0, 35)
    b.Position = UDim2.new(0, 10 + (col - 1) * 130, 0, 10 + (row - 1) * 45)
    b.Text = text
    b.TextScaled = false
    b.TextSize = 13
    b.Font = Enum.Font.GothamBold
    b.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.BorderSizePixel = 0
    
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    click(b)
    return b
end

--========================
-- AIM LOCK (LOOK ĐẦU)
--========================

local aimbotEnabled = false
local currentTarget = nil

local aimBtn = makeButton(" AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))

local function updateAimButton()
    if aimbotEnabled then
        aimBtn.Text = " AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        status.Text = "STATUS : AIM LOCK ON"
    else
        aimBtn.Text = " AIM LOCK"
        aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        currentTarget = nil
    end
end

local function getClosestPlayer()
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local myPos = character.HumanoidRootPart.Position
    local closest = nil
    local closestDist = math.huge
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local otherChar = other.Character
            if otherChar and otherChar:FindFirstChild("HumanoidRootPart") and otherChar:FindFirstChild("Head") then
                local otherPos = otherChar.HumanoidRootPart.Position
                local dist = (myPos - otherPos).Magnitude
                
                if dist < closestDist and dist < 150 then
                    closestDist = dist
                    closest = other
                end
            end
        end
    end
    
    return closest
end

local function aimAt(target)
    if not target or not target.Character then
        currentTarget = nil
        return
    end
    
    local head = target.Character:FindFirstChild("Head")
    local myCamera = workspace.CurrentCamera
    local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    
    if not head or not myCamera or not myRoot then
        return
    end
    
    local headPos = head.Position
    local cameraPos = myCamera.CFrame.Position
    local newCFrame = CFrame.new(cameraPos, headPos)
    myCamera.CFrame = newCFrame
end

aimBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    updateAimButton()
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestPlayer()
        if target then
            currentTarget = target
            aimAt(target)
        else
            currentTarget = nil
        end
    end
end)
--========================
-- ESP CHUYÊN NGHIỆP (NHÌN XUYÊN TƯỜNG)
--========================

local espEnabled = false
local espObjects = {}  -- Lưu các object ESP để xóa sau

-- Tạo nút ESP
local espBtn = makeButton("️ ESP", 1, 2, Color3.fromRGB(50, 100, 150))

-- Màu sắc cho từng đội (nếu có)
local teamColors = {
    ["Enemy"] = Color3.fromRGB(255, 0, 0),     -- Đỏ: kẻ địch
    ["Friend"] = Color3.fromRGB(0, 255, 0),   -- Xanh: đồng đội
    ["Neutral"] = Color3.fromRGB(255, 255, 0) -- Vàng: trung lập
}

-- Hàm tạo Box ESP (khung quanh người)
local function createBox(player)
    if espObjects[player] then
        destroyESP(player)
    end
    
    local char = player.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Tạo BillboardGui hiển thị tên + máu
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = char:WaitForChild("Head", 0.5) or char
    
    -- Tên người chơi
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = teamColors["Enemy"]
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    -- Khoảng cách
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0.3
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 11
    distLabel.Parent = billboard
    
    -- Khung Box (2D) - dùng Drawing nếu hỗ trợ, không thì dùng khung 3D
    local boxOutline = Instance.new("SelectionBox")
    boxOutline.Name = "ESP_Box"
    boxOutline.Adornee = root
    boxOutline.Color3 = teamColors["Enemy"]
    boxOutline.LineThickness = 0.05
    boxOutline.Transparency = 0.5
    boxOutline.Parent = char
    
    -- Đường Line từ camera đến mục tiêu
    local line = Instance.new("SelectionPartLasso")
    line.Name = "ESP_Line"
    line.Humanoid = char:FindFirstChild("Humanoid")
    line.Part = root
    line.Color3 = teamColors["Enemy"]
    line.Transparency = 0.3
    line.Visible = true
    line.Parent = char
    
    -- Lưu lại để xóa sau
    espObjects[player] = {
        billboard = billboard,
        box = boxOutline,
        line = line,
        nameLabel = nameLabel,
        distLabel = distLabel
    }
    
    return true
end

-- Hàm cập nhật khoảng cách và màu sắc
local function updateESP()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player and espObjects[other] then
            local otherChar = other.Character
            local dist = ""
            local color = teamColors["Enemy"]
            
            if myRoot and otherChar and otherChar:FindFirstChild("HumanoidRootPart") then
                local distance = (myRoot.Position - otherChar.HumanoidRootPart.Position).Magnitude
                dist = string.format("%.1f m", distance)
                
                -- Đổi màu theo khoảng cách
                if distance < 30 then
                    color = Color3.fromRGB(255, 50, 50)  -- Đỏ đậm (gần)
                elseif distance < 70 then
                    color = Color3.fromRGB(255, 150, 50) -- Cam (trung bình)
                else
                    color = Color3.fromRGB(255, 255, 100) -- Vàng (xa)
                end
            end
            
            local data = espObjects[other]
            if data then
                if data.nameLabel then
                    data.nameLabel.TextColor3 = color
                end
                if data.distLabel then
                    data.distLabel.Text = dist
                end
                if data.box then
                    data.box.Color3 = color
                end
                if data.line then
                    data.line.Color3 = color
                end
            end
        end
    end
end

-- Hàm xóa ESP của 1 player
local function destroyESP(target)
    local data = espObjects[target]
    if data then
        if data.billboard then data.billboard:Destroy() end
        if data.box then data.box:Destroy() end
        if data.line then data.line:Destroy() end
        espObjects[target] = nil
    end
end

-- Hàm xóa toàn bộ ESP
local function destroyAllESP()
    for target, _ in pairs(espObjects) do
        destroyESP(target)
    end
    espObjects = {}
end

-- Tạo ESP cho tất cả người chơi
local function createAllESP()
    destroyAllESP()
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            createBox(other)
        end
    end
end

-- Cập nhật khi người chơi mới vào
Players.PlayerAdded:Connect(function(newPlayer)
    if espEnabled then
        task.wait(0.5)
        createBox(newPlayer)
    end
end)

-- Cập nhật khi người chơi rời
Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espObjects[leavingPlayer] then
        destroyESP(leavingPlayer)
    end
end)

-- Cập nhật khi nhân vật xuất hiện
local function onCharacterAdded(player, character)
    if espEnabled and player ~= player then
        task.wait(0.5)
        createBox(player)
    end
end

for _, other in pairs(Players:GetPlayers()) do
    if other ~= player then
        other.CharacterAdded:Connect(function()
            onCharacterAdded(other)
        end)
    end
end

-- Cập nhật ESP mỗi frame
RunService.RenderStepped:Connect(function()
    if espEnabled then
        updateESP()
    end
end)

-- Bật/tắt ESP
local function toggleESP()
    espEnabled = not espEnabled
    
    if espEnabled then
        createAllESP()
        espBtn.Text = "️ ESP [ON]"
        espBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 180)
        status.Text = "STATUS : ESP ON"
    else
        destroyAllESP()
        espBtn.Text = "️ ESP"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

espBtn.MouseButton1Click:Connect(toggleESP)

-- Khi nhân vật chết thì xóa ESP cũ
player.CharacterAdded:Connect(function()
    if espEnabled then
        task.wait(1)
        createAllESP()
    end
end)
