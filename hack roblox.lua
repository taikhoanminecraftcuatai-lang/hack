--// SIMPLE GUI + KEY SYSTEM
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
frame.Size = UDim2.new(0, 450, 0, 350)
frame.Position = UDim2.new(0.5, -225, 0.5, -175)
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

-- KHU VỰC ĐỂ NÚT (ĐỂ TRỐNG)
local buttonContainer = Instance.new("Frame")
buttonContainer.Parent = frame
buttonContainer.Size = UDim2.new(1, -40, 0, 200)
buttonContainer.Position = UDim2.new(0, 20, 0.4, 0)
buttonContainer.BackgroundTransparency = 1
buttonContainer.Name = "ButtonContainer"

--========================
-- KEY SYSTEM
--========================

local correctKey = "tailovuong"

local whitelist = {
    ["sidbuddb"] = true  -- Tên bạn
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

-- TITLE
local keyTitle = Instance.new("TextLabel")
keyTitle.Parent = keyFrame
keyTitle.Size = UDim2.new(1, 0, 0, 60)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "🔐 ENTER KEY"
keyTitle.TextScaled = true
keyTitle.Font = Enum.Font.GothamBlack
keyTitle.TextColor3 = Color3.new(1, 1, 1)

-- TEXTBOX
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

-- ENTER BUTTON
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

-- STATUS
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
-- HÀM TẠO NÚT (ĐỂ DÙNG SAU)
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

-- Tạo nút bật/tắt AIM LOCK
local aimBtn = makeButton("AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))

-- Cập nhật trạng thái nút
local function updateAimButton()
    if aimbotEnabled then
        aimBtn.Text = "AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        status.Text = "STATUS : AIM LOCK ON"
    else
        aimBtn.Text = "AIM LOCK"
        aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        currentTarget = nil
    end
end

-- Tìm người chơi gần nhất (theo khoảng cách thực tế)
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
                
                -- Chỉ aim trong khoảng cách nhất định (có thể tăng giảm)
                if dist < closestDist and dist < 150 then
                    closestDist = dist
                    closest = other
                end
            end
        end
    end
    
    return closest
end

-- Xoay camera về hướng đầu mục tiêu (CỰC CỨNG)
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
    
    -- Lấy vị trí đầu mục tiêu và vị trí mắt camera
    local headPos = head.Position
    local cameraPos = myCamera.CFrame.Position
    
    -- Tính hướng từ camera đến đầu
    local direction = (headPos - cameraPos).Unit
    
    -- Tạo CFrame mới nhìn thẳng vào đầu (CỰC CỨNG, KHÔNG RUNG)
    local newCFrame = CFrame.new(cameraPos, headPos)
    
    -- Ép camera về hướng đó ngay lập tức (không có tween)
    myCamera.CFrame = newCFrame
end

-- Nút bấm để bật/tắt
aimBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    updateAimButton()
end)

-- Luồng chính: tự động aim mỗi frame khi bật
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        -- Tìm mục tiêu gần nhất
        local target = getClosestPlayer()
        
        if target then
            currentTarget = target
            aimAt(target)
        else
            currentTarget = nil
        end
    end
end)
