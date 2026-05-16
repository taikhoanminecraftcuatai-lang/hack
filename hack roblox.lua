--// SIMPLE PORTAL A-B SYSTEM
--// LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS =
	game:GetService("UserInputService")
--========================
-- GUI
--========================

local gui = Instance.new("ScreenGui")
gui.Name = "PORTAL_AB_GUI"
gui.Parent = game.CoreGui

-- OPEN BUTTON
local open = Instance.new("TextButton")
open.Parent = gui

open.Size = UDim2.new(0,70,0,70)
open.Position = UDim2.new(0,20,0.5,-35)

open.Text = "MENU"
open.TextScaled = true

open.Font =
	Enum.Font.GothamBold

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
-- KEY SYSTEM
--========================

local correctKey = "tailovuongthanhdehack"

-- USERNAME ĐƯỢC BYPASS KEY
local whitelist = {
	["sidbuddb"] = true
}
-- GUI
local keyGui = Instance.new("ScreenGui")
keyGui.Parent = game.CoreGui

local keyFrame = Instance.new("Frame")
keyFrame.Parent = keyGui

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

keyTitle.Parent = keyFrame

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

-- BUTTON
local enter =
	Instance.new("TextButton")

enter.Parent =
	keyFrame

enter.Size =
	UDim2.new(0.5,0,0,45)

enter.Position =
	UDim2.new(0.25,0,0.7,0)

enter.Text =
	"UNLOCK"

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

-- KIỂM TRA WHITELIST
if whitelist[player.Name] then

	gui.Enabled = true
	keyGui.Enabled = false

else

	gui.Enabled = false
end

-- CHECK KEY
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
-- MAIN FRAME
--========================

local frame = Instance.new("Frame")
frame.Parent = gui

-- GUI TO HƠN
frame.Size =
	UDim2.new(0,520,0,650)

frame.Position =
	UDim2.new(0.5,-260,0.5,-325)

frame.BackgroundColor3 =
	Color3.fromRGB(25,25,25)

frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.BorderSizePixel = 0

Instance.new(
	"UICorner",
	frame
).CornerRadius = UDim.new(0,20)

-- TITLE
local title = Instance.new("TextLabel")
title.Parent = frame

title.Size =
	UDim2.new(1,0,0,65)

title.BackgroundTransparency = 1

title.Text = "PORTAL SYSTEM"

title.TextScaled = true

title.Font =
	Enum.Font.GothamBlack

title.TextColor3 =
	Color3.new(1,1,1)

-- STATUS
local status = Instance.new("TextLabel")
status.Parent = frame

status.Size =
	UDim2.new(0.9,0,0,35)

status.Position =
	UDim2.new(0.05,0,0.11,0)

status.BackgroundTransparency = 1

status.Text = "STATUS : READY"

status.TextScaled = true

status.Font =
	Enum.Font.GothamBold

status.TextColor3 =
	Color3.new(1,1,1)

--========================
-- BUTTON STYLE
--========================

local function makeButton(
	text,
	pos,
	color
)

	local b =
		Instance.new("TextButton")

	b.Parent = frame

	-- NÚT NHỎ LẠI
	b.Size =
		UDim2.new(0.36,0,0,45)

	b.Position = pos

	b.Text = text
	b.TextScaled = true

	b.Font =
		Enum.Font.GothamBold

	b.BackgroundColor3 =
		color

	b.TextColor3 =
		Color3.new(1,1,1)

	b.BorderSizePixel = 0

	Instance.new(
		"UICorner",
		b
	).CornerRadius =
		UDim.new(0,12)

	return b
end

-- BUTTONS
local createA =
	makeButton(
		"CREATE PORTAL A",
		UDim2.new(0.08,0,0.22,0),
		Color3.fromRGB(120,0,255)
	)

local createB =
	makeButton(
		"CREATE PORTAL B",
		UDim2.new(0.56,0,0.22,0),
		Color3.fromRGB(0,170,255)
	)

