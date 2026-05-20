local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MAIN_GUI"
gui.Parent = game.CoreGui
gui.Enabled = false

local open = Instance.new("TextButton")
open.Parent = gui
open.Size = UDim2.new(0, 70, 0, 35)
open.Position = UDim2.new(0, 20, 0.5, -35)
open.Text = "MENU"
open.TextSize = 12
open.Font = Enum.Font.GothamBlack
open.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
open.TextColor3 = Color3.new(1, 1, 1)
open.BorderSizePixel = 0
open.Active = true
open.Draggable = true

Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 450, 0, 450)
frame.Position = UDim2.new(0.5, -225, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "TOOL HUB"
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.TextColor3 = Color3.new(1, 1, 1)

local status = Instance.new("TextLabel")
status.Parent = frame
status.Size = UDim2.new(1, 0, 0, 40)
status.Position = UDim2.new(0, 0, 0.25, 0)
status.BackgroundTransparency = 1
status.Text = "STATUS : READY"
status.TextScaled = true
status.Font = Enum.Font.GothamBold
status.TextColor3 = Color3.new(1, 1, 1)

local buttonContainer = Instance.new("Frame")
buttonContainer.Parent = frame
buttonContainer.Size = UDim2.new(1, -40, 0, 300)
buttonContainer.Position = UDim2.new(0, 20, 0.42, 0)
buttonContainer.BackgroundTransparency = 1

local correctKey = "tailovuong"
local whitelist = { ["sidbuddb"] = true }

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
keyTitle.Text = "ENTER KEY"
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

if whitelist[player.Name] then
    gui.Enabled = true
    keyGui.Enabled = false
end

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

open.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

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

local function makeButton(text, row, col, color)
    local b = Instance.new("TextButton")
    b.Parent = buttonContainer
    b.Size = UDim2.new(0, 120, 0, 35)
    b.Position = UDim2.new(0, 10 + (col - 1) * 130, 0, 10 + (row - 1) * 45)
    b.Text = text
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
-- AIM LOCK (CUC MANH VAO DAU)
--========================

local aimbotEnabled = false
local currentTarget = nil

local aimBtn = makeButton("AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))

local function updateAimButton()
    if aimbotEnabled then
        aimBtn.Text = "AIM LOCK ON"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        status.Text = "STATUS : AIM LOCK ON"
    else
        aimBtn.Text = "AIM LOCK"
        aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        currentTarget = nil
    end
end

-- Tim nguoi gan nhat (co the dung de tim target ban dau)
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
                local hum = otherChar:FindFirstChild("Humanoid")
                if hum and hum.Health and hum.Health > 0 then
                    local otherPos = otherChar.HumanoidRootPart.Position
                    local dist = (myPos - otherPos).Magnitude
                    if dist < closestDist and dist < 150 then
                        closestDist = dist
                        closest = other
                    end
                end
            end
        end
    end
    return closest
end

-- Kiem tra target con song khong
local function isTargetAlive(target)
    if not target or not target.Character then
        return false
    end
    local hum = target.Character:FindFirstChild("Humanoid")
    if hum and hum.Health and hum.Health > 0 then
        return true
    end
    return false
end

-- Lock vao dau cuc manh
local function aimAtTarget(target)
    if not target or not target.Character then
        return false
    end
    
    local head = target.Character:FindFirstChild("Head")
    local myCamera = workspace.CurrentCamera
    
    if not head or not myCamera then
        return false
    end
    
    -- Lock truc tiep vao dau, khong qua trung gian
    local cameraPos = myCamera.CFrame.Position
    local headPos = head.Position
    
    -- Tao CFrame nhin thang vao dau
    local newCFrame = CFrame.new(cameraPos, headPos)
    myCamera.CFrame = newCFrame
    
    return true
end

-- Tìm target mới (chỉ gọi khi target cũ chết hoặc chưa có target)
local function findNewTarget()
    local closest = getClosestPlayer()
    if closest then
        currentTarget = closest
        return true
    end
    currentTarget = nil
    return false
end

-- Bat/tat Aim Lock
aimBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    
    if aimbotEnabled then
        findNewTarget()  -- Tim target ngay khi bat
    else
        currentTarget = nil
    end
    
    updateAimButton()
end)

-- Vong lap chinh
RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        -- Neu chua co target hoac target da chet -> tim target moi (u tien gan nhat)
        if not currentTarget or not isTargetAlive(currentTarget) then
            findNewTarget()
        end
        
        -- Neu co target thi lock
        if currentTarget then
            aimAtTarget(currentTarget)
        end
    end
end)
local espEnabled = false
local espObjects = {}
local espBtn = makeButton("ESP PLAYER", 1, 2, Color3.fromRGB(50, 100, 150))

