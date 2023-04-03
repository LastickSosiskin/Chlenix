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

--assert(fireTouchInterest, getSenv, hookFunction, hookMetaMethod, checkCaller, getNameCallMethod, newCClosure, syn, "EXP not supported!")

if getGlobal().__CHLENIX ~= nil then return end
local SYN = syn or {}
local protectGui = SYN.protect_gui or defaultFunction

local CHLX_Language = "English"
local CHLX_DEBUG = true

getGlobal().__CHLENIX = {
	__DEBUG = CHLX_DEBUG; 
	__SETTINGS = {
		Language = CHLX_Language
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
function reverseTable(tbl)
	local a = #tbl
	local output = {}
	repeat 
		table.insert(output, tbl[a])
		a = a - 1
	until a == 0
	return output
end
function randomstring(len)
	local length = len or math.random(20,40)
	local str = ""
	for i = 1,length do
		str = str..string.char(math.random(32,126))
	end
	return str
end

local Notifications = {}
local CHLXBuilder = {
	NotificationFramework = {firstNotifyPosYScale = 0.9}; -- попробывать 0.9
	HubFramework = {};
	General = {};
}

local notifFramework = CHLXBuilder.NotificationFramework
local hubFramework = CHLXBuilder.HubFramework
local genralFramework = CHLXBuilder.General

-- Notifications
notifFramework.Initialize = function()
	local NF_GUI = Instance.new("ScreenGui")
	local NF_NFHolder = Instance.new("Frame")

	NF_GUI.Name = randomstring()
	NF_GUI.Parent = coreGui--localPlayer.PlayerGui
	NF_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	NF_GUI.ResetOnSpawn = false

	NF_NFHolder.Name = randomstring()
	NF_NFHolder.Parent = NF_GUI
	NF_NFHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NF_NFHolder.BackgroundTransparency = 1
	NF_NFHolder.BorderSizePixel = 0
	NF_NFHolder.ClipsDescendants = true
	NF_NFHolder.Position = UDim2.new(0.813642442, 0, 0.0197963864, 0)
	NF_NFHolder.Size = UDim2.new(0.178332582, 0, 0.961234152, 0)
	protectGui(NF_GUI)
	return NF_NFHolder
end

notifFramework.calculateNotifyPos = function(notify, padding)
	local index = table.find(Notifications, notify)
	if index == 1 then
		return UDim2.new(0, 0, CHLXBuilder.NotificationFramework.firstNotifyPosYScale, 0)
	end
	if index > 1 then
		local posYScale = Notifications[index-1].Position.Y.Scale - tonumber("0."..Notifications[index-1].Size.Y.Offset * 1)--1.5) -- * 1.5 er
		return UDim2.new(0, 0, posYScale, 0) -- попробывать всё на оффсет перестроить
	end
end

function notifFramework.notifyRepositon()
	for i,v in pairs(Notifications) do
		local pos = notifFramework.calculateNotifyPos(v, 0.15)
		local daTween = createTween(v, 0.1, "In", "Sine", {Position = pos})
		daTween:Play()
		daTween.Completed:Wait()
	end
end

local NotificationHolder = notifFramework.Initialize()

function createNotify()
	local NF_Example = Instance.new("Frame")
	local NFE_UICorner = Instance.new("UICorner")
	local NFE_name = Instance.new("TextLabel")
	local NFE_Close = Instance.new("TextButton")
	local NFE_Holder = Instance.new("Frame")
	local NFE_PBar = Instance.new("Frame")
	local NFE_Text = Instance.new("TextLabel")

	NF_Example.Name = randomstring()
	NF_Example.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	NF_Example.Position = UDim2.new(0, 0, 0.6875, 0)
	NF_Example.Size = UDim2.new(0, 320, 0, 100)

	NFE_UICorner.CornerRadius = UDim.new(0, 5)
	NFE_UICorner.Parent = NF_Example

	NFE_name.Name = randomstring()
	NFE_name.Parent = NF_Example
	NFE_name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NFE_name.BackgroundTransparency = 1.000
	NFE_name.BorderSizePixel = 2
	NFE_name.Position = UDim2.new(0.0187500007, 0, 0, 0)
	NFE_name.Size = UDim2.new(0, 308, 0, 16)
	NFE_name.Font = Enum.Font.GothamBold
	NFE_name.Text = "CHLENIX"
	NFE_name.TextColor3 = Color3.fromRGB(255, 255, 255)
	NFE_name.TextSize = 14.000
	NFE_name.TextXAlignment = Enum.TextXAlignment.Left

	NFE_Close.Name = randomstring()
	NFE_Close.Parent = NFE_name
	NFE_Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NFE_Close.BackgroundTransparency = 1.000
	NFE_Close.Position = UDim2.new(0.967532456, 0, 0, 0)
	NFE_Close.Size = UDim2.new(0, 16, 0, 16)
	NFE_Close.Font = Enum.Font.GothamBold
	NFE_Close.Text = "X"
	NFE_Close.TextColor3 = Color3.fromRGB(255, 255, 255)
	NFE_Close.TextSize = 13.000

	NFE_Holder.Name = randomstring()
	NFE_Holder.Parent = NFE_name
	NFE_Holder.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
	NFE_Holder.BorderSizePixel = 0
	NFE_Holder.Position = UDim2.new(0.204545453, 0, 0.375, 0)
	NFE_Holder.Size = UDim2.new(0, 235, 0, 3)
	NFE_Holder.ZIndex = 4

	NFE_PBar.Name = randomstring()
	NFE_PBar.Parent = NFE_Holder
	NFE_PBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NFE_PBar.BorderSizePixel = 0
	NFE_PBar.Size = UDim2.new(0, 235, 0, 3)

	NFE_Text.Name = randomstring()
	NFE_Text.Parent = NF_Example
	NFE_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NFE_Text.BackgroundTransparency = 1.000
	NFE_Text.Position = UDim2.new(0.0187500007, 0, 0.159999996, 0)
	NFE_Text.Size = UDim2.new(0, 308, 0, 78)
	NFE_Text.Font = Enum.Font.Gotham
	NFE_Text.Text = "s"
	NFE_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	NFE_Text.TextSize = 13
	NFE_Text.TextWrapped = true
	NFE_Text.TextXAlignment = Enum.TextXAlignment.Left
	NFE_Text.TextYAlignment = Enum.TextYAlignment.Top

	return {Base = NF_Example; Name = NFE_name; CloseButton = NFE_Close; Notif = NFE_Text; PBar = NFE_PBar}
end

function notifFramework.notify(notif, debounce)
	notif = tostring(notif)
	if debounce == nil then
		debounce = 5
	end
	local Notification = createNotify()

	Notification.Base.Parent = NotificationHolder
	Notification.Notif.Text = notif or "Sample Text"
	table.insert(Notifications, Notification.Base)

	local pos = notifFramework.calculateNotifyPos(Notification.Base, 0.15)
	Notification.Base.Position = UDim2.new(1, 0, pos.Y.Scale, 0)

	local function closeNotify()
		local closeTween = createTween(Notification.Base, 0.1, "In", "Sine", {Position = UDim2.new(1, 0, Notification.Base.Position.Y.Scale, 0)})
		closeTween:Play()
		closeTween.Completed:Wait()
		Notification.Base:Destroy()
	end

	if Notification.CloseButton ~= nil then
		Notification.CloseButton.MouseButton1Down:Connect(closeNotify)
	end

	if Notification.PBar ~= nil then
		local runner = createTween(Notification.PBar, debounce, "In", "Linear", {Size = UDim2.new(0,0,0,3)})
		runner:Play()
		runner.Completed:Connect(closeNotify)
	end

	local openTween = createTween(Notification.Base, 0.1, "In", "Sine", {Position = pos})
	openTween:Play()
	openTween.Completed:Wait()
end

NotificationHolder.ChildRemoved:Connect(function(child)
	local index = table.find(Notifications, child)
	if index ~= nil then
		table.remove(Notifications, index)
		notifFramework.notifyRepositon()
	end
end)

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
LO_Base.Position = UDim2.new(0.430789351, 0, 0.898664355, 0)
LO_Base.Size = UDim2.new(0, 250, 0, 40)

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

local LO_Debounce = 0
coroutine.resume(coroutine.create(function()
	repeat
		LO_Runner.Position = UDim2.new(-0.252, 0, 0, 0)
		local daTween = createTween(LO_Runner, .7, "In", "Linear", {Position = UDim2.new(1, 0, 0, 0)})
		daTween:Play()
		daTween.Completed:Wait()
		LO_Debounce = LO_Debounce + 1
	until LO_Debounce == 3 and isLoaded == true --LO_Debounce == 6
	createTween(LO_Base, .1, "In", "Linear", {Position = UDim2.new(0.43, 0, 1, 0), Transparency = 1}):Play()
end))

local hubDef = {}
local pageDef = {}
local categoryDef = {}
local dropdownDef = {}
local oneTimePressDef = {}
local checkboxDef = {Check = {}}
local textboxDef = {}

local dropdownOptionDef = {}

hubDef.__index = hubDef
pageDef.__index = pageDef
categoryDef.__index = categoryDef
dropdownDef.__index = dropdownDef
oneTimePressDef.__index = oneTimePressDef
checkboxDef.__index = checkboxDef
textboxDef.__index = textboxDef
dropdownOptionDef.__index = dropdownOptionDef

function CHLXBuilder.createHub()
	local HUB_GUI = Instance.new("ScreenGui")
	local HUB_Header = Instance.new("Frame")
	local HUB_Base = Instance.new("Frame")
	local HUB_BASE_UICorner2 = Instance.new("UICorner")
	local HUB_Shadow = Instance.new("Frame")
	local HUB_ContextMenu = Instance.new("ScrollingFrame")
	local HUB_CMenu_UIListLayout = Instance.new("UIListLayout")
	local HUB_CMenu_UIPadding = Instance.new("UIPadding")
	local HUB_Pages = Instance.new("Folder")
	local PAGES_HomePage = Instance.new("ScrollingFrame")
	local HOMEPAGE_UIListLayout = Instance.new("UIListLayout")
	local HOMEPAGE_GameInfo = Instance.new("Frame")
	local HM_GAMEINFO_GameImage = Instance.new("ImageLabel")
	local HM_GAMEINFO_GameName = Instance.new("TextLabel")
	local HM_GAMEINFO_LGU = Instance.new("TextLabel")
	local HM_GAMEINFO_LCU = Instance.new("TextLabel")
	local HOMEPAGE_UIPadding = Instance.new("UIPadding")
	local HM_DGame = Instance.new("TextLabel")
	local PAGES_SupportedGames = Instance.new("Frame")
	local SGAMES_Label = Instance.new("TextLabel")
	local SGAMES_Holder = Instance.new("ScrollingFrame")
	local SGAMES_HOLDER_UIListLayout = Instance.new("UIListLayout")
	local SGAMES_HOLDER_UIPadding = Instance.new("UIPadding")
	local SGAMES_UIListLayout = Instance.new("UIListLayout")
	local HUB_PopUpDropdown = Instance.new("Frame")
	local HUB_PUD_Header = Instance.new("TextLabel")
	local HUB_PUD_HEADER_UICorner = Instance.new("UICorner")
	local HUB_PUD_HEADER_Close = Instance.new("TextButton")
	local HUB_PUD_UICorner = Instance.new("UICorner")
	local HUB_PUD_Holder = Instance.new("ScrollingFrame")
	local HUB_PUD_HOLDER_UIListLayout = Instance.new("UIListLayout")
	local HUB_PUD_HOLDER_UIPadding = Instance.new("UIPadding")
	local HUB_PUD_Search = Instance.new("TextBox")
	local HUB_PUD_UIListLayout = Instance.new("UIListLayout")
	local HUB_PUD_UIPadding = Instance.new("UIPadding")
	local HUB_Text = Instance.new("TextLabel")
	local HUB_UICorner = Instance.new("UICorner")

	--Properties:

	HUB_GUI.Name = randomstring()
	HUB_GUI.Parent = coreGui
	HUB_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	HUB_Header.Name = randomstring()
	HUB_Header.Parent = HUB_GUI
	HUB_Header.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	HUB_Header.BorderSizePixel = 0
	HUB_Header.Position = UDim2.new(0.334180266, 0, 0.300632894, 0)
	HUB_Header.Size = UDim2.new(0, 600, 0, 20)

	HUB_Base.Name = randomstring()
	HUB_Base.Parent = HUB_Header
	HUB_Base.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	HUB_Base.BorderSizePixel = 0
	HUB_Base.ClipsDescendants = true
	HUB_Base.Position = UDim2.new(0, 0, 1, -2)
	HUB_Base.Size = UDim2.new(0, 600, 0, 300)

	HUB_BASE_UICorner2.CornerRadius = UDim.new(0, 3)
	HUB_BASE_UICorner2.Name = randomstring()
	HUB_BASE_UICorner2.Parent = HUB_Base

	HUB_Shadow.Name = randomstring()
	HUB_Shadow.Parent = HUB_Base
	HUB_Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	HUB_Shadow.BackgroundTransparency = 1.000
	HUB_Shadow.BorderSizePixel = 0
	HUB_Shadow.Position = UDim2.new(0, 0, 0.00666666683, 0)
	HUB_Shadow.Size = UDim2.new(0, 600, 0, 298)
	HUB_Shadow.ZIndex = 49

	HUB_ContextMenu.Name = randomstring()
	HUB_ContextMenu.Parent = HUB_Base
	HUB_ContextMenu.Active = true
	HUB_ContextMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	HUB_ContextMenu.BorderSizePixel = 0
	HUB_ContextMenu.Position = UDim2.new(0.00166666671, 0, 0, 0)
	HUB_ContextMenu.Size = UDim2.new(0, 60, 0, 300)
	HUB_ContextMenu.ZIndex = 50
	HUB_ContextMenu.BottomImage = ""
	HUB_ContextMenu.CanvasSize = UDim2.new(0, 0, 0, 0)
	HUB_ContextMenu.ScrollBarThickness = 2
	HUB_ContextMenu.TopImage = ""
	HUB_ContextMenu.AutomaticCanvasSize = Enum.AutomaticSize.Y

	HUB_CMenu_UIListLayout.Name = randomstring()
	HUB_CMenu_UIListLayout.Parent = HUB_ContextMenu
	HUB_CMenu_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	HUB_CMenu_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HUB_CMenu_UIListLayout.Padding = UDim.new(0, 9)

	HUB_CMenu_UIPadding.Name = randomstring()
	HUB_CMenu_UIPadding.Parent = HUB_ContextMenu
	HUB_CMenu_UIPadding.PaddingBottom = UDim.new(0, 5)
	HUB_CMenu_UIPadding.PaddingTop = UDim.new(0, 5)

	HUB_Pages.Name = randomstring()
	HUB_Pages.Parent = HUB_Base

	PAGES_HomePage.Name = randomstring()
	PAGES_HomePage.Parent = HUB_Pages
	PAGES_HomePage.Active = true
	PAGES_HomePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PAGES_HomePage.BackgroundTransparency = 1.000
	PAGES_HomePage.BorderSizePixel = 0
	PAGES_HomePage.Position = UDim2.new(0.101666667, 0, 0, 0)
	PAGES_HomePage.Size = UDim2.new(0, 539, 0, 300)
	PAGES_HomePage.Visible = true
	PAGES_HomePage.BottomImage = ""
	PAGES_HomePage.CanvasSize = UDim2.new(0, 0, 0, 0)
	PAGES_HomePage.ScrollBarThickness = 5
	PAGES_HomePage.TopImage = ""

	HOMEPAGE_UIListLayout.Name = randomstring()
	HOMEPAGE_UIListLayout.Parent = PAGES_HomePage
	HOMEPAGE_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	HOMEPAGE_GameInfo.Name = randomstring()
	HOMEPAGE_GameInfo.Parent = PAGES_HomePage
	HOMEPAGE_GameInfo.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	HOMEPAGE_GameInfo.BorderSizePixel = 0
	HOMEPAGE_GameInfo.Size = UDim2.new(0, 529, 0, 100)

	HM_GAMEINFO_GameImage.Name = randomstring()
	HM_GAMEINFO_GameImage.Parent = HOMEPAGE_GameInfo
	HM_GAMEINFO_GameImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_GameImage.Size = UDim2.new(0, 100, 0, 100)
	HM_GAMEINFO_GameImage.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

	HM_GAMEINFO_GameName.Name = randomstring()
	HM_GAMEINFO_GameName.Parent = HOMEPAGE_GameInfo
	HM_GAMEINFO_GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_GameName.BackgroundTransparency = 1.000
	HM_GAMEINFO_GameName.Position = UDim2.new(0.200378075, 0, 0, 0)
	HM_GAMEINFO_GameName.Size = UDim2.new(0, 85, 0, 20)
	HM_GAMEINFO_GameName.Font = Enum.Font.SourceSansBold
	HM_GAMEINFO_GameName.Text = "Sample Text"
	HM_GAMEINFO_GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_GameName.TextSize = 16.000
	HM_GAMEINFO_GameName.TextXAlignment = Enum.TextXAlignment.Left

	HM_GAMEINFO_LGU.Name = randomstring()
	HM_GAMEINFO_LGU.Parent = HOMEPAGE_GameInfo
	HM_GAMEINFO_LGU.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_LGU.BackgroundTransparency = 1.000
	HM_GAMEINFO_LGU.Position = UDim2.new(0.200378075, 0, 0.200000003, 0)
	HM_GAMEINFO_LGU.Size = UDim2.new(0, 147, 0, 20)
	HM_GAMEINFO_LGU.Font = Enum.Font.SourceSansBold
	HM_GAMEINFO_LGU.Text = "Last game update: N/A"
	HM_GAMEINFO_LGU.TextColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_LGU.TextSize = 16.000
	HM_GAMEINFO_LGU.TextXAlignment = Enum.TextXAlignment.Left

	HM_GAMEINFO_LCU.Name = randomstring()
	HM_GAMEINFO_LCU.Parent = HOMEPAGE_GameInfo
	HM_GAMEINFO_LCU.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_LCU.BackgroundTransparency = 1.000
	HM_GAMEINFO_LCU.Position = UDim2.new(0.200378075, 0, 0.400000006, 0)
	HM_GAMEINFO_LCU.Size = UDim2.new(0, 147, 0, 20)
	HM_GAMEINFO_LCU.Font = Enum.Font.SourceSansBold
	HM_GAMEINFO_LCU.Text = "Unknown Game!"
	HM_GAMEINFO_LCU.TextColor3 = Color3.fromRGB(255, 255, 255)
	HM_GAMEINFO_LCU.TextSize = 16.000
	HM_GAMEINFO_LCU.TextXAlignment = Enum.TextXAlignment.Left

	HOMEPAGE_UIPadding.Name = randomstring()
	HOMEPAGE_UIPadding.Parent = PAGES_HomePage
	HOMEPAGE_UIPadding.PaddingBottom = UDim.new(0, 5)
	HOMEPAGE_UIPadding.PaddingLeft = UDim.new(0, 5)
	HOMEPAGE_UIPadding.PaddingRight = UDim.new(0, 5)
	HOMEPAGE_UIPadding.PaddingTop = UDim.new(0, 5)

	HM_DGame.Name = randomstring()
	HM_DGame.Parent = PAGES_HomePage
	HM_DGame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HM_DGame.BackgroundTransparency = 1.000
	HM_DGame.LayoutOrder = -1
	HM_DGame.Size = UDim2.new(0, 0, 0, 20)
	HM_DGame.Font = Enum.Font.SourceSansBold
	HM_DGame.Text = "DETECTED GAME"
	HM_DGame.TextColor3 = Color3.fromRGB(255, 255, 255)
	HM_DGame.TextSize = 20.000
	HM_DGame.TextXAlignment = Enum.TextXAlignment.Left

	PAGES_SupportedGames.Name = randomstring()
	PAGES_SupportedGames.Parent = HUB_Pages
	PAGES_SupportedGames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	PAGES_SupportedGames.BackgroundTransparency = 1.000
	PAGES_SupportedGames.BorderSizePixel = 0
	PAGES_SupportedGames.Position = UDim2.new(0.101666667, 0, 0, 0)
	PAGES_SupportedGames.Size = UDim2.new(0, 539, 0, 300)
	PAGES_SupportedGames.Visible = false

	SGAMES_Label.Name = randomstring()
	SGAMES_Label.Parent = PAGES_SupportedGames
	SGAMES_Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SGAMES_Label.BackgroundTransparency = 1.000
	SGAMES_Label.BorderSizePixel = 0
	SGAMES_Label.Size = UDim2.new(0, 0, 0, 20)
	SGAMES_Label.Font = Enum.Font.SourceSansBold
	SGAMES_Label.Text = "SUPPORTED GAMES"
	SGAMES_Label.LayoutOrder = -1
	SGAMES_Label.AutomaticSize = Enum.AutomaticSize.X
	SGAMES_Label.TextColor3 = Color3.fromRGB(255, 255, 255)
	SGAMES_Label.TextSize = 20.000

	SGAMES_Holder.Name = randomstring()
	SGAMES_Holder.Parent = PAGES_SupportedGames
	SGAMES_Holder.Active = true
	SGAMES_Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SGAMES_Holder.BackgroundTransparency = 1.000
	SGAMES_Holder.BorderSizePixel = 0
	SGAMES_Holder.Position = UDim2.new(0, 0, 0.0666666701, 0)
	SGAMES_Holder.Size = UDim2.new(0, 539, 0, 280)
	SGAMES_Holder.BottomImage = ""
	SGAMES_Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
	SGAMES_Holder.ScrollBarThickness = 5
	SGAMES_Holder.TopImage = ""
	SGAMES_Holder.AutomaticCanvasSize = Enum.AutomaticSize.Y

	SGAMES_HOLDER_UIListLayout.Name = randomstring()
	SGAMES_HOLDER_UIListLayout.Parent = SGAMES_Holder
	SGAMES_HOLDER_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SGAMES_HOLDER_UIListLayout.Padding = UDim.new(0, 5)

	SGAMES_HOLDER_UIPadding.Name = randomstring()
	SGAMES_HOLDER_UIPadding.Parent = SGAMES_Holder
	SGAMES_HOLDER_UIPadding.PaddingLeft = UDim.new(0, 5)
	SGAMES_HOLDER_UIPadding.PaddingRight = UDim.new(0, 5)

	SGAMES_UIListLayout.Name = randomstring()
	SGAMES_UIListLayout.Parent = PAGES_SupportedGames
	SGAMES_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	HUB_PopUpDropdown.Name = randomstring()
	HUB_PopUpDropdown.Parent = HUB_Base
	HUB_PopUpDropdown.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
	HUB_PopUpDropdown.BorderSizePixel = 0
	HUB_PopUpDropdown.Position = UDim2.new(0.341666669, 0, 0.0300000012, 0)
	HUB_PopUpDropdown.Size = UDim2.new(0, 250, 0, 266)
	HUB_PopUpDropdown.Visible = false
	HUB_PopUpDropdown.ZIndex = 500
	HUB_PopUpDropdown.AutomaticSize = Enum.AutomaticSize.Y

	HUB_PUD_Header.Name = randomstring()
	HUB_PUD_Header.LayoutOrder = 1
	HUB_PUD_Header.Parent = HUB_PopUpDropdown
	HUB_PUD_Header.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	HUB_PUD_Header.BorderSizePixel = 0
	HUB_PUD_Header.Size = UDim2.new(0, 250, 0, 16)
	HUB_PUD_Header.Font = Enum.Font.SourceSansBold
	HUB_PUD_Header.Text = "Dropdown"
	HUB_PUD_Header.TextColor3 = Color3.fromRGB(255, 255, 255)
	HUB_PUD_Header.TextSize = 16.000

	HUB_PUD_HEADER_UICorner.CornerRadius = UDim.new(0, 3)
	HUB_PUD_HEADER_UICorner.Name = randomstring()
	HUB_PUD_HEADER_UICorner.Parent = HUB_PUD_Header

	HUB_PUD_HEADER_Close.Name = randomstring()
	HUB_PUD_HEADER_Close.Parent = HUB_PUD_Header
	HUB_PUD_HEADER_Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HUB_PUD_HEADER_Close.BackgroundTransparency = 1.000
	HUB_PUD_HEADER_Close.Position = UDim2.new(0.935274363, 0, 0, 0)
	HUB_PUD_HEADER_Close.Size = UDim2.new(0, 16, 0, 16)
	HUB_PUD_HEADER_Close.ZIndex = 5000
	HUB_PUD_HEADER_Close.Font = Enum.Font.GothamBold
	HUB_PUD_HEADER_Close.Text = "X"
	HUB_PUD_HEADER_Close.TextColor3 = Color3.fromRGB(255, 255, 255)
	HUB_PUD_HEADER_Close.TextSize = 13.000

	HUB_PUD_UICorner.CornerRadius = UDim.new(0, 3)
	HUB_PUD_UICorner.Name = randomstring()
	HUB_PUD_UICorner.Parent = HUB_PopUpDropdown

	HUB_PUD_Holder.Name = randomstring()
	HUB_PUD_Holder.LayoutOrder = 2
	HUB_PUD_Holder.Parent = HUB_PopUpDropdown
	HUB_PUD_Holder.Active = true
	HUB_PUD_Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HUB_PUD_Holder.BackgroundTransparency = 1.000
	HUB_PUD_Holder.BorderSizePixel = 0
	HUB_PUD_Holder.Position = UDim2.new(0, 0, 0.135338351, 0)
	HUB_PUD_Holder.Size = UDim2.new(0, 250, 0, 230)
	HUB_PUD_Holder.ZIndex = 1000000
	HUB_PUD_Holder.BottomImage = ""
	HUB_PUD_Holder.CanvasSize = UDim2.new(0, 0, 0, 0)
	HUB_PUD_Holder.ScrollBarThickness = 5
	HUB_PUD_Holder.TopImage = ""
	HUB_PUD_Holder.AutomaticCanvasSize = Enum.AutomaticSize.Y

	HUB_PUD_HOLDER_UIListLayout.Name = randomstring()
	HUB_PUD_HOLDER_UIListLayout.Parent = HUB_PUD_Holder
	HUB_PUD_HOLDER_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HUB_PUD_HOLDER_UIListLayout.Padding = UDim.new(0, 5)

	HUB_PUD_HOLDER_UIPadding.Name = randomstring()
	HUB_PUD_HOLDER_UIPadding.Parent = HUB_PUD_Holder
	HUB_PUD_HOLDER_UIPadding.PaddingBottom = UDim.new(0, 5)
	HUB_PUD_HOLDER_UIPadding.PaddingLeft = UDim.new(0, 5)
	HUB_PUD_HOLDER_UIPadding.PaddingRight = UDim.new(0, 5)

	HUB_PUD_Search.Name = randomstring()
	HUB_PUD_Search.LayoutOrder = 3
	HUB_PUD_Search.Parent = HUB_PopUpDropdown
	HUB_PUD_Search.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	HUB_PUD_Search.BorderSizePixel = 0
	HUB_PUD_Search.Position = UDim2.new(0.0199999996, 0, 0.0799999982, 0)
	HUB_PUD_Search.Size = UDim2.new(0, 240, 0, 20)
	HUB_PUD_Search.ClearTextOnFocus = false
	HUB_PUD_Search.Font = Enum.Font.SourceSans
	HUB_PUD_Search.PlaceholderText = "Search..."
	HUB_PUD_Search.Text = ""
	HUB_PUD_Search.TextColor3 = Color3.fromRGB(255, 255, 255)
	HUB_PUD_Search.TextSize = 14.000
	HUB_PUD_Search.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

	HUB_PUD_UIListLayout.Name = randomstring()
	HUB_PUD_UIListLayout.Parent = HUB_PopUpDropdown
	HUB_PUD_UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	HUB_PUD_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HUB_PUD_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	HUB_PUD_UIListLayout.Padding = UDim.new(0, 5)

	HUB_PUD_UIPadding.Name = randomstring()
	HUB_PUD_UIPadding.Parent = HUB_PopUpDropdown
	HUB_PUD_UIPadding.PaddingBottom = UDim.new(0, 5)

	HUB_Text.Name = randomstring()
	HUB_Text.Parent = HUB_Header
	HUB_Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HUB_Text.BackgroundTransparency = 1.000
	HUB_Text.BorderSizePixel = 0
	HUB_Text.Position = UDim2.new(0.00999999978, 0, -0.0189346317, 0)
	HUB_Text.Size = UDim2.new(0, 55, 0, 20)
	HUB_Text.Font = Enum.Font.GothamBold
	HUB_Text.Text = "CHLENIX"
	HUB_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	HUB_Text.TextScaled = true
	HUB_Text.TextSize = 16.000
	HUB_Text.TextWrapped = true
	HUB_Text.TextXAlignment = Enum.TextXAlignment.Left

	HUB_UICorner.CornerRadius = UDim.new(0, 3)
	HUB_UICorner.Name = randomstring()
	HUB_UICorner.Parent = HUB_Header

	protectGui(HUB_GUI)

	local toReturn = {
		-- Variables
		CurrentlyOpenPage = PAGES_HomePage;
		-- Interface
		GUI = HUB_GUI;
		Header = HUB_Header;
		Base = HUB_Base;
		Shadow = HUB_Shadow;
		ContextMenu = HUB_ContextMenu;
		Pages = HUB_Pages;
		HomePage = PAGES_HomePage;
		HM_GameInfo = HOMEPAGE_GameInfo;
		HM_GI_GameImage = HM_GAMEINFO_GameImage;
		HM_GI_GameName = HM_GAMEINFO_GameName;
		HM_GI_LGU = HM_GAMEINFO_LGU;
		HM_GI_LCU = HM_GAMEINFO_LCU;
		HM_DGame = HM_DGame;
		SupportedGames = PAGES_SupportedGames;
		SGAMES_Label = SGAMES_Label;
		SGAMES_Holder = SGAMES_Holder;
		PopUpDropdown = HUB_PopUpDropdown;
		PUD_Header = HUB_PUD_Header;
		PUD_HEADER_Close = HUB_PUD_HEADER_Close;
		PUD_Holder = HUB_PUD_Holder;
		PUD_Search = HUB_PUD_Search;
		HubName = HUB_Text;
	}

	setmetatable(toReturn, hubDef)
	
	toReturn:newContextMenuButton("HM").MouseButton1Down:connect(function()
		toReturn:SwitchPage({Base = PAGES_HomePage})
	end)
	toReturn:newContextMenuButton("GM").MouseButton1Down:connect(function()
		toReturn:SwitchPage({Base = PAGES_SupportedGames})
	end)
	
	return toReturn
end

-- Hub Functions
function hubDef:newContextMenuButton(buttonName)
	local EX_ConMButton = Instance.new("TextButton")

	EX_ConMButton.Name = randomstring()
	EX_ConMButton.AutoButtonColor = false
	EX_ConMButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	EX_ConMButton.BorderSizePixel = 0
	EX_ConMButton.Size = UDim2.new(0, 42, 0, 42)
	EX_ConMButton.AutoButtonColor = false
	EX_ConMButton.Font = Enum.Font.SourceSansBold
	EX_ConMButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	EX_ConMButton.TextSize = 16.000
	EX_ConMButton.TextWrapped = true

	EX_ConMButton.Parent = self.ContextMenu
	EX_ConMButton.Text = buttonName or "N/A"

	EX_ConMButton.MouseEnter:Connect(function()
		createTween(EX_ConMButton, .1, "In", "Sine", {Size = UDim2.new(0, 52, 0, 52)}):Play()
	end)
	EX_ConMButton.MouseLeave:Connect(function()
		createTween(EX_ConMButton, .1, "In", "Sine", {Size = UDim2.new(0, 42, 0, 42)}):Play()
	end)

	return EX_ConMButton
end

function hubDef:Destroy()
	self.GUI:Destroy()
end

function hubDef:newPage()
	local EX_Page = Instance.new("ScrollingFrame")
	local EX_PAGE_UIListLayout = Instance.new("UIListLayout")
	local EX_PAGE_UIPadding = Instance.new("UIPadding")

	--Properties:
	EX_Page.AutomaticCanvasSize =  Enum.AutomaticSize.Y
	EX_Page.Name = randomstring()
	EX_Page.Active = true
	EX_Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_Page.BackgroundTransparency = 1.000
	EX_Page.BorderSizePixel = 0
	EX_Page.Position = UDim2.new(0.101666667, 0, 0, 0)
	EX_Page.Size = UDim2.new(0, 539, 0, 300)
	EX_Page.Visible = false
	EX_Page.BottomImage = ""
	EX_Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	EX_Page.ScrollBarThickness = 5
	EX_Page.TopImage = ""

	EX_PAGE_UIListLayout.Name = randomstring()
	EX_PAGE_UIListLayout.Parent = EX_Page
	EX_PAGE_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	EX_PAGE_UIPadding.Name = randomstring()
	EX_PAGE_UIPadding.Parent = EX_Page
	EX_PAGE_UIPadding.PaddingBottom = UDim.new(0, 5)
	EX_PAGE_UIPadding.PaddingLeft = UDim.new(0, 5)
	EX_PAGE_UIPadding.PaddingRight = UDim.new(0, 5)
	EX_PAGE_UIPadding.PaddingTop = UDim.new(0, 5)

	EX_Page.Parent = self.Pages

	local toReturnPage = {Base = EX_Page; Hub = self}

	setmetatable(toReturnPage, pageDef)

	return toReturnPage
end

function hubDef:SwitchPage(page)
	self.CurrentlyOpenPage.Visible = false
	page.Base.Visible = true
	self.CurrentlyOpenPage = page.Base
end

function hubDef:toggleShadow()
	local tParency = 1
	if self.Shadow.Transparency == 1 then
		tParency = 0.6
	end
	createTween(self.Shadow, 0.08, "In", "Linear", {Transparency = tParency}):Play()
end

function hubDef:SummonDropdown(dropName, dropOptions, optionHolder)
	for i,v in pairs(self.PUD_Holder:GetChildren()) do
		if v:IsA("GuiButton") then
			v:Destroy()
		end
	end
	for i,v in pairs(dropOptions) do
		local EX_DropOption = Instance.new("TextButton")

		EX_DropOption.Name = randomstring()
		EX_DropOption.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
		EX_DropOption.BorderSizePixel = 0
		EX_DropOption.Size = UDim2.new(0, 240, 0, 20)
		EX_DropOption.Font = Enum.Font.SourceSansBold
		EX_DropOption.TextColor3 = Color3.fromRGB(255, 255, 255)
		EX_DropOption.TextSize = 14.000

		EX_DropOption.Text = v.optionName
		EX_DropOption.Parent = self.PUD_Holder
		EX_DropOption.MouseButton1Down:Connect(function()
			if optionHolder ~= nil then
				optionHolder.Text = v.optionName
			end
			v.func()
			return v
		end)
	end
	self.PopUpDropdown.Visible = true
	self:toggleShadow()
	self.PUD_Header.Text = dropName
	self.PUD_HEADER_Close.MouseButton1Down:Connect(function()
		self:toggleShadow()
		self.PopUpDropdown.Visible = false
	end)
	self.PUD_Search.Changed:Connect(function(ch) --вообще должен был быть getattribute changed signal, но он чё то не работает
		if ch ~= "Text" then 
			return 
		end
		for i,v in pairs(self.PUD_Holder:GetChildren()) do
			if v:IsA("GuiButton") then
				local sText = self.PUD_Search.Text:lower	()
				local vTextSub = string.sub(v.Text:lower(), 1, #sText)

				if vTextSub == sText then
					v.Visible = true
				else
					v.Visible = false
				end
			end
		end
	end)
end

-- Page Functions

function pageDef:newCategory(categoryName)
	local EX_CategoryName = Instance.new("TextLabel")
	local EX_Category = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	EX_CategoryName.Name = randomstring()
	EX_CategoryName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_CategoryName.BackgroundTransparency = 1.000
	EX_CategoryName.Size = UDim2.new(0, 0, 0, 20)
	EX_CategoryName.AutomaticSize = Enum.AutomaticSize.X
	EX_CategoryName.Font = Enum.Font.SourceSansBold
	EX_CategoryName.TextColor3 = Color3.fromRGB(255, 255, 255)
	EX_CategoryName.TextSize = 20.000
	EX_CategoryName.TextXAlignment = Enum.TextXAlignment.Left

	EX_Category.Name = randomstring()
	EX_Category.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	EX_Category.BorderSizePixel = 0
	EX_Category.AutomaticSize = Enum.AutomaticSize.Y
	EX_Category.Position = UDim2.new(0, 0, 0.068965517, 0)
	EX_Category.Size = UDim2.new(0, 529, 0, 0)

	UIListLayout.Parent = EX_Category
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 1)

	UIPadding.Parent = EX_Category
	UIPadding.PaddingBottom = UDim.new(0, 5)
	UIPadding.PaddingLeft = UDim.new(0, 5)
	UIPadding.PaddingRight = UDim.new(0, 5)

	EX_CategoryName.Text = categoryName:upper()
	EX_CategoryName.Parent = self.Base
	EX_Category.Parent = self.Base

	local toReturnCategory = {NameLabel = EX_CategoryName; Base = EX_Category; Page = self}

	setmetatable(toReturnCategory, categoryDef)

	return toReturnCategory
end

function pageDef:GetHub()
	return self.Hub
end

-- Category Functions

function categoryDef:newCheckbox(checkName)
	local pos = UDim2.new(0, 0, 0, 0)
	local size = UDim2.new(0, 0, 0, 0)

	local EX_Checkbox = Instance.new("Frame")
	local EXCB_UIListLayout = Instance.new("UIListLayout")
	local EX_CB_Checkname = Instance.new("TextLabel")
	local EX_CB_Check = Instance.new("Frame")
	local EX_CB_C_Runner = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local EX_CB_C_UICorner = Instance.new("UICorner")
	local EX_CB_C_ClickDetector = Instance.new("TextButton")
	local EX_CB_C_ColorRunner = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")

	EX_Checkbox.Name = randomstring()
	EX_Checkbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_Checkbox.BackgroundTransparency = 1.000
	EX_Checkbox.Size = UDim2.new(0, 0, 0, 20)
	EX_Checkbox.AutomaticSize = Enum.AutomaticSize.X

	EXCB_UIListLayout.Name = randomstring()
	EXCB_UIListLayout.Parent = EX_Checkbox
	EXCB_UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	EXCB_UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	EXCB_UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	EXCB_UIListLayout.Padding = UDim.new(0, 5)

	EX_CB_Checkname.Name = randomstring()
	EX_CB_Checkname.Parent = EX_Checkbox
	EX_CB_Checkname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_CB_Checkname.BackgroundTransparency = 1.000
	EX_CB_Checkname.Size = UDim2.new(0, 0, 0, 20)
	EX_CB_Checkname.Font = Enum.Font.SourceSansBold
	EX_CB_Checkname.TextColor3 = Color3.fromRGB(255, 255, 255)
	EX_CB_Checkname.TextSize = 18.000
	EX_CB_Checkname.TextXAlignment = Enum.TextXAlignment.Left
	EX_CB_Checkname.AutomaticSize = Enum.AutomaticSize.X

	EX_CB_Check.Name = randomstring()
	EX_CB_Check.Parent = EX_Checkbox
	EX_CB_Check.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	EX_CB_Check.Size = UDim2.new(0, 30, 0, 15)

	EX_CB_C_Runner.Name = randomstring()
	EX_CB_C_Runner.Parent = EX_CB_Check
	EX_CB_C_Runner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_CB_C_Runner.Position = UDim2.new(0, -1, 0, 0)
	EX_CB_C_Runner.Size = UDim2.new(0, 12, 0, 15)
	EX_CB_C_Runner.ZIndex = 3

	UICorner.CornerRadius = UDim.new(0, 3)
	UICorner.Parent = EX_CB_C_Runner

	EX_CB_C_UICorner.CornerRadius = UDim.new(0, 3)
	EX_CB_C_UICorner.Name = randomstring()
	EX_CB_C_UICorner.Parent = EX_CB_Check

	EX_CB_C_ClickDetector.Name = randomstring()
	EX_CB_C_ClickDetector.Parent = EX_CB_Check
	EX_CB_C_ClickDetector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_CB_C_ClickDetector.BackgroundTransparency = 1.000
	EX_CB_C_ClickDetector.Size = UDim2.new(0, 30, 0, 10)
	EX_CB_C_ClickDetector.Font = Enum.Font.SourceSans
	EX_CB_C_ClickDetector.Text = ""
	EX_CB_C_ClickDetector.AutomaticSize = Enum.AutomaticSize.X
	EX_CB_C_ClickDetector.TextColor3 = Color3.fromRGB(0, 0, 0)
	EX_CB_C_ClickDetector.TextSize = 14.000
	EX_CB_C_ClickDetector.TextTransparency = 1.000

	EX_CB_C_ColorRunner.Name = randomstring()
	EX_CB_C_ColorRunner.Parent = EX_CB_Check
	EX_CB_C_ColorRunner.BackgroundColor3 = Color3.fromRGB(69, 206, 0)
	EX_CB_C_ColorRunner.Size = UDim2.new(0, 0, 0, 15)

	UICorner_2.CornerRadius = UDim.new(0, 3)
	UICorner_2.Parent = EX_CB_C_ColorRunner

	EX_Checkbox.Parent = self.Base
	EX_CB_Checkname.Text = checkName or "Sample Text"

	local theCheckbox = {
		Checked = false;
		OnCheckFunc = nil; 
		OnUnCheckFunc = nil; 
		Base = EX_Checkbox; 
		CheckName = EX_CB_Checkname;
		ClickDetector = EX_CB_C_ClickDetector;
		Category = self;
	}

	EX_CB_C_ClickDetector.MouseButton1Down:Connect(function()
		local state = theCheckbox.Checked
		if state == true then
			theCheckbox.Checked = false
			pos = UDim2.new(0,-1,0,0)
			EX_CB_C_ColorRunner.BackgroundColor3 = Color3.new(255,0,0)
			size = UDim2.new(0, 0, 0, 15)
			if theCheckbox.OnUnCheckFunc ~= nil then
				theCheckbox.OnUnCheckFunc()
			end
		else
			theCheckbox.Checked = true
			pos = UDim2.new(0,18,0,0)
			EX_CB_C_ColorRunner.BackgroundColor3 = Color3.new(0.270588, 0.807843, 0)
			size = UDim2.new(0, 30, 0, 15)
			if theCheckbox.OnCheckFunc ~= nil then
				theCheckbox.OnCheckFunc()
			end
		end
		local anim = createTween(EX_CB_C_Runner, 0.1, "In", "Sine", {Position = pos})
		local anim2 = createTween(EX_CB_C_ColorRunner, 0.1, "In", "Sine", {Size = size})
		anim:Play()
		anim2:Play()
	end)

	setmetatable(theCheckbox, checkboxDef)

	return theCheckbox
end

function categoryDef:newTextbox(textBoxName)
	local TextBox = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local BoxName = Instance.new("TextLabel")
	local TextBox_2 = Instance.new("TextBox")
	local UICorner = Instance.new("UICorner")

	--Properties:

	TextBox.AutomaticSize = Enum.AutomaticSize.X
	TextBox.Name = randomstring()
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1.000
	TextBox.Size = UDim2.new(0, 0, 0, 20)

	UIListLayout.Parent = TextBox
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	BoxName.Name = randomstring()
	BoxName.AutomaticSize = Enum.AutomaticSize.X
	BoxName.Parent = TextBox
	BoxName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BoxName.BackgroundTransparency = 1.000
	BoxName.Size = UDim2.new(0, 0, 0, 20)
	BoxName.Font = Enum.Font.SourceSansBold
	BoxName.Text = "Sample Text:"
	BoxName.TextColor3 = Color3.fromRGB(255, 255, 255)
	BoxName.TextSize = 18.000
	BoxName.TextXAlignment = Enum.TextXAlignment.Left

	TextBox_2.Parent = TextBox
	TextBox_2.AutomaticSize = Enum.AutomaticSize.X
	TextBox_2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	TextBox_2.BorderSizePixel = 0
	TextBox_2.Position = UDim2.new(0.724771023, 0, 0.200000003, 0)
	TextBox_2.Size = UDim2.new(0, 50, 0, 20)
	TextBox_2.Font = Enum.Font.SourceSans
	TextBox_2.Text = "16"
	TextBox_2.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox_2.TextSize = 15.000

	UICorner.CornerRadius = UDim.new(0, 3)
	UICorner.Parent = TextBox_2

	BoxName.Text = textBoxName or "N/A"

	TextBox.Parent = self.Base

	local toReturnTextBox = {
		Base = TextBox;
		BoxName = BoxName;
		TextBox = TextBox_2;
		Type = nil;
		func = nil;
		Category = self;
	}

	TextBox_2.FocusLost:Connect(function(enterPressed)
		toReturnTextBox.func(TextBox_2.Text)
	end)

	setmetatable(toReturnTextBox, textboxDef)

	return toReturnTextBox
end

function categoryDef:newOneTimePressButton(buttonName)
	local OneTimePress = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")

	--Properties:

	OneTimePress.Name = randomstring()
	OneTimePress.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	OneTimePress.BorderSizePixel = 0
	OneTimePress.Position = UDim2.new(0, 0, 0.75, 0)
	OneTimePress.AutomaticSize = Enum.AutomaticSize.X
	OneTimePress.Size = UDim2.new(0, 166, 0, 20)
	OneTimePress.Font = Enum.Font.SourceSansBold
	OneTimePress.TextColor3 = Color3.fromRGB(255, 255, 255)
	OneTimePress.TextSize = 18.000

	UICorner.CornerRadius = UDim.new(0, 4)
	UICorner.Parent = OneTimePress

	OneTimePress.Text = buttonName or "N/A"

	OneTimePress.Parent = self.Base

	return OneTimePress
end

function categoryDef:newDropdown(dropdownName)
	local EX_Dropdown = Instance.new("Frame")
	local Dropname = Instance.new("TextLabel")
	local UIListLayout = Instance.new("UIListLayout")
	local Dropit = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local option = Instance.new("TextButton")
	local UICorner_2 = Instance.new("UICorner")

	--Properties:

	EX_Dropdown.AutomaticSize = Enum.AutomaticSize.X
	EX_Dropdown.Name = randomstring()
	EX_Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EX_Dropdown.BackgroundTransparency = 1.000
	EX_Dropdown.Position = UDim2.new(-0.00954198465, 0, 0.5, 0)
	EX_Dropdown.Size = UDim2.new(0, 176, 0, 20)

	Dropname.Name = randomstring()
	Dropname.AutomaticSize = Enum.AutomaticSize.X
	Dropname.Parent = EX_Dropdown
	Dropname.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Dropname.BackgroundTransparency = 1.000
	Dropname.Size = UDim2.new(0, 0, 0, 20)
	Dropname.Font = Enum.Font.SourceSansBold
	Dropname.Text = "Sample Text:"
	Dropname.TextColor3 = Color3.fromRGB(255, 255, 255)
	Dropname.TextSize = 18.000
	Dropname.TextXAlignment = Enum.TextXAlignment.Left
	Dropname.AutomaticSize = Enum.AutomaticSize.X

	UIListLayout.Parent = EX_Dropdown
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	Dropit.Name = randomstring()
	Dropit.Parent = EX_Dropdown
	Dropit.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Dropit.BorderSizePixel = 0
	Dropit.LayoutOrder = 2
	Dropit.Position = UDim2.new(1.45203531, 0, 0, 0)
	Dropit.Size = UDim2.new(0, 15, 0, 15)
	Dropit.Font = Enum.Font.SourceSansBold
	Dropit.Text = "V"
	Dropit.TextColor3 = Color3.fromRGB(255, 255, 255)
	Dropit.TextSize = 14.000

	UICorner.CornerRadius = UDim.new(0, 3)
	UICorner.Parent = Dropit

	option.Name = randomstring()
	option.Parent = EX_Dropdown
	option.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	option.BorderSizePixel = 0
	option.Size = UDim2.new(0, 80, 0, 15)
	option.Font = Enum.Font.SourceSans
	option.Text = ""
	option.TextColor3 = Color3.fromRGB(255, 255, 255)
	option.TextSize = 14.000
	option.AutomaticSize = Enum.AutomaticSize.X

	UICorner_2.CornerRadius = UDim.new(0, 3)
	UICorner_2.Parent = option
	Dropname.Text = dropdownName or "N/A"

	local toReturnDropdown = {
		Base = EX_Dropdown;
		DropName = Dropname;
		QuickFire = option;
		SelectedOption = nil;
		DropOptions = {};
		SummonFunc = 1;
		Category = self;
	}
	
	setmetatable(toReturnDropdown, dropdownDef)
	
	EX_Dropdown.Parent = self.Base

	option.MouseButton1Down:Connect(function()
		local opt = toReturnDropdown:FindOption(option.Text)
		if opt ~= nil then
			opt.Option.func()
		end
		--if toReturnDropdown.SelectedOption ~= nil then
			--toReturnDropdown.SelectedOption.func()
			--return
		--end
	end)

	Dropit.MouseButton1Down:Connect(function()
		if toReturnDropdown.SummonFunc ~= nil then
			self:GetPage():GetHub():SummonDropdown(dropdownName, toReturnDropdown.DropOptions, option)
		end
	end)

	return toReturnDropdown
end

function categoryDef:Destroy()
	self.NameLabel:Destroy()
	self.Base:Destroy()
end

function categoryDef:GetPage()
	return self.Page
end

-- Dropdown Functions
function dropdownDef:Destroy()
	self.Base:Destroy()
end

function dropdownDef:AddOption(optionName, func)
	local index = #self.DropOptions + 1
	local option = {
		optionName = optionName;
		func = func;
	}

	setmetatable(option, dropdownOptionDef)

	table.insert(self.DropOptions, option)

	return {Option = self.DropOptions[index]; Index = index;}
end

function dropdownDef:FindOption(name)
	for i,v in pairs(self.DropOptions) do
		if v.optionName == name then
			return {Option = v; Index = i}
		end
	end
	return nil
end

function dropdownDef:RemoveOption(option)
	local check = self:FindOption(option)
	if check ~= nil then
		table.remove(self.DropOptions, check.Index)
	end
end

-- Dropdown Option Functions (Doesn't work)
function dropdownOptionDef:Remove()
	self.optionName = nil;
	self.func = nil;
end

-- Textbox Functions
function textboxDef:Destroy()
	self.Base:Destroy()
end

function textboxDef:GetText()
	if self.Type == "string" then
		return tostring(self.TextBox.Text)
	end
	return tonumber(self.TextBox.Text)
end

-- Checkbox Functions
function checkboxDef:Destroy()
	self.Base:Destroy()
end

-- Hub Creation
local hubMain = CHLXBuilder.createHub()
--[[
local testPage = hubMain:newPage()
local trashCategory = testPage:newCategory("trash")
local contxBut = hubMain:newContextMenuButton("F")
contxBut.MouseButton1Down:Connect(function()hubMain:SwitchPage(testPage)end)
local chkbx = trashCategory:newCheckbox("do the thing")

chkbx:Connect(function()
	print(chkbx.Checked)
end)

local otp = trashCategory:newOneTimePressButton("void")
otp.MouseButton1Down:Connect(function()
	print("x")
end)
local tbox = trashCategory:newTextbox("nothin", "nd")
tbox.func = function(input)
	print(tbox:GetText())
end
local dropus = trashCategory:newDropdown("dropus")
dropus.summonFunc = hubMain
local a1 = dropus:AddOption("trash", function()
	print("fired")
end)]]

-- universal

local unvPage = hubMain:newPage()
hubMain:newContextMenuButton("UNV").MouseButton1Down:Connect(function()
	hubMain:SwitchPage(unvPage)
end)
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
	oldJumpPower = humanoid.JumpPower
	coroutine.resume(coroutine.create(function()
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
				--if playersService:FindFirstChild(v.Tag.Value) == plr or plr == true then
				fireClickDetector(v.ClickDetector)
				--end
			end
		end
	end

	local page = hubMain:newPage()
	local contxb = hubMain:newContextMenuButton("BBFT")
	contxb.MouseButton1Down:Connect(function()
		hubMain:SwitchPage(page)
	end)
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
		notifFramework.notify("Removed all currently existing Isolation Mode boundaries. Click again to remove new ones", 5)
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
		notifFramework.notify("Autofarm started", 3)

		local moneyBefore = localPlayer.Data.Gold.Value
		local cycleCount = 0

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
					notifFramework.notify("[AF]: Cycle Error, character.Parent ~= workspace", 3)
					autoFarmWorks = false
				end
			end)

			character.ChildRemoved:connect(function(v)
				if v == humanoidRootPart or v == humanoid then
					notifFramework.notify("[AF]: Cycle Error, humanoid or humanoidRootPart removed", 3)
					autoFarmWorks = false
				end
			end)

			humanoid.Died:connect(function()
				notifFramework.notify("[AF]: Cycle Error, humanoid died", 3)
				autoFarmWorks = false
			end)

			humanoid.PlatformStand = true

			local autoFarmFunctions = {
				["Gold"] = function()
					for i,v in pairs(toTouch) do
						if autoFarmWorks == false then
							notifFramework.notify("[AF]: Cycle Break", 3)
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
						notifFramework.notify("[AF]: Cycle Error, the chest wasn't opening for too much", 3)
						localPlayer.Character:BreakJoints()
					end
				end;
				["GBlocks"] = function()
					for i = 1, 3, 1 do
						if autoFarmWorks == false then
							notifFramework.notify("[AF]: Cycle Break", 3)
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
						notifFramework.notify("[AF]: Cycle Error, the chest wasn't opening for too much", 3)
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
				notifFramework.notify("Earned " .. localPlayer.Data.Gold.Value - moneyBefore .. " in ".. cycleCount .. " cycles. Took ".. cycleCount * (timeNeededToOpenChest + 1 + delayTB:GetText() * #toTouch) .. " seconds", 5)
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
	contxb.MouseButton1Down:Connect(function()
		hubMain:SwitchPage(page)
	end)
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
	local saberClient = Lightsaber.Client
	local forceClient = backPack.Force.Client
	local sClientEnv = getSenv(saberClient)
	local fClientEnv = getSenv(forceClient)
	-- Functions
	local function antiFreeze()
		local con;
		con = character.HumanoidRootPart.ChildAdded:connect(function(v)
			if antiFreezeCB.Checked == false then
				con:Disconnect()
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

	antiFreezeCB:Connect(antiFreeze)

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
				local tSab = target.Value.Lightsaber or target.Value["Dual Lightsabers"] or target.Value["Crossguard Lightsaber"] or target.Value.Darksaber
				local degree = tSab.combatData.Stance.Value
				local args = {
					[1] = degree,
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

function getDate(str)
	--2023-01-15T03:10:48.713Z
	local sep = string.split(str, "T")[1]
	local sep2 = string.split(sep, "-")	
	return sep2[3].."."..sep2[2].."."..sep2[1]
end

hubMain.Header.Size  = UDim2.new(0, 0, 0, 20)
hubMain.Base.Size = UDim2.new(0, 600, 0, 0)

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
	local EX_GameInfo = Instance.new("Frame")
	local GameLogo = Instance.new("ImageLabel")
	local GameName = Instance.new("TextLabel")
	local LGU = Instance.new("TextLabel")
	local LCU = Instance.new("TextLabel")

	--Properties:

	EX_GameInfo.Name = randomstring()
	EX_GameInfo.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	EX_GameInfo.BorderSizePixel = 0
	EX_GameInfo.Size = UDim2.new(0, 529, 0, 100)

	GameLogo.Name = randomstring()
	GameLogo.Parent = EX_GameInfo
	GameLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GameLogo.Size = UDim2.new(0, 100, 0, 100)
	GameLogo.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

	GameName.Name = randomstring()
	GameName.Parent = EX_GameInfo
	GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GameName.BackgroundTransparency = 1.000
	GameName.Position = UDim2.new(0.200378075, 0, 0, 0)
	GameName.Size = UDim2.new(0, 85, 0, 20)
	GameName.Font = Enum.Font.SourceSansBold
	GameName.Text = "Sample Text"
	GameName.TextColor3 = Color3.fromRGB(255, 255, 255)
	GameName.TextSize = 16.000
	GameName.TextXAlignment = Enum.TextXAlignment.Left

	LGU.Name = randomstring()
	LGU.Parent = EX_GameInfo
	LGU.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LGU.BackgroundTransparency = 1.000
	LGU.Position = UDim2.new(0.200378075, 0, 0.200000003, 0)
	LGU.Size = UDim2.new(0, 147, 0, 20)
	LGU.Font = Enum.Font.SourceSansBold
	LGU.Text = "Last game update: N/A"
	LGU.TextColor3 = Color3.fromRGB(255, 255, 255)
	LGU.TextSize = 16.000
	LGU.TextXAlignment = Enum.TextXAlignment.Left

	LCU.Name = randomstring()
	LCU.Parent = EX_GameInfo
	LCU.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LCU.BackgroundTransparency = 1.000
	LCU.Position = UDim2.new(0.200378075, 0, 0.400000006, 0)
	LCU.Size = UDim2.new(0, 147, 0, 20)
	LCU.Font = Enum.Font.SourceSansBold
	LCU.Text = "Last CHLENIX update: N/A"
	LCU.TextColor3 = Color3.fromRGB(255, 255, 255)
	LCU.TextSize = 16.000
	LCU.TextXAlignment = Enum.TextXAlignment.Left
	pcall(function()
		GameLogo.Image = "rbxassetid://"..marketService:GetProductInfo(v.GameId).IconImageAssetId
		GameName.Text = marketService:GetProductInfo(v.GameId).Name
		LGU.Text = "Last game update: "..getDate(marketService:GetProductInfo(v.GameId).Updated)
		LCU.Text = "Last CHLENIX update: "..v.CHLXUpd
	end)

	EX_GameInfo.Parent = hubMain.SGAMES_Holder

	if v.GameId == game.PlaceId then
		detectedGame = true

		hubMain.HM_GI_LCU.Text = "Last CHLENIX update: "..v.CHLXUpd
		--v.Func()
	end
end

pcall(function()
	hubMain.HM_GI_GameImage.Image = "rbxassetid://"..marketService:GetProductInfo(game.PlaceId).IconImageAssetId
	hubMain.HM_GI_GameName.Text = marketService:GetProductInfo(game.PlaceId).Name
	hubMain.HM_GI_LGU.Text = "Last game update: "..getDate(marketService:GetProductInfo(game.PlaceId).Updated)
end)

if detectedGame == false then
	notifFramework.notify("Unknown game!", 10)
end

-- Dragging
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
OBJ_Dragger(hubMain.Header)

-- Cleanup
isLoaded = true

-- Hub Open Animation
local animn = createTween(hubMain.Header, .3, "InOut", "Quad", {Size  = UDim2.new(0, 600, 0, 20)})
animn:Play()
animn.Completed:Wait()
local animn2 = createTween(hubMain.Base, .2, "In", "Quad", {Size = UDim2.new(0, 600, 0, 300)})
animn2:Play()

-- Hub Close

userInputService.InputBegan:Connect(function(input, chatting)
	if input.KeyCode == Enum.KeyCode.RightAlt and not chatting then
		if hubMain.Header.Visible == false then
			hubMain.Header.Visible = true
			return
		end
		hubMain.Header.Visible = false
	end
end)

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