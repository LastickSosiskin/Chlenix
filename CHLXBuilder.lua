local CHLXBuilderDebug = false
function default(...)
	return ...
end
-- Services
local tweenService = game:GetService('TweenService')
local userInputService = game:GetService("UserInputService")
local coreGUI = game:GetService("CoreGui")
local marketService = game:GetService("MarketplaceService")
-- Variables
local Syn = syn or {}
local protectGUI = Syn.protect_gui or default
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
function getDate(str)
	-- 2023-01-15T03:10:48.713Z
	local sep = string.split(str, "T")[1]
	local sep2 = string.split(sep, "-")	
	return sep2[3].."."..sep2[2].."."..sep2[1]
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
-- Create Functions
local interfaceLib = {}
-- [1]: Notification
function interfaceLib.createNotify()
	local NF_Example = Instance.new("Frame")
	local NFE_UICorner = Instance.new("UICorner")
	local NFE_name = Instance.new("TextLabel")
	local NFE_Close = Instance.new("TextButton")
	local NFE_Holder = Instance.new("Frame")
	local NFE_PBar = Instance.new("Frame")
	local NFE_Text = Instance.new("TextLabel")

	NF_Example.Name = randomstring()
	NF_Example.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
	NF_Example.Position = UDim2.new(0, 0, 0, 0)
	NF_Example.Size = UDim2.new(0, 320, 0, 100)
	NF_Example.AnchorPoint = Vector2.new(0.5, 0.5)

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

	return
		{
			Base = NF_Example;
			Name = NFE_name;
			CloseButton = NFE_Close; 
			Notif = NFE_Text; 
			PBar = NFE_PBar
		}
end
-- [2]: Game Info
function interfaceLib.createGameInfo()
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

	return 
		{
			Base = EX_GameInfo;
			GameLogo = GameLogo;
			GameName = GameName;
			LastGameUpdate = LGU;
			LastChlenixUpdate = LCU;
		}
