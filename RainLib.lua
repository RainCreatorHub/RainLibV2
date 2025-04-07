local RainLib = {
    Version = "1.1.0",
    Themes = {
        Dark = {
            Background = Color3.fromRGB(30, 30, 30),
            Accent = Color3.fromRGB(50, 150, 255),
            Text = Color3.fromRGB(255, 255, 255),
            Secondary = Color3.fromRGB(50, 50, 50),
            Disabled = Color3.fromRGB(100, 100, 100)
        }
    },
    Icons = loadstring(game:HttpGet("https://raw.githubusercontent.com/RainCreatorHub/RainLib/main/Icons.lua"))(),
    Windows = {},
    CurrentTheme = nil
}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function tween(obj, info, properties)
    local tween = TweenService:Create(obj, info or TweenInfo.new(0.3), properties)
    tween:Play()
    return tween
end

local success, err = pcall(function()
    RainLib.ScreenGui = Instance.new("ScreenGui")
    RainLib.ScreenGui.Name = "RainLib"
    RainLib.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui", 5)
    RainLib.ScreenGui.ResetOnSpawn = false
    RainLib.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    RainLib.CurrentTheme = RainLib.Themes.Dark
    RainLib.Notifications = Instance.new("Frame")
    RainLib.Notifications.Size = UDim2.new(0, 300, 1, 0)
    RainLib.Notifications.Position = UDim2.new(1, -310, 0, 0)
    RainLib.Notifications.BackgroundTransparency = 1
    RainLib.Notifications.Parent = RainLib.ScreenGui
end)
if not success887 then
    return nil
end