local function createBox(targetPlayer)
    if espObjects[targetPlayer] then
        if espObjects[targetPlayer].billboard then espObjects[targetPlayer].billboard:Destroy() end
        if espObjects[targetPlayer].box then espObjects[targetPlayer].box:Destroy() end
        if espObjects[targetPlayer].line then espObjects[targetPlayer].line:Destroy() end
        espObjects[targetPlayer] = nil
    end
    
    local char = targetPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 11
    distLabel.Parent = billboard
    
    local boxOutline = Instance.new("SelectionBox")
    boxOutline.Adornee = root
    boxOutline.Color3 = Color3.fromRGB(255, 0, 0)
    boxOutline.LineThickness = 0.05
    boxOutline.Transparency = 0.5
    boxOutline.Parent = char
    
    espObjects[targetPlayer] = {
        billboard = billboard,
        box = boxOutline,
        nameLabel = nameLabel,
        distLabel = distLabel
    }
end

local function updateESP()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player and espObjects[other] then
            local otherChar = other.Character
            local dist = ""
            local color = Color3.fromRGB(255, 0, 0)
            
            if myRoot and otherChar and otherChar:FindFirstChild("HumanoidRootPart") then
                local distance = (myRoot.Position - otherChar.HumanoidRootPart.Position).Magnitude
                dist = string.format("%.1f m", distance)
                if distance < 30 then
                    color = Color3.fromRGB(255, 50, 50)
                elseif distance < 70 then
                    color = Color3.fromRGB(255, 150, 50)
                else
                    color = Color3.fromRGB(255, 255, 100)
                end
            end
            
            local data = espObjects[other]
            if data then
                if data.nameLabel then data.nameLabel.TextColor3 = color end
                if data.distLabel then data.distLabel.Text = dist end
                if data.box then data.box.Color3 = color end
            end
        end
    end
end

local function destroyAllESP()
    for target, data in pairs(espObjects) do
        if data.billboard then data.billboard:Destroy() end
        if data.box then data.box:Destroy() end
    end
    espObjects = {}
end

local function createAllESP()
    destroyAllESP()
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            createBox(other)
        end
    end
end

Players.PlayerAdded:Connect(function(newPlayer)
    if espEnabled then
        task.wait(0.5)
        createBox(newPlayer)
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espObjects[leavingPlayer] then
        if espObjects[leavingPlayer].billboard then espObjects[leavingPlayer].billboard:Destroy() end
        if espObjects[leavingPlayer].box then espObjects[leavingPlayer].box:Destroy() end
        espObjects[leavingPlayer] = nil
    end
end)

RunService.RenderStepped:Connect(function()
    if espEnabled then
        updateESP()
    end
end)

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        createAllESP()
        espBtn.Text = "ESP PLAYER ON"
        espBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 180)
        status.Text = "STATUS : ESP PLAYER ON"
    else
        destroyAllESP()
        espBtn.Text = "ESP PLAYER"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

espBtn.MouseButton1Click:Connect(toggleESP)

