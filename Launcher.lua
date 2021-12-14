-- Instances:

local EzLauncher = {
	EzLauncher = Instance.new("ScreenGui"),
	Frame = Instance.new("Frame"),
	StatusSection = Instance.new("Frame"),
	SectionTopBar = Instance.new("Folder"),
	Frame_2 = Instance.new("Frame"),
	UICorner = Instance.new("UICorner"),
	Frame_3 = Instance.new("Frame"),
	TextLabel = Instance.new("TextLabel"),
	UICorner_2 = Instance.new("UICorner"),
	ContentFrame = Instance.new("Frame"),
	EzHubStatusFrame = Instance.new("Frame"),
	Status = Instance.new("TextLabel"),
	StatusName = Instance.new("TextLabel"),
	EzAPIStatusFrame = Instance.new("Frame"),
	Status_2 = Instance.new("TextLabel"),
	StatusName_2 = Instance.new("TextLabel"),
	EzLauncherStatusFrame = Instance.new("Frame"),
	Status_3 = Instance.new("TextLabel"),
	StatusName_3 = Instance.new("TextLabel"),
	UIListLayout = Instance.new("UIListLayout"),
	UICorner_3 = Instance.new("UICorner"),
	UIListLayout_2 = Instance.new("UIListLayout"),
	UIPadding = Instance.new("UIPadding"),
	NewsSection = Instance.new("Frame"),
	SectionTopBar_2 = Instance.new("Folder"),
	Frame_4 = Instance.new("Frame"),
	UICorner_4 = Instance.new("UICorner"),
	Frame_5 = Instance.new("Frame"),
	TextLabel_2 = Instance.new("TextLabel"),
	UICorner_5 = Instance.new("UICorner"),
	ContentFrame_2 = Instance.new("ScrollingFrame"),
	UIListLayout_3 = Instance.new("UIListLayout"),
	LaunchSection = Instance.new("Frame"),
	SectionTopBar_3 = Instance.new("Folder"),
	Frame_6 = Instance.new("Frame"),
	UICorner_6 = Instance.new("UICorner"),
	Frame_7 = Instance.new("Frame"),
	TextLabel_3 = Instance.new("TextLabel"),
	UICorner_7 = Instance.new("UICorner"),
	ContentFrame_3 = Instance.new("Frame"),
	ThemeSelectionFrame = Instance.new("Frame"),
	UICorner_8 = Instance.new("UICorner"),
	SelectionLeft = Instance.new("TextButton"),
	SelectionRight = Instance.new("TextButton"),
	SelectedLabel = Instance.new("TextLabel"),
	Launch = Instance.new("TextButton"),
	UICorner_9 = Instance.new("UICorner"),
	Containers = Instance.new("Folder"),
	NewsDivider = Instance.new("Frame"),
	UICorner_10 = Instance.new("UICorner"),
	NewsLabel = Instance.new("TextLabel"),
	UIPadding_2 = Instance.new("UIPadding"),
}

--Properties:

EzLauncher.EzLauncher.Name = "EzLauncher"
EzLauncher.EzLauncher.Parent = game.CoreGui
EzLauncher.EzLauncher.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

EzLauncher.Frame.Parent = EzLauncher.EzLauncher
EzLauncher.Frame.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.Frame.BackgroundColor3 = Color3.fromRGB(41, 53, 68)
EzLauncher.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
EzLauncher.Frame.Size = UDim2.new(0, 350, 0, 400)

EzLauncher.StatusSection.Name = "StatusSection"
EzLauncher.StatusSection.Parent = EzLauncher.Frame
EzLauncher.StatusSection.AnchorPoint = Vector2.new(0.5, 0)
EzLauncher.StatusSection.BackgroundColor3 = Color3.fromRGB(35, 47, 62)
EzLauncher.StatusSection.BorderSizePixel = 0
EzLauncher.StatusSection.Size = UDim2.new(1, -20, 0, 100)

