-- === HỆ THỐNG KEY (CHỈ NGƯỜI CÓ KEY MỚI XÀI ĐƯỢC) ===
local player = game.Players.LocalPlayer
local yourUserID = player.UserId  -- Thay số này thành ID của bạn

-- DANH SÁCH USER ID ĐƯỢC MIỄN NHẬP KEY (bỏ trống key của họ)
local whitelist = {
    3410814241,  -- Thay bằng User ID của bạn
    -- Thêm ID người khác nếu muốn, mỗi ID cách nhau bằng dấu phẩy
}

-- KEY đúng (đổi thành key bạn muốn)
local correctKey = "tailovuong"

-- Kiểm tra nếu user nằm trong whitelist thì khỏi cần key
local isWhitelisted = false
for _, id in pairs(whitelist) do
    if player.UserId == id then
        isWhitelisted = true
        break
    end
end

-- Nếu KHÔNG trong whitelist thì yêu cầu nhập key
if not isWhitelisted then
    -- Tạo cửa sổ nhập key
    local keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeySystem"
    keyGui.Parent = player:WaitForChild("PlayerGui")
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(0, 300, 0, 150)
    bg.Position = UDim2.new(0.5, -150, 0.5, -75)
    bg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    bg.BorderSizePixel = 0
    bg.Parent = keyGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = bg
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    title.Text = "🔐 NHẬP KEY"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = bg
    
    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0, 200, 0, 35)
    keyBox.Position = UDim2.new(0.5, -100, 0.35, 0)
    keyBox.PlaceholderText = "Nhập key vào đây..."
    keyBox.Text = ""
    keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 14
    keyBox.Parent = bg
    
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(0, 100, 0, 35)
    submitBtn.Position = UDim2.new(0.5, -50, 0.7, 0)
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
    submitBtn.Text = "VÀO"
    submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 14
    submitBtn.Parent = bg
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = submitBtn
    
    local errorText = Instance.new("TextLabel")
    errorText.Size = UDim2.new(1, 0, 0, 25)
    errorText.Position = UDim2.new(0, 0, 0.55, 0)
    errorText.BackgroundTransparency = 1
    errorText.Text = ""
    errorText.TextColor3 = Color3.fromRGB(255, 100, 100)
    errorText.Font = Enum.Font.Gotham
    errorText.TextSize = 12
    errorText.Parent = bg
    
    -- Biến để chặn script chạy tiếp
    local accessGranted = false
    
    submitBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == correctKey then
            accessGranted = true
            keyGui:Destroy()
            print("✅ Key đúng! Đang tải GUI...")
            -- Gọi load GUI ở đây (chỗ code GUI của bạn)
            loadGUI()  -- Hàm này bạn sẽ tạo bên dưới
        else
            errorText.Text = "❌ Key sai! Thử lại."
            keyBox.Text = ""
        end
    end)
    
    -- Chờ đến khi key đúng thì mới chạy tiếp
    repeat task.wait() until accessGranted == true
else
    print("✅ Bạn trong whitelist, không cần nhập key!")
    loadGUI()
end

-- === HÀM ĐỂ TẢI GUI (bỏ toàn bộ code GUI cũ của bạn vào đây) ===
function loadGUI()
    -- ===== DÁN TOÀN BỘ CODE GUI CỦA BẠN VÀO ĐÂY =====
    -- (Code GUI rỗng hoặc code có nút ở bên trên)

end
-- Tạo GUI chính
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ToolGUI"
gui.Parent = player:WaitForChild("PlayerGui")

-- === ICON MỞ GUI ===
local icon = Instance.new("TextButton")
icon.Size = UDim2.new(0, 45, 0, 45)
icon.Position = UDim2.new(0.85, 0, 0.05, 0)
icon.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
icon.Text = "⚙️"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextSize = 24
icon.Font = Enum.Font.GothamBold
icon.BorderSizePixel = 0
icon.Parent = gui

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(1, 0)
iconCorner.Parent = icon

-- === MAIN GUI (ẩn ban đầu) ===
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 340)
mainFrame.Position = UDim2.new(0.5, -130, 0.45, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

-- === THANH TIÊU ĐỀ ===
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -30, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Tool Hub"
titleText.TextColor3 = Color3.fromRGB(230, 230, 255)
titleText.Font = Enum.Font.GothamSemibold
titleText.TextSize = 14
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Nút đóng
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 1, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- === KHU VỰC ĐỂ NÚT (ĐỂ TRỐNG) ===
-- Bạn tự thêm nút vào đây, ví dụ:

-- local myButton = Instance.new("TextButton")
-- myButton.Size = UDim2.new(0, 220, 0, 40)
-- myButton.Position = UDim2.new(0.5, -110, 0.2, 0)
-- myButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
-- myButton.Text = "Nút của bạn"
-- myButton.TextColor3 = Color3.fromRGB(255, 255, 255)
-- myButton.Font = Enum.Font.Gotham
-- myButton.TextSize = 13
-- myButton.Parent = mainFrame
-- 
-- local btnCorner = Instance.new("UICorner")
-- btnCorner.CornerRadius = UDim.new(0, 6)
-- btnCorner.Parent = myButton

-- === MỞ GUI KHI NHẤN ICON ===
icon.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

print("✅ GUI rỗng đã sẵn sàng! Bạn tự thêm nút tính năng vào nhé.")
