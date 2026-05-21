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
--========================
-- ESP PLAYER (CHUYEN NGHIEP, KHONG ICON)
--========================

local espEnabled = false
local espObjects = {}

local espBtn = makeButton("ESP PLAYER", 1, 2, Color3.fromRGB(50, 100, 150))

local function getHealthColor(health, maxHealth)
    local percent = health / maxHealth
    if percent > 0.7 then
        return Color3.fromRGB(0, 255, 0)
    elseif percent > 0.3 then
        return Color3.fromRGB(255, 255, 0)
    else
        return Color3.fromRGB(255, 0, 0)
    end
end

local function createESP(targetPlayer)
    if espObjects[targetPlayer] then
        destroyESP(targetPlayer)
    end
    
    local char = targetPlayer.Character
    if not char then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChild("Humanoid")
    
    if not root or not head or not hum then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_Billboard"
    billboard.Size = UDim2.new(0, 180, 0, 55)
    billboard.StudsOffset = Vector3.new(0, 2.8, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = targetPlayer.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    local healthBarBg = Instance.new("Frame")
    healthBarBg.Size = UDim2.new(0.9, 0, 0, 6)
    healthBarBg.Position = UDim2.new(0.05, 0, 0.4, 0)
    healthBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBarBg.BorderSizePixel = 0
    healthBarBg.Parent = billboard
    
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = healthBarBg
    
    local healthText = Instance.new("TextLabel")
    healthText.Size = UDim2.new(1, 0, 0, 15)
    healthText.Position = UDim2.new(0, 0, 0.55, 0)
    healthText.BackgroundTransparency = 1
    healthText.Text = ""
    healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
    healthText.Font = Enum.Font.Gotham
    healthText.TextSize = 11
    healthText.Parent = billboard
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0, 15)
    distLabel.Position = UDim2.new(0, 0, 0.75, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 10
    distLabel.Parent = billboard
    
    local boxOutline = Instance.new("SelectionBox")
    boxOutline.Adornee = root
    boxOutline.Color3 = Color3.fromRGB(255, 0, 0)
    boxOutline.LineThickness = 0.08
    boxOutline.Transparency = 0.4
    boxOutline.Parent = char
    
    local line = Instance.new("SelectionPartLasso")
    line.Name = "ESP_Line"
    line.Humanoid = hum
    line.Part = root
    line.Color3 = Color3.fromRGB(255, 255, 255)
    line.Transparency = 0.3
    line.Visible = true
    line.Parent = char
    
    espObjects[targetPlayer] = {
        billboard = billboard,
        box = boxOutline,
        line = line,
        nameLabel = nameLabel,
        healthBar = healthBar,
        healthText = healthText,
        distLabel = distLabel,
        humanoid = hum,
        root = root
    }
    
    return true
end

local function updateESP()
    local myChar = player.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    for other, data in pairs(espObjects) do
        if other and data and data.humanoid and data.root then
            local health = data.humanoid.Health
            local maxHealth = data.humanoid.MaxHealth
            local healthPercent = health / maxHealth
            
            if data.healthBar then
                data.healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
                data.healthBar.BackgroundColor3 = getHealthColor(health, maxHealth)
            end
            
            if data.healthText then
                data.healthText.Text = string.format("%.0f / %.0f", health, maxHealth)
                data.healthText.TextColor3 = getHealthColor(health, maxHealth)
            end
            
            if myRoot and data.root then
                local dist = (myRoot.Position - data.root.Position).Magnitude
                if data.distLabel then
                    data.distLabel.Text = string.format("%.1f m", dist)
                end
                
                local isVisible = dist <= 200
                if data.billboard then data.billboard.Enabled = isVisible end
                if data.box then data.box.Visible = isVisible end
                if data.line then data.line.Visible = isVisible end
                
                if data.box then
                    if dist < 50 then
                        data.box.Color3 = Color3.fromRGB(255, 50, 50)
                    elseif dist < 100 then
                        data.box.Color3 = Color3.fromRGB(255, 200, 50)
                    else
                        data.box.Color3 = Color3.fromRGB(255, 255, 255)
                    end
                end
                
                if data.line then
                    if dist < 50 then
                        data.line.Color3 = Color3.fromRGB(255, 50, 50)
                    elseif dist < 100 then
                        data.line.Color3 = Color3.fromRGB(255, 200, 50)
                    else
                        data.line.Color3 = Color3.fromRGB(255, 255, 255)
                    end
                end
            end
        else
            destroyESP(other)
        end
    end
end

local function destroyESP(target)
    local data = espObjects[target]
    if data then
        if data.billboard then data.billboard:Destroy() end
        if data.box then data.box:Destroy() end
        if data.line then data.line:Destroy() end
        espObjects[target] = nil
    end
end

local function destroyAllESP()
    for target, _ in pairs(espObjects) do
        destroyESP(target)
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

Players.PlayerAdded:Connect(function(newPlayer)
    if espEnabled then
        task.wait(0.5)
        createESP(newPlayer)
    end
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if espObjects[leavingPlayer] then
        destroyESP(leavingPlayer)
    end
end)

local function onCharacterAdded(targetPlayer)
    if espEnabled and targetPlayer ~= player then
        task.wait(0.5)
        if targetPlayer.Character then
            createESP(targetPlayer)
        end
    end
end

for _, other in pairs(Players:GetPlayers()) do
    if other ~= player then
        other.CharacterAdded:Connect(function()
            onCharacterAdded(other)
        end)
    end
end

RunService.RenderStepped:Connect(function()
    if espEnabled then
        updateESP()
    end
end)

player.CharacterAdded:Connect(function()
    if espEnabled then
        task.wait(1)
        createAllESP()
    end
end)

espBtn.MouseButton1Click:Connect(toggleESP)

-- XEM NGUOI CHOI (GOC NHIN THU 3)
--========================

local spectateEnabled = false
local currentSpectateTarget = nil
local originalCamera = nil

local spectateBtn = makeButton("POV PLAYER", 2, 1, Color3.fromRGB(80, 150, 200))

local spectateFrame = Instance.new("Frame")
spectateFrame.Parent = frame
spectateFrame.Size = UDim2.new(0, 200, 0, 300)
spectateFrame.Position = UDim2.new(1, 10, 0, 60)
spectateFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
spectateFrame.BackgroundTransparency = 0.1
spectateFrame.BorderSizePixel = 0
spectateFrame.Visible = false
spectateFrame.Active = true
spectateFrame.Draggable = true

Instance.new("UICorner", spectateFrame).CornerRadius = UDim.new(0, 10)

local specTitle = Instance.new("TextLabel")
specTitle.Parent = spectateFrame
specTitle.Size = UDim2.new(1, 0, 0, 30)
specTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
specTitle.Text = "CHON NGUOI XEM"
specTitle.TextColor3 = Color3.new(1, 1, 1)
specTitle.Font = Enum.Font.GothamBold
specTitle.TextSize = 12

local specPlayerList = Instance.new("ScrollingFrame")
specPlayerList.Parent = spectateFrame
specPlayerList.Size = UDim2.new(1, -10, 1, -40)
specPlayerList.Position = UDim2.new(0, 5, 0, 35)
specPlayerList.BackgroundTransparency = 1
specPlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
specPlayerList.ScrollBarThickness = 5

local specListLayout = Instance.new("UIListLayout")
specListLayout.Parent = specPlayerList
specListLayout.SortOrder = Enum.SortOrder.Name
specListLayout.Padding = UDim.new(0, 5)

-- Luu camera goc
local function saveOriginalCamera()
    originalCamera = workspace.CurrentCamera.CFrame
end

-- Quay ve camera cua minh
local function returnToOwnCamera()
    if not originalCamera then return end
    local myChar = player.Character
    if myChar and myChar:FindFirstChild("Humanoid") then
        workspace.CurrentCamera.CameraSubject = myChar.Humanoid
    end
    workspace.CurrentCamera.CFrame = originalCamera
end

-- Xem nguoi khac (goc thu 3)
local function spectatePlayer(targetPlayer)
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
    
    if not spectateEnabled then
        saveOriginalCamera()
    end
    
    -- Gan camera vao nguoi do (goc thu 3)
    workspace.CurrentCamera.CameraSubject = targetHumanoid
    
    -- Dat camera o vi tri xa de nhin thay toan than
    local offset = Vector3.new(5, 3, 8)  -- X: trai/phai, Y: cao/thap, Z: xa/gan
    local targetPos = targetRoot.Position
    workspace.CurrentCamera.CFrame = CFrame.new(targetPos + offset, targetPos)
    
    currentSpectateTarget = targetPlayer
    spectateEnabled = true
    spectateBtn.Text = "POV PLAYER [ON]"
    spectateBtn.BackgroundColor3 = Color3.fromRGB(100, 170, 220)
    status.Text = "STATUS : DANG XEM " .. targetPlayer.Name
    spectateFrame.Visible = false
    
    return true
end

-- Dung xem
local function stopSpectate()
    if spectateEnabled then
        returnToOwnCamera()
        spectateEnabled = false
        currentSpectateTarget = nil
        spectateBtn.Text = "POV PLAYER"
        spectateBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
    end
end

-- Cap nhat camera khi dang xem
RunService.RenderStepped:Connect(function()
    if spectateEnabled and currentSpectateTarget then
        local targetChar = currentSpectateTarget.Character
        if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
            local targetRoot = targetChar.HumanoidRootPart
            local targetHumanoid = targetChar:FindFirstChild("Humanoid")
            
            if targetHumanoid and targetHumanoid.Health > 0 then
                workspace.CurrentCamera.CameraSubject = targetHumanoid
                local offset = Vector3.new(5, 3, 8)
                local targetPos = targetRoot.Position
                workspace.CurrentCamera.CFrame = CFrame.new(targetPos + offset, targetPos)
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

-- Tao danh sach nguoi choi
local function updateSpectateList()
    for _, child in pairs(specPlayerList:GetChildren()) do
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
            btn.Parent = specPlayerList
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseButton1Click:Connect(function()
                spectatePlayer(other)
            end)
            
            ySize = ySize + 40
        end
    end
    specPlayerList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

-- Nut mo menu
spectateBtn.MouseButton1Click:Connect(function()
    if spectateEnabled then
        stopSpectate()
    else
        spectateFrame.Visible = not spectateFrame.Visible
        if spectateFrame.Visible then
            updateSpectateList()
        end
    end
end)

Players.PlayerAdded:Connect(function()
    if spectateFrame.Visible then updateSpectateList() end
end)

Players.PlayerRemoving:Connect(function()
    if spectateFrame.Visible then updateSpectateList() end
end)

player.CharacterAdded:Connect(function()
    if spectateEnabled then
        stopSpectate()
    end
end)
--========================
-- INFINITE JUMP (NHẢY VÔ HẠN)
--========================

local infiniteJumpEnabled = false
local jumpBtn = makeButton("INFINITE JUMP", 2, 2, Color3.fromRGB(100, 150, 100))

local function onJumpRequest()
    if not infiniteJumpEnabled then return end
    
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Kiem tra dang o tren khong
    if hum.FloorMaterial == Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Bat/tat Infinite Jump
local function toggleInfiniteJump()
    infiniteJumpEnabled = not infiniteJumpEnabled
    
    if infiniteJumpEnabled then
        jumpBtn.Text = "INFINITE JUMP [ON]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(130, 180, 130)
        status.Text = "STATUS : INFINITE JUMP ON"
        
        -- Ket noi su kien nhay
        if not jumpConnection then
            jumpConnection = game:GetService("UserInputService").JumpRequest:Connect(onJumpRequest)
        end
    else
        jumpBtn.Text = "INFINITE JUMP"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        
        -- Ngat ket noi
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end

jumpBtn.MouseButton1Click:Connect(toggleInfiniteJump)

-- Reset khi nhan vat respawn
player.CharacterAdded:Connect(function()
    if infiniteJumpEnabled then
        task.wait(0.5)
        -- Dam bao van tiep tuc hoat dong
    end
end)
--========================
-- GODMODE THAT (CHAN SAT THUONG TU GOC)
--========================

local godModeEnabled = false

local godBtn = makeButton("GODMODE", 4, 1, Color3.fromRGB(200, 100, 50))

-- Luu cac ket noi
local connections = {}

local function clearConnections()
    for _, conn in pairs(connections) do
        pcall(function() conn:Disconnect() end)
    end
    connections = {}
end

-- CACH 1: Chan ham gay sat thuong trong Humanoid
local function hookHumanoid()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Ghi de ham TakeDamage (quan trong nhat)
    if hum.TakeDamage then
        local oldTakeDamage = hum.TakeDamage
        hum.TakeDamage = function(self, amount)
            if godModeEnabled then
                return  -- Khong nhan sat thuong
            end
            return oldTakeDamage(self, amount)
        end
    end
    
    -- Ghi de ham BreakJoints
    local oldBreakJoints = hum.BreakJoints
    hum.BreakJoints = function(self)
        if godModeEnabled then
            return
        end
        return oldBreakJoints(self)
    end
end

-- CACH 2: Chan remote event (server gui sat thuong)
local function hookRemotes()
    local rs = game:GetService("ReplicatedStorage")
    
    local function blockRemote(remote)
        if remote:IsA("RemoteEvent") then
            local oldFire = remote.FireServer
            remote.FireServer = function(_, ...)
                local args = {...}
                -- Kiem tra xem co phai lenh gay sat thuong khong
                local isDamage = false
                for _, arg in pairs(args) do
                    if type(arg) == "number" and arg > 0 and arg < 1000 then
                        if tostring(arg):find("damage") or tostring(arg):find("health") then
                            isDamage = true
                        end
                    end
                end
                if godModeEnabled and isDamage then
                    return  -- Chan khong gui di
                end
                return oldFire(remote, ...)
            end
        end
    end
    
    for _, remote in pairs(rs:GetDescendants()) do
        blockRemote(remote)
    end
    
    rs.DescendantAdded:Connect(blockRemote)
end

-- CACH 3: Chan tag (game dung tag de gay sat thuong)
local function hookTags()
    local char = player.Character
    if not char then return end
    
    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BasePart") then
            -- Xoa cac tag gay sat thuong
            local tags = {"Damage", "Hit", "Attack", "Kill", "Death"}
            for _, tag in pairs(tags) do
                local attr = obj:GetAttribute(tag)
                if attr then
                    obj:SetAttribute(tag, nil)
                end
            end
        end
    end
end

-- CACH 4: Chan Player.Character (tranh bi thay the bang xac chet)
local function blockCharacterReplace()
    local oldCharacter = player.Character
    
    local conn = player:GetPropertyChangedSignal("Character"):Connect(function()
        if godModeEnabled then
            local newChar = player.Character
            if newChar and newChar ~= oldCharacter then
                -- Kiem tra xem co phai chet khong
                local hum = newChar:FindFirstChild("Humanoid")
                if hum and hum.Health <= 0 then
                    -- Quay lai nhan vat cu
                    player.Character = oldCharacter
                else
                    oldCharacter = newChar
                end
            end
        end
    end)
    table.insert(connections, conn)
end

-- CACH 5: Chan Explosion (no)
local function blockExplosion()
    local conn = workspace.DescendantAdded:Connect(function(obj)
        if godModeEnabled and obj:IsA("Explosion") then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local root = char.HumanoidRootPart
                local dist = (root.Position - obj.Position).Magnitude
                if dist < obj.BlastRadius then
                    obj.BlastRadius = 0
                    obj.BlastPressure = 0
                end
            end
        end
    end)
    table.insert(connections, conn)
end

-- CACH 6: Chan moi truong (lava, void, kill brick)
local function blockEnvironment()
    local conn = RunService.RenderStepped:Connect(function()
        if not godModeEnabled then return end
        
        local char = player.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        -- Chan roi vuc
        if root.Position.Y < -10 then
            root.CFrame = CFrame.new(root.Position.X, 50, root.Position.Z)
        end
        
        -- Chan lava, kill brick
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                local name = part.Name:lower()
                if name:find("lava") or name:find("acid") or name:find("kill") or name:find("death") or name:find("void") then
                    local dist = (root.Position - part.Position).Magnitude
                    if dist < 10 then
                        local dir = (root.Position - part.Position).Unit
                        root.CFrame = root.CFrame + dir * 15
                    end
                end
            end
        end
    end)
    table.insert(connections, conn)
end

-- CACH 7: Chan tool ban sung
local function blockTools()
    local char = player.Character
    if not char then return end
    
    local conn = char.DescendantAdded:Connect(function(obj)
        if godModeEnabled and obj:IsA("Tool") then
            -- Chan cac tool gay sat thuong
            local dangerousTools = {"Gun", "Weapon", "Sword", "Knife", "Bow", "Rocket"}
            for _, toolName in pairs(dangerousTools) do
                if obj.Name:find(toolName) then
                    obj.Parent = nil
                end
            end
        end
    end)
    table.insert(connections, conn)
end

-- CACH 8: Chan BodyVelocity, BodyForce (bi hut, day)
local function blockForces()
    local char = player.Character
    if not char then return end
    
    local conn = char.DescendantAdded:Connect(function(obj)
        if godModeEnabled then
            local forceTypes = {"BodyVelocity", "BodyForce", "BodyAngularVelocity", "BodyThrust", "BodyPosition"}
            for _, ft in pairs(forceTypes) do
                if obj:IsA(ft) then
                    obj:Destroy()
                end
            end
        end
    end)
    table.insert(connections, conn)
end

-- CHAY TAT CA CAC CHE DO
local function enableGodMode()
    clearConnections()
    
    hookHumanoid()
    hookRemotes()
    hookTags()
    blockCharacterReplace()
    blockExplosion()
    blockEnvironment()
    blockTools()
    blockForces()
    
    -- Chay lap de duy tri trang thai
    local maintainConn = RunService.RenderStepped:Connect(function()
        if godModeEnabled then
            local char = player.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                end
            end
        end
    end)
    table.insert(connections, maintainConn)
    
    
end

-- BAT/TAT
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        godBtn.Text = "GODMODE [ON]"
        godBtn.BackgroundColor3 = Color3.fromRGB(220, 120, 70)
        status.Text = "STATUS : GODMODE ON"
        enableGodMode()
    else
        godBtn.Text = "GODMODE"
        godBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        clearConnections()
    end
end

godBtn.MouseButton1Click:Connect(toggleGodMode)

player.CharacterAdded:Connect(function()
    if godModeEnabled then
        task.wait(0.5)
        enableGodMode()
    end
end)