end
-- [3]: Main GUI
function interfaceLib.createMainGUI()
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
	HUB_GUI.Parent = coreGUI
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

	protectGUI(HUB_GUI)

	OBJ_Dragger(HUB_Header)

	local toReturn = 
		{
			-- Variables
			CurrentlyOpenPage = PAGES_HomePage;
			Active = true;
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

	return toReturn
end
-- BUILDER
local CHLXBuilder = 
	{
		NotificationFramework = 
		{
			Notifications = {};
		};
		HubFramework = 
		{

		};
		InterfaceLib = interfaceLib;
	}
-- Shortcuts
local hubFramework = CHLXBuilder.HubFramework
local notifFramework = CHLXBuilder.NotificationFramework
local Notifications = notifFramework.Notifications
-- Notification Framework
--[1] Definitions
local NFFrameDef = {};
local notifDef = {};

NFFrameDef.__index = NFFrameDef
notifDef.__index = notifDef

-- [2] Functions
-- Handler
notifFramework.Initialize = function()
	local NF_GUI = Instance.new("ScreenGui")

	NF_GUI.Name = randomstring()
	NF_GUI.Parent = coreGUI
	NF_GUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	NF_GUI.ResetOnSpawn = false

	protectGUI(NF_GUI)

	local toReturn = {GUI = NF_GUI}

	setmetatable(toReturn, NFFrameDef)

	NF_GUI.ChildRemoved:Connect(function(child)
		for i,v in pairs(Notifications) do
			if v.Base == child then
				table.remove(Notifications, i)
				toReturn:Repositon()
			end
		end
	end)

	return toReturn
end
function NFFrameDef:Notify(text, duration)
	if self.createNotify == nil then
		return
	end

	text = tostring(text)
	if duration == nil then
		duration = 5
	end
	local Notification = self.createNotify()

	Notification.Closing = false;

	setmetatable(Notification, notifDef)

	Notification.Base.Parent = self.GUI
	Notification.Notif.Text = text or "Sample Text"

	table.insert(Notifications, Notification)

	local pos = Notification:gPosition()

	Notification.Base.Position = UDim2.new(1, 0, pos.Y.Scale, 0)

	if Notification.CloseButton ~= nil then
		Notification.CloseButton.MouseButton1Down:Connect(function()
			Notification:Close()
		end)
	end

	if Notification.PBar ~= nil then
		local runner = createTween(Notification.PBar, duration, "In", "Linear", {Size = UDim2.new(0, 0, 0, 3)})
		runner:Play()
		runner.Completed:Connect(function()
			Notification:Close()
		end)
	end

	local openTween = createTween(Notification.Base, 0.1, "In", "Sine", {Position = pos})
	openTween:Play()
	openTween.Completed:Wait()
end
function NFFrameDef:Repositon()
	for i,v in pairs(Notifications) do
		if v.Closing == false then
			local pos = v:gPosition()
			local daTween = createTween(v.Base, 0.1, "In", "Sine", {Position = pos})
			daTween:Play()
			daTween.Completed:Wait()
		end
	end
end
-- Notification
function notifDef:gPosition()
	local index = nil

	for i,v in pairs(Notifications) do
		if v.Base == self.Base then
			index = i
			break
		end
	end

	if index == 1 then
		local experimental = 1 - self.Base.Size.Y.Offset / 10 / 10 / 10
		return UDim2.new(experimental, 0, experimental, 0) --(0.9, 0, 0.9, 0)
	end
	if index > 1 then
		--local posYScale = Notifications[index-1].Base.Position.Y.Scale - tonumber("0."..Notifications[index-1].Base.Size.Y.Offset)
		local experimental = 1 - self.Base.Size.Y.Offset * index / 10 / 10 / 10
		return UDim2.new(0.9, 0, experimental, 0)
	end
end
function notifDef:Close()
	local closeTween = createTween(self.Base, 0.1, "In", "Sine", {Position = UDim2.new(1, 0, self.Base.Position.Y.Scale, 0)})
	closeTween:Play()
	closeTween.Completed:Wait()
	self.Base:Destroy()
end
-- Hub Framework
-- [1] Definitions
local hubDef = {}
local pageDef = {}
local categoryDef = {}
local zoneDef = {}
local oneTimePressDef = {}
local checkboxDef = {}
local textboxDef = {}
local dropdownDef = {}
local dropdownOptionDef = {}

hubDef.__index = hubDef
pageDef.__index = pageDef
categoryDef.__index = categoryDef
zoneDef.__index = zoneDef
oneTimePressDef.__index = oneTimePressDef
checkboxDef.__index = checkboxDef
textboxDef.__index = textboxDef
dropdownDef.__index = dropdownDef
dropdownOptionDef.__index = dropdownOptionDef

-- [2] Functions
function hubFramework.Initialize()
	local main = interfaceLib.createMainGUI()

	setmetatable(main, hubDef)
	
	main:newContextMenuButton("HM").MouseButton1Down:connect(function()
		main:switchPage({Base = main.HomePage})
	end)
	main:newContextMenuButton("GM").MouseButton1Down:connect(function()
		main:switchPage({Base = main.SupportedGames})
	end)
	
	return main
end

-- Hub Functions
function hubDef:addGameInfo(v)
	local GInfo = interfaceLib.createGameInfo()
	pcall(function()
		GInfo.GameLogo.Image = "rbxassetid://"..marketService:GetProductInfo(v.GameId).IconImageAssetId
		GInfo.GameName.Text = marketService:GetProductInfo(v.GameId).Name
		GInfo.LastGameUpdate.Text = "Last game update: "..getDate(marketService:GetProductInfo(v.GameId).Updated)
		GInfo.LastChlenixUpdate.Text = "Last CHLENIX update: "..v.CHLXUpd
	end)
	GInfo.Base.Parent = self.SGAMES_Holder
end

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

	local toReturnPage = 
		{
			Base = EX_Page;
			Hub = self;
		}

	setmetatable(toReturnPage, pageDef)

	return toReturnPage
end

function hubDef:switchPage(page)
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

function hubDef:toggleWindow(skipAnim)
	local t1 = 0.3
	local t2 = 0.2

	local s1 = UDim2.new(0, 600, 0, 20)
	local s2 = UDim2.new(0, 600, 0, 300)

	if skipAnim == true then
		t1 = 0
		t2 = 0
	end

	if self.Active == true then
		self.Active = false
		s1 = UDim2.new(0, 0, 0, 20)
		s2 = UDim2.new(0, 600, 0, 0)
		local animn2 = createTween(self.Base, t2, "In", "Quad", {Size = s2})
		animn2:Play()
		animn2.Completed:Wait()
		local animn = createTween(self.Header, t1, "InOut", "Quad", {Size  = s1})
		animn:Play()
		animn.Completed:Wait()
		self.Header.Visible = false
		return
	end
	self.Active = true
	self.Header.Visible = true
	local animn = createTween(self.Header, t1, "InOut", "Quad", {Size  = s1})
	animn:Play()
	animn.Completed:Wait()
	local animn2 = createTween(self.Base, t2, "In", "Quad", {Size = s2})
	animn2:Play()
	animn2.Completed:Wait()
end

function hubDef:SummonDropdown(dropSetting)
	for i,v in pairs(self.PUD_Holder:GetChildren()) do
		if v:IsA("GuiButton") then
			v:Destroy()
		end
	end
	for i,v in pairs(dropSetting.DropOptions) do
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
			if dropSetting.QuickFire ~= nil then
				dropSetting.SelectedOption = v
				dropSetting.QuickFire.Text = v.optionName
			end
			v.func()
		end)
	end
	self.PopUpDropdown.Visible = true
	self:toggleShadow()
	self.PUD_Header.Text = dropSetting.DropName.Text
	self.PUD_HEADER_Close.MouseButton1Down:Connect(function()
		self:toggleShadow()
		self.PopUpDropdown.Visible = false
	end)
	self.PUD_Search:GetPropertyChangedSignal("Text"):Connect(function() --вообще должен был быть getattribute changed signal, но он чё то не работает
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

function hubDef:Destroy()
	self.GUI:Destroy()
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

	local toReturnCategory = 
		{
			NameLabel = EX_CategoryName;
			Base = EX_Category;
			Page = self;
			Objects = 
			{
				Checkboxes = {};
				OneTimePressButtons = {};
				Textboxes = {};
				Dropdowns = {};
			};
		}

	setmetatable(toReturnCategory, categoryDef)

	return toReturnCategory
end

function pageDef:GetHub()
	return self.Hub
end

--function pageDef:Destroy()
--self.Base:Destroy()
--end

-- Category Functions

function categoryDef:newZone()
	local Zone = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	
	Zone.AutomaticSize = Enum.AutomaticSize.X
	Zone.Name = randomstring()
	Zone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Zone.BackgroundTransparency = 1
	Zone.Size = UDim2.new(0, 0, 0, 20)

	UIListLayout.Parent = Zone
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)
	
	Zone.Parent = self.Base
	
	local toReturn = 
		{
			Base = Zone;
			Objects = {};
			Category = self;
		}
	
	setmetatable(toReturn, zoneDef)
	
	return toReturn
