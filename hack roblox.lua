--// SIMPLE GUI + KEY SYSTEM
--// LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--========================
-- MAIN GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "MAIN_GUI"
gui.Parent = game.CoreGui

gui.Enabled = false

--========================
-- OPEN BUTTON
--========================

local open = Instance.new("TextButton")
open.Parent = gui

open.Size = UDim2.new(0,70,0,70)
open.Position = UDim2.new(0,20,0.5,-35)

open.Text = "MENU"
open.TextScaled = true

open.Font = Enum.Font.GothamBlack

open.BackgroundColor3 =
	Color3.fromRGB(35,35,35)

open.TextColor3 =
	Color3.new(1,1,1)

open.BorderSizePixel = 0

open.Active = true
open.Draggable = true

Instance.new(
	"UICorner",
	open
).CornerRadius = UDim.new(1,0)

--========================
-- MAIN FRAME
--========================

local frame = Instance.new("Frame")
frame.Parent = gui

frame.Size =
	UDim2.new(0,450,0,300)

frame.Position =
	UDim2.new(0.5,-225,0.5,-150)

frame.BackgroundColor3 =
	Color3.fromRGB(25,25,25)

frame.Visible = false

frame.Active = true
frame.Draggable = true

frame.BorderSizePixel = 0

Instance.new(
	"UICorner",
	frame
).CornerRadius =
	UDim.new(0,20)

-- TITLE

local title =
	Instance.new("TextLabel")

title.Parent = frame

title.Size =
	UDim2.new(1,0,0,60)

title.BackgroundTransparency = 1

title.Text = "MY SYSTEM"

title.TextScaled = true

title.Font =
	Enum.Font.GothamBlack

title.TextColor3 =
	Color3.new(1,1,1)

-- STATUS

local status =
	Instance.new("TextLabel")

status.Parent = frame

status.Size =
	UDim2.new(1,0,0,40)

status.Position =
	UDim2.new(0,0,0.25,0)

status.BackgroundTransparency = 1

status.Text =
	"STATUS : READY"

status.TextScaled = true

status.Font =
	Enum.Font.GothamBold

status.TextColor3 =
	Color3.new(1,1,1)

--========================
-- KEY SYSTEM
--========================

local correctKey =
	"tailovuong"

local whitelist = {
	["sidbuddb"] = true
}

local keyGui =
	Instance.new("ScreenGui")

keyGui.Parent =
	game.CoreGui

local keyFrame =
	Instance.new("Frame")

keyFrame.Parent =
	keyGui

keyFrame.Size =
	UDim2.new(0,350,0,220)

keyFrame.Position =
	UDim2.new(0.5,-175,0.5,-110)

keyFrame.BackgroundColor3 =
	Color3.fromRGB(25,25,25)

keyFrame.BorderSizePixel = 0

Instance.new(
	"UICorner",
	keyFrame
).CornerRadius =
	UDim.new(0,18)

-- TITLE

local keyTitle =
	Instance.new("TextLabel")

keyTitle.Parent =
	keyFrame

keyTitle.Size =
	UDim2.new(1,0,0,60)

keyTitle.BackgroundTransparency = 1

keyTitle.Text =
	"ENTER KEY"

keyTitle.TextScaled = true

keyTitle.Font =
	Enum.Font.GothamBlack

keyTitle.TextColor3 =
	Color3.new(1,1,1)

-- TEXTBOX

local keyBox =
	Instance.new("TextBox")

keyBox.Parent =
	keyFrame

keyBox.Size =
	UDim2.new(0.8,0,0,50)

keyBox.Position =
	UDim2.new(0.1,0,0.38,0)

keyBox.PlaceholderText =
	"INPUT KEY..."

keyBox.Text = ""

keyBox.TextScaled = true

keyBox.Font =
	Enum.Font.GothamBold

keyBox.BackgroundColor3 =
	Color3.fromRGB(40,40,40)

keyBox.TextColor3 =
	Color3.new(1,1,1)

keyBox.BorderSizePixel = 0

Instance.new(
	"UICorner",
	keyBox
).CornerRadius =
	UDim.new(0,12)

-- ENTER BUTTON

local enter =
	Instance.new("TextButton")

enter.Parent =
	keyFrame

enter.Size =
	UDim2.new(0.5,0,0,45)

enter.Position =
	UDim2.new(0.25,0,0.7,0)

enter.Text = "UNLOCK"

enter.TextScaled = true