EzLauncher.SectionTopBar.Name = "SectionTopBar"
EzLauncher.SectionTopBar.Parent = EzLauncher.StatusSection

EzLauncher.Frame_2.Parent = EzLauncher.SectionTopBar
EzLauncher.Frame_2.BackgroundColor3 = Color3.fromRGB(18, 98, 159)
EzLauncher.Frame_2.Size = UDim2.new(0, 2, 0, 32)

EzLauncher.UICorner.Parent = EzLauncher.Frame_2

EzLauncher.Frame_3.Parent = EzLauncher.SectionTopBar
EzLauncher.Frame_3.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
EzLauncher.Frame_3.BackgroundTransparency = 0.750
EzLauncher.Frame_3.BorderSizePixel = 0
EzLauncher.Frame_3.Position = UDim2.new(0, 0, 0, 32)
EzLauncher.Frame_3.Size = UDim2.new(1, 0, 0, 1)

EzLauncher.TextLabel.Parent = EzLauncher.SectionTopBar
EzLauncher.TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.TextLabel.BackgroundTransparency = 1.000
EzLauncher.TextLabel.Position = UDim2.new(0, 12, 0, 4)
EzLauncher.TextLabel.Size = UDim2.new(0, 299, 0, 24)
EzLauncher.TextLabel.Font = Enum.Font.SourceSans
EzLauncher.TextLabel.Text = "Server Status"
EzLauncher.TextLabel.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.TextLabel.TextSize = 14.000
EzLauncher.TextLabel.TextXAlignment = Enum.TextXAlignment.Left

EzLauncher.UICorner_2.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_2.Parent = EzLauncher.StatusSection

EzLauncher.ContentFrame.Name = "ContentFrame"
EzLauncher.ContentFrame.Parent = EzLauncher.StatusSection
EzLauncher.ContentFrame.AnchorPoint = Vector2.new(0.5, 1)
EzLauncher.ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.ContentFrame.BackgroundTransparency = 1.000
EzLauncher.ContentFrame.Position = UDim2.new(0.5, 0, 1, -2)
EzLauncher.ContentFrame.Size = UDim2.new(1, -20, 0, 60)

EzLauncher.EzHubStatusFrame.Name = "EzHubStatusFrame"
EzLauncher.EzHubStatusFrame.Parent = EzLauncher.ContentFrame
EzLauncher.EzHubStatusFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.EzHubStatusFrame.BackgroundTransparency = 1.000
EzLauncher.EzHubStatusFrame.LayoutOrder = 2
EzLauncher.EzHubStatusFrame.Position = UDim2.new(0, 10, 0, 38)
EzLauncher.EzHubStatusFrame.Size = UDim2.new(0, 60, 0, 60)

EzLauncher.Status.Name = "Status"
EzLauncher.Status.Parent = EzLauncher.EzHubStatusFrame
EzLauncher.Status.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.Status.BackgroundTransparency = 1.000
EzLauncher.Status.Position = UDim2.new(0.5, 0, 0.5, 12)
EzLauncher.Status.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.Status.Font = Enum.Font.SourceSans
EzLauncher.Status.Text = "Online"
EzLauncher.Status.TextColor3 = Color3.fromRGB(45, 192, 179)
EzLauncher.Status.TextSize = 20.000

EzLauncher.StatusName.Name = "StatusName"
EzLauncher.StatusName.Parent = EzLauncher.EzHubStatusFrame
EzLauncher.StatusName.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.StatusName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.StatusName.BackgroundTransparency = 1.000
EzLauncher.StatusName.Position = UDim2.new(0.5, 0, 0.5, -12)
EzLauncher.StatusName.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.StatusName.Font = Enum.Font.SourceSans
EzLauncher.StatusName.Text = "Ez Hub"
EzLauncher.StatusName.TextColor3 = Color3.fromRGB(92, 106, 124)
EzLauncher.StatusName.TextSize = 14.000

