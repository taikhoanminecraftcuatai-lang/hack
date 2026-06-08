local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "MenuGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút mở
local openBtn = Instance.new("TextButton")
openBtn.Parent = gui
openBtn.Size = UDim2.new(0,100,0,40)
openBtn.Position = UDim2.new(0,10,0,10)
openBtn.Text = "Mở Menu"

-- Khung menu
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,300,0,200)
frame.Position = UDim2.new(0.5,-150,0.5,-100)
frame.Visible = false

-- Nút đóng
local closeBtn = Instance.new("TextButton")
closeBtn.Parent = frame
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.Text = "MENU"

-- Mở menu
openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
end)

-- Đóng menu
closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	openBtn.Visible = true
end)
local player = game.Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "AutoZGui"
gui.Parent = player:WaitForChild("PlayerGui")

-- Nút Auto Z
local autoBtn = Instance.new("TextButton")
autoBtn.Parent = gui
autoBtn.Size = UDim2.new(0, 120, 0, 40)
autoBtn.Position = UDim2.new(0, 20, 0, 100)
autoBtn.Text = "Auto Z : OFF"

-- Ô nhập thời gian
local timeBox = Instance.new("TextBox")
timeBox.Parent = gui
timeBox.Size = UDim2.new(0, 60, 0, 40)
timeBox.Position = UDim2.new(0, 150, 0, 100)
timeBox.Text = "0.5"
timeBox.PlaceholderText = "Giây"

local autoZ = false

-- Hàm kỹ năng Z
local function SkillZ()
	print("Dùng kỹ năng Z")
	-- Code kỹ năng Z của mày ở đây
end

autoBtn.MouseButton1Click:Connect(function()
	autoZ = not autoZ

	if autoZ then
		autoBtn.Text = "Auto Z : ON"

		task.spawn(function()
			while autoZ do
				local delayTime = tonumber(timeBox.Text) or 0.5

				SkillZ()

				task.wait(delayTime)
			end
		end)
	else
		autoBtn.Text = "Auto Z : OFF"
	end
end)