function RainLib:Window(options)
    local window = {}
    options = options or {}
    
    window.Title = options.Title or "Rain Lib"
    window.Size = options.Size or UDim2.new(0, 500, 0, 350)
    window.Position = options.Position or UDim2.new(0.5, -250, 0.5, -175)
    window.Minimized = false
    window.Tabs = {}
    window.CurrentTabIndex = 1
    window.MinimizeButton = nil
    
    local success, err = pcall(function()
        window.MainFrame = Instance.new("Frame")
        window.MainFrame.Size = window.Size
        window.MainFrame.Position = window.Position
        window.MainFrame.BackgroundColor3 = RainLib.CurrentTheme.Background
        window.MainFrame.ClipsDescendants = true
        window.MainFrame.Parent = RainLib.ScreenGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = window.MainFrame
        
        local shadow = Instance.new("ImageLabel")
        shadow.Size = UDim2.new(1, 20, 1, 20)
        shadow.Position = UDim2.new(0, -10, 0, -10)
        shadow.BackgroundTransparency = 1
        shadow.Image = "rbxassetid://1316045217"
        shadow.ImageTransparency = 0.7
        shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
        shadow.ScaleType = Enum.ScaleType.Slice
        shadow.SliceCenter = Rect.new(10, 10, 118, 118)
        shadow.Parent = window.MainFrame
        
        window.TitleBar = Instance.new("Frame")
        window.TitleBar.Size = UDim2.new(1, 0, 0, 40)
        window.TitleBar.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TitleBar.Parent = window.MainFrame
        
        window.TitleLabel = Instance.new("TextLabel")
        window.TitleLabel.Size = UDim2.new(1, -40, 1, 0)
        window.TitleLabel.Position = UDim2.new(0, 10, 0, 0)
        window.TitleLabel.BackgroundTransparency = 1
        window.TitleLabel.Text = window.Title
        window.TitleLabel.TextColor3 = RainLib.CurrentTheme.Text
        window.TitleLabel.Font = Enum.Font.GothamBold
        window.TitleLabel.TextSize = 16
        window.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
        window.TitleLabel.Parent = window.TitleBar
        
        window.CloseButton = Instance.new("TextButton")
        window.CloseButton.Size = UDim2.new(0, 30, 0, 30)
        window.CloseButton.Position = UDim2.new(1, -35, 0, 5)
        window.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        window.CloseButton.Text = "X"
        window.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseButton.Font = Enum.Font.SourceSansBold
        window.CloseButton.TextSize = 16
        window.CloseButton.Parent = window.TitleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 8)
        closeCorner.Parent = window.CloseButton
        
        window.TabContainer = Instance.new("ScrollingFrame")
        window.TabContainer.Size = UDim2.new(0, 150, 1, -40)
        window.TabContainer.Position = UDim2.new(0, 0, 0, 40)
        window.TabContainer.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        window.TabContainer.ScrollBarThickness = 0
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0,硬 0)
        window.TabContainer.Parent = window.MainFrame
        
        window.TabIndicator = Instance.new("Frame")
        window.TabIndicator.Size = UDim2.new(0, 3, 0, 40)
        window.TabIndicator.BackgroundColor3 = RainLib.CurrentTheme.Accent
        window.TabIndicator.Position = UDim2.new(0, 0, 0, 5)
        window.TabIndicator.Parent = window.TabContainer
    end)
    if not success then
        return nil
    end
    
    window.CloseButton.MouseButton1Click:Connect(function()
        if window.MinimizeButton then
            window.MinimizeButton:Destroy()
            window.MinimizeButton = nil
        end
        window.MainFrame:Destroy()
    end)
    
    local dragging, dragStart, startPos
    window.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = window.MainFrame.Position
        end
    end)
    
    window.TitleBar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            window.MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
    
    window.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    function window:Minimize(options)
        options = options or {}
        local button
        local success, err = pcall(function()
            button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 100, 0, 30)
            button.Position = UDim2.new(0, 10, 0, 10)
            button.Text = options.Text1 or "Close"
            button.BackgroundColor3 = RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            button.BackgroundTransparency = options.BackgroundTransparency or 0
            button.Parent = RainLib.ScreenGui
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = options.CornerRadius or UDim.new(0, 8)
            corner.Parent = button
            
            button.MouseButton1Click:Connect(function()
                window.MainFrame.Visible = not window.MainFrame.Visible
                button.Text = window.MainFrame.Visible and (options.Text1 or "Close") or (options.Text2 or "Open")
            end)
            
            if options.Draggable then
                local draggingButton, dragStartButton, startPosButton
                button.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingButton = true
                        dragStartButton = input.Position
                        startPosButton = button.Position
                    end
                end)
                
                button.InputChanged:Connect(function(input)
                    if draggingButton and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local delta = input.Position - dragStartButton
                        button.Position = UDim2.new(
                            startPosButton.X.Scale,
                            startPosButton.X.Offset + delta.X,
                            startPosButton.Y.Scale,
                            startPosButton.Y.Offset + delta.Y
                        )
                    end
                end)
                
                button.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        draggingButton = false
                    end
                end)
            end
        end)
        
        if not success then
            warn("[RainLib] Falha ao criar botão de minimizar: " .. err)
            return nil
        end
        
        window.MinimizeButton = button
        return button
    end
    
    function window:Tab(options)
        local tab = {}
        options = options or {}
        tab.Name = options.Name or "Tab"
        tab.Icon = options.Icon or nil
        tab.ElementsPerRow = options.ElementsPerRow or 1
        tab.ElementCount = 0
        tab.TotalHeight = 0
        tab.OccupiedPositions = {} -- Tabela para rastrear posições ocupadas
        
        tab.Content = Instance.new("ScrollingFrame")
        tab.Content.Size = UDim2.new(1, -160, 1, -50)
        tab.Content.Position = UDim2.new(0, 155, 0, 45)
        tab.Content.BackgroundTransparency = 1
        tab.Content.ScrollBarThickness = 5
        tab.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
        tab.Content.Visible = false
        tab.Content.Parent = window.MainFrame
        
        tab.Container = Instance.new("Frame")
        tab.Container.Size = UDim2.new(1, -10, 0, 0)
        tab.Container.Position = UDim2.new(0, 5, 0, 5)
        tab.Container.BackgroundTransparency = 1
        tab.Container.Parent = tab.Content
        
        local containerCorner = Instance.new("UICorner")
        containerCorner.CornerRadius = UDim.new(0, 8)
        containerCorner.Parent = tab.Container
        
        local containerStroke = Instance.new("UIStroke")
        containerStroke.Thickness = 1
        containerStroke.Color = Color3.fromRGB(0, 0, 0)
        containerStroke.Parent = tab.Container
        
        tab.Button = Instance.new("TextButton")
        tab.Button.Size = UDim2.new(1, -10, 0, 40)
        tab.Button.Position = UDim2.new(0, 5, 0, #window.Tabs * 45 + 5)
        tab.Button.BackgroundColor3 = RainLib.CurrentTheme.Secondary
        tab.Button.BackgroundTransparency = 0
        tab.Button.Text = tab.Icon and "" or tab.Name
        tab.Button.TextColor3 = RainLib.CurrentTheme.Text
        tab.Button.Font = Enum.Font.SourceSansBold
        tab.Button.TextSize = 16
        tab.Button.TextXAlignment = Enum.TextXAlignment.Left
        tab.Button.Parent = window.TabContainer
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, #window.Tabs * 45 + 50)
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 8)
        buttonCorner.Parent = tab.Button
        
        if tab.Icon then
            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 24, 0, 24)
            icon.Position = UDim2.new(0, 5, 0.5, -12)
            icon.BackgroundTransparency = 1
            icon.Image = RainLib.Icons[tab.Icon] or tab.Icon
            icon.Parent = tab.Button
            
            local text = Instance.new("TextLabel")
            text.Size = UDim2.new(1, -40, 1, 0)
            text.Position = UDim2.new(0, 35, 0, 0)
            text.BackgroundTransparency = 1
            text.Text = tab.Name
            text.TextColor3 = RainLib.CurrentTheme.Text
            text.Font = Enum.Font.SourceSansBold
            text.TextSize = 16
            text.TextXAlignment = Enum.TextXAlignment.Left
            text.Parent = tab.Button
        else
            tab.Button.Position = UDim2.new(0, 15, 0, #window.Tabs * 45 + 5)
        end
        
        table.insert(window.Tabs, tab)
        
        local function selectTab(index)
            for i, t in pairs(window.Tabs) do
                if i == index then
                    t.Content.Visible = true
                    tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                    tween(window.TabIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, (i-1) * 45 + 5)})
                    tween(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Accent})
                    window.CurrentTabIndex = i
                else
                    tween(t.Content, TweenInfo.new(0.2), {BackgroundTransparency = 1})
                    tween(t.Button, TweenInfo.new(0.2), {BackgroundColor3 = RainLib.CurrentTheme.Secondary})
                    task.delay(0.2, function() t.Content.Visible = false end)
                end
            end
        end
        
        tab.Button.MouseButton1Click:Connect(function()
            local index = table.find(window.Tabs, tab)
            selectTab(index)
        end)
        
        if #window.Tabs == 1 then
            selectTab(1)
        end
        
        local function updateCanvasSize(height)
            tab.TotalHeight = math.max(tab.TotalHeight, height + 10) -- Atualiza a altura máxima
            tab.Container.Size = UDim2.new(1, -10, 0, tab.TotalHeight)
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, tab.TotalHeight)
        end
        
        local function getNextPosition(elementSize)
            local padding = 10
            local row = math.floor(tab.ElementCount / tab.ElementsPerRow)
            local col = tab.ElementCount % tab.ElementsPerRow
            local xOffset = padding + col * (elementSize.X.Offset + padding + 20) -- Inclui margem do container
            local yOffset = padding + row * (elementSize.Y.Offset + padding + 20)
            
            -- Verifica se a posição já está ocupada
            local positionKey = tostring(xOffset) .. "_" .. tostring(yOffset)
            if tab.OccupiedPositions[positionKey] then
                -- Se ocupada, move para a próxima linha
                row = row + 1
                yOffset = padding + row * (elementSize.Y.Offset + padding + 20)
                positionKey = tostring(xOffset) .. "_" .. tostring(yOffset)
            end
            
            tab.OccupiedPositions[positionKey] = true
            tab.ElementCount = tab.ElementCount + 1
            updateCanvasSize(yOffset + elementSize.Y.Offset + 20) -- Atualiza com a altura do container
            return UDim2.new(0, xOffset, 0, yOffset)
        end
        
        local function createContainer(element, size)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(0, size.X.Offset + 20, 0, size.Y.Offset + 20)
            container.Position = getNextPosition(size)
            container.BackgroundTransparency = 1
            container.Parent = tab.Container
            element.Parent = container
            element.Position = UDim2.new(0, 10, 0, 10)
            return container
        end
        
        function tab:AddSection(name)
            local sectionSize = UDim2.new(1, -10, 0, 20)
            local section = Instance.new("TextLabel")
            section.Size = sectionSize
            section.BackgroundTransparency = 1
            section.Text = name or "Section"
            section.TextColor3 = RainLib.CurrentTheme.Text
            section.Font = Enum.Font.GothamBold
            section.TextSize = 18
            section.TextXAlignment = Enum.TextXAlignment.Left
            
            local container = createContainer(section, sectionSize)
            return section
        end
        
        function tab:Button(options)
            local buttonSize = options.Size or UDim2.new(0, 100, 0, 30)
            local button = Instance.new("TextButton")
            button.Size = buttonSize
            button.Text = options.Text or "Button"
            button.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Accent
            button.TextColor3 = RainLib.CurrentTheme.Text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 16
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = button
            
            local container = createContainer(button, buttonSize)
            button.MouseButton1Click:Connect(options.Callback or function() end)
            return button
        end
        
        function tab:Textbox(options)
            local textboxSize = options.Size or UDim2.new(0, 100, 0, 30)
            local textbox = Instance.new("TextBox")
            textbox.Size = textboxSize
            textbox.Text = options.Text or ""
            textbox.BackgroundColor3 = options.BackgroundColor3 or RainLib.CurrentTheme.Secondary
            textbox.TextColor3 = RainLib.CurrentTheme.Text
            textbox.Font = Enum.Font.SourceSans
            textbox.TextSize = 16
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = textbox
            
            local container = createContainer(textbox, textboxSize)
            textbox.FocusLost:Connect(function(enterPressed)
                if enterPressed and options.Callback then
                    options.Callback(textbox.Text)
                end
            end)
            
            return textbox
        end
        
        function tab:Toggle(options)
            local toggleSize = options.Size or UDim2.new(0, 100, 0, 30)
            local toggle = { Value = options.Default or false }
            local frame = Instance.new("Frame")
            frame.Size = toggleSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 70, 1, 0)
            label.Text = options.Text or "Toggle"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 20, 0, 20)
            indicator.Position = UDim2.new(1, -25, 0.5, -10)
            indicator.BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled
            indicator.Parent = frame
            
            local indicatorCorner = Instance.new("UICorner")
            indicatorCorner.CornerRadius = UDim.new(0, 5)
            indicatorCorner.Parent = indicator
            
            local container = createContainer(frame, toggleSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    toggle.Value = not toggle.Value
                    tween(indicator, TweenInfo.new(0.2), {BackgroundColor3 = toggle.Value and RainLib.CurrentTheme.Accent or RainLib.CurrentTheme.Disabled})
                    if options.Callback then
                        options.Callback(toggle.Value)
                    end
                end
            end)
            
            return toggle
        end
        
        function tab:Slider(options)
            local sliderSize = options.Size or UDim2.new(0, 200, 0, 40)
            local slider = { Value = options.Default or 0 }
            local frame = Instance.new("Frame")
            frame.Size = sliderSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 100, 0, 20)
            label.Text = options.Text or "Slider"
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 50, 0, 20)
            valueLabel.Position = UDim2.new(1, -60, 0, 0)
            valueLabel.Text = tostring(slider.Value)
            valueLabel.BackgroundTransparency = 1
            valueLabel.TextColor3 = RainLib.CurrentTheme.Text
            valueLabel.Font = Enum.Font.SourceSans
            valueLabel.TextSize = 16
            valueLabel.Parent = frame
            
            local bar = Instance.new("Frame")
            bar.Size = UDim2.new(1, -10, 0, 10)
            bar.Position = UDim2.new(0, 5, 0, 25)
            bar.BackgroundColor3 = RainLib.CurrentTheme.Disabled
            bar.Parent = frame
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(slider.Value / (options.Max or 100), 0, 1, 0)
            fill.BackgroundColor3 = RainLib.CurrentTheme.Accent
            fill.Parent = bar
            
            local cornerBar = Instance.new("UICorner")
            cornerBar.CornerRadius = UDim.new(0, 5)
            cornerBar.Parent = bar
            
            local cornerFill = Instance.new("UICorner")
            cornerFill.CornerRadius = UDim.new(0, 5)
            cornerFill.Parent = fill
            
            local container = createContainer(frame, sliderSize)
            local dragging
            bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            bar.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            RunService.RenderStepped:Connect(function()
                if dragging then
                    local mousePos = UserInputService:GetMouseLocation()
                    local relativeX = math.clamp((mousePos.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
                    slider.Value = math.floor(relativeX * (options.Max or 100))
                    fill.Size = UDim2.new(relativeX, 0, 1, 0)
                    valueLabel.Text = tostring(slider.Value)
                    if options.Callback then
                        options.Callback(slider.Value)
                    end
                end
            end)
            
            return slider
        end
        
        function tab:Dropdown(options)
            local dropdownSize = options.Size or UDim2.new(0, 150, 0, 30)
            local dropdown = { Value = options.Default or options.Options[1] }
            local frame = Instance.new("Frame")
            frame.Size = dropdownSize
            frame.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 8)
            corner.Parent = frame
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -30, 1, 0)
            label.Text = dropdown.Value
            label.BackgroundTransparency = 1
            label.TextColor3 = RainLib.CurrentTheme.Text
            label.Font = Enum.Font.SourceSans
            label.TextSize = 16
            label.Parent = frame
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.Text = "▼"
            arrow.BackgroundTransparency = 1
            arrow.TextColor3 = RainLib.CurrentTheme.Text
            arrow.Font = Enum.Font.SourceSans
            arrow.TextSize = 16
            arrow.Parent = frame
            
            local list = Instance.new("Frame")
            list.Size = UDim2.new(1, 0, 0, #options.Options * 30)
            list.Position = UDim2.new(0, 0, 1, 5)
            list.BackgroundColor3 = RainLib.CurrentTheme.Secondary
            list.Visible = false
            list.Parent = frame
            
            local listCorner = Instance.new("UICorner")
            listCorner.CornerRadius = UDim.new(0, 8)
            listCorner.Parent = list
            
            for i, opt in ipairs(options.Options) do
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 30)
                btn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
                btn.Text = opt
                btn.BackgroundTransparency = 1
                btn.TextColor3 = RainLib.CurrentTheme.Text
                btn.Font = Enum.Font.SourceSans
                btn.TextSize = 16
                btn.Parent = list
                
                btn.MouseButton1Click:Connect(function()
                    dropdown.Value = opt
                    label.Text = opt
                    list.Visible = false
                    if options.Callback then
                        options.Callback(dropdown.Value)
                    end
                end)
            end
            
            local container = createContainer(frame, dropdownSize)
            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    list.Visible = not list.Visible
                end
            end)
            
            return dropdown
        end
        
        return tab
    end
    
    table.insert(RainLib.Windows, window)
    return window
