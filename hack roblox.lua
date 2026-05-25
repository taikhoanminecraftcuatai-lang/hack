--[[
    ╔══════════════════════════════════════════════════════════╗
    ║        ROBLOX MOBILE OPTIMIZER & AUTOMATION KIT          ║
    ║              Tối ưu hóa & Tự động hóa                    ║
    ║                   Version 2.0                            ║
    ╚══════════════════════════════════════════════════════════╝

    Cấu trúc module:
    1. MobileDetector   - Phát hiện & thích nghi thiết bị mobile
    2. PerformanceManager - Tối ưu FPS & bộ nhớ
    3. InputHandler     - Xử lý touch input mobile
    4. UIAutoScaler     - Tự động scale UI theo màn hình
    5. TaskScheduler    - Lập lịch tác vụ tự động
    6. EventBus         - Hệ thống sự kiện nội bộ
    7. ObjectPool       - Tái sử dụng object để giảm GC
    8. NetworkOptimizer - Tối ưu kết nối mạng
]]

local RunService   = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService   = game:GetService("GuiService")
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace    = game:GetService("Workspace")

local LocalPlayer  = Players.LocalPlayer
local PlayerGui    = LocalPlayer:WaitForChild("PlayerGui")
local Camera       = Workspace.CurrentCamera

-- ─────────────────────────────────────────────
-- 1. EVENT BUS (pub/sub nội bộ)
-- ─────────────────────────────────────────────
local EventBus = {}
EventBus.__index = EventBus

function EventBus.new()
    return setmetatable({ _listeners = {} }, EventBus)
end

function EventBus:on(event, callback)
    if not self._listeners[event] then
        self._listeners[event] = {}
    end
    table.insert(self._listeners[event], callback)
    -- Trả về hàm huỷ đăng ký
    return function()
        local list = self._listeners[event]
        for i, cb in ipairs(list) do
            if cb == callback then
                table.remove(list, i)
                break
            end
        end
    end
end

function EventBus:emit(event, ...)
    local list = self._listeners[event]
    if list then
        for _, cb in ipairs(list) do
            task.spawn(cb, ...)
        end
    end
end

local Bus = EventBus.new()

-- ─────────────────────────────────────────────
-- 2. MOBILE DETECTOR
-- ─────────────────────────────────────────────
local MobileDetector = {}
MobileDetector.__index = MobileDetector

function MobileDetector.new()
    local self = setmetatable({}, MobileDetector)
    self.isMobile   = UserInputService.TouchEnabled
                      and not UserInputService.KeyboardEnabled
    self.isTablet   = false
    self.screenSize = Vector2.new(0, 0)
    self.density    = 1
    self:_detect()
    return self
end

function MobileDetector:_detect()
    local vp = Camera.ViewportSize
    self.screenSize = vp
    -- Phân loại: tablet nếu cạnh ngắn >= 768
    self.isTablet = math.min(vp.X, vp.Y) >= 768

    -- Ước tính pixel density từ viewport
    local guiInset = GuiService:GetGuiInset()
    self.safeAreaTop    = guiInset.Y
    self.safeAreaBottom = 0

    Bus:emit("DeviceDetected", {
        isMobile  = self.isMobile,
        isTablet  = self.isTablet,
        screenSize = self.screenSize,
    })
end

function MobileDetector:IsSmallScreen()
    return self.screenSize.X < 480
end

local Device = MobileDetector.new()

-- ─────────────────────────────────────────────
-- 3. PERFORMANCE MANAGER
-- ─────────────────────────────────────────────
local PerformanceManager = {}
PerformanceManager.__index = PerformanceManager

function PerformanceManager.new()
    local self = setmetatable({}, PerformanceManager)
    self.targetFPS    = 60
    self.currentFPS   = 60
    self.frameHistory = {}  -- vòng đệm 60 frame
    self.historySize  = 60
    self._connections = {}
    self:_startMonitor()
    return self
end

-- Theo dõi FPS theo thời gian thực
function PerformanceManager:_startMonitor()
    local lastTime = os.clock()
    local conn = RunService.Heartbeat:Connect(function()
        local now   = os.clock()
        local delta = now - lastTime
        lastTime    = now

        local fps = (delta > 0) and (1 / delta) or 60
        -- Lưu vào vòng đệm
        table.insert(self.frameHistory, fps)
        if #self.frameHistory > self.historySize then
            table.remove(self.frameHistory, 1)
        end
        -- Tính trung bình
        local sum = 0
        for _, v in ipairs(self.frameHistory) do sum = sum + v end
        self.currentFPS = sum / #self.frameHistory

        -- Cảnh báo khi FPS thấp
        if self.currentFPS < 30 then
            Bus:emit("LowFPS", self.currentFPS)
        end
    end)
    table.insert(self._connections, conn)