local noclipButton =
	makeButton(
		"NOCLIP : OFF",
		UDim2.new(0.08,0,0.34,0),
		Color3.fromRGB(255,120,0)
	)

local espButton =
	makeButton(
		"ESP : OFF",
		UDim2.new(0.56,0,0.34,0),
		Color3.fromRGB(255,0,120)
	)

--========================
-- CLICK EFFECT
--========================

local function click(button)

	local old = button.Size

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
click(createA)
click(createB)
click(noclipButton)
click(espButton)

--========================
-- OPEN/CLOSE
--========================

open.MouseButton1Click:Connect(function()

	frame.Visible =
		not frame.Visible
end)

--========================
-- PORTAL SYSTEM
--========================

local portalA
local portalB

local debounce = false

local function createPortal(
	pos,
	color,
	text
)

	local p = Instance.new("Part")

	p.Anchored = true
	p.CanCollide = false

	p.Size =
		Vector3.new(8,10,1)

	p.Material =
		Enum.Material.Neon

	p.Color = color

	p.CFrame =
		CFrame.new(pos)

	p.Parent = workspace

	local ui =
		Instance.new(
			"BillboardGui",
			p
		)

	ui.Size =
		UDim2.new(0,120,0,50)

	ui.AlwaysOnTop = true

	local lbl =
		Instance.new(
			"TextLabel",
			ui
		)

	lbl.Size =
		UDim2.new(1,0,1,0)

	lbl.BackgroundTransparency = 1

	lbl.Text = text
	lbl.TextScaled = true

	lbl.Font =
		Enum.Font.GothamBlack

	lbl.TextColor3 =
		Color3.new(1,1,1)

	return p
end

	local lastTP = {}

local function tp(hit,target)

	local char =
		hit.Parent

	if not char then
		return
	end

	local hum =
		char:FindFirstChild("Humanoid")

	local root =
		char:FindFirstChild(
			"HumanoidRootPart"
		)

	if hum and root then

		if lastTP[char]
		and tick() - lastTP[char] < 2 then
			return
		end

		lastTP[char] = tick()

		root.CFrame =
			target.CFrame
			+ target.CFrame.LookVector * 8
	end
end
--========================
-- CREATE PORTAL A
--========================

createA.MouseButton1Click:Connect(function()

	if portalA then
		portalA:Destroy()
	end

	local char =
		player.Character

	if not char then
		return
	end

	local root =
		char:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	-- TẠO TRƯỚC MẶT PLAYER
	local pos =
		root.Position
		+ root.CFrame.LookVector * 6

	portalA =
		createPortal(
			pos,
			Color3.fromRGB(120,0,255),
			"PORTAL A"
		)

	status.Text =
		"STATUS : PORTAL A CREATED"

	portalA.Touched:Connect(function(hit)

		if portalB then

			tp(hit,portalB)
		end
	end)
end)

--========================
-- CREATE PORTAL B
--========================

createB.MouseButton1Click:Connect(function()

	if portalB then
		portalB:Destroy()
	end

	local char =
		player.Character

	if not char then
		return
	end

	local root =
		char:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	-- TẠO TRƯỚC MẶT PLAYER
	local pos =
		root.Position
		+ root.CFrame.LookVector * 6

	portalB =
		createPortal(
			pos,
			Color3.fromRGB(0,170,255),
			"PORTAL B"
		)

	status.Text =
		"STATUS : PORTAL B CREATED"

	portalB.Touched:Connect(function(hit)

		if portalA then

			tp(hit,portalA)
		end
	end)
end)
--========================
-- NOCLIP
--========================

local noclip = false

noclipButton.MouseButton1Click:Connect(function()

	noclip = not noclip

	if noclip then

		noclipButton.Text =
			"NOCLIP : ON"

		noclipButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		noclipButton.Text =
			"NOCLIP : OFF"

		noclipButton.BackgroundColor3 =
			Color3.fromRGB(255,120,0)
	end
end)

