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
-- AIM LOCK
--========================

local aimbotEnabled = false
local currentClosestTarget = nil
local maxAimDistance = 250

local aimBtn = makeButton("AIM LOCK", 1, 1, Color3.fromRGB(80, 50, 120))

local function getAimPosition(character)
    if not character then return nil end
    local head = character:FindFirstChild("Head")
    if head then return head.Position end
    local root = character:FindFirstChild("HumanoidRootPart")
    if root then return root.Position end
    return nil
end

local function isValidTarget(targetPlayer)
    if not targetPlayer or targetPlayer == player then return false end
    local character = targetPlayer.Character
    if not character then return false end
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    return getAimPosition(character) ~= nil
end

local function findClosestPlayer()
    local playerChar = player.Character
    if not playerChar then return nil end
    local playerRoot = playerChar:FindFirstChild("HumanoidRootPart")
    if not playerRoot then return nil end
    local myPos = playerRoot.Position
    local closest = nil
    local closestDist = maxAimDistance + 1
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player and isValidTarget(other) then
            local otherRoot = other.Character:FindFirstChild("HumanoidRootPart")
            if otherRoot then
                local dist = (myPos - otherRoot.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closest = other
                end
            end
        end
    end
    return closest
end

local function lockCamera(target)
    if not target then return end
    local aimPos = getAimPosition(target.Character)
    if not aimPos then return end
    local camera = workspace.CurrentCamera
    if camera then
        camera.CFrame = CFrame.new(camera.CFrame.Position, aimPos)
    end
end

local aimLoop = nil

local function toggleAimLock()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        if aimLoop then aimLoop:Disconnect() end
        aimLoop = RunService.RenderStepped:Connect(function()
            if aimbotEnabled then
                local target = findClosestPlayer()
                if target then
                    currentClosestTarget = target
                    lockCamera(target)
                end
            end
        end)
        aimBtn.Text = "AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(100, 70, 150)
        status.Text = "STATUS : AIM LOCK ON"
    else
        if aimLoop then aimLoop:Disconnect() aimLoop = nil end
        aimBtn.Text = "AIM LOCK"
        aimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

aimBtn.MouseButton1Click:Connect(toggleAimLock)

--========================
-- ESP PLAYER
--========================

local espEnabled = false
local espObjects = {}

local espBtn = makeButton("ESP PLAYER", 1, 2, Color3.fromRGB(50, 100, 150))

local function createESP(targetPlayer)
    if espObjects[targetPlayer] then
        if espObjects[targetPlayer].billboard then espObjects[targetPlayer].billboard:Destroy() end
        if espObjects[targetPlayer].box then espObjects[targetPlayer].box:Destroy() end
        espObjects[targetPlayer] = nil
    end
    
    local char = targetPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not head or not root or not hum or hum.Health <= 0 then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 180, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    local healthText = Instance.new("TextLabel")
    healthText.Size = UDim2.new(1, 0, 0, 16)
    healthText.Position = UDim2.new(0, 0, 0.35, 0)
    healthText.BackgroundTransparency = 1
    healthText.Text = ""
    healthText.Font = Enum.Font.Gotham
    healthText.TextSize = 11
    healthText.Parent = billboard
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0, 14)
    distLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 10
    distLabel.Parent = billboard
    
    local box = Instance.new("SelectionBox")
    box.Adornee = root
    box.Color3 = Color3.fromRGB(255, 0, 0)
    box.LineThickness = 0.08
    box.Transparency = 0.4
    box.Parent = char
    
    espObjects[targetPlayer] = {
        billboard = billboard,
        box = box,
        healthText = healthText,
        distLabel = distLabel,
        humanoid = hum,
        root = root
    }
end

local function destroyAllESP()
    for _, data in pairs(espObjects) do
        if data.billboard then data.billboard:Destroy() end
        if data.box then data.box:Destroy() end
    end
    espObjects = {}
end

local function createAllESP()
    destroyAllESP()
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            createESP(other)
        end
    end
