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
-- SUPER GODMODE (CHAN MOI SAT THUONG)
--========================

local godModeEnabled = false

local godBtn = makeButton("GODMODE", 4, 1, Color3.fromRGB(200, 100, 50))

-- Luu tat ca ket noi de quan ly
local allConnections = {}
local originalMaxHealth = {}
local remoteHooks = {}

-- Ham xoa tat ca ket noi
local function clearAllConnections()
    for _, conn in pairs(allConnections) do
        if conn then
            pcall(function() conn:Disconnect() end)
        end
    end
    allConnections = {}
end

-- Ham khoi phuc lai nhan vat
local function restoreCharacter()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    if originalMaxHealth[char] then
        hum.MaxHealth = originalMaxHealth[char]
    end
    hum.Health = hum.MaxHealth
    hum:ChangeState(Enum.HumanoidStateType.Running)
end

-- CHAN 1: Chan mat mau (quan trong nhat)
local function blockHealthLoss()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Luu max health goc
    if not originalMaxHealth[char] then
        originalMaxHealth[char] = hum.MaxHealth
    end
    
    -- Set max health that lon
    hum.MaxHealth = 999999999
    hum.Health = 999999999
    
    -- Theo doi su thay doi cua health
    local healthConn = hum:GetPropertyChangedSignal("Health"):Connect(function()
        if godModeEnabled and hum.Health > 0 then
            if hum.Health < 999999999 then
                hum.Health = 999999999
            end
        end
    end)
    table.insert(allConnections, healthConn)
    
    -- Theo doi su thay doi cua max health
    local maxHealthConn = hum:GetPropertyChangedSignal("MaxHealth"):Connect(function()
        if godModeEnabled then
            hum.MaxHealth = 999999999
            hum.Health = 999999999
        end
    end)
    table.insert(allConnections, maxHealthConn)
end

-- CHAN 2: Chan su kien chet (Died)
local function blockDeath()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    local diedConn = hum.Died:Connect(function()
        if godModeEnabled then
            task.wait(0.05)
            hum.Health = 999999999
            hum.MaxHealth = 999999999
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end)
    table.insert(allConnections, diedConn)
end

-- CHAN 3: Chan BreakJoints (chet cung)
local function blockBreakJoints()
    local char = player.Character
    if not char then return end
    
    local breakConn = char.BreakJoints:Connect(function()
        if godModeEnabled then
            task.wait(0.05)
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.Health = 999999999
                hum.MaxHealth = 999999999
            end
        end
    end)
    table.insert(allConnections, breakConn)
end

-- CHAN 4: Chan state change (nga, stun, ragdoll)
local function blockBadStates()
    local char = player.Character
    if not char then return end
    
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    local stateConn = hum.StateChanged:Connect(function(_, newState)
        if godModeEnabled then
            local badStates = {
                Enum.HumanoidStateType.Dead,
                Enum.HumanoidStateType.FallenDown,
                Enum.HumanoidStateType.Ragdoll,
                Enum.HumanoidStateType.Stunned,
                Enum.HumanoidStateType.GettingUp,
                Enum.HumanoidStateType.Physics,
                Enum.HumanoidStateType.Seated
            }
            for _, state in pairs(badStates) do
                if newState == state then
                    hum:ChangeState(Enum.HumanoidStateType.Running)
                    break
                end
            end
        end
    end)
    table.insert(allConnections, stateConn)
end

-- CHAN 5: Chan luc day/keo (BodyVelocity)
local function blockForces()
    local char = player.Character
    if not char then return end
    
    local forceConn = char.DescendantAdded:Connect(function(obj)
        if godModeEnabled then
            local forceTypes = {
                "BodyVelocity", "BodyForce", "BodyAngularVelocity", 
                "BodyThrust", "BodyPosition", "RocketPropulsion"
            }
            for _, forceName in pairs(forceTypes) do
                if obj:IsA(forceName) then
                    obj:Destroy()
                end
            end
        end
    end)
    table.insert(allConnections, forceConn)
end