EzLauncher.EzAPIStatusFrame.Name = "EzAPIStatusFrame"
EzLauncher.EzAPIStatusFrame.Parent = EzLauncher.ContentFrame
EzLauncher.EzAPIStatusFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.EzAPIStatusFrame.BackgroundTransparency = 1.000
EzLauncher.EzAPIStatusFrame.LayoutOrder = 3
EzLauncher.EzAPIStatusFrame.Position = UDim2.new(0, 80, 0, 38)
EzLauncher.EzAPIStatusFrame.Size = UDim2.new(0, 60, 0, 60)

EzLauncher.Status_2.Name = "Status"
EzLauncher.Status_2.Parent = EzLauncher.EzAPIStatusFrame
EzLauncher.Status_2.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.Status_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.Status_2.BackgroundTransparency = 1.000
EzLauncher.Status_2.Position = UDim2.new(0.5, 0, 0.5, 12)
EzLauncher.Status_2.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.Status_2.Font = Enum.Font.SourceSans
EzLauncher.Status_2.Text = "Online"
EzLauncher.Status_2.TextColor3 = Color3.fromRGB(45, 192, 179)
EzLauncher.Status_2.TextSize = 20.000

EzLauncher.StatusName_2.Name = "StatusName"
EzLauncher.StatusName_2.Parent = EzLauncher.EzAPIStatusFrame
EzLauncher.StatusName_2.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.StatusName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.StatusName_2.BackgroundTransparency = 1.000
EzLauncher.StatusName_2.Position = UDim2.new(0.5, 0, 0.5, -12)
EzLauncher.StatusName_2.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.StatusName_2.Font = Enum.Font.SourceSans
EzLauncher.StatusName_2.Text = "Ez API"
EzLauncher.StatusName_2.TextColor3 = Color3.fromRGB(92, 106, 124)
EzLauncher.StatusName_2.TextSize = 14.000

EzLauncher.EzLauncherStatusFrame.Name = "EzLauncherStatusFrame"
EzLauncher.EzLauncherStatusFrame.Parent = EzLauncher.ContentFrame
EzLauncher.EzLauncherStatusFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.EzLauncherStatusFrame.BackgroundTransparency = 1.000
EzLauncher.EzLauncherStatusFrame.LayoutOrder = 1
EzLauncher.EzLauncherStatusFrame.Position = UDim2.new(0, 150, 0, 38)
EzLauncher.EzLauncherStatusFrame.Size = UDim2.new(0, 60, 0, 60)

EzLauncher.Status_3.Name = "Status"
EzLauncher.Status_3.Parent = EzLauncher.EzLauncherStatusFrame
EzLauncher.Status_3.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.Status_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.Status_3.BackgroundTransparency = 1.000
EzLauncher.Status_3.Position = UDim2.new(0.5, 0, 0.5, 12)
EzLauncher.Status_3.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.Status_3.Font = Enum.Font.SourceSans
EzLauncher.Status_3.Text = "Online"
EzLauncher.Status_3.TextColor3 = Color3.fromRGB(45, 192, 179)
EzLauncher.Status_3.TextSize = 20.000

EzLauncher.StatusName_3.Name = "StatusName"
EzLauncher.StatusName_3.Parent = EzLauncher.EzLauncherStatusFrame
EzLauncher.StatusName_3.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.StatusName_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.StatusName_3.BackgroundTransparency = 1.000
EzLauncher.StatusName_3.Position = UDim2.new(0.5, 0, 0.5, -12)
EzLauncher.StatusName_3.Size = UDim2.new(0, 50, 0, 30)
EzLauncher.StatusName_3.Font = Enum.Font.SourceSans
EzLauncher.StatusName_3.Text = "Ez Launcher"
EzLauncher.StatusName_3.TextColor3 = Color3.fromRGB(92, 106, 124)
EzLauncher.StatusName_3.TextSize = 14.000

