-- сделать ооп
repeat wait() until game.Loaded
local isLoaded = false

function defaultFunction(...)
	return ...
end

local fireTouchInterest = firetouchinterest or defaultFunction
local getSenv = getsenv or defaultFunction
local hookFunction = hookfunction or defaultFunction
local hookMetaMethod = hookmetamethod or defaultFunction
local checkCaller = checkcaller or defaultFunction
local getNameCallMethod = getnamecallmethod or defaultFunction
local newCClosure = newcclosure or defaultFunction
local fireClickDetector = fireclickdetector or defaultFunction

local getGlobal = getgenv or function()
	return _G -- когда надо будет всё перенести эту строчку надо убрать для безопасности
end

if getGlobal().__CHLENIX ~= nil then return end
local SYN = syn or {}
local protectGui = SYN.protect_gui or defaultFunction

local CHLX_DEBUG = true

getGlobal().__CHLENIX = {
	__DEBUG = CHLX_DEBUG; 
	__SETTINGS = {
		Language = "English"
	};
	__WORKSPACE = {};
}

-- Services
local playersService = game:GetService('Players')
local replicatedStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService('TweenService')
local marketService = game:GetService('MarketplaceService')
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
-- Variables
local localPlayer = playersService.LocalPlayer
local playerGui = localPlayer:FindFirstChildWhichIsA("PlayerGui")
local backPack = localPlayer:FindFirstChildWhichIsA("Backpack")
local character = localPlayer.Character
local humanoid = character:FindFirstChildWhichIsA("Humanoid")
-- Functions
function createTween(twnObject, ts, easDir, easStl, twnSet)
	if type(easDir) == "string" then 
		easDir = Enum.EasingDirection[easDir] 
	end
	if type(easStl) == "string" then 
		easStl = Enum.EasingStyle[easStl] 
	end
	local tweenInfo = TweenInfo.new(tonumber(ts), easStl, easDir)
	return tweenService:Create(twnObject, tweenInfo, twnSet)
end
function randomstring(len)
	local length = len or math.random(20,40)
	local str = ""
	for i = 1,length do
		str = str..string.char(math.random(32,126))
	end
	return str
end
function OBJ_Dragger(object)
	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPos = nil

	local function update(input)
		local delta = input.Position - dragStart
		local SmoothDrag = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		createTween(object, 0.05, "InOut", "Sine", {Position = SmoothDrag}):Play()
	end

	object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	object.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	userInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging and object.Size then
			update(input)
		end
	end)
end
-- hub loader
local LO_GUI = Instance.new("ScreenGui")
local LO_Base = Instance.new("Frame")
local LO_UICorner = Instance.new("UICorner")
local LO_HubName = Instance.new("TextLabel")
local LO_LoadHolder = Instance.new("Frame")
local LO_Runner = Instance.new("Frame")
local LO_UIListLayout = Instance.new("UIListLayout")
local LO_UIPadding = Instance.new("UIPadding")

LO_GUI.Name = randomstring()
LO_GUI.Parent = coreGui
LO_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LO_GUI.ResetOnSpawn = false

LO_Base.Name = randomstring()
LO_Base.Parent = LO_GUI
LO_Base.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
LO_Base.Position = UDim2.new(0.5, 0, 0.90, 0)
LO_Base.Size = UDim2.new(0, 250, 0, 40)
LO_Base.AnchorPoint = Vector2.new(0.5, 0.5)

LO_UICorner.CornerRadius = UDim.new(0, 3)
LO_UICorner.Parent = LO_Base

LO_HubName.Name = randomstring()
LO_HubName.Parent = LO_Base
LO_HubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LO_HubName.BackgroundTransparency = 1.000
LO_HubName.BorderSizePixel = 2
LO_HubName.Position = UDim2.new(0.0200959481, 0, 0, 0)
LO_HubName.Size = UDim2.new(0, 238, 0, 16)
LO_HubName.Font = Enum.Font.SourceSansBold
LO_HubName.Text = "CHLENIX"
LO_HubName.TextColor3 = Color3.fromRGB(255, 255, 255)
LO_HubName.TextSize = 14.000
LO_HubName.TextXAlignment = Enum.TextXAlignment.Left
LO_HubName.LayoutOrder = 1

