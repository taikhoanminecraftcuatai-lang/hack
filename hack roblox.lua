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
    if not head or not myCamera then
        return
    end
    local cameraPos = myCamera.CFrame.Position
    local newCFrame = CFrame.new(cameraPos, head.Position)
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
local swapMenuBtn = makeButton("teleport", 2, 1, Color3.fromRGB(150, 80, 100))

local swapFrame = Instance.new("Frame")
swapFrame.Parent = frame
swapFrame.Size = UDim2.new(0, 200, 0, 300)
swapFrame.Position = UDim2.new(1, 10, 0, 60)
swapFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
swapFrame.BackgroundTransparency = 0.1
swapFrame.BorderSizePixel = 0
swapFrame.Visible = false
swapFrame.Active = true
swapFrame.Draggable = true

local swapCorner = Instance.new("UICorner")
swapCorner.CornerRadius = UDim.new(0, 10)
swapCorner.Parent = swapFrame

local swapTitle = Instance.new("TextLabel")
swapTitle.Parent = swapFrame
swapTitle.Size = UDim2.new(1, 0, 0, 30)
swapTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
swapTitle.Text = "CHON NGUOI TELEPORT"
swapTitle.TextColor3 = Color3.new(1, 1, 1)
swapTitle.Font = Enum.Font.GothamBold
swapTitle.TextSize = 12
swapTitle.Parent = swapFrame

local playerList = Instance.new("ScrollingFrame")
playerList.Parent = swapFrame
playerList.Size = UDim2.new(1, -10, 1, -40)
playerList.Position = UDim2.new(0, 5, 0, 35)
playerList.BackgroundTransparency = 1
playerList.CanvasSize = UDim2.new(0, 0, 0, 0)
playerList.ScrollBarThickness = 5

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = playerList
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 5)

local function updatePlayerListUI()
    for _, child in pairs(playerList:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
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
            btn.Parent = playerList
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                local myChar = player.Character
                local targetChar = other.Character
                local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
                local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                
                if myRoot and targetRoot then
                    local myPos = myRoot.CFrame
                    local targetPos = targetRoot.CFrame
                    
                    myRoot.CFrame = targetPos + Vector3.new(0, 3, 0)
                    targetRoot.CFrame = myPos + Vector3.new(0, 3, 0)
                    
                    status.Text = "STATUS : DA DOI TELEPORT DEN " .. other.Name
                    swapFrame.Visible = false
                else
                    status.Text = "STATUS : KHONG THE TELEPORT"
                end
            end)
            
            ySize = ySize + 40
        end
    end
    playerList.CanvasSize = UDim2.new(0, 0, 0, ySize)
end

swapMenuBtn.MouseButton1Click:Connect(function()
    swapFrame.Visible = not swapFrame.Visible
    if swapFrame.Visible then
        updatePlayerListUI()
    end
end)

Players.PlayerAdded:Connect(function()
    if swapFrame.Visible then
        updatePlayerListUI()
    end
end)

Players.PlayerRemoving:Connect(function()
    if swapFrame.Visible then
        updatePlayerListUI()
    end
end)
--========================
-- ESP DO NHAT DUOC (CO THE NHAT)
--========================

local itemEspEnabled = false
local itemEspRadius = 100
local itemEspList = {}

local itemEspBtn = makeButton("ITEM ESP", 2, 2, Color3.fromRGB(80, 150, 80))

-- Danh sach ten do co the nhat (them tuy y)
local pickupItems = {
    "coin", "money", "gold", "gem", "diamond", "ruby", "crystal", "emerald",
    "health", "med", "heal", "bandage", "potion", "food", "apple", "berry", "meat",
    "ammo", "bullet", "magazine", "shell", "rocket", "arrow",
    "key", "card", "pass", "token",
    "chest", "crate", "bag", "backpack", "loot",
    "weapon", "gun", "sword", "knife", "axe", "hammer", "bow",
    "wood", "stone", "ore", "ingot", "leather", "cloth", "herb",
    "scroll", "book", "potion", "elixir", "vial",
}

local function isPickupItem(itemName)
    local lower = itemName:lower()
    for _, name in pairs(pickupItems) do
        if lower:find(name) then
            return true
        end
    end
    return false
end