end

local function updateESP()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for other, data in pairs(espObjects) do
        if other and data and data.humanoid and data.root then
            local health = data.humanoid.Health
            local maxHealth = data.humanoid.MaxHealth
            local healthPercent = health / maxHealth
            local color = Color3.fromRGB(0, 255, 0)
            if healthPercent < 0.3 then color = Color3.fromRGB(255, 0, 0)
            elseif healthPercent < 0.7 then color = Color3.fromRGB(255, 255, 0) end
            
            if data.healthText then
                data.healthText.Text = string.format("%.0f / %.0f", health, maxHealth)
                data.healthText.TextColor3 = color
            end
            
            if myRoot then
                local dist = (myRoot.Position - data.root.Position).Magnitude
                if data.distLabel then
                    data.distLabel.Text = string.format("%.1f m", dist)
                end
                if data.box then
                    if dist < 50 then data.box.Color3 = Color3.fromRGB(255, 50, 50)
                    elseif dist < 100 then data.box.Color3 = Color3.fromRGB(255, 150, 50)
                    else data.box.Color3 = Color3.fromRGB(255, 255, 100) end
                end
                local visible = dist <= 250
                if data.billboard then data.billboard.Enabled = visible end
                if data.box then data.box.Visible = visible end
            end
        else
            if data and data.billboard then data.billboard:Destroy() end
            if data and data.box then data.box:Destroy() end
            espObjects[other] = nil
        end
    end
end

local function toggleESP()
    espEnabled = not espEnabled
    if espEnabled then
        createAllESP()
        espBtn.Text = "ESP PLAYER [ON]"
        espBtn.BackgroundColor3 = Color3.fromRGB(80, 130, 180)
        status.Text = "STATUS : ESP PLAYER ON"
        if not espLoop then
            espLoop = RunService.RenderStepped:Connect(function()
                if espEnabled then updateESP() end
            end)
        end
    else
        destroyAllESP()
        espBtn.Text = "ESP PLAYER"
        espBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        if espLoop then espLoop:Disconnect() espLoop = nil end
    end
end

espBtn.MouseButton1Click:Connect(toggleESP)

Players.PlayerAdded:Connect(function(newPlayer)
    if espEnabled then task.wait(0.5) createESP(newPlayer) end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espObjects[leavingPlayer] then
        if espObjects[leavingPlayer].billboard then espObjects[leavingPlayer].billboard:Destroy() end
        if espObjects[leavingPlayer].box then espObjects[leavingPlayer].box:Destroy() end
        espObjects[leavingPlayer] = nil
    end
end)

player.CharacterAdded:Connect(function()
    if espEnabled then task.wait(1) createAllESP() end
end)

local espLoop = nil

--========================
-- POV PLAYER
--========================

local povEnabled = false
local povTarget = nil
local originalCamera = nil

local povBtn = makeButton("POV PLAYER", 2, 1, Color3.fromRGB(80, 150, 200))

local povFrame = Instance.new("Frame")
povFrame.Parent = frame
povFrame.Size = UDim2.new(0, 200, 0, 300)
povFrame.Position = UDim2.new(1, 10, 0, 60)
povFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
povFrame.BackgroundTransparency = 0.1
povFrame.BorderSizePixel = 0
povFrame.Visible = false
povFrame.Active = true
povFrame.Draggable = true

Instance.new("UICorner", povFrame).CornerRadius = UDim.new(0, 10)

local povTitle = Instance.new("TextLabel")
povTitle.Parent = povFrame
povTitle.Size = UDim2.new(1, 0, 0, 30)
povTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
povTitle.Text = "CHON NGUOI XEM"
povTitle.TextColor3 = Color3.new(1, 1, 1)
povTitle.Font = Enum.Font.GothamBold
povTitle.TextSize = 12

local povList = Instance.new("ScrollingFrame")
povList.Parent = povFrame
povList.Size = UDim2.new(1, -10, 1, -40)
povList.Position = UDim2.new(0, 5, 0, 35)
povList.BackgroundTransparency = 1
povList.CanvasSize = UDim2.new(0, 0, 0, 0)
povList.ScrollBarThickness = 5