LO_LoadHolder.Name = randomstring()
LO_LoadHolder.Parent = LO_Base
LO_LoadHolder.BackgroundColor3 = Color3.fromRGB(168, 17, 255)
LO_LoadHolder.BorderSizePixel = 0
LO_LoadHolder.ClipsDescendants = true
LO_LoadHolder.Position = UDim2.new(0.0240000002, 0, 0.400000006, 0)
LO_LoadHolder.Size = UDim2.new(0, 238, 0, 17)
LO_LoadHolder.LayoutOrder = 2

LO_Runner.Name = randomstring()
LO_Runner.Parent = LO_LoadHolder
LO_Runner.BackgroundColor3 = Color3.fromRGB(104, 11, 158)
LO_Runner.BorderSizePixel = 0
LO_Runner.Size = UDim2.new(0, 60, 0, 17)
LO_Runner.ZIndex = 3

LO_UIListLayout.Parent = LO_Base
LO_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
LO_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

LO_UIPadding.Parent = LO_Base
LO_UIPadding.PaddingBottom = UDim.new(0, 5)
LO_UIPadding.PaddingLeft = UDim.new(0, 5)
LO_UIPadding.PaddingRight = UDim.new(0, 5)

protectGui(LO_GUI)

coroutine.resume(coroutine.create(function()
	local LO_Debounce = 0
	repeat
		LO_Runner.Position = UDim2.new(-0.252, 0, 0, 0)
		local daTween = createTween(LO_Runner, .7, "In", "Linear", {Position = UDim2.new(1, 0, 0, 0)})
		daTween:Play()
		daTween.Completed:Wait()
		LO_Debounce = LO_Debounce + 1
	until LO_Debounce >= 3 and isLoaded == true
	createTween(LO_Base, .1, "In", "Sine", {Position = UDim2.new(0.5, 0, 1.1, 0), Transparency = 1}):Play()
	wait(.1)
	LO_GUI:Destroy()
end))

local CHLXBuilder = loadstring(game:HttpGet(('https://raw.githubusercontent.com/LastickSosiskin/Chlenix/main/CHLXBuilder.lua'),true))() --require(script.Parent.CHLXBuilder)
local notifFramework = CHLXBuilder.NotificationFramework
local hubFramework = CHLXBuilder.HubFramework

local notifFr = notifFramework.Initialize()
notifFr.createNotify = CHLXBuilder.InterfaceLib.createNotify
-- Hub Creation
local hubMain = hubFramework.Initialize()
hubMain:toggleWindow(true)
-- universal
local unvPage = hubMain:newPage()
hubMain:newContextMenuButton("UNV").MouseButton1Down:Connect(unvPage.switchTo)
local characterCat = unvPage:newCategory("Character")
local cWSB = characterCat:newCheckbox("WalkSpeed Enabled")
local cJPB = characterCat:newCheckbox("JumpPower Enabled")
local speedChange = characterCat:newTextbox("WalkSpeed")
local jumpChange = characterCat:newTextbox("JumpPower")

speedChange.TextBox.Text = humanoid.WalkSpeed
jumpChange.TextBox.Text = humanoid.JumpPower

speedChange.func = function(input)
	if not tonumber(input) then
		speedChange.TextBox.Text = localPlayer.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed
	end
end
jumpChange.func = function(input)
	if not tonumber(input) then
		jumpChange.TextBox.Text = localPlayer.Character:FindFirstChildWhichIsA("Humanoid").JumpPower
	end
end

local oldSpeed = humanoid.WalkSpeed
local oldJumpPower = humanoid.JumpPower

cWSB.OnCheckFunc = function()
	coroutine.resume(coroutine.create(function()
		oldSpeed = humanoid.WalkSpeed
		while cWSB.Checked == true do
			localPlayer.Character:FindFirstChildWhichIsA("Humanoid").WalkSpeed = speedChange:GetText()
			wait()
		end
	end))
end

cWSB.OnUnCheckFunc = function()
	humanoid.WalkSpeed = oldSpeed
end

cJPB.OnCheckFunc = function()
	coroutine.resume(coroutine.create(function()
		oldJumpPower = humanoid.JumpPower
		while cJPB.Checked == true do
			humanoid.JumpPower = jumpChange:GetText()
			wait()
		end
	end))
end

cJPB.OnUnCheckFunc = function()
	humanoid.JumpPower = oldJumpPower
end