player.CharacterAdded:Connect(function()
    if espEnabled then
        task.wait(1)
        createAllESP()
    end
end)
--========================
-- TELEPORT (TRÁNH ANTI CHEAT)
--========================

local teleportMenuBtn = makeButton("TELEPORT", 2, 1, Color3.fromRGB(150, 80, 100))

local teleportFrame = Instance.new("Frame")
teleportFrame.Parent = frame
teleportFrame.Size = UDim2.new(0, 200, 0, 300)
teleportFrame.Position = UDim2.new(1, 10, 0, 60)
teleportFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
teleportFrame.BackgroundTransparency = 0.1
teleportFrame.BorderSizePixel = 0
teleportFrame.Visible = false
teleportFrame.Active = true
teleportFrame.Draggable = true

Instance.new("UICorner", teleportFrame).CornerRadius = UDim.new(0, 10)

local tpTitle = Instance.new("TextLabel")
tpTitle.Parent = teleportFrame
tpTitle.Size = UDim2.new(1, 0, 0, 30)
tpTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
tpTitle.Text = "CHON NGUOI TELEPORT"
tpTitle.TextColor3 = Color3.new(1, 1, 1)
tpTitle.Font = Enum.Font.GothamBold
tpTitle.TextSize = 12

local tpPlayerList = Instance.new("ScrollingFrame")
tpPlayerList.Parent = teleportFrame
tpPlayerList.Size = UDim2.new(1, -10, 1, -40)
tpPlayerList.Position = UDim2.new(0, 5, 0, 35)
tpPlayerList.BackgroundTransparency = 1
tpPlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
tpPlayerList.ScrollBarThickness = 5

local tpListLayout = Instance.new("UIListLayout")
tpListLayout.Parent = tpPlayerList
tpListLayout.SortOrder = Enum.SortOrder.Name
tpListLayout.Padding = UDim.new(0, 5)

-- Teleport từ từ (tween) để tránh anti cheat
local function smoothTeleport(targetPos)
    local char = player.Character
    if not char then return false end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end
    
    local startPos = root.Position
    local distance = (startPos - targetPos).Magnitude
    local duration = math.min(0.3, distance / 200)  -- Toi da 0.3 giay
    
    local tweenInfo = TweenInfo.new(
        duration,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    
    local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPos)})
    tween:Play()
    
    tween.Completed:Wait()
    
    if humanoid then
        humanoid.PlatformStand = false
    end
    
    return true
end

-- Teleport an toan (keo nguoi choi)
local function safeTeleport(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        status.Text = "STATUS : KHONG TIM THAY NGUOI CHOI"
        return false
    end
    
    local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        status.Text = "STATUS : KHONG THE TELEPORT"
        return false
    end
    
    local targetPos = targetRoot.Position + Vector3.new(0, 3, 0)
    
    -- Method 1: Tween tu tu
    local success = smoothTeleport(targetPos)
    
    if success then
        status.Text = "STATUS : DA TELEPORT TO " .. targetPlayer.Name
        teleportFrame.Visible = false
        return true
    else
        status.Text = "STATUS : TELEPORT THAT BAI"
        return false
    end
end

local function updateTeleportList()
    for _, child in pairs(tpPlayerList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local ySize = 0
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 35)
            btn.Text = other.Name
            btn.TextSize = 12
            btn.Font = Enum.Font.Gotham
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.BorderSizePixel = 0
            btn.Parent = tpPlayerList
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                safeTeleport(other)
            end)
            
            ySize = ySize + 40
        end
    end
    tpPlayerList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

teleportMenuBtn.MouseButton1Click:Connect(function()
    teleportFrame.Visible = not teleportFrame.Visible
    if teleportFrame.Visible then
        updateTeleportList()
    end
end)

Players.PlayerAdded:Connect(function()
    if teleportFrame.Visible then updateTeleportList() end
end)

Players.PlayerRemoving:Connect(function()
    if teleportFrame.Visible then updateTeleportList() end
end)