-- CHAN 6: Chan Explosion (no)
local function blockExplosions()
    local expConn = workspace.DescendantAdded:Connect(function(obj)
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
    table.insert(allConnections, expConn)
end

-- CHAN 7: Chan moi truong doc hai (lava, fire, acid)
local function blockEnvironment()
    local envConn = RunService.RenderStepped:Connect(function()
        if not godModeEnabled then return end
        
        local char = player.Character
        if not char then return end
        
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local hum = char:FindFirstChild("Humanoid")
        if not hum then return end
        
        -- Tim vat the gay sat thuong
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Parent ~= char then
                local name = obj.Name:lower()
                local dangerNames = {"lava", "acid", "fire", "kill", "death", "void", "spike", "trap"}
                local isDanger = false
                for _, dn in pairs(dangerNames) do
                    if name:find(dn) then
                        isDanger = true
                        break
                    end
                end
                
                if isDanger then
                    local dist = (root.Position - obj.Position).Magnitude
                    if dist < 15 then
                        -- Day lui
                        local dir = (root.Position - obj.Position).Unit
                        root.CFrame = root.CFrame + dir * 8
                        hum.Health = 999999999
                    end
                end
            end
        end
        
        -- Chan roi xuong void
        if root.Position.Y < -20 then
            root.CFrame = CFrame.new(root.Position.X, 100, root.Position.Z)
            hum.Health = 999999999
        end
    end)
    table.insert(allConnections, envConn)
end

-- CHAN 8: Chan remote event (server gui sat thuong)
local function blockRemoteDamage()
    local function hookRemote(remote)
        if remote:IsA("RemoteEvent") and not remoteHooks[remote] then
            remoteHooks[remote] = true
            
            local oldFire = remote.FireServer
            remote.FireServer = function(...)
                if not godModeEnabled then
                    return oldFire(...)
                end
            end
            
            local oldInvoke = remote.InvokeServer
            if oldInvoke then
                remote.InvokeServer = function(...)
                    if not godModeEnabled then
                        return oldInvoke(...)
                    end
                end
            end
        end
    end
    
    local rs = game:GetService("ReplicatedStorage")
    for _, remote in pairs(rs:GetDescendants()) do
        hookRemote(remote)
    end
    
    local addedConn = rs.DescendantAdded:Connect(hookRemote)
    table.insert(allConnections, addedConn)
end

-- CHAN 9: Chan tool va dan
local function blockWeapons()
    local char = player.Character
    if not char then return end
    
    local weaponConn = char.DescendantAdded:Connect(function(obj)
        if godModeEnabled then
            -- Xoa dan, bullet
            if obj:IsA("BasePart") then
                local name = obj.Name:lower()
                if name:find("bullet") or name:find("projectile") or name:find("shell") or name:find("beam") then
                    obj:Destroy()
                end
            end
        end
    end)
    table.insert(allConnections, weaponConn)
    
    -- Quet workspace de xoa dan co san
    local cleanConn = RunService.RenderStepped:Connect(function()
        if godModeEnabled then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Parent ~= char then
                    local name = obj.Name:lower()
                    if name:find("bullet") or name:find("projectile") then
                        obj:Destroy()
                    end
                end
            end
        end
    end)
    table.insert(allConnections, cleanConn)
end

-- CHAN 10: Chan raycast (bam sung)
local function blockRaycast()
    local oldFindPartOnRay = workspace.FindPartOnRay
    local oldRaycast = workspace.Raycast
    
    workspace.FindPartOnRay = function(...)
        if godModeEnabled then
            return nil, nil
        end
        return oldFindPartOnRay(workspace, ...)
    end
    
    workspace.Raycast = function(...)
        if godModeEnabled then
            return nil
        end
        return oldRaycast(workspace, ...)
    end
    
    table.insert(allConnections, {Disconnect = function()
        workspace.FindPartOnRay = oldFindPartOnRay
        workspace.Raycast = oldRaycast
    end})
end

-- CHAN 11: Chan damage tag (game dung tag de gay sat thuong)
local function blockDamageTags()
    local char = player.Character
    if not char then return end
    
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            local conn = part:GetPropertyChangedSignal("CFrame"):Connect(function()
                if godModeEnabled then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        hum.Health = 999999999
                    end
                end
            end)
            table.insert(allConnections, conn)
        end
    end
end

-- CHAN 12: Tu dong respawn bao ve
local function autoProtectOnRespawn()
    local respawnConn = player.CharacterAdded:Connect(function(newChar)
        if godModeEnabled then
            task.wait(0.2)
            
            local hum = newChar:FindFirstChild("Humanoid")
            if hum then
                hum.MaxHealth = 999999999
                hum.Health = 999999999
                hum:ChangeState(Enum.HumanoidStateType.Running)
            end
            
            -- Tai lai cac che do bao ve
            blockHealthLoss()
            blockDeath()
            blockBreakJoints()
            blockBadStates()
            blockForces()
            blockWeapons()
            blockDamageTags()
        end
    end)
    table.insert(allConnections, respawnConn)
end

-- KHONG CHE TAT CA
local function enableGodMode()
    -- Xoa het cu
    clearAllConnections()
    remoteHooks = {}
    
    -- Khoi tao lai
    blockHealthLoss()
    blockDeath()
    blockBreakJoints()
    blockBadStates()
    blockForces()
    blockExplosions()
    blockEnvironment()
    blockRemoteDamage()
    blockWeapons()
    blockRaycast()
    blockDamageTags()
    autoProtectOnRespawn()
    

end

-- BAT/TAT
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        godBtn.Text = "GODMODE [ON]"
        godBtn.BackgroundColor3 = Color3.fromRGB(220, 120, 70)
        status.Text = "STATUS :  GODMODE ON"
        enableGodMode()
    else
        godBtn.Text = "GODMODE"
        godBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        clearAllConnections()
        
        -- Khoi phuc lai
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum and originalMaxHealth[char] then
                hum.MaxHealth = originalMaxHealth[char]
                hum.Health = originalMaxHealth[char]
            end
        end
    end
end

godBtn.MouseButton1Click:Connect(toggleGodMode)