RunService.Stepped:Connect(function()

	if noclip then

		local char =
			player.Character

		if char then

			for _,v in pairs(
				char:GetDescendants()
			) do

				if v:IsA("BasePart") then

					v.CanCollide = false
				end
			end
		end
	end
end)

--========================
-- ESP SYSTEM
--========================

local espEnabled = false
local espObjects = {}

espButton.MouseButton1Click:Connect(function()

	espEnabled =
		not espEnabled

	if espEnabled then

		espButton.Text =
			"ESP : ON"

		espButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		espButton.Text =
			"ESP : OFF"

		espButton.BackgroundColor3 =
			Color3.fromRGB(255,0,120)

		for _,v in pairs(
			espObjects
		) do

			pcall(function()
				v:Destroy()
			end)
		end

		espObjects = {}
	end
end)

local function createESP(plr)

	if plr == player then
		return
	end

	local function setup(char)

		if not espEnabled then
			return
		end

		local root =
			char:FindFirstChild(
				"HumanoidRootPart"
			)

		local hum =
			char:FindFirstChildOfClass(
				"Humanoid"
			)

		if not root
		or not hum then
			return
		end

		local hl =
			Instance.new(
				"Highlight"
			)

		hl.FillColor =
			Color3.fromRGB(255,0,0)

		hl.OutlineColor =
			Color3.new(1,1,1)

		hl.FillTransparency = 0.5

		hl.DepthMode =
			Enum.HighlightDepthMode.AlwaysOnTop

		hl.Parent = char

		table.insert(
			espObjects,
			hl
		)

		local bill =
			Instance.new(
				"BillboardGui"
			)

		bill.Size =
			UDim2.new(0,220,0,70)

		bill.AlwaysOnTop = true

		bill.StudsOffset =
			Vector3.new(0,4,0)

		bill.Parent = root

		table.insert(
			espObjects,
			bill
		)

		local txt =
			Instance.new(
				"TextLabel"
			)

		txt.Parent = bill

		txt.Size =
			UDim2.new(1,0,1,0)

		txt.BackgroundTransparency = 1

		txt.TextScaled = true

		txt.Font =
			Enum.Font.GothamBlack

		txt.TextColor3 =
			Color3.new(1,1,1)

		txt.TextStrokeTransparency = 0

		local ring =
			Instance.new("Part")

		ring.Shape =
			Enum.PartType.Cylinder

		ring.Anchored = true
		ring.CanCollide = false

		ring.Material =
			Enum.Material.Neon

		ring.Color =
			Color3.fromRGB(255,0,0)

		ring.Transparency = 0.3

		ring.Size =
			Vector3.new(0.2,7,7)

		ring.Parent = workspace

		table.insert(
			espObjects,
			ring
		)

		task.spawn(function()

			while espEnabled
			and char
			and char.Parent do

				task.wait()

				txt.Text =
					plr.Name
					.." | HP : "
					..math.floor(
						hum.Health
					)

				for _,p in pairs(
					char:GetDescendants()
				) do

					if p:IsA(
						"BasePart"
					) then

						p.LocalTransparencyModifier = 0
					end
				end

				if root then

					ring.CFrame =
						CFrame.new(
							root.Position
						)
						* CFrame.Angles(
							0,
							tick()*2,
							math.rad(90)
						)
				end
			end
		end)
	end

	if plr.Character then
		setup(plr.Character)
	end

	plr.CharacterAdded:Connect(setup)
end

Players.PlayerAdded:Connect(function(plr)

	if espEnabled then
		createESP(plr)
	end
end)

task.spawn(function()

	while true do

		task.wait(1)

		if espEnabled then

			for _,plr in pairs(
				Players:GetPlayers()
			) do

				createESP(plr)
			end
		end
	end
end)
--========================
-- AIMLOCK SYSTEM
--========================

