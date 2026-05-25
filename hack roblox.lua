--========================
-- TOOl
--========================
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyGUI"
screenGui.Parent = game.CoreGui

-- Nút mở GUI
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0.02, 0, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
openBtn.BackgroundTransparency = 0.1
openBtn.Text = "🇻🇳"
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.TextSize = 24
openBtn.Font = Enum.Font.GothamBold
openBtn.BorderSizePixel = 0
openBtn.Draggable = true
openBtn.Parent = screenGui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = openBtn

-- Cửa sổ chính
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 340)
mainFrame.Position = UDim2.new(0.02, 60, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Thanh tiêu đề
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
header.BackgroundTransparency = 0.2
header.Draggable = true
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.Text = " MY TOOL"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 1, 0)
closeBtn.Position = UDim2.new(1, -36, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(220, 80, 80)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

-- Khu vực chứa nút
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1, -16, 1, -80)
content.Position = UDim2.new(0, 8, 0, 50)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.ScrollBarThickness = 4
content.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Parent = content
layout.Padding = UDim.new(0, 8)

-- Thanh trạng thái
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 24)
statusBar.Position = UDim2.new(0, 0, 1, -24)
statusBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
statusBar.BackgroundTransparency = 0.3
statusBar.Parent = mainFrame

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -12, 1, 0)
statusText.Position = UDim2.new(0, 10, 0, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "● READY"
statusText.TextColor3 = Color3.fromRGB(100, 255, 100)
statusText.TextSize = 10
statusText.Font = Enum.Font.Gotham
statusText.TextXAlignment = Enum.TextXAlignment.Left
statusText.Parent = statusBar

-- Cập nhật canvas
local function updateCanvas()
    task.wait(0.1)
    content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

layout.ChildAdded:Connect(updateCanvas)
layout.ChildRemoved:Connect(updateCanvas)

-- HÀM makeButton (giống hồi trước)
local function makeButton(text, row, col, color)
    local btn = Instance.new("TextButton")
    btn.Parent = content
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0, 10 + (col - 1) * 130, 0, 10 + (row - 1) * 45)
    btn.Text = text
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 80)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BorderSizePixel = 0
    btn.BackgroundTransparency = 0.2
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Hiệu ứng hover
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play()
    end)
    
    return btn
end

-- Mở/đóng GUI
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
    if mainFrame.Visible then
        updateCanvas()
    end
end)
--========================
-- AIM LOCK PRO MAX - CỨNG NHƯ THÉP
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- ==================== CẤU HÌNH ====================
local aimLockEnabled = false
local currentTarget = nil
local aimConnection = nil
local lockDistance = 400

-- ==================== LẤY VỊ TRÍ ĐẦU CHÍNH XÁC ====================
local function getHeadPosition(target)
    if not target then return nil end
    local character = target.Character
    if not character then return nil end
    
    -- Lấy Head trực tiếp
    local head = character:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        return head.Position
    end
    
    -- Nếu không có Head, lấy HumanoidRootPart + offset
    local root = character:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        return root.Position + Vector3.new(0, 1.8, 0)
    end
    
    return nil
end

-- ==================== KIỂM TRA MỤC TIÊU ====================
local function isTargetAlive(target)
    if not target then return false end
    local character = target.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    if humanoid.Health <= 0 then return false end
    
    return true
end

-- ==================== TÌM NGƯỜI GẦN NHẤT ====================
local function getDistance(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function findClosestEnemy()
    local myChar = player.Character
    if not myChar then return nil end
    
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    
    local myPos = myRoot.Position
    local closest = nil
    local closestDist = lockDistance
    
    for _, other in pairs(Players:GetPlayers()) do
        if other ~= player then
            local otherChar = other.Character
            if otherChar then
                local otherRoot = otherChar:FindFirstChild("HumanoidRootPart")
                local otherHum = otherChar:FindFirstChild("Humanoid")
                
                if otherRoot and otherHum and otherHum.Health > 0 then
                    local dist = getDistance(myPos, otherRoot.Position)
                    if dist < closestDist then
                        closestDist = dist
                        closest = other
                    end
                end
            end
        end
    end
    
    return closest
end

-- ==================== LOCK CỨNG VÀO ĐẦU (KHÔNG MƯỢT) ====================
local function lockHardToHead(target)
    if not target then return end
    
    local targetChar = target.Character
    if not targetChar then return end
    
    local headPos = getHeadPosition(target)
    if not headPos then return end
    
    local camera = workspace.CurrentCamera
    if not camera then return end
    
    -- LOCK CỨNG: Gán trực tiếp CFrame, không qua Lerp, không qua bất kỳ trung gian nào
    local cameraPos = camera.CFrame.Position
    camera.CFrame = CFrame.new(cameraPos, headPos)
end

-- ==================== VÒNG LẶP LOCK ====================
local function updateLock()
    if not aimLockEnabled then return end
    
    -- Tìm target mới mỗi frame (luôn ưu tiên người gần nhất)
    local target = findClosestEnemy()
    
    if target then
        currentTarget = target
        lockHardToHead(target)
    else
        currentTarget = nil
    end
end

-- ==================== BẬT/TẮT ====================
local function startLock()
    if aimConnection then
        aimConnection:Disconnect()
    end
    aimConnection = RunService.RenderStepped:Connect(updateLock)
end

local function stopLock()
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    currentTarget = nil
end

local function enableAimLock()
    if aimLockEnabled then return end
    aimLockEnabled = true
    startLock()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 100)
    end
    print("[AIM LOCK] ĐÃ BẬT - LOCK CỨNG VÀO ĐẦU")