EzLauncher.UIListLayout.Parent = EzLauncher.ContentFrame
EzLauncher.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
EzLauncher.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
EzLauncher.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
EzLauncher.UIListLayout.Padding = UDim.new(0, 25)

EzLauncher.UICorner_3.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_3.Parent = EzLauncher.Frame

EzLauncher.UIListLayout_2.Parent = EzLauncher.Frame
EzLauncher.UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
EzLauncher.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
EzLauncher.UIListLayout_2.Padding = UDim.new(0, 5)

EzLauncher.UIPadding.Parent = EzLauncher.Frame
EzLauncher.UIPadding.PaddingBottom = UDim.new(0, 10)
EzLauncher.UIPadding.PaddingTop = UDim.new(0, 10)

EzLauncher.NewsSection.Name = "NewsSection"
EzLauncher.NewsSection.Parent = EzLauncher.Frame
EzLauncher.NewsSection.AnchorPoint = Vector2.new(0.5, 0)
EzLauncher.NewsSection.BackgroundColor3 = Color3.fromRGB(35, 47, 62)
EzLauncher.NewsSection.BorderSizePixel = 0
EzLauncher.NewsSection.Size = UDim2.new(1, -20, 0, 150)

EzLauncher.SectionTopBar_2.Name = "SectionTopBar"
EzLauncher.SectionTopBar_2.Parent = EzLauncher.NewsSection

EzLauncher.Frame_4.Parent = EzLauncher.SectionTopBar_2
EzLauncher.Frame_4.BackgroundColor3 = Color3.fromRGB(18, 98, 159)
EzLauncher.Frame_4.Size = UDim2.new(0, 2, 0, 32)

EzLauncher.UICorner_4.Parent = EzLauncher.Frame_4

EzLauncher.Frame_5.Parent = EzLauncher.SectionTopBar_2
EzLauncher.Frame_5.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
EzLauncher.Frame_5.BackgroundTransparency = 0.750
EzLauncher.Frame_5.BorderSizePixel = 0
EzLauncher.Frame_5.Position = UDim2.new(0, 0, 0, 32)
EzLauncher.Frame_5.Size = UDim2.new(1, 0, 0, 1)

EzLauncher.TextLabel_2.Parent = EzLauncher.SectionTopBar_2
EzLauncher.TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.TextLabel_2.BackgroundTransparency = 1.000
EzLauncher.TextLabel_2.Position = UDim2.new(0, 12, 0, 4)
EzLauncher.TextLabel_2.Size = UDim2.new(0, 299, 0, 24)
EzLauncher.TextLabel_2.Font = Enum.Font.SourceSans
EzLauncher.TextLabel_2.Text = "News"
EzLauncher.TextLabel_2.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.TextLabel_2.TextSize = 14.000
EzLauncher.TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left

EzLauncher.UICorner_5.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_5.Parent = EzLauncher.NewsSection

EzLauncher.ContentFrame_2.Name = "ContentFrame"
EzLauncher.ContentFrame_2.Parent = EzLauncher.NewsSection
EzLauncher.ContentFrame_2.Active = true
EzLauncher.ContentFrame_2.AnchorPoint = Vector2.new(0.5, 1)
EzLauncher.ContentFrame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.ContentFrame_2.BackgroundTransparency = 1.000
EzLauncher.ContentFrame_2.BorderSizePixel = 0
EzLauncher.ContentFrame_2.Position = UDim2.new(0.5, 0, 1, -8)
EzLauncher.ContentFrame_2.Size = UDim2.new(1, -20, 0, 100)
EzLauncher.ContentFrame_2.CanvasSize = UDim2.new(0, 0, 0, 0)
EzLauncher.ContentFrame_2.ScrollBarThickness = 4