local aimlock = false
local aimTarget = nil

local camera =
	workspace.CurrentCamera

-- AIMLOCK BUTTON
local aimButton =
	makeButton(
		"AIMLOCK : OFF",
		UDim2.new(0.08,0,0.46,0),
		Color3.fromRGB(0,255,120)
	)

click(aimButton)

-- TOGGLE
aimButton.MouseButton1Click:Connect(function()

	aimlock = not aimlock

	if aimlock then

		aimButton.Text =
			"AIMLOCK : ON"

		aimButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		aimButton.Text =
			"AIMLOCK : OFF"

		aimButton.BackgroundColor3 =
			Color3.fromRGB(0,255,120)

		aimTarget = nil
	end
end)

-- FIND NEAREST PLAYER
local function getNearestPlayer()

	local nearest = nil
	local distance = math.huge

	for _,plr in pairs(
		Players:GetPlayers()
	) do

		if plr ~= player
		and plr.Character
		and plr.Character:FindFirstChild(
			"HumanoidRootPart"
		)
		and plr.Character:FindFirstChild(
			"Humanoid"
		)
		and plr.Character.Humanoid.Health > 0 then

			local targetPos =
				plr.Character
				.HumanoidRootPart.Position

			local myChar =
				player.Character

			if myChar
			and myChar:FindFirstChild(
				"HumanoidRootPart"
			) then

				local myPos =
					myChar
					.HumanoidRootPart.Position

				local dist =
					(targetPos - myPos).Magnitude

				-- CHỈ KHÓA NGƯỜI GẦN
				if dist < 50
				and dist < distance then

					distance = dist
					nearest = plr
				end
			end
		end
	end

	return nearest
end

-- AIMLOCK LOOP
RunService.RenderStepped:Connect(function()

	if aimlock then

		local target =
			getNearestPlayer()

		if target
		and target.Character
		and target.Character:FindFirstChild(
			"Head"
		) then

			aimTarget = target

			local head =
				target.Character.Head

			camera.CFrame =
	camera.CFrame:Lerp(
		CFrame.new(
			camera.CFrame.Position,
			head.Position
		),
		0.18
	)
		end
	end
end)
--========================
-- HEAD LOCK SYSTEM
--========================

local headLockEnabled = false
local headTarget = nil

local headButton =
	makeButton(
		"HEAD LOCK : OFF",
		UDim2.new(0.08,0,0.58,0),
		Color3.fromRGB(0,170,255)
	)

click(headButton)

headButton.MouseButton1Click:Connect(function()

	headLockEnabled =
		not headLockEnabled

	if headLockEnabled then

		headButton.Text =
			"HEAD LOCK : ON"

		headButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		headButton.Text =
			"HEAD LOCK : OFF"

		headButton.BackgroundColor3 =
			Color3.fromRGB(0,170,255)

		headTarget = nil
	end
end)

local function getNearestTarget()

	local nearest = nil
	local distance = math.huge

	local myChar =
		player.Character

	if not myChar
	or not myChar:FindFirstChild(
		"HumanoidRootPart"
	) then
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
		and plr.Character:FindFirstChildOfClass("Humanoid")
		and plr.Character.Humanoid.Health > 0 then

			local dist =
				(
					myRoot.Position
					-
					plr.Character
					.HumanoidRootPart.Position
				).Magnitude

			if dist < 40
			and dist < distance then

				distance = dist
				nearest = plr
			end
		end
	end

	return nearest
end

RunService.RenderStepped:Connect(function()

	if not headLockEnabled then
		return
	end

	local char =
		player.Character

	if not char then
		return
	end

	local root =
		char:FindFirstChild(
			"HumanoidRootPart"
		)

	if not root then
		return
	end

	local target =
		getNearestTarget()

	if target
	and target.Character
	and target.Character:FindFirstChild("Head") then

		local head =
			target.Character.Head

		-- BAY TRÊN ĐẦU
		local pos =
			head.Position
			+ Vector3.new(0,5,0)

		-- AIM VÀO ĐẦU
		root.CFrame =
			CFrame.new(
				pos,
				head.Position
			)
	end
end)--========================
-- SPEED SYSTEM
--========================