end

local function disableAimLock()
    if not aimLockEnabled then return end
    aimLockEnabled = false
    stopLock()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [OFF]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    end
    print("[AIM LOCK] ĐÃ TẮT")
end

local function toggleAimLock()
    if aimLockEnabled then
        disableAimLock()
    else
        enableAimLock()
    end
end

-- ==================== XỬ LÝ RESPAWN ====================
player.CharacterAdded:Connect(function()
    if aimLockEnabled then
        currentTarget = nil
    end
end)

-- ==================== TẠO NÚT TRONG GUI ====================
local aimBtn = makeButton(" AIM LOCK", 1, 1, Color3.fromRGB(80, 60, 100))
aimBtn.MouseButton1Click:Connect(toggleAimLock)
--========================
-- INFINITE JUMP PRO MAX (CHỈ CÒN NÚT BẬT/TẮT)
--========================
local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local jumpEnabled = false
local jumpConnection = nil
local originalJumpPower = nil
local currentJumpPower = 65

-- Lấy Humanoid
local function getHumanoid()
    local char = player.Character
    if not char then return nil end
    return char:FindFirstChild("Humanoid")
end

-- Lưu lực nhảy gốc
local function saveOriginalJumpPower()
    local hum = getHumanoid()
    if hum and originalJumpPower == nil then
        originalJumpPower = hum.JumpPower
    end
end

-- Khôi phục lực nhảy gốc
local function restoreOriginalJumpPower()
    local hum = getHumanoid()
    if hum and originalJumpPower then
        hum.JumpPower = originalJumpPower
    end
end

-- Xử lý nhảy
local function onJumpRequest()
    if not jumpEnabled then return end
    
    local hum = getHumanoid()
    if not hum then return end
    if hum.Health <= 0 then return end
    
    hum.JumpPower = currentJumpPower
    
    if hum.FloorMaterial == Enum.Material.Air then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- Bật
local function enableJump()
    if jumpEnabled then return end
    jumpEnabled = true
    saveOriginalJumpPower()
    
    if jumpConnection then jumpConnection:Disconnect() end
    jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    
    if jumpBtn then
        jumpBtn.Text = " INFINITE JUMP [ON]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(100, 150, 120)
    end
    print("[INFINITE JUMP] ĐÃ BẬT")
end

-- Tắt
local function disableJump()
    if not jumpEnabled then return end
    jumpEnabled = false
    
    if jumpConnection then
        jumpConnection:Disconnect()
        jumpConnection = nil
    end
    
    restoreOriginalJumpPower()
    
    if jumpBtn then
        jumpBtn.Text = " INFINITE JUMP [OFF]"
        jumpBtn.BackgroundColor3 = Color3.fromRGB(80, 100, 80)
    end
    print("[INFINITE JUMP] ĐÃ TẮT")
end

-- Đảo trạng thái
local function toggleJump()
    if jumpEnabled then
        disableJump()
    else
        enableJump()
    end
end

-- Xử lý respawn
player.CharacterAdded:Connect(function()
    if jumpEnabled then
        task.wait(0.5)
        saveOriginalJumpPower()
        if jumpConnection then
            jumpConnection:Disconnect()
        end
        jumpConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    end
end)

-- Tạo nút trong GUI
local jumpBtn = makeButton(" INFINITE JUMP", 2, 1, Color3.fromRGB(80, 100, 80))
jumpBtn.MouseButton1Click:Connect(toggleJump)
--========================
-- MELEE WEAPON (VŨ KHÍ CẦM TAY GÂY SÁT THƯƠNG)
--========================
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local weaponEnabled = false
local currentWeapon = nil
local attackCooldown = false

-- Tạo vũ khí (gậy/kiếm) để cầm
local function createWeapon()
    local char = player.Character
    if not char then return nil end
    
    local rightHand = char:FindFirstChild("RightHand")
    if not rightHand then return nil end
    
    -- Tạo model vũ khí
    local weapon = Instance.new("Model")
    weapon.Name = "MeleeWeapon"
    
    -- Phần chính (thân kiếm/gậy)
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.5, 1, 0.5)
    handle.BrickColor = BrickColor.new("Dark stone grey")
    handle.Material = Enum.Material.SmoothPlastic
    handle.Parent = weapon
    
    -- Lưỡi / phần gây sát thương
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.3, 3, 0.8)
    blade.Position = Vector3.new(0, 1.8, 0)
    blade.BrickColor = BrickColor.new("Really red")
    blade.Material = Enum.Material.Neon
    blade.Parent = weapon
    
    -- Khớp nối để gắn vào tay
    local weld = Instance.new("Weld")
    weld.Part0 = rightHand
    weld.Part1 = handle
    weld.C0 = rightHand.CFrame
    weld.C1 = CFrame.new(0, 0.5, -0.5)
    weld.Parent = handle
    
    -- Hiệu ứng phát sáng
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(255, 50, 50)
    pointLight.Range = 8
    pointLight.Brightness = 1
    pointLight.Parent = blade
    
    -- Particle (bụi đỏ)
    local particles = Instance.new("ParticleEmitter")
    particles.Texture = "rbxassetid://129909788"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    particles.Rate = 0
    particles.Parent = blade
    
    weapon.Parent = char
    
    return weapon, blade, particles, weld