end

-- Tự động giảm chất lượng khi FPS thấp
function PerformanceManager:AutoQuality()
    Bus:on("LowFPS", function(fps)
        -- Giảm render distance
        Workspace.StreamingMinRadius = math.max(32, Workspace.StreamingMinRadius - 16)
        -- Tắt shadows tạm thời nếu cần
        if fps < 20 then
            Lighting = game:GetService("Lighting")
            Lighting.GlobalShadows = false
        end
        warn(string.format("[PerfManager] FPS thấp: %.1f – đã điều chỉnh chất lượng", fps))
    end)
end

-- Xóa bộ nhớ: ngắt kết nối toàn bộ
function PerformanceManager:Destroy()
    for _, c in ipairs(self._connections) do c:Disconnect() end
    self._connections = {}
end

local Perf = PerformanceManager.new()
Perf:AutoQuality()

-- ─────────────────────────────────────────────
-- 4. OBJECT POOL (tái sử dụng instance)
-- ─────────────────────────────────────────────
local ObjectPool = {}
ObjectPool.__index = ObjectPool

--[[
    Ví dụ dùng:
        local BulletPool = ObjectPool.new(function()
            local p = Instance.new("Part")
            p.Size = Vector3.new(0.2,0.2,1)
            return p
        end, 50)

        local bullet = BulletPool:Get()
        -- ...dùng bullet...
        BulletPool:Return(bullet)
]]

function ObjectPool.new(factory, initialSize)
    local self = setmetatable({
        _factory  = factory,
        _pool     = {},
        _active   = 0,
        _created  = 0,
    }, ObjectPool)

    -- Tạo sẵn một số object
    for _ = 1, (initialSize or 10) do
        local obj = factory()
        if obj:IsA("Instance") then obj.Parent = nil end
        table.insert(self._pool, obj)
        self._created += 1
    end
    return self
end

function ObjectPool:Get()
    self._active += 1
    if #self._pool > 0 then
        return table.remove(self._pool)
    end
    -- Tạo mới nếu hết
    self._created += 1
    return self._factory()
end

function ObjectPool:Return(obj)
    self._active -= 1
    if obj:IsA("Instance") then obj.Parent = nil end
    table.insert(self._pool, obj)
end

function ObjectPool:Stats()
    return {
        pooled  = #self._pool,
        active  = self._active,
        created = self._created,
    }
end

-- ─────────────────────────────────────────────
-- 5. INPUT HANDLER (touch & gesture mobile)
-- ─────────────────────────────────────────────
local InputHandler = {}
InputHandler.__index = InputHandler

function InputHandler.new()
    local self = setmetatable({
        _touches    = {},   -- track các ngón tay đang chạm
        _gestures   = {},
        _connections = {},
    }, InputHandler)
    self:_bindEvents()
    return self
end

function InputHandler:_bindEvents()
    -- Touch bắt đầu
    local c1 = UserInputService.TouchStarted:Connect(function(touch, processed)
        if processed then return end
        self._touches[touch] = {
            startPos  = touch.Position,
            startTime = os.clock(),
        }
        Bus:emit("TouchDown", touch.Position)
    end)

    -- Touch kết thúc → nhận diện gesture
    local c2 = UserInputService.TouchEnded:Connect(function(touch, processed)
        if processed then return end
        local data = self._touches[touch]
        if data then
            local dt   = os.clock() - data.startTime
            local dist = (touch.Position - data.startPos).Magnitude

            if dt < 0.2 and dist < 10 then
                -- Tap nhanh
                Bus:emit("Tap", touch.Position)
            elseif dt < 0.5 and dist > 80 then
                -- Swipe
                local dir = (touch.Position - data.startPos).Unit
                Bus:emit("Swipe", dir, touch.Position)
            elseif dt >= 0.5 and dist < 10 then
                -- Long press
                Bus:emit("LongPress", touch.Position)
            end
            self._touches[touch] = nil
        end
        Bus:emit("TouchUp", touch.Position)
    end)

    -- Pinch to zoom (2 ngón)
    local c3 = UserInputService.TouchPinch:Connect(function(positions, scale, velocity, state, processed)
        if processed then return end
        Bus:emit("Pinch", scale, velocity, state)
    end)

    -- Swipe toàn màn hình (built-in)
    local c4 = UserInputService.TouchSwipe:Connect(function(swipeDir, numberOfTouches, processed)
        if processed then return end
        Bus:emit("SwipeDir", swipeDir, numberOfTouches)
    end)

    table.insert(self._connections, c1)
    table.insert(self._connections, c2)
    table.insert(self._connections, c3)
    table.insert(self._connections, c4)