local speedEnabled = false
local currentSpeed = 16

local speedButton =
	makeButton(
		"SPEED : OFF",
		UDim2.new(0.08,0,0.70,0),
		Color3.fromRGB(0,255,150)
	)

local speedBox =
	Instance.new("TextBox")

speedBox.Parent = frame

speedBox.Size =
	UDim2.new(0.36,0,0,45)

speedBox.Position =
	UDim2.new(0.56,0,0.70,0)

speedBox.PlaceholderText =
	"SPEED"

speedBox.Text = "16"

speedBox.TextScaled = true

speedBox.Font =
	Enum.Font.GothamBold

speedBox.BackgroundColor3 =
	Color3.fromRGB(40,40,40)

speedBox.TextColor3 =
	Color3.new(1,1,1)

speedBox.BorderSizePixel = 0

Instance.new(
	"UICorner",
	speedBox
).CornerRadius =
	UDim.new(0,12)

click(speedButton)

speedButton.MouseButton1Click:Connect(function()

	speedEnabled =
		not speedEnabled

	if speedEnabled then

		speedButton.Text =
			"SPEED : ON"

		speedButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

	else

		speedButton.Text =
			"SPEED : OFF"

		speedButton.BackgroundColor3 =
			Color3.fromRGB(0,255,150)

		local char =
			player.Character

		if char
		and char:FindFirstChildOfClass(
			"Humanoid"
		) then

			char:FindFirstChildOfClass(
				"Humanoid"
			).WalkSpeed = 16
		end
	end
end)

speedBox.FocusLost:Connect(function()

	local num =
		tonumber(speedBox.Text)

	if num then

		currentSpeed =
			math.clamp(
				num,
				1,
				1e6
			)
	end
end)

RunService.RenderStepped:Connect(function()

	if speedEnabled then

		local char =
			player.Character

		if char
		and char:FindFirstChildOfClass(
			"Humanoid"
		) then

			char:FindFirstChildOfClass(
				"Humanoid"
			).WalkSpeed =
				currentSpeed
		end
	end
end)
--========================
-- GODMODE SYSTEM
--========================

local godEnabled = false

local godButton =
	makeButton(
		"GODMODE : OFF",
		UDim2.new(0.56,0,0.46,0),
		Color3.fromRGB(255,215,0)
	)

click(godButton)

local function enableGodmode()

	local char =
		player.Character

	if not char then
		return
	end

	local hum =
		char:FindFirstChildOfClass(
			"Humanoid"
		)

	if not hum then
		return
	end

	hum.HealthChanged:Connect(function()

		if godEnabled then

			if hum.Health < hum.MaxHealth then

				hum.Health =
					hum.MaxHealth
			end
		end
	end)

	hum:SetStateEnabled(
		Enum.HumanoidStateType.Dead,
		false
	)

	hum.BreakJointsOnDeath = false

	hum.Health =
		hum.MaxHealth
end

godButton.MouseButton1Click:Connect(function()

	godEnabled =
		not godEnabled

	if godEnabled then

		godButton.Text =
			"GODMODE : ON"

		godButton.BackgroundColor3 =
			Color3.fromRGB(255,70,70)

		enableGodmode()

		status.Text =
			"STATUS : GODMODE ENABLED"

	else

		godButton.Text =
			"GODMODE : OFF"

		godButton.BackgroundColor3 =
			Color3.fromRGB(255,215,0)

		status.Text =
			"STATUS : GODMODE DISABLED"
	end
end)

player.CharacterAdded:Connect(function()

	task.wait(1)

	if godEnabled then
		enableGodmode()
	end
end)