EzLauncher.UIListLayout_3.Parent = EzLauncher.ContentFrame_2
EzLauncher.UIListLayout_3.HorizontalAlignment = Enum.HorizontalAlignment.Center
EzLauncher.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
EzLauncher.UIListLayout_3.Padding = UDim.new(0, 5)

EzLauncher.LaunchSection.Name = "LaunchSection"
EzLauncher.LaunchSection.Parent = EzLauncher.Frame
EzLauncher.LaunchSection.AnchorPoint = Vector2.new(0.5, 0)
EzLauncher.LaunchSection.BackgroundColor3 = Color3.fromRGB(35, 47, 62)
EzLauncher.LaunchSection.BorderSizePixel = 0
EzLauncher.LaunchSection.Size = UDim2.new(1, -20, 0, 120)

EzLauncher.SectionTopBar_3.Name = "SectionTopBar"
EzLauncher.SectionTopBar_3.Parent = EzLauncher.LaunchSection

EzLauncher.Frame_6.Parent = EzLauncher.SectionTopBar_3
EzLauncher.Frame_6.BackgroundColor3 = Color3.fromRGB(18, 98, 159)
EzLauncher.Frame_6.Size = UDim2.new(0, 2, 0, 32)

EzLauncher.UICorner_6.Parent = EzLauncher.Frame_6

EzLauncher.Frame_7.Parent = EzLauncher.SectionTopBar_3
EzLauncher.Frame_7.BackgroundColor3 = Color3.fromRGB(112, 112, 112)
EzLauncher.Frame_7.BackgroundTransparency = 0.750
EzLauncher.Frame_7.BorderSizePixel = 0
EzLauncher.Frame_7.Position = UDim2.new(0, 0, 0, 32)
EzLauncher.Frame_7.Size = UDim2.new(1, 0, 0, 1)

EzLauncher.TextLabel_3.Parent = EzLauncher.SectionTopBar_3
EzLauncher.TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.TextLabel_3.BackgroundTransparency = 1.000
EzLauncher.TextLabel_3.Position = UDim2.new(0, 12, 0, 4)
EzLauncher.TextLabel_3.Size = UDim2.new(0, 299, 0, 24)
EzLauncher.TextLabel_3.Font = Enum.Font.SourceSans
EzLauncher.TextLabel_3.Text = "Launcher / Other"
EzLauncher.TextLabel_3.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.TextLabel_3.TextSize = 14.000
EzLauncher.TextLabel_3.TextXAlignment = Enum.TextXAlignment.Left

EzLauncher.UICorner_7.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_7.Parent = EzLauncher.LaunchSection

EzLauncher.ContentFrame_3.Name = "ContentFrame"
EzLauncher.ContentFrame_3.Parent = EzLauncher.LaunchSection
EzLauncher.ContentFrame_3.AnchorPoint = Vector2.new(0.5, 1)
EzLauncher.ContentFrame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.ContentFrame_3.BackgroundTransparency = 1.000
EzLauncher.ContentFrame_3.BorderColor3 = Color3.fromRGB(27, 42, 53)
EzLauncher.ContentFrame_3.Position = UDim2.new(0.5, 0, 1, -8)
EzLauncher.ContentFrame_3.Size = UDim2.new(1, -20, 0, 70)

EzLauncher.ThemeSelectionFrame.Name = "ThemeSelectionFrame"
EzLauncher.ThemeSelectionFrame.Parent = EzLauncher.ContentFrame_3
EzLauncher.ThemeSelectionFrame.AnchorPoint = Vector2.new(0, 1)
EzLauncher.ThemeSelectionFrame.BackgroundColor3 = Color3.fromRGB(41, 84, 178)
EzLauncher.ThemeSelectionFrame.Position = UDim2.new(0, 0, 1, -4)
EzLauncher.ThemeSelectionFrame.Size = UDim2.new(0, 150, 0, 30)

EzLauncher.UICorner_8.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_8.Parent = EzLauncher.ThemeSelectionFrame