-- Kiem tra xem vat pham co the nhat duoc khong
local function canPickup(obj)
    -- Co ClickDetector?
    if obj:FindFirstChild("ClickDetector") then
        return true
    end
    
    -- Hoac tool (vu khi, do dung)
    if obj:IsA("Tool") then
        return true
    end
    
    -- Hoac co ten trong danh sach do nhap
    if isPickupItem(obj.Name) then
        return true
    end
    
    -- Hoac co trong model co chua child la tool
    if obj:IsA("Model") and obj:FindFirstChildWhichIsA("Tool") then
        return true
    end
    
    return false
end

local function createItemESP(itemPart, itemName)
    local bill = Instance.new("BillboardGui")
    bill.Size = UDim2.new(0, 140, 0, 35)
    bill.StudsOffset = Vector3.new(0, 1.5, 0)
    bill.AlwaysOnTop = true
    bill.Parent = itemPart
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.6, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = itemName
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Center
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    nameLabel.Parent = bill
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.4, 0)
    distLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = ""
    distLabel.TextSize = 10
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextXAlignment = Enum.TextXAlignment.Center
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.Parent = bill
    
    return {bill = bill, nameLabel = nameLabel, distLabel = distLabel, part = itemPart}
end

local function getPickupItems()
    local items = {}
    local myChar = player.Character
    if not myChar then return items end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return items end
    local myPos = myRoot.Position
    
    for _, obj in pairs(workspace:GetDescendants()) do
        -- Bo qua nguoi choi
        local isPlayer = false
        for _, p in pairs(Players:GetPlayers()) do
            if obj:IsDescendantOf(p.Character) then
                isPlayer = true
                break
            end
        end
        if isPlayer then continue end
        
        -- Bo qua ban than minh
        if obj:IsDescendantOf(myChar) then continue end
        
        -- Bo qua terrain
        if obj.Name == "Terrain" then continue end
        
        -- Kiem tra co the nhat khong
        if canPickup(obj) then
            local part = obj
            if obj:IsA("Model") then
                part = obj:FindFirstChild("Head") or obj:FindFirstChild("Handle") or obj:FindFirstChildWhichIsA("BasePart")
                if not part then part = obj end
            end
            
            local dist = (myPos - (part.Position or obj.Position)).Magnitude
            if dist <= itemEspRadius then
                table.insert(items, {part = part, name = obj.Name})
            end
        end
    end
    return items
end

local function clearESP()
    for _, esp in pairs(itemEspList) do
        if esp and esp.bill then esp.bill:Destroy() end
    end
    itemEspList = {}
end

local function refreshESP()
    clearESP()
    local items = getPickupItems()
    for _, item in pairs(items) do
        if item.part and item.part.Parent then
            local esp = createItemESP(item.part, item.name)
            table.insert(itemEspList, esp)
        end
    end
end

local function updateDistances()
    local myChar = player.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    local myPos = myRoot.Position
    
    for _, esp in pairs(itemEspList) do
        if esp and esp.part and esp.part.Parent then
            local dist = (myPos - esp.part.Position).Magnitude
            esp.distLabel.Text = string.format("%.1fm", dist)
            esp.bill.Enabled = (dist <= itemEspRadius)
        end
    end
end

local function scanNewItems()
    local currentParts = {}
    for _, esp in pairs(itemEspList) do
        if esp and esp.part then currentParts[esp.part] = true end
    end
    local items = getPickupItems()
    for _, item in pairs(items) do
        if item.part and item.part.Parent and not currentParts[item.part] then
            table.insert(itemEspList, createItemESP(item.part, item.name))
        end
    end
end

local scanLoop = nil

local function toggleESP()
    itemEspEnabled = not itemEspEnabled
    
    if itemEspEnabled then
        refreshESP()
        itemEspBtn.Text = "ITEM ESP ON"
        itemEspBtn.BackgroundColor3 = Color3.fromRGB(100, 180, 100)
        status.Text = "STATUS : ITEM ESP ON"
        if scanLoop then scanLoop:Disconnect() end
        scanLoop = RunService.RenderStepped:Connect(function()
            if itemEspEnabled then
                scanNewItems()
                updateDistances()
            end
        end)
    else
        clearESP()
        itemEspBtn.Text = "ITEM ESP"
        itemEspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        status.Text = "STATUS : READY"
        if scanLoop then scanLoop:Disconnect() scanLoop = nil end
    end
end

itemEspBtn.MouseButton1Click:Connect(toggleESP)

player.CharacterAdded:Connect(function()
    if itemEspEnabled then task.wait(1) refreshESP() end
end)
