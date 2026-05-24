--========================
-- GUI RỖNG (DÙNG makeButton)
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
-- AIM LOCK PRO MAX - GHIM CHẶT VÀO ĐẦU
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
local targetLockStartTime = 0
local frameCounter = 0
local forceLockStrength = 1.0

-- ==================== LẤY VỊ TRÍ ĐẦU CHÍNH XÁC ====================
local function getAccurateHeadPosition(target)
    if not target then return nil end
    local character = target.Character
    if not character then return nil end
    
    -- Ưu tiên lấy Head trước
    local head = character:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        return head.Position
    end
    
    -- Nếu không có Head, lấy HumanoidRootPart
    local root = character:FindFirstChild("HumanoidRootPart")
    if root and root:IsA("BasePart") then
        return root.Position + Vector3.new(0, 1.5, 0)
    end
    
    -- Nếu không có gì, lấy UpperTorso
    local torso = character:FindFirstChild("UpperTorso")
    if torso and torso:IsA("BasePart") then
        return torso.Position + Vector3.new(0, 0.5, 0)
    end
    
    return nil
end

-- ==================== KIỂM TRA MỤC TIÊU CÒN SỐNG ====================
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
local function getDistanceBetween(pos1, pos2)
    return (pos1 - pos2).Magnitude
end

local function findClosestEnemy()
    local myCharacter = player.Character
    if not myCharacter then return nil, 0 end
    
    local myRoot = myCharacter:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil, 0 end
    
    local myPosition = myRoot.Position
    local closestPlayer = nil
    local shortestDistance = lockDistance + 1
    
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter then
                local otherRoot = otherCharacter:FindFirstChild("HumanoidRootPart")
                local otherHumanoid = otherCharacter:FindFirstChild("Humanoid")
                
                if otherRoot and otherHumanoid and otherHumanoid.Health > 0 then
                    local distance = getDistanceBetween(myPosition, otherRoot.Position)
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestPlayer = otherPlayer
                    end
                end
            end
        end
    end
    
    return closestPlayer, shortestDistance
end

-- ==================== GHIM CAMERA VÀO ĐẦU (CỰC CHẶT) ====================
local function ghimCameraVaoDau(targetPosition)
    local camera = workspace.CurrentCamera
    if not camera or not targetPosition then return false end
    
    -- Lấy vị trí hiện tại của camera
    local cameraPosition = camera.CFrame.Position
    
    -- Tính toán vector hướng từ camera đến mục tiêu
    local direction = (targetPosition - cameraPosition).Unit
    
    -- Tạo CFrame mới hướng thẳng vào mục tiêu
    local newCameraCFrame = CFrame.new(cameraPosition, targetPosition)
    
    -- GHIM CHẶT: Gán trực tiếp, không qua bất kỳ trung gian nào
    camera.CFrame = newCameraCFrame
    
    return true
end

-- ==================== GHIM CỰC MẠNH CÓ LẶP LẠI ====================
local function ghimVaoDauCucManh(target)
    if not target then return false end
    
    -- Lấy vị trí đầu chính xác
    local headPosition = getAccurateHeadPosition(target)
    if not headPosition then return false end
    
    -- Ghim camera
    local success = ghimCameraVaoDau(headPosition)
    
    return success
end

-- ==================== TỰ ĐỘNG CHUYỂN MỤC TIÊU ====================
local function timMucTieuMoi()
    local newTarget, distance = findClosestEnemy()
    if newTarget then
        currentTarget = newTarget
        targetLockStartTime = tick()
        return true
    end
    currentTarget = nil
    return false
end

local function kiemTraMucTieuConHopLe()
    if not currentTarget then return false end
    if not isTargetAlive(currentTarget) then return false end
    
    -- Kiểm tra khoảng cách
    local myCharacter = player.Character
    local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")
    local targetRoot = currentTarget.Character and currentTarget.Character:FindFirstChild("HumanoidRootPart")
    
    if not myRoot or not targetRoot then return false end
    
    local distance = getDistanceBetween(myRoot.Position, targetRoot.Position)
    if distance > lockDistance then return false end
    
    return true
end

-- ==================== VÒNG LẶP GHIM CHẶT ====================
local function vongLapGhim()
    if not aimLockEnabled then return end
    
    frameCounter = frameCounter + 1
    
    -- Kiểm tra target hiện tại
    if not kiemTraMucTieuConHopLe() then
        timMucTieuMoi()
    end
    
    -- Ghim vào target nếu có
    if currentTarget then
        ghimVaoDauCucManh(currentTarget)
    end
end

-- ==================== KHỞI ĐỘNG VÀ DỪNG ====================
local function khoiDongGhim()
    if aimConnection then
        aimConnection:Disconnect()
    end
    aimConnection = RunService.RenderStepped:Connect(vongLapGhim)
end

local function dungGhim()
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    currentTarget = nil
end

-- ==================== BẬT/TẮT ====================
local function batAimLock()
    if aimLockEnabled then return end
    aimLockEnabled = true
    timMucTieuMoi()
    khoiDongGhim()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [ON]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(200, 80, 100)
    end
    print("[AIM LOCK] ĐÃ BẬT - GHIM CHẶT VÀO ĐẦU")
end

local function tatAimLock()
    if not aimLockEnabled then return end
    aimLockEnabled = false
    dungGhim()
    
    if aimBtn then
        aimBtn.Text = " AIM LOCK [OFF]"
        aimBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
    end
    print("[AIM LOCK] ĐÃ TẮT")
end

local function chuyenDoiAimLock()
    if aimLockEnabled then
        tatAimLock()
    else
        batAimLock()
    end
end

-- ==================== XỬ LÝ KHI NHÂN VẬT RESPAWN ====================
player.CharacterAdded:Connect(function()
    if aimLockEnabled then
        task.wait(0.5)
        currentTarget = nil
        timMucTieuMoi()
    end
end)

-- ==================== XỬ LÝ KHI CÓ NGƯỜI CHƠI RỜI ====================
Players.PlayerRemoving:Connect(function(leavingPlayer)
    if aimLockEnabled and currentTarget == leavingPlayer then
        timMucTieuMoi()
    end
end)

-- ==================== TẠO NÚT TRONG GUI ====================
local aimBtn = makeButton(" AIM LOCK", 1, 1, Color3.fromRGB(80, 60, 100))
aimBtn.MouseButton1Click:Connect(chuyenDoiAimLock)