end

-- Đăng ký callback cho gesture cụ thể
function InputHandler:OnGesture(gesture, callback)
    return Bus:on(gesture, callback)
end

function InputHandler:Destroy()
    for _, c in ipairs(self._connections) do c:Disconnect() end
    self._connections = {}
end

local Input = InputHandler.new()

-- ─────────────────────────────────────────────
-- 6. UI AUTO SCALER
-- ─────────────────────────────────────────────
local UIAutoScaler = {}
UIAutoScaler.__index = UIAutoScaler

--[[
    Tự động scale toàn bộ ScreenGui theo tỷ lệ màn hình.
    Dùng UIScale để đảm bảo UI không quá nhỏ trên mobile.
]]

function UIAutoScaler.new(screenGui, referenceSize)
    local self = setmetatable({
        _gui  = screenGui,
        _ref  = referenceSize or Vector2.new(1920, 1080),
        _conn = nil,
    }, UIAutoScaler)

    -- Gắn UIScale nếu chưa có
    local scaler = screenGui:FindFirstChildOfClass("UIScale")
                or Instance.new("UIScale", screenGui)
    self._scaler = scaler
    self:_update()

    -- Cập nhật khi resize
    self._conn = Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        self:_update()
    end)
    return self
end

function UIAutoScaler:_update()
    local vp    = Camera.ViewportSize
    local scaleX = vp.X / self._ref.X
    local scaleY = vp.Y / self._ref.Y
    -- Dùng min để UI không bị cắt
    local scale = math.min(scaleX, scaleY)
    -- Tối thiểu 0.4 để tránh quá nhỏ trên mobile
    self._scaler.Scale = math.max(0.4, scale)
    Bus:emit("UIScaled", self._scaler.Scale)
end

function UIAutoScaler:Destroy()
    if self._conn then self._conn:Disconnect() end
end

-- ─────────────────────────────────────────────
-- 7. TASK SCHEDULER (tự động hóa tác vụ)
-- ─────────────────────────────────────────────
local TaskScheduler = {}
TaskScheduler.__index = TaskScheduler

--[[
    Lên lịch tác vụ chạy lặp hoặc delay mà không chặn main thread.

    Ví dụ:
        Scheduler:Every(5, function() print("5 giây/lần") end)
        Scheduler:After(3, function() print("Sau 3 giây") end)
        Scheduler:NextFrame(function() print("Frame tiếp theo") end)
]]

function TaskScheduler.new()
    local self = setmetatable({
        _tasks  = {},   -- {id, interval, last, callback, once}
        _nextId = 0,
        _conn   = nil,
    }, TaskScheduler)
    self:_start()
    return self
end

function TaskScheduler:_start()
    self._conn = RunService.Heartbeat:Connect(function(dt)
        local now = os.clock()
        local remove = {}
        for i, t in ipairs(self._tasks) do
            if now - t.last >= t.interval then
                t.last = now
                local ok, err = pcall(t.callback, dt)
                if not ok then
                    warn("[Scheduler] Lỗi tác vụ #" .. t.id .. ": " .. tostring(err))
                end
                if t.once then
                    table.insert(remove, i)
                end
            end
        end
        -- Xóa tác vụ một lần từ cuối lên đầu
        for i = #remove, 1, -1 do
            table.remove(self._tasks, remove[i])
        end
    end)
end

-- Chạy callback mỗi `interval` giây
function TaskScheduler:Every(interval, callback)
    self._nextId += 1
    local id = self._nextId
    table.insert(self._tasks, {
        id       = id,
        interval = interval,
        last     = os.clock(),
        callback = callback,
        once     = false,
    })
    return id
end