end

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

	local theCheckbox = 
		{
			Checked = false;
			Check = EX_CB_C_ClickDetector.MouseButton1Down;
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

	table.insert(self.Objects.Checkboxes, theCheckbox)

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

	local toReturnTextBox = 
		{
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

	table.insert(self.Objects.Textboxes, toReturnTextBox)

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

	local OTP = 
		{
			MouseButton1Down = OneTimePress.MouseButton1Down;
			Base = OneTimePress;
			Category = self;
		}

	setmetatable(OTP, oneTimePressDef)

	table.insert(self.Objects.OneTimePressButtons, OTP)

	return OTP
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
	Dropit.TextXAlignment = Enum.TextXAlignment.Center
	Dropit.TextYAlignment = Enum.TextYAlignment.Center

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

	local toReturnDropdown =
		{
			Base = EX_Dropdown;
			DropName = Dropname;
			QuickFire = option;
			SelectedOption = nil;
			DropOptions = {};
			Category = self;
		}

	setmetatable(toReturnDropdown, dropdownDef)

	table.insert(self.Objects.Dropdowns, toReturnDropdown)

	EX_Dropdown.Parent = self.Base

	option.MouseButton1Down:Connect(function()
		if toReturnDropdown.SelectedOption ~= nil then
			toReturnDropdown.SelectedOption.func()
		end
	end)
	local main = self:GetPage():GetHub()
	Dropit.MouseButton1Down:Connect(function()
		main:SummonDropdown(toReturnDropdown)
	end)

	return toReturnDropdown
end

function categoryDef:Destroy()
	self.NameLabel:Destroy()
	self.Base:Destroy()
	self.Objects = nil
end

function categoryDef:GetPage()
	return self.Page
end

-- OneTimePress Functions
function oneTimePressDef:Destroy()
	self.Base:Destroy()
	table.remove(self.Category.Objects.OneTimePressButtons, table.find(self.Category.Objects.OneTimePressButtons, self))
end
-- Dropdown Functions
function dropdownDef:Destroy()
	self.Base:Destroy()
	table.remove(self.Category.Objects.Dropdowns, table.find(self.Category.Objects.Dropdowns, self))
end

function dropdownDef:AddOption(optionName, func)
	local index = #self.DropOptions + 1
	local option = {
		optionName = optionName;
		func = func;
	}

	setmetatable(option, dropdownOptionDef)

	table.insert(self.DropOptions, option)

	return self.DropOptions[index]
end

function dropdownDef:GetOption(name)
	for i,v in pairs(self.DropOptions) do
		if v.optionName == name then
			return {Option = v; Index = i}
		end
	end
	return nil
end

function dropdownDef:RemoveOption(option)
	local check = self:GetOption(option)
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
	table.remove(self.Category.Objects.Textboxes, table.find(self.Category.Objects.Textboxes, self))
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
	table.remove(self.Category.Objects.Checkboxes, table.find(self.Category.Objects.Checkboxes, self))
end

return CHLXBuilder