EzLauncher.SelectionLeft.Name = "SelectionLeft"
EzLauncher.SelectionLeft.Parent = EzLauncher.ThemeSelectionFrame
EzLauncher.SelectionLeft.AnchorPoint = Vector2.new(0, 0.5)
EzLauncher.SelectionLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.SelectionLeft.BackgroundTransparency = 1.000
EzLauncher.SelectionLeft.Position = UDim2.new(0, 5, 0.5, 0)
EzLauncher.SelectionLeft.Size = UDim2.new(0, 20, 0, 20)
EzLauncher.SelectionLeft.Font = Enum.Font.SourceSans
EzLauncher.SelectionLeft.Text = "<"
EzLauncher.SelectionLeft.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.SelectionLeft.TextSize = 14.000

EzLauncher.SelectionRight.Name = "SelectionRight"
EzLauncher.SelectionRight.Parent = EzLauncher.ThemeSelectionFrame
EzLauncher.SelectionRight.AnchorPoint = Vector2.new(1, 0.5)
EzLauncher.SelectionRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.SelectionRight.BackgroundTransparency = 1.000
EzLauncher.SelectionRight.Position = UDim2.new(1, -5, 0.5, 0)
EzLauncher.SelectionRight.Size = UDim2.new(0, 20, 0, 20)
EzLauncher.SelectionRight.Font = Enum.Font.SourceSans
EzLauncher.SelectionRight.Text = ">"
EzLauncher.SelectionRight.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.SelectionRight.TextSize = 14.000

EzLauncher.SelectedLabel.Name = "SelectedLabel"
EzLauncher.SelectedLabel.Parent = EzLauncher.ThemeSelectionFrame
EzLauncher.SelectedLabel.AnchorPoint = Vector2.new(0.5, 0.5)
EzLauncher.SelectedLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
EzLauncher.SelectedLabel.BackgroundTransparency = 1.000
EzLauncher.SelectedLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
EzLauncher.SelectedLabel.Size = UDim2.new(1, -54, 1, -2)
EzLauncher.SelectedLabel.Font = Enum.Font.SourceSans
EzLauncher.SelectedLabel.Text = "Default Theme"
EzLauncher.SelectedLabel.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.SelectedLabel.TextSize = 14.000

EzLauncher.Launch.Name = "Launch"
EzLauncher.Launch.Parent = EzLauncher.ContentFrame_3
EzLauncher.Launch.BackgroundColor3 = Color3.fromRGB(41, 84, 178)
EzLauncher.Launch.Size = UDim2.new(0, 150, 0, 30)
EzLauncher.Launch.Font = Enum.Font.SourceSans
EzLauncher.Launch.Text = "Launch"
EzLauncher.Launch.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.Launch.TextSize = 14.000

EzLauncher.UICorner_9.CornerRadius = UDim.new(0, 4)
EzLauncher.UICorner_9.Parent = EzLauncher.Launch

EzLauncher.Containers.Name = "Containers"
EzLauncher.Containers.Parent = EzLauncher.EzLauncher

EzLauncher.NewsDivider.Name = "NewsDivider"
EzLauncher.NewsDivider.Parent = EzLauncher.Containers
EzLauncher.NewsDivider.BackgroundColor3 = Color3.fromRGB(18, 98, 159)
EzLauncher.NewsDivider.LayoutOrder = 1
EzLauncher.NewsDivider.Size = UDim2.new(1, -10, 0, 3)
EzLauncher.NewsDivider.Visible = false

EzLauncher.UICorner_10.Parent = EzLauncher.NewsDivider