-- Chạy callback sau `delay` giây (một lần)
function TaskScheduler:After(delay, callback)
    self._nextId += 1
    local id = self._nextId
    table.insert(self._tasks, {
        id       = id,
        interval = delay,
        last     = os.clock(),
        callback = callback,
        once     = true,
    })
    return id
end

-- Chạy ở frame tiếp theo
function TaskScheduler:NextFrame(callback)
    return self:After(0, callback)
end

-- Huỷ tác vụ theo id
function TaskScheduler:Cancel(id)
    for i, t in ipairs(self._tasks) do
        if t.id == id then
            table.remove(self._tasks, i)
            return true
        end
    end
    return false
end

function TaskScheduler:Destroy()
    if self._conn then self._conn:Disconnect() end
    self._tasks = {}
end

local Scheduler = TaskScheduler.new()

-- ─────────────────────────────────────────────
-- 8. NETWORK OPTIMIZER
-- ─────────────────────────────────────────────
local NetworkOptimizer = {}
NetworkOptimizer.__index = NetworkOptimizer

--[[
    Giảm tần suất gửi RemoteEvent trên mobile để tiết kiệm băng thông.
    Thay vì gửi mỗi frame, gộp và gửi theo batch.
]]

function NetworkOptimizer.new(remote, batchInterval)
    local self = setmetatable({
        _remote   = remote,          -- RemoteEvent hoặc RemoteFunction
        _queue    = {},
        _interval = batchInterval or 0.1,  -- giây
        _taskId   = nil,
    }, NetworkOptimizer)
    self:_startBatch()
    return self
end

function NetworkOptimizer:_startBatch()
    self._taskId = Scheduler:Every(self._interval, function()
        if #self._queue == 0 then return end
        local batch = self._queue
        self._queue = {}
        -- Gửi toàn bộ batch một lần
        self._remote:FireServer(batch)
    end)
end

-- Đưa dữ liệu vào hàng đợi thay vì gửi ngay
function NetworkOptimizer:Send(data)
    table.insert(self._queue, {
        data = data,
        time = os.clock(),
    })
end

function NetworkOptimizer:Destroy()
    if self._taskId then Scheduler:Cancel(self._taskId) end
    self._queue = {}
end

-- ─────────────────────────────────────────────
-- 9. VÍ DỤ TÍCH HỢP THỰC TẾ
-- ─────────────────────────────────────────────

-- 9A. Tự động ẩn/hiện HUD khi người dùng không tương tác
local function SetupAutoHideHUD(hudFrame, hideDelay)
    hideDelay = hideDelay or 3
    local lastInteract = os.clock()
    local hidden = false

    local function showHUD()
        if hidden then
            TweenService:Create(hudFrame,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad),
                { GroupTransparency = 0 }
            ):Play()
            hidden = false
        end
        lastInteract = os.clock()
    end

    local function hideHUD()
        if not hidden then
            TweenService:Create(hudFrame,
                TweenInfo.new(0.5, Enum.EasingStyle.Quad),
                { GroupTransparency = 0.8 }
            ):Play()
            hidden = true
        end
    end

    -- Lắng nghe touch để reset timer
    Bus:on("TouchDown", showHUD)
    Bus:on("Tap", showHUD)

    -- Kiểm tra mỗi giây
    Scheduler:Every(1, function()
        if os.clock() - lastInteract > hideDelay then
            hideHUD()
        end
    end)
end

-- 9B. Joystick ảo đơn giản (chỉ logic, không kèm UI)
local function CreateVirtualJoystick(outerFrame, innerFrame)
    local dragging   = false
    local origin     = Vector2.new(0, 0)
    local maxRadius  = outerFrame.AbsoluteSize.X / 2
    local direction  = Vector2.new(0, 0)

    outerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            origin = Vector2.new(
                outerFrame.AbsolutePosition.X + maxRadius,
                outerFrame.AbsolutePosition.Y + maxRadius
            )
        end
    end)

    outerFrame.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local raw = Vector2.new(input.Position.X, input.Position.Y) - origin
            local clamped = raw.Magnitude > maxRadius
                            and raw.Unit * maxRadius
                            or  raw
            direction = raw.Magnitude > 0 and raw.Unit or Vector2.new(0, 0)

            innerFrame.Position = UDim2.new(0.5, clamped.X, 0.5, clamped.Y)
            Bus:emit("JoystickMoved", direction)
        end
    end)

    outerFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging  = false
            direction = Vector2.new(0, 0)
            innerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
            Bus:emit("JoystickReleased")
        end
    end)

    return {
        GetDirection = function() return direction end,
        IsActive     = function() return dragging end,
    }