enter.Font =
	Enum.Font.GothamBlack

enter.BackgroundColor3 =
	Color3.fromRGB(0,170,255)

enter.TextColor3 =
	Color3.new(1,1,1)

enter.BorderSizePixel = 0

Instance.new(
	"UICorner",
	enter
).CornerRadius =
	UDim.new(0,12)

-- STATUS

local keyStatus =
	Instance.new("TextLabel")

keyStatus.Parent =
	keyFrame

keyStatus.Size =
	UDim2.new(1,0,0,30)

keyStatus.Position =
	UDim2.new(0,0,0.88,0)

keyStatus.BackgroundTransparency = 1

keyStatus.Text =
	"STATUS : WAITING"

keyStatus.TextScaled = true

keyStatus.Font =
	Enum.Font.GothamBold

keyStatus.TextColor3 =
	Color3.new(1,1,1)

--========================
-- WHITELIST
--========================

if whitelist[player.Name] then

	gui.Enabled = true
	keyGui.Enabled = false
end

--========================
-- KEY CHECK
--========================

enter.MouseButton1Click:Connect(function()

	if keyBox.Text == correctKey then

		keyStatus.Text =
			"STATUS : ACCESS GRANTED"

		task.wait(0.5)

		keyGui:Destroy()

		gui.Enabled = true

	else

		keyStatus.Text =
			"STATUS : WRONG KEY"

		keyFrame.BackgroundColor3 =
			Color3.fromRGB(120,0,0)

		task.wait(0.3)

		keyFrame.BackgroundColor3 =
			Color3.fromRGB(25,25,25)
	end
end)

--========================
-- OPEN / CLOSE
--========================

open.MouseButton1Click:Connect(function()

	frame.Visible =
		not frame.Visible
end)

--========================
-- CLICK EFFECT
--========================

local function click(button)

	local old =
		button.Size

	button.MouseButton1Down:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.08),
			{
				Size =
					old - UDim2.new(0,4,0,4)
			}
		):Play()
	end)

	button.MouseButton1Up:Connect(function()

		TweenService:Create(
			button,
			TweenInfo.new(0.08),
			{
				Size = old
			}
		):Play()
	end)
end

click(open)
click(enter)
--========================
-- HARD LOOK LOCK SYSTEM
--========================

local lookEnabled = false
local camera = workspace.CurrentCamera

local lookButton =
	makeButton(
		"LOOK LOCK : OFF",
		UDim2.new(0.32,0,0.25,0),
		Color3.fromRGB(0,170,255)
	)

click(lookButton)

lookButton.MouseButton1Click:Connect(function()

	lookEnabled = not lookEnabled

	if lookEnabled then

		lookButton.Text =
			"LOOK LOCK : ON"

		lookButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		lookButton.Text =
			"LOOK LOCK : OFF"

		lookButton.BackgroundColor3 =
			Color3.fromRGB(0,170,255)
	end
end)

local function getNearestPlayer()

	local nearest = nil
	local distance = math.huge

	local myChar = player.Character

	if not myChar
	or not myChar:FindFirstChild("HumanoidRootPart") then
		return nil
	end

	local myRoot =
		myChar.HumanoidRootPart

	for _,plr in pairs(
		Players:GetPlayers()
	) do

		if plr ~= player
		and plr.Character
		and plr.Character:FindFirstChild("Head")
		and plr.Character:FindFirstChild("HumanoidRootPart")
		and plr.Character:FindFirstChild("Humanoid")
		and plr.Character.Humanoid.Health > 0 then

			local dist =
				(
					myRoot.Position
					-
					plr.Character
					.HumanoidRootPart.Position
				).Magnitude

			if dist < distance then

				distance = dist
				nearest = plr
			end
		end
	end

	return nearest
end

RunService.RenderStepped:Connect(function()

	if not lookEnabled then
		return
	end

	local target =
		getNearestPlayer()

	if target
	and target.Character
	and target.Character:FindFirstChild("Head") then

		local head =
			target.Character.Head

		-- LOCK CỨNG CAMERA
		camera.CFrame =
			CFrame.new(
				camera.CFrame.Position,
				head.Position
			)

		-- KHÓA CHUỘT
		UIS.MouseBehavior =
			Enum.MouseBehavior.LockCenter
	end
end)

UIS.InputEnded:Connect(function()

	if not lookEnabled then

		UIS.MouseBehavior =
			Enum.MouseBehavior.Default
	end
end)