end

function RainLib:Notify(options)
    local success, err = pcall(function()
        local notification = Instance.new("Frame")
        notification.Size = UDim2.new(0, 280, 0, 80)
        notification.Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)
        notification.BackgroundColor3 = RainLib.CurrentTheme.Background
        notification.Parent = RainLib.Notifications
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = notification
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -10, 0, 20)
        title.Position = UDim2.new(0, 5, 0, 5)
        title.Text = options.Title or "Notification"
        title.BackgroundTransparency = 1
        title.TextColor3 = RainLib.CurrentTheme.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 16
        title.Parent = notification
        
        local message = Instance.new("TextLabel")
        message.Size = UDim2.new(1, -10, 0, 40)
        message.Position = UDim2.new(0, 5, 0, 30)
        message.Text = options.Message or "Message"
        message.BackgroundTransparency = 1
        message.TextColor3 = RainLib.CurrentTheme.Text
        message.Font = Enum.Font.SourceSans
        message.TextSize = 14
        message.TextWrapped = true
        message.Parent = notification
        
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(0, 10, 0, (#RainLib.Notifications:GetChildren() - 1) * 90 + 10)})
        task.wait(options.Duration or 3)
        tween(notification, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 0, notification.Position.Y.Offset)}).Completed:Connect(function()
            notification:Destroy()
        end)
    end)