EzLauncher.NewsLabel.Name = "NewsLabel"
EzLauncher.NewsLabel.Parent = EzLauncher.Containers
EzLauncher.NewsLabel.BackgroundColor3 = Color3.fromRGB(28, 41, 56)
EzLauncher.NewsLabel.BackgroundTransparency = 1.000
EzLauncher.NewsLabel.Size = UDim2.new(1, -8, 0, 30)
EzLauncher.NewsLabel.Visible = false
EzLauncher.NewsLabel.Font = Enum.Font.SourceSans
EzLauncher.NewsLabel.Text = ""
EzLauncher.NewsLabel.TextColor3 = Color3.fromRGB(211, 216, 226)
EzLauncher.NewsLabel.TextSize = 14.000
EzLauncher.NewsLabel.TextWrapped = true
EzLauncher.NewsLabel.TextXAlignment = Enum.TextXAlignment.Left

EzLauncher.UIPadding_2.Parent = EzLauncher.NewsLabel
EzLauncher.UIPadding_2.PaddingBottom = UDim.new(0, 5)
EzLauncher.UIPadding_2.PaddingLeft = UDim.new(0, 5)
EzLauncher.UIPadding_2.PaddingRight = UDim.new(0, 5)
EzLauncher.UIPadding_2.PaddingTop = UDim.new(0, 5)

--------------------------------------------------------------------
-- Gui to lua manual properties

EzLauncher.Containers.NewsLabel.AutomaticSize = Enum.AutomaticSize.Y;
EzLauncher.NewsSection.ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
EzLauncher.NewsSection.ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(112, 112, 112);

--------------------------------------------------------------------
-- Get launcher data

EzLauncher.EzLauncher.Enabled = false;

local launcherData = game:GetService("HttpService"):JSONDecode(
	(game:HttpGet("https://raw.githubusercontent.com/debug420/Ez-Industries-Launcher-Data/master/LauncherData.json")));

EzLauncher.EzLauncher.Enabled = true;

--------------------------------------------------------------------
-- Startup animation

-- Essentially changes the visibillity of the descendants of the main frame of the launcher
local function changeElementState(state)
	for i,v in pairs(EzLauncher.EzLauncher.Frame:GetDescendants()) do
		if v:IsA("GuiObject") then
			v.Visible = state;
		end
	end
end

changeElementState(false);

local oldSize = EzLauncher.EzLauncher.Frame.Size;
EzLauncher.EzLauncher.Frame.Size = UDim2.new(0,0,0,0);

EzLauncher.EzLauncher.Frame:TweenSize(oldSize, Enum.EasingDirection.Out,
	Enum.EasingStyle.Quad, 0.3);

wait(0.35);

changeElementState(true);

--------------------------------------------------------------------
-- Get all the launcher data necessary

local newsData = launcherData["NewsData"];
local statusData = launcherData["StatusData"];
local latestVersion = launcherData["LatestVersion"];
local themes = launcherData["Themes"];

--------------------------------------------------------------------
-- Apply the launcher data: News

for i,v in pairs(newsData) do

	local newsOrder = v[1] * -1;	-- This is to make it sort in a different order
	local newsText = v[2];

	if newsText == "@DIVIDER" then
		local div = EzLauncher.NewsDivider:Clone();
		div.LayoutOrder = newsOrder;
		div.Parent = EzLauncher.NewsSection.ContentFrame;
		div.Visible = true;
	else
		local container = EzLauncher.NewsLabel:Clone();
		container.Text = newsText;
		container.LayoutOrder = newsOrder;
		container.Parent = EzLauncher.NewsSection.ContentFrame;
		container.Visible = true;
	end

end

--------------------------------------------------------------------
-- Apply the launcher data: Status

EzLauncher.EzHubStatusFrame.Status.Text = statusData["EzHub"];
EzLauncher.EzAPIStatusFrame.Status.Text = statusData["EzAPI"];
EzLauncher.EzLauncherStatusFrame.Status.Text = statusData["EzLauncher"];

if EzLauncher.EzHubStatusFrame.Status.Text == "Offline" then
	EzLauncher.EzHubStatusFrame.Status.TextColor3 = Color3.fromRGB(192, 49, 52)