local OldIndex = nil
OldIndex = hookMetaMethod(game, "__index", newCClosure(function(Self, Key)
	if not checkCaller() and Self == humanoid then
		if Key == "WalkSpeed" and cWSB.Checked == true then
			return 16
		end
		if Key == "JumpPower" and cJPB.Checked == true then
			return 50
		end
	end

	return OldIndex(Self, Key)
end))

local detectedGame = false
if game.PlaceId == 537413528 then
	detectedGame = true

	local teamZones = {}
	for i,v in pairs(workspace:GetChildren()) do
		if string.find(v.Name, "Zone") and v:FindFirstChild("TeamColor") then
			table.insert(teamZones, v)
		end
	end

	local function destroyGlue(plr)
		for i,v in pairs(workspace:GetChildren()) do
			if v.Name == "Glue" and v:IsA("Model") and v:FindFirstChildWhichIsA("ClickDetector") and (plr == true or playersService:FindFirstChild(v.Tag.Value) == plr) then
				fireClickDetector(v.ClickDetector)
			end
		end
	end

	local page = hubMain:newPage()
	local contxb = hubMain:newContextMenuButton("BBFT")
	contxb.MouseButton1Down:Connect(page.switchTo)
	-- General
	local generalCategory = page:newCategory("General")
	local noglue = generalCategory:newDropdown("Destroy glue")
	local antiIsolation = generalCategory:newOneTimePressButton("Anti-Isolation")

	noglue:AddOption("Everyone (in the server)", function()
		destroyGlue(true)
	end)

	for i,v in pairs(playersService:GetPlayers()) do
		noglue:AddOption(v.Name, function()
			destroyGlue(v)
		end)
	end

	playersService.PlayerAdded:Connect(function(v)
		noglue:AddOption(v.Name, function()
			destroyGlue(v)
		end)
	end)

	playersService.PlayerRemoving:Connect(function(v)
		noglue:RemoveOption(v.Name)
	end)

	antiIsolation.MouseButton1Down:Connect(function()
		notifFr:Notify("Removed all currently existing Isolation Mode boundaries. Click again to remove new ones", 5)
		for i,v in pairs(teamZones) do
			if v:FindFirstChild("Lock") and v.Lock:FindFirstChild("Part") then
				v.Lock.Part:Destroy()
			end
		end
	end)

	-- Autofarm
	local autoFarmCategory = page:newCategory("Autofarm")
	local aFCB = autoFarmCategory:newCheckbox("Enabled")
	local delayTB = autoFarmCategory:newTextbox("Delay")
	local afPriority = "Gold"

	delayTB.TextBox.Text = 2
	delayTB.func = function(input)
		if not tonumber(input) or input == "" or string.find(input, " ") then
			delayTB.TextBox.Text = 2
		end
	end

	local timeNeededToOpenChest = 15
	local stages = workspace.BoatStages.NormalStages
	local toTouch = {}
	for i,v in pairs(stages:GetChildren()) do
		if stages:FindFirstChild("CaveStage"..i) then
			table.insert(toTouch, stages["CaveStage"..i].DarknessPart)
		else
			break
		end
	end

	aFCB.OnCheckFunc = function()
		notifFr:Notify("Autofarm started", 3)

		local moneyBefore = localPlayer.Data.Gold.Value
		local cycleCount = 0

		local GC = getconnections or get_signal_cons
		if GC then
			for i,v in pairs(GC(localPlayer.Idled)) do
				if v["Disable"] then
					v["Disable"](v)
				elseif v["Disconnect"] then
					v["Disconnect"](v)
				end
			end
		else
			localPlayer.Idled:Connect(function()
				local VirtualUser = game:GetService("VirtualUser")
				VirtualUser:CaptureController()
				VirtualUser:ClickButton2(Vector2.new())
			end)
		end

		local function repeatProcces()
			character:WaitForChild("HumanoidRootPart")

			local AFcharacter = localPlayer.Character
			humanoid = character:FindFirstChildWhichIsA("Humanoid")

			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

			local bodyVelocityForce = Instance.new("BodyVelocity")
			bodyVelocityForce.Parent = humanoidRootPart
			bodyVelocityForce.Velocity = Vector3.new(0, 0, 0)

			local autoFarmWorks = true

			character.AncestryChanged:connect(function(Self, newParent)
				if newParent ~= workspace then
					notifFr:Notify("[AF]: Cycle Error, character.Parent ~= workspace", 3)
					autoFarmWorks = false
				end
			end)

			character.ChildRemoved:connect(function(v)
				if v == humanoidRootPart or v == humanoid then
					notifFr:Notify("[AF]: Cycle Error, humanoid or humanoidRootPart removed", 3)
					autoFarmWorks = false
				end
			end)

			humanoid.Died:connect(function()
				notifFr:Notify("[AF]: Cycle Error, humanoid died", 3)
				autoFarmWorks = false
			end)

			humanoid.PlatformStand = true

			local autoFarmFunctions = {
				["Gold"] = function()
					for i,v in pairs(toTouch) do
						if autoFarmWorks == false then
							notifFr:Notify("[AF]: Cycle Break", 3)
							break
						end
						createTween(humanoidRootPart, delayTB:GetText(), Enum.EasingDirection.In, Enum.EasingStyle.Linear, {CFrame = v.CFrame}):Play()
						wait(delayTB:GetText())
					end

					if autoFarmWorks == false then
						return
					end

					humanoidRootPart.CFrame = stages.TheEnd.GoldenChest.Trigger.CFrame
					fireTouchInterest(stages.TheEnd.GoldenChest.Trigger, humanoidRootPart, 0)
					wait(timeNeededToOpenChest + 1)

					if localPlayer.Character == AFcharacter then
						notifFr:Notify("[AF]: Cycle Error, the chest wasn't opening for too much", 3)
						localPlayer.Character:BreakJoints()
					end
				end;
				["GBlocks"] = function()
					for i = 1, 3, 1 do
						if autoFarmWorks == false then
							notifFr:Notify("[AF]: Cycle Break", 3)
							break
						end
						createTween(humanoidRootPart, delayTB:GetText(), Enum.EasingDirection.In, Enum.EasingStyle.Linear, {CFrame = toTouch[i].CFrame}):Play()
						wait(delayTB:GetText())
					end

					if autoFarmWorks == false then
						return
					end

					humanoidRootPart.CFrame = stages.TheEnd.GoldenChest.Trigger.CFrame
					fireTouchInterest(stages.TheEnd.GoldenChest.Trigger, humanoidRootPart, 0)
					wait(timeNeededToOpenChest + 1)

					if localPlayer.Character == AFcharacter then
						notifFr:Notify("[AF]: Cycle Error, the chest wasn't opening for too much", 3)
						localPlayer.Character:BreakJoints()
					end
				end
			}

			autoFarmFunctions[afPriority]()
		end
		aFCB.OnUnCheckFunc = function()
			character:BreakJoints()
		end

		local autoFarmCheck = nil
		autoFarmCheck = localPlayer.CharacterAdded:connect(function()
			if aFCB.Checked == false then
				notifFr:Notify("Earned " .. localPlayer.Data.Gold.Value - moneyBefore .. " in ".. cycleCount .. " cycles. Took ".. cycleCount * (timeNeededToOpenChest + 1 + delayTB:GetText() * #toTouch) .. " seconds", 5)
				autoFarmCheck:Disconnect()
				return
			end
			cycleCount = cycleCount + 1
			localPlayer.Character:WaitForChild("HumanoidRootPart")
			wait(0.05)
			repeatProcces()
		end)

		localPlayer.Character:BreakJoints()
	end
elseif game.PlaceId == 850917308 then
	detectedGame = true
	-- Gui Variables
	local page = hubMain:newPage()
	local general = page:newCategory("General")
	local contxb = hubMain:newContextMenuButton("LB2")
	contxb.MouseButton1Down:Connect(page.switchTo)
	local medHeal = general:newCheckbox("Meditation Heal")
	local antiFreezeCB = general:newCheckbox("Anti-Freeze")
	local infiniteStaminaOTP = general:newOneTimePressButton("Infinite Stamina")
	local infiniteForceOTP = general:newOneTimePressButton("Infinite Force")
	local unlockForce = general:newOneTimePressButton("Unlock All Powers")
	local combatAssistCat = page:newCategory("Combat Assist")
	local protectusBotusCB = combatAssistCat:newCheckbox("Protection Bot")
	local megaHit = combatAssistCat:newCheckbox("Unblockable Hit")
	-- Variables
	character = localPlayer.Character
	humanoid = character:FindFirstChildWhichIsA("Humanoid")
	local tHeal = replicatedStorage:FindFirstChild("Events"):FindFirstChild("toggleHealing")
	local Lightsaber = character:FindFirstChild("Lightsaber") or backPack:WaitForChild("Lightsaber")
	local Assets = Lightsaber.Assets
	local Eventz = Assets.Events
	local updStance = Eventz.updateStance
	local atkStart = Eventz.attackStart
	local target = Lightsaber.combatData.Target
	local targetS = 90
	local saberClient = Lightsaber.Client
	local forceClient = backPack.Force.Client
	local sClientEnv = getSenv(saberClient)
	local fClientEnv = getSenv(forceClient)
	-- Functions
	local aFCon = nil
	local function antiFreeze()
		if aFCon ~= nil then
			aFCon:Disconnect()
		end
		aFCon = character.HumanoidRootPart.ChildAdded:connect(function(v)
			if antiFreezeCB.Checked == false then
				aFCon:Disconnect()
				return
			end
			if v:IsA('BodyGyro') and v.Name == "FakeBPVelocity" then
				v.MaxTorque = Vector3.new(0,0,0)
			elseif v:IsA("BodyPosition") and v.Name == "forceFreezeEffect" or v.Name == "forceChokeEffect" then
				v.MaxForce = Vector3.new(0,0,0)
			end 
		end)
	end

	function infiniteForce()
		local fenv = getfenv(fClientEnv.canUse)
		fenv.forceLevel = math.huge
		setfenv(fClientEnv.canUse, fenv)
		hookFunction(fClientEnv.regenForce, function()
			return
		end)
	end
	function infiniteStamina()
		hookFunction(sClientEnv.getStaminaBoost, function()
			return math.huge
		end)
	end

	local cooldown = .5
	local canAttack = true

	function attackStart(degree)
		if canAttack == false then 
			return 
		end

		local args = {
			[1] = degree,
			[2] = false
		}

		Eventz.attackStart:FireServer(unpack(args))
		canAttack = false
		wait(cooldown)
		canAttack = true
	end

	local function setActive(bool)
		local args = {
			[1] = bool
		}

		Eventz.setActive:FireServer(unpack(args))
	end

	local function cancelAttack()
		Eventz.cancelAttack:FireServer()
	end

	local function toggleBlocking(bool)
		local args = {
			[1] = bool
		}

		Eventz.toggleBlocking:FireServer(unpack(args))
	end
	-- GUI Functions
	infiniteStaminaOTP.MouseButton1Down:Connect(infiniteStamina)
	infiniteForceOTP.MouseButton1Down:Connect(infiniteForce)

	medHeal.OnCheckFunc = function()
		local args = {
			[1] = true
		}

		tHeal:FireServer(unpack(args))
	end
	medHeal.OnUnCheckFunc = function()
		local args = {
			[1] = false
		}

		tHeal:FireServer(unpack(args))
	end

	antiFreezeCB.OnCheckFunc = antiFreeze

	unlockForce.MouseButton1Down:Connect(function()
		local a = playerGui.forcePowers.LocalScript
		local b = getSenv(a)
		local fenv = getfenv(b.frameSetup)
		fenv.myLevel = 9e9
		for idx,val in pairs(fenv.powerData) do
			val.requirement = 0
		end
		setfenv(b.frameSetup, fenv)
	end)

	-- MetaMethod Hook
	local OldNameCall = nil

	OldNameCall = hookMetaMethod(game, "__namecall", newCClosure(function(Self, ...)
		local Args = {...}
		local NamecallMethod = getNameCallMethod()

		if not checkCaller() and NamecallMethod == "FireServer" then
			if Self == updStance and protectusBotusCB.Checked == true then
				local args = {
					[1] = targetS,
					[2] = false
				}
				return OldNameCall(Self,  unpack(args))
			end
			if Self == tHeal and medHeal.Checked == true then
				local args = {
					[1] = true
				}
				return OldNameCall(Self,  unpack(args))
			end
			if Self == atkStart and megaHit.Checked == true then
				local args = {
					[1] = 0/0, --9e9
					[2] = false
				}
				return OldNameCall(Self,  unpack(args))
			end
		elseif not checkCaller() and Self == localPlayer and NamecallMethod == "Kick" then
			return wait(1)
		end

		return OldNameCall(Self, ...)
	end))
	-- Rebuilder
	localPlayer.CharacterAdded:connect(function()
		localPlayer.Character:WaitForChild("HumanoidRootPart")
		Lightsaber = character:FindFirstChild("Lightsaber") or backPack:WaitForChild("Lightsaber")
		Assets = Lightsaber.Assets
		Eventz = Assets.Events
		updStance = Eventz.updateStance
		atkStart = Eventz.attackStart
		saberClient = Lightsaber.Client
		forceClient = backPack.Force.Client
		sClientEnv = getSenv(saberClient)
		fClientEnv = getSenv(forceClient)
		target = Lightsaber.combatData.Target
		if antiFreezeCB.Checked then
			antiFreeze()
		end
	end)

	coroutine.resume(coroutine.create(function()
		while wait() do
			pcall(function()
				local za = target.Value:FindFirstChild("Lightsaber") or target.Value:FindFirstChild("Dual Lightsabers") or target.Value:FindFirstChild("Crossguard Lightsaber") or target.Value.Darksaber
				targetS = za.combatData.Stance.Value
			end)
			humanoid.Sit = false
			humanoid.PlatformStand = false
			if cWSB.Checked == false then
				humanoid.WalkSpeed = oldSpeed
			end
			if cJPB.Checked == false then
				humanoid.JumpPower = oldJumpPower
			end
		end
	end))
end

hubMain.HM_GI_LCU.Text = "Unknown game!"

local gH = {
	{ 
		GameId = 537413528; --Build A Boat
		CHLXUpd = "02.04.2023";
		Func = nil
	};
	{
		GameId = 850917308; -- Lightsaber Battles
		CHLXUpd = "02.04.2023";
		Func = nil
	};
}

for i,v in pairs(gH) do
	if v.GameId == game.PlaceId then
		detectedGame = true

		hubMain.HM_GI_LCU.Text = "Last CHLENIX update: "..v.CHLXUpd
	end
	
	hubMain:addGameInfo(v)
end

function getDate(str)
	-- 2023-01-15T03:10:48.713Z
	local sep = string.split(str, "T")[1]
	local sep2 = string.split(sep, "-")	
	return sep2[3].."."..sep2[2].."."..sep2[1]
end

pcall(function()
	hubMain.HM_GI_GameImage.Image = "rbxassetid://"..marketService:GetProductInfo(game.PlaceId).IconImageAssetId
	hubMain.HM_GI_GameName.Text = marketService:GetProductInfo(game.PlaceId).Name
	hubMain.HM_GI_LGU.Text = "Last game update: "..getDate(marketService:GetProductInfo(game.PlaceId).Updated)
end)

if detectedGame == false then
	notifFr:Notify("Unknown game!", 10)
end

-- Cleanup
isLoaded = true

-- Hub Open Animation
hubMain:toggleWindow()
-- Hub Close

userInputService.InputBegan:Connect(function(input, chatting)
	if input.KeyCode == Enum.KeyCode.RightAlt and not chatting then
		hubMain:toggleWindow(true)
	end
end)

if CHLX_DEBUG == true then
	local testPage = hubMain:newPage()
	local trashCategory = testPage:newCategory("Test1")
	local contxBut = hubMain:newContextMenuButton("</>")
	contxBut.MouseButton1Down:Connect(testPage.switchTo)
	local chkbx = trashCategory:newCheckbox("Checkbox")

	chkbx.OnCheckFunc = function()
		notifFr:Notify(chkbx.Checked)
	end

	local otp = trashCategory:newOneTimePressButton("Test Notification")
	otp.MouseButton1Down:Connect(function()
		notifFr:Notify("Fired")
	end)

	local tbox = trashCategory:newTextbox()
	tbox.func = function(input)
		notifFr:Notify(tbox:GetText())
	end

	local dropus = trashCategory:newDropdown("dropus")
	local a1 = dropus:AddOption("trash", function()
		notifFr:Notify("1")
	end)
	local a2 = dropus:AddOption("hsart", function()
		notifFr:Notify("2")
	end)
	local a3 = dropus:AddOption("_omg", function()
		notifFr:Notify("3")
	end)
end

-- Rebuilder
localPlayer.CharacterAdded:Connect(function()
	playerGui = localPlayer:FindFirstChildWhichIsA("PlayerGui")
	backPack = localPlayer:FindFirstChildWhichIsA("Backpack")
	character = localPlayer.Character
	character:WaitForChild("Humanoid")
	humanoid = character:FindFirstChildWhichIsA("Humanoid")
	if cWSB.Checked == true then
		humanoid.WalkSpeed = speedChange:GetText()
	end
	if cJPB.Checked == true then
		humanoid.JumpPower = jumpChange:GetText()
	end
end)