end

function RainLib:SetTheme(theme)
    local success, err = pcall(function()
        RainLib.CurrentTheme = theme
        for _, window in pairs(RainLib.Windows) do
            window.MainFrame.BackgroundColor3 = theme.Background
            window.TitleBar.BackgroundColor3 = theme.Secondary
            window.TitleLabel.TextColor3 = theme.Text
            window.TabContainer.BackgroundColor3 = theme.Secondary
            window.TabIndicator.BackgroundColor3 = theme.Accent
            for _, tab in pairs(window.Tabs) do
                tab.Button.TextColor3 = theme.Text
                if tab.Content.Visible then
                    tab.Button.BackgroundColor3 = theme.Accent
                else
                    tab.Button.BackgroundColor3 = theme.Secondary
                end
                for _, child in pairs(tab.Button:GetChildren()) do
                    if child:IsA("TextLabel") then
                        child.TextColor3 = theme.Text
                    end
                end
                for _, child in pairs(tab.Container:GetChildren()) do
                    if child:IsA("TextButton") or child:IsA("TextBox") then
                        child.BackgroundColor3 = theme.Accent
                        child.TextColor3 = theme.Text
                    elseif child:IsA("Frame") then
                        child.BackgroundColor3 = theme.Secondary
                        for _, subchild in pairs(child:GetChildren()) do
                            if subchild:IsA("TextLabel") then
                                subchild.TextColor3 = theme.Text
                            elseif subchild:IsA("Frame") then
                                subchild.BackgroundColor3 = subchild.Parent.BackgroundColor3 == theme.Accent and theme.Accent or theme.Disabled
                            end
                        end
                    end
                end
            end
        end
    end)
end

return RainLib