end
if EzLauncher.EzAPIStatusFrame.Status.Text == "Offline" then
	EzLauncher.EzAPIStatusFrame.Status.TextColor3 = Color3.fromRGB(192, 49, 52)
end
if EzLauncher.EzLauncherStatusFrame.Status.Text == "Offline" then
	EzLauncher.EzLauncherStatusFrame.Status.TextColor3 = Color3.fromRGB(192, 49, 52)
end

--------------------------------------------------------------------
-- Apply the launcher data: Themes

local selectedTheme = "Default";
local currentThemeIndex = themes[selectedTheme]["ThemeIndex"];
local highestThemeIndex = (function()
	local highest = 0;
	for i,v in pairs(themes) do
		if v["ThemeIndex"] > highest then highest = v["ThemeIndex"]; end
	end
	return highest;
end)();

local function getThemeWithThemeIndex(themeIndex)
	for i,v in pairs(themes) do
		if v["ThemeIndex"] == themeIndex then return i; end
	end
end

local function updateSelectedTheme()
	selectedTheme = getThemeWithThemeIndex(currentThemeIndex);
	EzLauncher.SelectedLabel.Text = selectedTheme;
end

EzLauncher.SelectionRight.MouseButton1Click:Connect(function()
	if currentThemeIndex == highestThemeIndex then
		currentThemeIndex = 1;
	else
		currentThemeIndex = currentThemeIndex + 1;
	end
	updateSelectedTheme();
end)

EzLauncher.SelectionLeft.MouseButton1Click:Connect(function()
	if currentThemeIndex == 1 then
		currentThemeIndex = highestThemeIndex;
	else
		currentThemeIndex = currentThemeIndex - 1;
	end
	updateSelectedTheme();
end)

--------------------------------------------------------------------
-- Apply the launcher data: latest version

-- List of accouonts that can launch Ez Hub regardless of the status
-- Note that the status is just to prevent users from executing Ez Hub when it is in testing/broken stages
-- Therefore there is no need for any type of secure whitelist
local allowedOverrideUsers = {
	2626915991,
	1274116266,
	2626881906,
	2626911435,
	1608045548,
	1593772727,
	2821690140,
	269429714,
	1772649133,
	1818847308,
	382498,
	1606794809
}

EzLauncher.Launch.MouseButton1Click:Connect(function()
	
	-- Check if services are down
	if not table.find(allowedOverrideUsers, game.Players.LocalPlayer.UserId) and (EzLauncher.EzHubStatusFrame.Status.Text == "Offline" or
	EzLauncher.EzAPIStatusFrame.Status.Text == "Offline" or
	EzLauncher.EzLauncherStatusFrame.Status.Text == "Offline") then
		spawn(function()
			EzLauncher.Launch.Text = "Service Offline";
			wait(3);
			EzLauncher.Launch.Text = "Launch";
		end)
		return;
	end

	EzLauncher.Launch.Text = "Launching...";

	-- Apply the theme before launching Ez Hub
	_G.EzHubTheme = themes[selectedTheme];
	loadstring(game:HttpGet(latestVersion))();

	changeElementState(false)

	EzLauncher.EzLauncher.Frame:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.Out,
		Enum.EasingStyle.Quad, 0.5, false, function()
			EzLauncher.EzLauncher:Destroy();
		end);

end)

--------------------------------------------------------------------
-- Dragify

local function dragify(MainFrame)

	local dragging;
	local dragInput;
	local dragStart;
	local startPos;

	local function update(input)
		local Delta = input.Position - dragStart;
		local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y);
		game:GetService("TweenService"):Create(MainFrame, TweenInfo.new(.15), {Position = Position}):Play();
	end

	MainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true;
			dragStart = input.Position;
			startPos = MainFrame.Position;

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false;
				end
			end)
		end
	end)

	MainFrame.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input;
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input);
		end
	end)
end

dragify(EzLauncher.EzLauncher.Frame);