end

-- 9C. Pinch to zoom camera
local function SetupPinchZoom(minFOV, maxFOV)
    minFOV = minFOV or 20
    maxFOV = maxFOV or 90
    local baseFOV = Camera.FieldOfView

    Bus:on("Pinch", function(scale, velocity, state)
        if state == Enum.UserInputState.Change then
            local newFOV = baseFOV / scale
            Camera.FieldOfView = math.clamp(newFOV, minFOV, maxFOV)
        elseif state == Enum.UserInputState.End then
            baseFOV = Camera.FieldOfView
        end
    end)
end

-- 9D. Tự động lưu dữ liệu người chơi mỗi 60 giây
local function SetupAutoSave(saveCallback)
    local saveId = Scheduler:Every(60, function()
        local ok, err = pcall(saveCallback)
        if ok then
            print("[AutoSave] Đã lưu dữ liệu – " .. os.date("%X"))
        else
            warn("[AutoSave] Lỗi lưu: " .. tostring(err))
        end
    end)
    print("[AutoSave] Đã bật – lưu mỗi 60 giây (taskId=" .. saveId .. ")")
    return saveId
end

-- ─────────────────────────────────────────────
-- 10. PUBLIC API – xuất các module
-- ─────────────────────────────────────────────
local RobloxMobileKit = {
    -- Core
    Bus          = Bus,
    Device       = Device,
    Scheduler    = Scheduler,

    -- Managers
    Performance  = Perf,
    Input        = Input,

    -- Classes (khởi tạo thủ công)
    ObjectPool        = ObjectPool,
    UIAutoScaler      = UIAutoScaler,
    NetworkOptimizer  = NetworkOptimizer,

    -- Helpers sẵn dùng
    SetupAutoHideHUD  = SetupAutoHideHUD,
    CreateVirtualJoystick = CreateVirtualJoystick,
    SetupPinchZoom    = SetupPinchZoom,
    SetupAutoSave     = SetupAutoSave,
}

-- ─────────────────────────────────────────────
-- LOG KHỞI ĐỘNG
-- ─────────────────────────────────────────────
print(string.format(
    "[RobloxMobileKit] Đã khởi động | Mobile: %s | Tablet: %s | Màn hình: %dx%d",
    tostring(Device.isMobile),
    tostring(Device.isTablet),
    Device.screenSize.X,
    Device.screenSize.Y
))

-- ─────────────────────────────────────────────
-- HƯỚNG DẪN SỬ DỤNG NHANH
-- ─────────────────────────────────────────────
--[[
    === CÁCH DÙNG ===

    -- 1. Require module này (hoặc paste vào LocalScript)
    local Kit = require(path.to.this.module)

    -- 2. Lắng nghe gesture
    Kit.Input:OnGesture("Tap",       function(pos) print("Tap tại", pos) end)
    Kit.Input:OnGesture("Swipe",     function(dir) print("Swipe", dir) end)
    Kit.Input:OnGesture("LongPress", function(pos) print("Giữ tại", pos) end)
    Kit.Input:OnGesture("Pinch",     function(scale) print("Zoom", scale) end)

    -- 3. Lên lịch tác vụ
    Kit.Scheduler:Every(10, function() print("Chạy mỗi 10 giây") end)
    Kit.Scheduler:After(5,  function() print("Chạy sau 5 giây")  end)

    -- 4. Object Pool
    local Pool = Kit.ObjectPool.new(function()
        return Instance.new("Part")
    end, 20)
    local p = Pool:Get()
    -- ...dùng xong...
    Pool:Return(p)

    -- 5. Auto scale UI
    local scaler = Kit.UIAutoScaler.new(script.Parent.ScreenGui)

    -- 6. Auto save
    Kit.SetupAutoSave(function()
        -- DataStore save logic ở đây
    end)

    -- 7. Pinch zoom
    Kit.SetupPinchZoom(30, 80)

    -- 8. FPS hiện tại
    print("FPS:", Kit.Performance.currentFPS)

    -- 9. Kiểm tra thiết bị
    if Kit.Device.isMobile then
        -- Hiển thị UI mobile
    end
]]

return RobloxMobileKit