local povLayout = Instance.new("UIListLayout")
povLayout.Parent = povList
povLayout.SortOrder = Enum.SortOrder.Name
povLayout.Padding = UDim.new(0, 5)

local function saveOriginalCamera()
    originalCamera = workspace.CurrentCamera.CFrame
end

local function returnToOwnCamera()
    if not originalCamera then return end
    local myChar = player.Character
    if myChar and myChar:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = myChar.Humanoid
    end
    workspace.CurrentCamera.CFrame = originalCamera
end

local function spectateThirdPerson(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        status.Text = "STATUS : KHONG TIM THAY NGUOI CHOI"
        return false
    end
    
    local targetChar = targetPlayer.Character
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    local targetHumanoid = targetChar:FindFirstChild("Humanoid")
    
    if not targetRoot or not targetHumanoid then
        status.Text = "STATUS : KHONG THE XEM"
        return false
    end
    
    if not povEnabled then
        saveOriginalCamera()
    end
    
    workspace.CurrentCamera.CameraSubject = targetHumanoid
    local offset = Vector3.new(5, 3, 8)
    workspace.CurrentCamera.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
    
    povTarget = targetPlayer
    povEnabled = true
    povBtn.Text = "POV PLAYER [ON]"
    povBtn.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    status.Text = "STATUS : DANG XEM " .. targetPlayer.Name
    povFrame.Visible = false
    
    return true
end

local function stopSpectate()
    if povEnabled then
        returnToOwnCamera()
        povEnabled = false
        povTarget = nil
        povBtn.Text = "POV PLAYER"
        povBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

RunService.RenderStepped:Connect(function()
    if povEnabled and povTarget then
        local targetChar = povTarget.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            local targetRoot = targetChar.HumanoidRootPart
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            if targetHumanoid and targetHumanoid.Health > 0 then
                workspace.CurrentCamera.CameraSubject = targetHumanoid
                local offset = Vector3.new(5, 3, 8)
                workspace.CurrentCamera.CFrame = CFrame.new(targetRoot.Position + offset, targetRoot.Position)
            else
                stopSpectate()
                status.Text = "STATUS : NGUOI CHOI DA CHET"
            end
        else
            stopSpectate()
            status.Text = "STATUS : MAT KET NOI"
        end
    end
end)

local function updatePOVList()
    for _, child in pairs(povList:GetChildren()) do
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
            btn.Parent = povList
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                spectateThirdPerson(other)
            end)
            
            ySize = ySize + 40
        end
    end
    povList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

povBtn.MouseButton1Click:Connect(function()
    if povEnabled then
        stopSpectate()
    else
        povFrame.Visible = not povFrame.Visible
        if povFrame.Visible then
            updatePOVList()
        end
    end
end)

Players.PlayerAdded:Connect(function()
    if povFrame.Visible then updatePOVList() end
end)

Players.PlayerRemoving:Connect(function()
    if povFrame.Visible then updatePOVList() end
end)

player.CharacterAdded:Connect(function()
    if povEnabled then
        stopSpectate()
    end
end)

--========================
-- INFINITE JUMP
--========================

local infiniteJumpEnabled = false
local jumpBtn = makeButton("INFINITE JUMP", 2, 2, Color3.fromRGB(100, 150, 100))

local function onJumpRequest()
    if not infiniteJumpEnabled then return end
    local char = player.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if hum.FloorMaterial == Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

local jumpConnection = nil

local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    
    if infiniteJumpEnabled then
        jumpBtn.Text = "INFINITE JUMP [ON]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(130, 180, 130)
        status.Text = "STATUS : INFINITE JUMP ON"
        if not jumpConnection then
            jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
        end
    else
        jumpBtn.Text = "INFINITE JUMP"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end

jumpBtn.MouseButton1Click:Connect(toggleInfiniteJump)