end

-- Gây sát thương
local function dealDamage(target)
    if not target then return false end
    
    local targetChar = target.Character
    if not targetChar then return false end
    
    local hum = targetChar:FindFirstChild("Humanoid")
    if not hum then return false end
    if hum.Health <= 0 then return false end
    
    -- Gây sát thương (50 máu)
    hum.Health = hum.Health - 50
    
    -- Hiệu ứng khi đánh trúng
    local attachment = Instance.new("Attachment")
    attachment.Parent = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
    
    local particle = Instance.new("ParticleEmitter")
    particle.Texture = "rbxassetid://129909788"
    particle.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    particle.Lifetime = NumberRange.new(0.3)
    particle.Rate = 50
    particle.Parent = attachment
    
    task.spawn(function()
        task.wait(0.2)
        particle:Destroy()
        attachment:Destroy()
    end)
    
    print("[MELEE] Đã đánh " .. target.Name .. " - Máu còn: " .. hum.Health)
    return true
end

-- Kiểm tra va chạm của lưỡi kiếm
local function checkHit(blade)
    if not blade then return end
    
    local hitParts = blade:GetTouchingParts()
    for _, part in pairs(hitParts) do
        local hitChar = part:FindFirstAncestorWhichIsA("Model")
        if hitChar then
            local targetPlayer = game.Players:GetPlayerFromCharacter(hitChar)
            if targetPlayer and targetPlayer ~= player then
                return targetPlayer
            end
        end
    end
    return nil
end

-- Animation khi đánh
local function swingAnimation(blade, particles)
    if not blade then return end
    
    -- Xoay lưỡi kiếm
    local originalCF = blade.CFrame
    local forward = blade.CFrame * CFrame.Angles(0, 0, math.rad(-60))
    local back = blade.CFrame * CFrame.Angles(0, 0, math.rad(60))
    
    -- Bật particle
    if particles then
        particles.Rate = 200
    end
    
    -- Quạt tới
    for i = 1, 10 do
        blade.CFrame = originalCF:Lerp(forward, i/10)
        task.wait(0.01)
        
        -- Kiểm tra va chạm trong khi đánh
        local hitTarget = checkHit(blade)
        if hitTarget and not attackCooldown then
            attackCooldown = true
            dealDamage(hitTarget)
            task.wait(0.3)
            attackCooldown = false
        end
    end
    
    -- Quạt lui
    for i = 1, 10 do
        blade.CFrame = forward:Lerp(originalCF, i/10)
        task.wait(0.01)
    end
    
    -- Tắt particle
    if particles then
        particles.Rate = 0
    end
end

-- Bật/tắt vũ khí
local function toggleWeapon()
    weaponEnabled = not weaponEnabled
    
    if weaponEnabled then
        local weapon, blade, particles, weld = createWeapon()
        if weapon then
            currentWeapon = {weapon = weapon, blade = blade, particles = particles, weld = weld}
            weaponBtn.Text = " MELEE [ON]"
            weaponBtn.BackgroundColor3 = Color3.fromRGB(180, 80, 100)
            print("[MELEE] ĐÃ CẦM VŨ KHÍ - Nhấn R để đánh")
        else
            print("[ERROR] Không thể tạo vũ khí")
            weaponEnabled = false
        end
    else
        if currentWeapon and currentWeapon.weapon then
            currentWeapon.weapon:Destroy()
            currentWeapon = nil
        end
        weaponBtn.Text = " MELEE [OFF]"
        weaponBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 80)
        print("[MELEE] ĐÃ CẤT VŨ KHÍ")
    end
end

-- Đánh khi nhấn phím R
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.R and weaponEnabled and currentWeapon then
        swingAnimation(currentWeapon.blade, currentWeapon.particles)
    end
end)

-- Xử lý khi nhân vật respawn
player.CharacterAdded:Connect(function()
    if weaponEnabled then
        weaponEnabled = false
        if currentWeapon then
            currentWeapon.weapon:Destroy()
            currentWeapon = nil
        end
        task.wait(0.5)
        toggleWeapon()
    end
end)

-- Tạo nút trong GUI
local weaponBtn = makeButton(" MELEE", 3, 1, Color3.fromRGB(80, 60, 80))
weaponBtn.MouseButton1Click:Connect(toggleWeapon)
