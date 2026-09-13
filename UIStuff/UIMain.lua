--!strict
--[[
    GlassHubUI.lua (Cyber-Frost SkyBlue Edition - Perfect Layout & Header Fix)
]]--

local Library = {}
Library.__index = Library

Library.Assets = {
    Shadow          = "rbxassetid://1316045217",
    Minimize        = "rbxassetid://13857987062",
    Hide            = "rbxassetid://99432006374500",
    Close           = "rbxassetid://15082305656",
    Resize          = "rbxassetid://15082210525",
    Chevron         = "rbxassetid://14937709869",
    Arrow           = "rbxassetid://14923748517",
    Search          = "rbxassetid://13847222481",
    Textbox         = "rbxassetid://13868675087",
    GlowDot         = "rbxassetid://105506802034513",
    ImageLogo       = "rbxassetid://111362591084511",
    FloatingToggle  = "rbxassetid://99432006374500",
    Discord         = "rbxassetid://119690296342461",
    Theme           = "rbxassetid://14923748517",
    Home            = "rbxassetid://10723405374",
    User            = "rbxassetid://10747373176",
    Key             = "rbxassetid://10709790644",
    Clock           = "rbxassetid://10709791437",
    Check           = "rbxassetid://10709790644",
    Globe           = "rbxassetid://10734887376",
    Chat            = "rbxassetid://10734887852",
    Gear            = "rbxassetid://10734950309",
    Sliders         = "rbxassetid://10734950020",
    Terminal        = "rbxassetid://10734951847",
}

Library.Themes = {
    SkyBlue = {
        Background    = Color3.fromRGB(11, 16, 28),
        Sidebar       = Color3.fromRGB(15, 22, 38),
        Surface       = Color3.fromRGB(20, 30, 52),
        SurfaceHover  = Color3.fromRGB(26, 40, 70),
        Stroke        = Color3.fromRGB(50, 95, 160),
        StrokeSoft    = Color3.fromRGB(32, 58, 98),
        Text          = Color3.fromRGB(245, 250, 255),
        Muted         = Color3.fromRGB(140, 165, 205),
        Accent        = Color3.fromRGB(0, 168, 255),
        AccentHover   = Color3.fromRGB(56, 192, 255),
        AccentSoft    = Color3.fromRGB(14, 50, 90),
        Success       = Color3.fromRGB(0, 235, 140),
        Warning       = Color3.fromRGB(255, 190, 40),
        Danger        = Color3.fromRGB(255, 75, 105),
    },
    DeepAzure = {
        Background    = Color3.fromRGB(8, 12, 20),
        Sidebar       = Color3.fromRGB(12, 18, 30),
        Surface       = Color3.fromRGB(16, 25, 44),
        SurfaceHover  = Color3.fromRGB(22, 35, 60),
        Stroke        = Color3.fromRGB(40, 120, 215),
        StrokeSoft    = Color3.fromRGB(25, 72, 130),
        Text          = Color3.fromRGB(255, 255, 255),
        Muted         = Color3.fromRGB(130, 160, 200),
        Accent        = Color3.fromRGB(30, 144, 255),
        AccentHover   = Color3.fromRGB(80, 175, 255),
        AccentSoft    = Color3.fromRGB(16, 45, 85),
        Success       = Color3.fromRGB(0, 235, 140),
        Warning       = Color3.fromRGB(255, 190, 40),
        Danger        = Color3.fromRGB(255, 75, 105),
    },
    FrostCyan = {
        Background    = Color3.fromRGB(10, 18, 26),
        Sidebar       = Color3.fromRGB(14, 26, 38),
        Surface       = Color3.fromRGB(20, 38, 54),
        SurfaceHover  = Color3.fromRGB(28, 50, 72),
        Stroke        = Color3.fromRGB(45, 175, 210),
        StrokeSoft    = Color3.fromRGB(28, 100, 125),
        Text          = Color3.fromRGB(240, 252, 255),
        Muted         = Color3.fromRGB(135, 180, 200),
        Accent        = Color3.fromRGB(0, 215, 255),
        AccentHover   = Color3.fromRGB(80, 230, 255),
        AccentSoft    = Color3.fromRGB(14, 65, 85),
        Success       = Color3.fromRGB(0, 235, 140),
        Warning       = Color3.fromRGB(255, 190, 40),
        Danger        = Color3.fromRGB(255, 75, 105),
    }
}

local THEME_ORDER = { "SkyBlue", "DeepAzure", "FrostCyan" }

local function resolveTheme(themeInput: any): { [string]: Color3 }
    local base = Library.Themes.SkyBlue
    local resolved = {}
    for k, v in pairs(base) do
        resolved[k] = v
    end

    if type(themeInput) == "string" and Library.Themes[themeInput] then
        for k, v in pairs(Library.Themes[themeInput]) do
            resolved[k] = v
        end
    elseif type(themeInput) == "table" then
        for k, v in pairs(themeInput) do
            resolved[k] = v
        end
    end

    return resolved
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local function tween(object: Instance, time: number, goal: { [string]: any }, style: Enum.EasingStyle?, direction: Enum.EasingDirection?)
    local info = TweenInfo.new(time, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
    local anim = TweenService:Create(object, info, goal)
    anim:Play()
    return anim
end

local function make(className: string, props: { [string]: any }?, children: { Instance }?): any
    local object = Instance.new(className)
    if props then
        for key, value in pairs(props) do
            (object :: any)[key] = value
        end
    end
    if children then
        for _, child in ipairs(children) do
            child.Parent = object
        end
    end
    return object
end

local function corner(parent: Instance, radius: number)
    return make("UICorner", {
        CornerRadius = UDim.new(0, radius),
        Parent = parent,
    })
end

local function stroke(parent: Instance, color: Color3, thickness: number?, transparency: number?)
    return make("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
end

local function padding(parent: Instance, left: number, top: number, right: number, bottom: number)
    return make("UIPadding", {
        PaddingLeft = UDim.new(0, left),
        PaddingTop = UDim.new(0, top),
        PaddingRight = UDim.new(0, right),
        PaddingBottom = UDim.new(0, bottom),
        Parent = parent,
    })
end

local function list(parent: Instance, paddingSize: number, direction: Enum.FillDirection?)
    return make("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, paddingSize),
        FillDirection = direction or Enum.FillDirection.Vertical,
        Parent = parent,
    })
end

local function normalizeAsset(image: any): string
    if type(image) == "number" then
        return "rbxassetid://" .. tostring(image)
    end
    if type(image) == "string" then
        if image == "" then return "" end
        if image:find("rbxassetid://") or image:find("rbxthumb://") or image:find("http") then
            return image
        end
        if Library.Assets[image] then
            return Library.Assets[image]
        end
        return "rbxassetid://" .. image
    end
    return ""
end

local function getParentGui()
    if gethui then
        local ok, h = pcall(gethui)
        if ok and h then return h end
    end
    local ok, parent = pcall(function() return CoreGui end)
    if ok and parent then return parent end
    return LocalPlayer:WaitForChild("PlayerGui")
end

local function updateCanvas(scroll: ScrollingFrame, layout: UIListLayout, extra: number?)
    local function refresh()
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + (extra or 24))
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(refresh)
    refresh()
end

local function addRipple(button: GuiButton, color: Color3)
    button.ClipsDescendants = true
    button.MouseButton1Down:Connect(function(x, y)
        local ripple = make("Frame", {
            Name = "Ripple",
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromOffset(x - button.AbsolutePosition.X, y - button.AbsolutePosition.Y),
            Size = UDim2.fromOffset(0, 0),
            BackgroundColor3 = color,
            BackgroundTransparency = 0.4,
            BorderSizePixel = 0,
            ZIndex = button.ZIndex + 2,
            Parent = button,
        })
        corner(ripple, 100)
        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.2
        tween(ripple, 0.4, {
            Size = UDim2.fromOffset(size, size),
            BackgroundTransparency = 1,
        })
        task.delay(0.42, function()
            if ripple then ripple:Destroy() end
        end)
    end)
end

local function bindDrag(handle: GuiObject, target: GuiObject)
    local dragging = false
    local dragInput: InputObject? = nil
    local dragStart: Vector3? = nil
    local startPosition: UDim2? = nil

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPosition = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput and dragStart and startPosition then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

local function bindResize(handle: GuiObject, target: GuiObject, minSize: Vector2)
    local resizing = false
    local resizeInput: InputObject? = nil
    local startPos: Vector2? = nil
    local startSize: UDim2? = nil

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            startPos = Vector2.new(input.Position.X, input.Position.Y)
            startSize = target.Size
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)

    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            resizeInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if resizing and input == resizeInput and startPos and startSize then
            local currentPos = Vector2.new(input.Position.X, input.Position.Y)
            local delta = currentPos - startPos
            local newX = math.max(minSize.X, startSize.X.Offset + delta.X)
            local newY = math.max(minSize.Y, startSize.Y.Offset + delta.Y)
            target.Size = UDim2.fromOffset(newX, newY)
        end
    end)
end

local function createIcon(parent: Instance, image: any, size: number, color: Color3, transparency: number?)
    local asset = normalizeAsset(image)
    return make("ImageLabel", {
        Name = "Icon",
        Size = UDim2.fromOffset(size, size),
        BackgroundTransparency = 1,
        Image = asset,
        ImageColor3 = color,
        ImageTransparency = transparency or 0,
        ScaleType = Enum.ScaleType.Fit,
        Visible = asset ~= "",
        Parent = parent,
    })
end

local function createText(parent: Instance, name: string, text: string, size: number, color: Color3, bold: boolean?, order: number?)
    return make("TextLabel", {
        Name = name,
        Text = text,
        Font = bold and Enum.Font.GothamBold or Enum.Font.GothamMedium,
        TextSize = size,
        TextColor3 = color,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextWrapped = true,
        TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
        TextStrokeTransparency = bold and 0.6 or 0.8,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = order or 1,
        Parent = parent,
    })
end

local function createCoreRow(self: any, parent: Instance, title: string, desc: string?, image: any?, height: number?)
    local iconAsset = normalizeAsset(image or "")
    local hasIcon = iconAsset ~= ""
    local leftInset = hasIcon and 56 or 16

    local row = make("TextButton", {
        Name = "CoreRow",
        Text = "",
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, height or 56),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.08,
        BorderSizePixel = 0,
        LayoutOrder = 10,
        Parent = parent,
    })
    row.ClipsDescendants = true
    corner(row, 12)
    local rowStroke = stroke(row, self.Theme.Stroke, 1, 0.3)

    local leftGlow = make("Frame", {
        Name = "LeftGlow",
        Position = UDim2.fromOffset(0, 10),
        Size = UDim2.new(0, 3.5, 1, -20),
        BackgroundColor3 = self.Theme.Accent,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        Parent = row,
    })
    corner(leftGlow, 2)

    local iconWrap = make("Frame", {
        Name = "IconWrap",
        BackgroundColor3 = self.Theme.Sidebar,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(11, 11),
        Size = UDim2.fromOffset(34, 34),
        Visible = hasIcon,
        Parent = row,
    })
    corner(iconWrap, 9)
    stroke(iconWrap, self.Theme.StrokeSoft, 1, 0.25)
    local icon = createIcon(iconWrap, iconAsset, 18, self.Theme.Accent, 0.05)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.Position = UDim2.fromScale(0.5, 0.5)

    local textWrap = make("Frame", {
        Name = "TextWrap",
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(leftInset, 10),
        Size = UDim2.new(1, -leftInset - 36, 1, -20),
        Parent = row,
    })
    list(textWrap, 2)

    createText(textWrap, "Title", title, 12, self.Theme.Text, true, 1)
    if desc and desc ~= "" then
        createText(textWrap, "Desc", desc, 9.5, self.Theme.Muted, false, 2)
    end

    row.MouseEnter:Connect(function()
        tween(row, 0.2, { BackgroundColor3 = self.Theme.SurfaceHover, BackgroundTransparency = 0 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        tween(rowStroke, 0.2, { Color = self.Theme.Accent, Transparency = 0.1 })
        tween(leftGlow, 0.2, { BackgroundTransparency = 0, Size = UDim2.new(0, 4.5, 1, -12), Position = UDim2.fromOffset(0, 6) })
    end)
    row.MouseLeave:Connect(function()
        tween(row, 0.2, { BackgroundColor3 = self.Theme.Surface, BackgroundTransparency = 0.08 })
        tween(rowStroke, 0.2, { Color = self.Theme.Stroke, Transparency = 0.3 })
        tween(leftGlow, 0.2, { BackgroundTransparency = 0.5, Size = UDim2.new(0, 3.5, 1, -20), Position = UDim2.fromOffset(0, 10) })
    end)

    return row
end

local function createPageApi(window: any, scroll: ScrollingFrame)
    local api = {}

    local function checkPremium(props: { [string]: any }?): boolean
        -- If IsPrem is explicitly false, they don't own premium -> block and notify
        if props and props.IsPrem == false then
            window:Notify({
                Title = "Premium Required",
                Desc = "Please activate prem",
                Duration = 3,
            })
            return false
        end
        -- If nil (free) or true (owned premium), allow it
        return true
    end

    function api:Section(props: { [string]: any })
        props = props or {}
        local section = make("Frame", {
            Name = "Section",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = props.Order or 10,
            Parent = scroll,
        })
        list(section, 8)

        local headerWrap = make("Frame", {
            Name = "SectionHeaderWrap",
            Size = UDim2.new(1, 0, 0, 22),
            BackgroundTransparency = 1,
            LayoutOrder = 1,
            Parent = section,
        })
        local hLayout = list(headerWrap, 8, Enum.FillDirection.Horizontal)
        hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local dot = make("Frame", {
            Name = "SectionDot",
            Size = UDim2.fromOffset(6, 6),
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Parent = headerWrap,
        })
        corner(dot, 6)

        make("TextLabel", {
            Name = "SectionTitle",
            Text = string.upper(tostring(props.Title or "Section")),
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -16, 1, 0),
            Parent = headerWrap,
        })

        local sectionApi = createPageApi(window, section :: any)
        sectionApi.Root = section
        return sectionApi
    end

    function api:Label(props: { [string]: any })
        props = props or {}
        local row = createCoreRow(window, scroll, tostring(props.Title or "Label"), props.Desc or "", props.Image or "", props.Height or 54)
        local item = {}
        function item:SetTitle(value: string)
            local titleLabel = row:FindFirstChild("Title", true)
            if titleLabel and titleLabel:IsA("TextLabel") then titleLabel.Text = value end
        end
        function item:SetDesc(value: string)
            local descLabel = row:FindFirstChild("Desc", true)
            if descLabel and descLabel:IsA("TextLabel") then descLabel.Text = value end
        end
        function item:SetVisible(value: boolean) row.Visible = value end
        return item
    end

    function api:Button(props: { [string]: any })
        props = props or {}
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Button"), props.Desc or "", props.Image or "Arrow", props.Height or 54)
        addRipple(row, window.Theme.Accent)

        local glyph = createIcon(row, props.RightIcon or "Arrow", 16, window.Theme.Muted, 0.1)
        glyph.AnchorPoint = Vector2.new(1, 0.5)
        glyph.Position = UDim2.new(1, -16, 0.5, 0)

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end

            tween(row, 0.08, { Size = UDim2.new(1, 0, 0, (props.Height or 54) - 4) })
            task.delay(0.08, function()
                tween(row, 0.12, { Size = UDim2.new(1, 0, 0, props.Height or 54) })
            end)
            task.spawn(callback)
        end)

        local item = {}
        function item:SetTitle(value: string)
            local titleLabel = row:FindFirstChild("Title", true)
            if titleLabel and titleLabel:IsA("TextLabel") then titleLabel.Text = value end
        end
        function item:SetVisible(value: boolean) row.Visible = value end
        return item
    end

    function api:Toggle(props: { [string]: any })
        props = props or {}
        local value = props.Value == true
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Toggle"), props.Desc or "", props.Image or "", props.Height or 56)
        addRipple(row, window.Theme.Accent)

        local leftGlow = row:FindFirstChild("LeftGlow")

        local switch = make("Frame", {
            Name = "Switch",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0.5, 0),
            Size = UDim2.fromOffset(46, 24),
            BackgroundColor3 = value and window.Theme.Success or window.Theme.StrokeSoft,
            BackgroundTransparency = value and 0.05 or 0.3,
            BorderSizePixel = 0,
            Parent = row,
        })
        corner(switch, 12)
        local switchStroke = stroke(switch, value and window.Theme.Success or window.Theme.StrokeSoft, 1.2, 0.25)

        local knob = make("Frame", {
            Name = "Knob",
            Size = UDim2.fromOffset(18, 18),
            Position = value and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
            BackgroundColor3 = window.Theme.Text,
            BorderSizePixel = 0,
            Parent = switch,
        })
        corner(knob, 9)

        local function setValue(nextValue: boolean, fire: boolean?)
            value = nextValue == true
            tween(switch, 0.22, {
                BackgroundColor3 = value and window.Theme.Success or window.Theme.StrokeSoft,
            }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            tween(switchStroke, 0.22, {
                Color = value and window.Theme.Success or window.Theme.StrokeSoft,
            })
            tween(knob, 0.22, {
                Position = value and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
            }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if leftGlow and leftGlow:IsA("Frame") then
                tween(leftGlow, 0.22, {
                    BackgroundColor3 = value and window.Theme.Success or window.Theme.Accent,
                    BackgroundTransparency = value and 0.05 or 0.5,
                })
            end
            if fire then
                task.spawn(function() callback(value) end)
            end
        end

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end
            setValue(not value, true)
        end)

        local item = {}
        function item:SetValue(nextVal: boolean) setValue(nextVal, false) end
        function item:GetValue() return value end
        function item:SetVisible(nextVal: boolean) row.Visible = nextVal end
        return item
    end

    function api:Dropdown(props: { [string]: any })
        props = props or {}
        local options = props.List or props.Options or {}
        local multi = props.Multi == true
        local title = tostring(props.Title or "Dropdown")
        local desc = tostring(props.Desc or "")
        local callback = props.Callback or function() end
        local selected = props.Value
        if selected == nil and not multi then
            selected = options[1]
        elseif selected == nil and multi then
            selected = {}
        end

        local container = make("Frame", {
            Name = "DropdownContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 10,
            Parent = scroll,
        })
        list(container, 8)

        local row = createCoreRow(window, container, title, desc, props.Image or "", props.Height or 56)
        addRipple(row, window.Theme.Accent)

        local valueLabel = make("TextLabel", {
            Name = "Value",
            Text = multi and table.concat(selected, ", ") or tostring(selected or "Select"),
            Font = Enum.Font.GothamBold,
            TextSize = 11,
            TextColor3 = window.Theme.Accent,
            TextXAlignment = Enum.TextXAlignment.Right,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -40, 0.5, 0),
            Size = UDim2.fromOffset(props.ValueWidth or 140, 22),
            Parent = row,
        })

        local chevron = createIcon(row, "Chevron", 16, window.Theme.Muted, 0.1)
        chevron.AnchorPoint = Vector2.new(1, 0.5)
        chevron.Position = UDim2.new(1, -16, 0.5, 0)

        local listFrame = make("Frame", {
            Name = "DropdownList",
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            ClipsDescendants = true,
            Visible = false,
            LayoutOrder = 11,
            Parent = container,
        })
        corner(listFrame, 12)
        stroke(listFrame, window.Theme.Stroke, 1, 0.25)
        padding(listFrame, 10, 10, 10, 10)
        local optionLayout = list(listFrame, 6)

        local open = false
        local buttons = {}

        local function getDropdownHeight()
            return optionLayout.AbsoluteContentSize.Y + 20
        end

        local function closeDropdown()
            open = false
            tween(listFrame, 0.2, { Size = UDim2.new(1, 0, 0, 0) }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
            task.delay(0.2, function()
                if not open and listFrame.Parent then listFrame.Visible = false end
            end)
        end

        local function openDropdown()
            open = true
            listFrame.Visible = true
            listFrame.Size = UDim2.new(1, 0, 0, 0)
            tween(listFrame, 0.25, { Size = UDim2.new(1, 0, 0, getDropdownHeight()) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end

        local function selectedContains(val: any)
            if not multi or type(selected) ~= "table" then return selected == val end
            return table.find(selected, val) ~= nil
        end

        local function refreshValue()
            valueLabel.Text = multi and table.concat(selected, ", ") or tostring(selected or "Select")
            if valueLabel.Text == "" then valueLabel.Text = "Select" end
            for opt, btn in pairs(buttons) do
                local active = selectedContains(opt)
                btn.TextColor3 = active and window.Theme.Accent or window.Theme.Text
                btn.BackgroundColor3 = active and window.Theme.AccentSoft or window.Theme.Surface
            end
        end

        local function addOption(opt: any)
            local btn = make("TextButton", {
                Name = "Option",
                Text = "  " .. tostring(opt),
                Font = Enum.Font.GothamMedium,
                TextSize = 11.5,
                TextColor3 = selectedContains(opt) and window.Theme.Accent or window.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutoButtonColor = false,
                BackgroundColor3 = selectedContains(opt) and window.Theme.AccentSoft or window.Theme.Surface,
                BackgroundTransparency = 0.08,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 30),
                Parent = listFrame,
            })
            corner(btn, 8)
            addRipple(btn, window.Theme.Accent)
            buttons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                if multi then
                    local pos = table.find(selected, opt)
                    if pos then table.remove(selected, pos) else table.insert(selected, opt) end
                else
                    selected = opt
                    closeDropdown()
                end
                refreshValue()
                callback(selected)
            end)
        end

        for _, opt in ipairs(options) do
            addOption(opt)
        end

        row.MouseButton1Click:Connect(function()
            if not checkPremium(props) then return end
            if open then closeDropdown() else openDropdown() end
            tween(chevron, 0.22, { Rotation = open and 180 or 0 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        end)

        local item = {}
        function item:SetValue(v: any) selected = v; refreshValue() end
        function item:GetValue() return selected end
        function item:SetVisible(v: boolean) container.Visible = v end
        return item
    end

    function api:Segmented(props: { [string]: any })
        props = props or {}
        local options = props.Options or props.List or { "Option 1", "Option 2" }
        local selected = props.Value or options[1]
        local callback = props.Callback or function() end

        local row = make("Frame", {
            Name = "SegmentedContainer",
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.08,
            BorderSizePixel = 0,
            LayoutOrder = 10,
            Parent = scroll,
        })
        corner(row, 12)
        stroke(row, window.Theme.StrokeSoft, 1, 0.3)
        padding(row, 6, 6, 6, 6)
        local segLayout = list(row, 6, Enum.FillDirection.Horizontal)
        segLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        segLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local buttons = {}
        local btnWidth = 1 / #options

        local function refreshSegmented()
            for opt, btn in pairs(buttons) do
                local active = opt == selected
                tween(btn, 0.2, {
                    BackgroundColor3 = active and window.Theme.Accent or window.Theme.Surface,
                    BackgroundTransparency = active and 0 or 0.45,
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or window.Theme.Muted
            end
        end

        for _, opt in ipairs(options) do
            local btn = make("TextButton", {
                Name = "Segment_" .. tostring(opt),
                Text = tostring(opt),
                Font = Enum.Font.GothamBold,
                TextSize = 11.5,
                TextColor3 = opt == selected and Color3.fromRGB(255, 255, 255) or window.Theme.Muted,
                AutoButtonColor = false,
                BackgroundColor3 = opt == selected and window.Theme.Accent or window.Theme.Surface,
                BackgroundTransparency = opt == selected and 0 or 0.45,
                BorderSizePixel = 0,
                Size = UDim2.new(btnWidth, -4, 1, 0),
                Parent = row,
            })
            corner(btn, 9)
            addRipple(btn, Color3.fromRGB(255, 255, 255))
            buttons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                selected = opt
                refreshSegmented()
                task.spawn(function() callback(selected) end)
            end)
        end

        local item = {}
        function item:SetValue(v: any) selected = v; refreshSegmented() end
        function item:GetValue() return selected end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    function api:SelectionBox(props: { [string]: any })
        props = props or {}
        local selections = props.Selections or { "Free", "Premium" }
        local descriptions = props.Descriptions or {}
        local checklist = props.Checklist or {}
        local buttonTexts = props.ButtonTexts or {}
        local callbacks = props.Callbacks or {}
        
        local selected = props.Value or selections[1]

        local container = make("Frame", {
            Name = "SelectionBoxContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            LayoutOrder = 10,
            Parent = scroll,
        })
        list(container, 10)

        local segRow = make("Frame", {
            Name = "SegmentedContainer",
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.08,
            BorderSizePixel = 0,
            Parent = container,
        })
        corner(segRow, 12)
        stroke(segRow, window.Theme.StrokeSoft, 1, 0.3)
        padding(segRow, 6, 6, 6, 6)
        local segLayout = list(segRow, 6, Enum.FillDirection.Horizontal)
        segLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        segLayout.VerticalAlignment = Enum.VerticalAlignment.Center

        local segButtons = {}
        local btnWidth = 1 / #selections

        local card = make("Frame", {
            Name = "SelectionCardBody",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.06,
            BorderSizePixel = 0,
            Parent = container,
        })
        corner(card, 14)
        stroke(card, window.Theme.Stroke, 1, 0.3)
        padding(card, 16, 16, 16, 16)
        
        local cardLayout = list(card, 12)

        local headerRow = make("Frame", {
            Name = "HeaderRow",
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            Parent = card,
        })
        local cardTitleLabel = createText(headerRow, "CardTitle", "", 14, window.Theme.Text, true)

        local badgePill = make("Frame", {
            Name = "BadgePill",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, 0, 0.5, 0),
            Size = UDim2.fromOffset(0, 24),
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = window.Theme.AccentSoft,
            BorderSizePixel = 0,
            Parent = headerRow,
        })
        corner(badgePill, 8)
        padding(badgePill, 10, 2, 10, 2)
        stroke(badgePill, window.Theme.Accent, 1, 0.4)

        local badgeText = make("TextLabel", {
            Name = "BadgeText",
            Text = "",
            Font = Enum.Font.GothamBold,
            TextSize = 10,
            TextColor3 = window.Theme.Accent,
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(0, 20),
            AutomaticSize = Enum.AutomaticSize.X,
            Parent = badgePill,
        })

        local checklistContainer = make("Frame", {
            Name = "ChecklistContainer",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Parent = card,
        })
        local checkListLayout = list(checklistContainer, 10)

        local actionBtn = make("TextButton", {
            Name = "ActionButton",
            Text = "",
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            AutoButtonColor = false,
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 40),
            Parent = card,
        })
        corner(actionBtn, 10)
        addRipple(actionBtn, Color3.fromRGB(255, 255, 255))

        actionBtn.MouseEnter:Connect(function()
            tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.AccentHover })
        end)
        actionBtn.MouseLeave:Connect(function()
            tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.Accent })
        end)

        local function updateSelectionView(targetOption: any)
            selected = targetOption

            for opt, btn in pairs(segButtons) do
                local active = opt == targetOption
                tween(btn, 0.2, {
                    BackgroundColor3 = active and window.Theme.Accent or window.Theme.Surface,
                    BackgroundTransparency = active and 0 or 0.45,
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
                btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or window.Theme.Muted
            end

            cardTitleLabel.Text = tostring(targetOption)
            local descVal = descriptions[targetOption] or descriptions[tostring(targetOption)] or ""
            badgeText.Text = string.upper(tostring(descVal))
            badgePill.Visible = (descVal ~= "")

            for _, child in ipairs(checklistContainer:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end

            local matchedKey = targetOption
            if not checklist[matchedKey] then
                for k, v in pairs(checklist) do
                    if tostring(k):lower() == tostring(targetOption):lower() then
                        matchedKey = k
                        break
                    end
                end
            end

            local items = checklist[matchedKey] or {}
            for _, it in ipairs(items) do
                local itemRow = make("Frame", {
                    Name = "ItemRow",
                    Size = UDim2.new(1, 0, 0, 22),
                    BackgroundTransparency = 1,
                    Parent = checklistContainer,
                })
                local hLayout = list(itemRow, 10, Enum.FillDirection.Horizontal)
                hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

                make("TextLabel", {
                    Name = "Checkmark",
                    Text = "✓",
                    Font = Enum.Font.GothamBold,
                    TextSize = 13.5,
                    TextColor3 = window.Theme.Success,
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(16, 20),
                    Parent = itemRow,
                })

                make("TextLabel", {
                    Name = "ItemText",
                    Text = tostring(it),
                    Font = Enum.Font.GothamMedium,
                    TextSize = 11,
                    TextColor3 = window.Theme.Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -26, 1, 0),
                    Parent = itemRow,
                })
            end

            local matchedBtnKey = targetOption
            if not buttonTexts[matchedBtnKey] then
                for k, v in pairs(buttonTexts) do
                    if tostring(k):lower() == tostring(targetOption):lower() then
                        matchedBtnKey = k
                        break
                    end
                end
            end
            actionBtn.Text = tostring(buttonTexts[matchedBtnKey] or ("Select " .. tostring(targetOption)))

            actionBtn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                local matchedCbKey = targetOption
                if not callbacks[matchedCbKey] then
                    for k, v in pairs(callbacks) do
                        if tostring(k):lower() == tostring(targetOption):lower() then
                            matchedCbKey = k
                            break
                        end
                    end
                end
                local cb = callbacks[matchedCbKey]
                if type(cb) == "function" then
                    task.spawn(cb)
                end
            end)
        end

        for _, opt in ipairs(selections) do
            local btn = make("TextButton", {
                Name = "Segment_" .. tostring(opt),
                Text = tostring(opt),
                Font = Enum.Font.GothamBold,
                TextSize = 11.5,
                TextColor3 = opt == selected and Color3.fromRGB(255, 255, 255) or window.Theme.Muted,
                AutoButtonColor = false,
                BackgroundColor3 = opt == selected and window.Theme.Accent or window.Theme.Surface,
                BackgroundTransparency = opt == selected and 0 or 0.45,
                BorderSizePixel = 0,
                Size = UDim2.new(btnWidth, -4, 1, 0),
                Parent = segRow,
            })
            corner(btn, 9)
            addRipple(btn, Color3.fromRGB(255, 255, 255))
            segButtons[opt] = btn

            btn.MouseButton1Click:Connect(function()
                updateSelectionView(opt)
            end)
        end

        updateSelectionView(selected)

        local apiItem = {}
        function apiItem:SetValue(v: any) updateSelectionView(v) end
        function apiItem:GetValue() return selected end
        function apiItem:SetVisible(v: boolean) container.Visible = v end
        return apiItem
    end

    function api:FeatureCard(props: { [string]: any })
        props = props or {}
        local title = tostring(props.Title or "Feature Card")
        local badge = tostring(props.Badge or "")
        local items = props.Items or {}
        local buttonText = tostring(props.ButtonText or "Action")
        local callback = props.Callback or function() end

        local card = make("Frame", {
            Name = "FeatureCard",
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.06,
            BorderSizePixel = 0,
            LayoutOrder = 10,
            Parent = scroll,
        })
        corner(card, 14)
        stroke(card, window.Theme.Stroke, 1, 0.3)
        padding(card, 16, 16, 16, 16)
        list(card, 12)

        local headerRow = make("Frame", {
            Name = "HeaderRow",
            Size = UDim2.new(1, 0, 0, 28),
            BackgroundTransparency = 1,
            Parent = card,
        })
        createText(headerRow, "CardTitle", title, 14, window.Theme.Text, true)

        if badge ~= "" then
            local badgePill = make("Frame", {
                Name = "BadgePill",
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.fromOffset(0, 24),
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundColor3 = window.Theme.AccentSoft,
                BorderSizePixel = 0,
                Parent = headerRow,
            })
            corner(badgePill, 8)
            padding(badgePill, 10, 2, 10, 2)
            stroke(badgePill, window.Theme.Accent, 1, 0.4)

            make("TextLabel", {
                Name = "BadgeText",
                Text = badge,
                Font = Enum.Font.GothamBold,
                TextSize = 10,
                TextColor3 = window.Theme.Accent,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(0, 20),
                AutomaticSize = Enum.AutomaticSize.X,
                Parent = badgePill,
            })
        end

        for _, it in ipairs(items) do
            local itemRow = make("Frame", {
                Name = "ItemRow",
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Parent = card,
            })
            local hLayout = list(itemRow, 10, Enum.FillDirection.Horizontal)
            hLayout.VerticalAlignment = Enum.VerticalAlignment.Center

            make("TextLabel", {
                Name = "Checkmark",
                Text = "✓",
                Font = Enum.Font.GothamBold,
                TextSize = 13.5,
                TextColor3 = window.Theme.Success,
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(16, 20),
                Parent = itemRow,
            })

            make("TextLabel", {
                Name = "ItemText",
                Text = tostring(it),
                Font = Enum.Font.GothamMedium,
                TextSize = 11,
                TextColor3 = window.Theme.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -26, 1, 0),
                Parent = itemRow,
            })
        end

        if buttonText ~= "" then
            local actionBtn = make("TextButton", {
                Name = "ActionButton",
                Text = buttonText,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                AutoButtonColor = false,
                BackgroundColor3 = window.Theme.Accent,
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 40),
                Parent = card,
            })
            corner(actionBtn, 10)
            addRipple(actionBtn, Color3.fromRGB(255, 255, 255))

            actionBtn.MouseEnter:Connect(function()
                tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.AccentHover })
            end)
            actionBtn.MouseLeave:Connect(function()
                tween(actionBtn, 0.16, { BackgroundColor3 = window.Theme.Accent })
            end)
            actionBtn.MouseButton1Click:Connect(function()
                if not checkPremium(props) then return end
                task.spawn(callback)
            end)
        end

        local item = {}
        function item:SetVisible(v: boolean) card.Visible = v end
        return item
    end

    function api:Search(props: { [string]: any })
        props = props or {}
        local placeholder = tostring(props.Placeholder or "Search components...")
        local callback = props.Callback or function() end

        local container = make("Frame", {
            Name = "SearchContainer",
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = window.Theme.Surface,
            BackgroundTransparency = 0.06,
            BorderSizePixel = 0,
            LayoutOrder = props.Order or 1,
            Parent = scroll,
        })
        corner(container, 12)
        stroke(container, window.Theme.Stroke, 1, 0.3)

        local searchIcon = createIcon(container, "Search", 16, window.Theme.Accent, 0.1)
        searchIcon.AnchorPoint = Vector2.new(0, 0.5)
        searchIcon.Position = UDim2.new(0, 14, 0.5, 0)

        local textBox = make("TextBox", {
            Name = "SearchInput",
            Text = "",
            PlaceholderText = placeholder,
            Font = Enum.Font.GothamMedium,
            TextSize = 11.5,
            TextColor3 = window.Theme.Text,
            PlaceholderColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(42, 0),
            Size = UDim2.new(1, -54, 1, 0),
            Parent = container,
        })

        textBox.Focused:Connect(function()
            if not checkPremium(props) then
                textBox:ReleaseFocus()
                return
            end
        end)

        textBox:GetPropertyChangedSignal("Text"):Connect(function()
            if props.IsPrem == false then return end
            local query = textBox.Text:lower()
            task.spawn(function() callback(query) end)
        end)

        local item = {}
        function item:SetVisible(v: boolean) container.Visible = v end
        return item
    end

    function api:Slider(props: { [string]: any })
        props = props or {}
        local min = tonumber(props.Min) or 0
        local max = tonumber(props.Max) or 100
        local value = tonumber(props.Value) or min
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Slider"), props.Desc or "", props.Image or "", props.Height or 68)

        local bar = make("Frame", {
            Name = "Bar",
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0.5, 10),
            Size = UDim2.fromOffset(props.Width or 160, 6),
            BackgroundColor3 = window.Theme.StrokeSoft,
            BorderSizePixel = 0,
            Parent = row,
        })
        corner(bar, 3)

        local fill = make("Frame", {
            Name = "Fill",
            Size = UDim2.fromScale(0, 1),
            BackgroundColor3 = window.Theme.Accent,
            BorderSizePixel = 0,
            Parent = bar,
        })
        corner(fill, 3)

        local numberLabel = make("TextLabel", {
            Name = "Number",
            Text = tostring(value),
            Font = Enum.Font.GothamBold,
            TextSize = 11.5,
            TextColor3 = window.Theme.Accent,
            TextXAlignment = Enum.TextXAlignment.Right,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0.5, -10),
            Size = UDim2.fromOffset(100, 16),
            Parent = row,
        })

        local dragging = false
        local function setValueFromAlpha(alpha: number, fire: boolean?)
            alpha = math.clamp(alpha, 0, 1)
            value = math.floor((min + ((max - min) * alpha)) + 0.5)
            fill.Size = UDim2.fromScale((value - min) / math.max(max - min, 1), 1)
            numberLabel.Text = tostring(value)
            if fire then callback(value) end
        end

        local function fromX(x: number)
            setValueFromAlpha((x - bar.AbsolutePosition.X) / math.max(bar.AbsoluteSize.X, 1), true)
        end

        bar.InputBegan:Connect(function(input)
            if not checkPremium(props) then return end
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                fromX(input.Position.X)
            end
        end)
        bar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                fromX(input.Position.X)
            end
        end)

        setValueFromAlpha((value - min) / math.max(max - min, 1), false)

        local item = {}
        function item:SetValue(v: number)
            value = math.clamp(v, min, max)
            setValueFromAlpha((value - min) / math.max(max - min, 1), false)
        end
        function item:GetValue() return value end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    function api:Textbox(props: { [string]: any })
        props = props or {}
        local callback = props.Callback or function() end
        local row = createCoreRow(window, scroll, tostring(props.Title or "Textbox"), props.Desc or "", props.Image or "Textbox", props.Height or 62)

        local box = make("TextBox", {
            Name = "Input",
            Text = tostring(props.Value or ""),
            PlaceholderText = tostring(props.Placeholder or "Enter text"),
            Font = Enum.Font.GothamMedium,
            TextSize = 11.5,
            TextColor3 = window.Theme.Text,
            PlaceholderColor3 = window.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            ClearTextOnFocus = props.ClearTextOnFocus == true or props.ClearText == true,
            BackgroundColor3 = window.Theme.Sidebar,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -16, 0.5, 0),
            Size = UDim2.fromOffset(props.Width or 150, 32),
            Parent = row,
        })
        corner(box, 9)
        local boxStroke = stroke(box, window.Theme.StrokeSoft, 1, 0.3)
        padding(box, 12, 0, 12, 0)

        box.Focused:Connect(function()
            if not checkPremium(props) then
                box:ReleaseFocus()
                return
            end
            tween(boxStroke, 0.16, { Color = window.Theme.Accent, Transparency = 0.05 })
        end)
        box.FocusLost:Connect(function(enterPressed)
            tween(boxStroke, 0.16, { Color = window.Theme.StrokeSoft, Transparency = 0.3 })
            if props.IsPrem ~= false then
                callback(box.Text, enterPressed)
            end
        end)

        local item = {}
        function item:SetValue(v: string) box.Text = v end
        function item:GetValue() return box.Text end
        function item:SetPlaceholderText(v: string) box.PlaceholderText = v end
        function item:SetVisible(v: boolean) row.Visible = v end
        return item
    end

    api.Root = scroll
    return api
end

function Library:Window(props: { [string]: any })
    props = props or {}
    local self = setmetatable({}, Library)
    self.ThemeName = (type(props.Theme) == "string" and props.Theme) or "SkyBlue"
    self.Theme = resolveTheme(props.Theme or "SkyBlue")
    self.Tabs = {}
    self.SelectedTab = nil
    self.Keybind = (props.Config and props.Config.Keybind) or props.Keybind or Enum.KeyCode.RightControl

    local appTitle = tostring(props.Title or "CYBERFLOW // v2.0")
    local guiName = props.Name or "SkyBlueUI_Window"
    local existing = getParentGui():FindFirstChild(guiName)
    if existing then existing:Destroy() end

    local screenGui = make("ScreenGui", {
        Name = guiName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = props.DisplayOrder or 999,
        Parent = getParentGui(),
    })
    if typeof(protectgui) == "function" then
        pcall(protectgui, screenGui)
    elseif typeof(syn) == "table" and typeof((syn :: any).protect_gui) == "function" then
        pcall((syn :: any).protect_gui, screenGui)
    end
    self.ScreenGui = screenGui

    local shadow = make("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = props.Position or UDim2.fromScale(0.5, 0.5),
        Size = (props.Config and props.Config.Size) or props.Size or UDim2.fromOffset(720, 500),
        BackgroundTransparency = 1,
        Image = Library.Assets.Shadow,
        ImageColor3 = Color3.fromRGB(0, 110, 255),
        ImageTransparency = 0.35,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = screenGui,
    })
    self.Shadow = shadow

    local root = make("Frame", {
        Name = "WindowRoot",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, -16, 1, -16),
        BackgroundColor3 = self.Theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = shadow,
    })
    corner(root, 16)
    stroke(root, self.Theme.Stroke, 1.3, 0.15)
    self.Root = root

    -- Floating Moveable Open/Restore Button (when UI is hidden)
    local floatingOpenBtn = make("ImageButton", {
        Name = "FloatingOpenButton",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 20, 0.5, 0),
        Size = UDim2.fromOffset(46, 46),
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Image = normalizeAsset("ImageLogo"),
        ImageColor3 = self.Theme.Accent,
        Visible = false,
        ZIndex = 200,
        Parent = screenGui,
    })
    corner(floatingOpenBtn, 23)
    stroke(floatingOpenBtn, self.Theme.Stroke, 1.5, 0.2)
    addRipple(floatingOpenBtn, self.Theme.Accent)
    bindDrag(floatingOpenBtn, floatingOpenBtn)

    -- Confirmation Exit Popup Modal
    local confirmOverlay = make("Frame", {
        Name = "ConfirmOverlay",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.6,
        Visible = false,
        ZIndex = 300,
        Parent = root,
    })

    local confirmModal = make("Frame", {
        Name = "ConfirmModal",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(280, 140),
        BackgroundColor3 = self.Theme.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 301,
        Parent = confirmOverlay,
    })
    corner(confirmModal, 14)
    stroke(confirmModal, self.Theme.Stroke, 1.5, 0.1)
    padding(confirmModal, 16, 16, 16, 16)
    list(confirmModal, 12)

    createText(confirmModal, "ModalTitle", "Confirm Exit", 13.5, self.Theme.Text, true, 1)
    createText(confirmModal, "ModalDesc", "Are you sure you want to close this UI?", 10.5, self.Theme.Muted, false, 2)

    local modalBtnRow = make("Frame", {
        Name = "ModalBtnRow",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        LayoutOrder = 3,
        Parent = confirmModal,
    })
    list(modalBtnRow, 10, Enum.FillDirection.Horizontal)

    local cancelBtn = make("TextButton", {
        Name = "CancelBtn",
        Text = "Cancel",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = self.Theme.Text,
        AutoButtonColor = false,
        BackgroundColor3 = self.Theme.Surface,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -5, 1, 0),
        Parent = modalBtnRow,
    })
    corner(cancelBtn, 8)
    stroke(cancelBtn, self.Theme.StrokeSoft, 1, 0.3)
    addRipple(cancelBtn, self.Theme.Muted)

    local confirmBtn = make("TextButton", {
        Name = "ConfirmBtn",
        Text = "Exit",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        AutoButtonColor = false,
        BackgroundColor3 = self.Theme.Danger,
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -5, 1, 0),
        Parent = modalBtnRow,
    })
    corner(confirmBtn, 8)
    addRipple(confirmBtn, Color3.fromRGB(255, 255, 255))

    cancelBtn.MouseButton1Click:Connect(function()
        confirmOverlay.Visible = false
    end)

    confirmBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    local resizeHandle = make("ImageButton", {
        Name = "ResizeHandle",
        AnchorPoint = Vector2.new(1, 1),
        Position = UDim2.new(1, -4, 1, -4),
        Size = UDim2.fromOffset(16, 16),
        BackgroundTransparency = 1,
        Image = Library.Assets.Resize,
        ImageColor3 = self.Theme.Muted,
        ImageTransparency = 0.4,
        ZIndex = 100,
        Parent = shadow,
    })
    bindResize(resizeHandle, shadow, Vector2.new(520, 380))

    resizeHandle.MouseEnter:Connect(function()
        tween(resizeHandle, 0.15, { ImageTransparency = 0, ImageColor3 = self.Theme.Accent })
    end)
    resizeHandle.MouseLeave:Connect(function()
        tween(resizeHandle, 0.15, { ImageTransparency = 0.4, ImageColor3 = self.Theme.Muted })
    end)

    local sidebarWidth = 200
    local sidebar = make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, sidebarWidth, 1, 0),
        BackgroundColor3 = self.Theme.Sidebar,
        BorderSizePixel = 0,
        Parent = root,
    })
    self.Sidebar = sidebar

    local sideDivider = make("Frame", {
        Name = "SideDivider",
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = self.Theme.StrokeSoft,
        BorderSizePixel = 0,
        Parent = sidebar,
    })

    local sideHeader = make("Frame", {
        Name = "SideHeader",
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = sidebar,
    })
    bindDrag(sideHeader, shadow)

    local sideLogoWrap = make("Frame", {
        Name = "SideLogoWrap",
        Position = UDim2.fromOffset(16, 16),
        Size = UDim2.fromOffset(28, 28),
        BackgroundTransparency = 1,
        Parent = sideHeader,
    })
    local sideLogo = createIcon(sideLogoWrap, props.Icon or "ImageLogo", 22, self.Theme.Accent, 0)
    sideLogo.AnchorPoint = Vector2.new(0.5, 0.5)
    sideLogo.Position = UDim2.fromScale(0.5, 0.5)

    local sideAppTitle = make("TextLabel", {
        Name = "AppTitle",
        Text = appTitle,
        Font = Enum.Font.GothamBold,
        TextSize = 12.5,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(52, 0),
        Size = UDim2.new(1, -56, 1, 0),
        Parent = sideHeader,
    })

    local tabContainer = make("ScrollingFrame", {
        Name = "TabContainer",
        Position = UDim2.fromOffset(0, 60),
        Size = UDim2.new(1, 0, 1, -150),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.Theme.Stroke,
        CanvasSize = UDim2.fromOffset(0, 0),
        Parent = sidebar,
    })
    padding(tabContainer, 12, 10, 12, 10)
    local tabLayout = list(tabContainer, 8)
    updateCanvas(tabContainer, tabLayout, 10)

    local profileCard = make("Frame", {
        Name = "ProfileCard",
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 12, 1, -12),
        Size = UDim2.new(1, -24, 0, 72),
        BackgroundColor3 = self.Theme.Surface,
        BorderSizePixel = 0,
        Parent = sidebar,
    })
    corner(profileCard, 12)
    stroke(profileCard, self.Theme.StrokeSoft, 1, 0.25)
    padding(profileCard, 10, 10, 10, 10)
    list(profileCard, 6)

    local pTopRow = make("Frame", {
        Name = "ProfileTop",
        Size = UDim2.new(1, 0, 0, 34),
        BackgroundTransparency = 1,
        Parent = profileCard,
    })

    local pAvatarWrap = make("Frame", {
        Name = "AvatarWrap",
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.fromOffset(34, 34),
        BackgroundColor3 = self.Theme.Sidebar,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = pTopRow,
    })
    corner(pAvatarWrap, 17)
    stroke(pAvatarWrap, self.Theme.Accent, 1, 0.25)

    local pAvatarImage = make("ImageLabel", {
        Name = "Avatar",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer and LocalPlayer.UserId or 1) .. "&w=100&h=100",
        Parent = pAvatarWrap,
    })

    local pInfoWrap = make("Frame", {
        Name = "InfoWrap",
        Position = UDim2.fromOffset(42, 0),
        Size = UDim2.new(1, -42, 1, 0),
        BackgroundTransparency = 1,
        Parent = pTopRow,
    })
    list(pInfoWrap, 2)

    local pUsernameLabel = make("TextLabel", {
        Name = "Username",
        Text = LocalPlayer and LocalPlayer.Name or "User",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 15),
        Parent = pInfoWrap,
    })

    local pBadgePill = make("Frame", {
        Name = "BadgePill",
        Size = UDim2.fromOffset(0, 14),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = self.Theme.AccentSoft,
        BorderSizePixel = 0,
        Parent = pInfoWrap,
    })
    corner(pBadgePill, 5)
    padding(pBadgePill, 6, 1, 6, 1)

    local pBadgeText = make("TextLabel", {
        Name = "BadgeText",
        Text = "SKYBLUE VIP",
        Font = Enum.Font.GothamBold,
        TextSize = 8,
        TextColor3 = self.Theme.Accent,
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(0, 12),
        AutomaticSize = Enum.AutomaticSize.X,
        Parent = pBadgePill,
    })

    local pTimeLabel = make("TextLabel", {
        Name = "TimeLeft",
        Text = "Time left: 23h 45m",
        Font = Enum.Font.GothamMedium,
        TextSize = 9.5,
        TextColor3 = self.Theme.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 14),
        Parent = profileCard,
    })

    function self:UserProfile(userProps: { [string]: any })
        userProps = userProps or {}
        if userProps.Username then pUsernameLabel.Text = tostring(userProps.Username) end
        if userProps.Badge then pBadgeText.Text = string.upper(tostring(userProps.Badge)) end
        if userProps.TimeLeft then pTimeLabel.Text = "Time left: " .. tostring(userProps.TimeLeft) end
        if userProps.AvatarId then
            pAvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userProps.AvatarId) .. "&w=100&h=100"
        end
        return {
            SetUsername = function(_, name: string) pUsernameLabel.Text = name end,
            SetBadge    = function(_, badge: string) pBadgeText.Text = string.upper(badge) end,
            SetTimeLeft = function(_, timeStr: string) pTimeLabel.Text = "Time left: " .. timeStr end,
            SetAvatar   = function(_, id: number) pAvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(id) .. "&w=100&h=100" end,
        }
    end

    -- Fixed contentArea layout constraint starting cleanly below the topbar header
    local contentArea = make("Frame", {
        Name = "ContentArea",
        Position = UDim2.new(0, sidebarWidth, 0, 60),
        Size = UDim2.new(1, -sidebarWidth, 1, -60),
        BackgroundTransparency = 1,
        Parent = root,
    })

    local topBar = make("Frame", {
        Name = "TopBar",
        Position = UDim2.new(0, sidebarWidth, 0, 0),
        Size = UDim2.new(1, -sidebarWidth, 0, 60),
        BackgroundTransparency = 1,
        Parent = root,
    })
    bindDrag(topBar, shadow)

    local breadcrumbWrap = make("Frame", {
        Name = "BreadcrumbWrap",
        Position = UDim2.fromOffset(16, 11),
        Size = UDim2.new(1, -174, 1, -22),
        BackgroundTransparency = 1,
        Parent = topBar,
    })
    list(breadcrumbWrap, 2)

    local breadcrumbLabel = make("TextLabel", {
        Name = "Breadcrumb",
        Text = string.upper(appTitle) .. " // START",
        Font = Enum.Font.GothamBold,
        TextSize = 12.5,
        TextColor3 = self.Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 18),
        Parent = breadcrumbWrap,
    })

    local descLabelRef = make("TextLabel", {
        Name = "Subtitle",
        Text = tostring(props.Desc or props.Subtitle or "SYSTEM ONLINE"),
        Font = Enum.Font.GothamMedium,
        TextSize = 10.5,
        TextColor3 = self.Theme.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 15),
        Parent = breadcrumbWrap,
    })

    local controls = make("Frame", {
        Name = "Controls",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -16, 0.5, 0),
        Size = UDim2.fromOffset(156, 28),
        BackgroundTransparency = 1,
        Parent = topBar,
    })
    list(controls, 6, Enum.FillDirection.Horizontal)

    local function makeTopBtn(name: string, icon: string, callback: () -> ())
        local btn = make("ImageButton", {
            Name = name,
            Image = normalizeAsset(icon),
            ImageColor3 = self.Theme.Muted,
            BackgroundColor3 = self.Theme.Surface,
            BackgroundTransparency = 0.2,
            BorderSizePixel = 0,
            Size = UDim2.fromOffset(26, 26),
            AutoButtonColor = false,
            Parent = controls,
        })
        corner(btn, 7)
        stroke(btn, self.Theme.StrokeSoft, 1, 0.3)

        btn.MouseEnter:Connect(function()
            tween(btn, 0.15, { BackgroundTransparency = 0, ImageColor3 = self.Theme.Text })
        end)
        btn.MouseLeave:Connect(function()
            tween(btn, 0.15, { BackgroundTransparency = 0.2, ImageColor3 = self.Theme.Muted })
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    makeTopBtn("HideBtn", "Hide", function()
        shadow.Visible = false
        floatingOpenBtn.Visible = true
        self:Notify({ Title = "UI Hidden", Desc = "Click the floating icon to restore.", Duration = 2 })
    end)

    local minimized = false
    local originalSize = shadow.Size
    makeTopBtn("MinimizeBtn", "Minimize", function()
        minimized = not minimized
        if minimized then
            originalSize = shadow.Size
            resizeHandle.Visible = false
            tween(shadow, 0.2, { Size = UDim2.fromOffset(originalSize.X.Offset, 60) })
            contentArea.Visible = false
            sidebar.Visible = false
        else
            contentArea.Visible = true
            sidebar.Visible = true
            tween(shadow, 0.2, { Size = originalSize })
            task.delay(0.2, function()
                resizeHandle.Visible = true
            end)
        end
    end)

    makeTopBtn("ThemeBtn", "Theme", function()
        local currentIdx = table.find(THEME_ORDER, self.ThemeName) or 1
        local nextIdx = (currentIdx % #THEME_ORDER) + 1
        local nextThemeName = THEME_ORDER[nextIdx]
        self:SetTheme(nextThemeName)
        self:Notify({
            Title = "Theme Shift",
            Desc = "Switched theme to: " .. nextThemeName,
            Duration = 2,
        })
    end)

    makeTopBtn("DiscordBtn", "Discord", function()
        if setclipboard then
            pcall(setclipboard, props.DiscordLink or "https://discord.gg")
            self:Notify({
                Title = "Link Copied",
                Desc = "Discord invite copied to clipboard!",
                Duration = 2,
            })
        end
    end)

    makeTopBtn("CloseBtn", "Close", function()
        confirmOverlay.Visible = true
    end)

    floatingOpenBtn.MouseButton1Click:Connect(function()
        floatingOpenBtn.Visible = false
        shadow.Visible = true
    end)

    make("Frame", {
        Name = "TopBarDivider",
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = self.Theme.StrokeSoft,
        BorderSizePixel = 0,
        Parent = contentArea,
    })

    local pages = make("Frame", {
        Name = "Pages",
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -32, 1, -24),
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        Parent = contentArea,
    })

    function self:SetTitle(newTitle: string)
        appTitle = newTitle
        sideAppTitle.Text = newTitle
        if self.SelectedTab then
            breadcrumbLabel.Text = string.upper(appTitle) .. " // " .. string.upper(self.SelectedTab)
        end
    end

    function self:SetSubtitle(newSub: string)
        descLabelRef.Text = newSub
    end
    self.SetSub = self.SetSubtitle

    function self:SetTheme(themeNameOrTable: any)
        self.Theme = resolveTheme(themeNameOrTable)
        if type(themeNameOrTable) == "string" then
            self.ThemeName = themeNameOrTable
        end

        root.BackgroundColor3 = self.Theme.Background
        sidebar.BackgroundColor3 = self.Theme.Sidebar
        sideDivider.BackgroundColor3 = self.Theme.StrokeSoft
        sideLogo.ImageColor3 = self.Theme.Accent
        pAvatarWrap.UIStroke.Color = self.Theme.Accent
        pBadgePill.BackgroundColor3 = self.Theme.AccentSoft
        pBadgeText.TextColor3 = self.Theme.Accent

        if self.SelectedTab then
            self:SelectTab(self.SelectedTab)
        end
    end

    function self:SelectTab(name: string)
        for tabName, tab in pairs(self.Tabs) do
            local selected = tabName == name
            
            if selected then
                tab.Page.Visible = true
                tab.Page.Position = UDim2.new(0, 15, 0, 0)
                tab.Page.BackgroundTransparency = 1
                tween(tab.Page, 0.25, { Position = UDim2.fromScale(0, 0) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            else
                tab.Page.Visible = false
            end

            tween(tab.Button, 0.18, {
                BackgroundColor3 = selected and self.Theme.AccentSoft or self.Sidebar.BackgroundColor3,
                BackgroundTransparency = selected and 0.05 or 0.5,
            })
            if tab.Indicator then
                tween(tab.Indicator, 0.18, {
                    BackgroundTransparency = selected and 0 or 1,
                })
            end
            if tab.TitleLabel then
                tab.TitleLabel.TextColor3 = selected and self.Theme.Text or self.Theme.Muted
            end
            if tab.DescLabel then
                tab.DescLabel.TextColor3 = selected and self.Theme.Accent or Color3.fromRGB(110, 140, 180)
            end
            if tab.Icon then
                tab.Icon.ImageColor3 = selected and self.Theme.Accent or self.Theme.Muted
            end
        end
        self.SelectedTab = name
        breadcrumbLabel.Text = string.upper(appTitle) .. " // " .. string.upper(name)
    end

    function self:Tab(tabProps: { [string]: any })
        tabProps = tabProps or {}
        local name = tostring(tabProps.Title or ("Tab " .. tostring(#self.Tabs + 1)))
        local subDesc = tostring(tabProps.Subtitle or tabProps.Desc or "Active Module")
        local tabIconAsset = normalizeAsset(tabProps.Icon or "Home")
        local hasTabIcon = tabIconAsset ~= ""

        local tabButton = make("TextButton", {
            Name = "Tab_" .. name,
            Text = "",
            AutoButtonColor = false,
            Size = UDim2.new(1, 0, 0, 48),
            BackgroundColor3 = self.Theme.Sidebar,
            BackgroundTransparency = 0.5,
            BorderSizePixel = 0,
            Parent = tabContainer,
        })
        corner(tabButton, 10)
        addRipple(tabButton, self.Theme.Accent)

        local tabIndicator = make("Frame", {
            Name = "ActiveIndicator",
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.new(0, 3.5, 0.7, 0),
            BackgroundColor3 = self.Theme.Accent,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Parent = tabButton,
        })
        corner(tabIndicator, 2)

        local tabIcon = createIcon(tabButton, tabIconAsset, 18, self.Theme.Muted, 0.1)
        tabIcon.AnchorPoint = Vector2.new(0, 0.5)
        tabIcon.Position = UDim2.new(0, 14, 0.5, 0)

        local textWrap = make("Frame", {
            Name = "TextWrap",
            Position = UDim2.fromOffset(hasTabIcon and 40 or 14, 6),
            Size = UDim2.new(1, -(hasTabIcon and 46 or 20), 1, -12),
            BackgroundTransparency = 1,
            Parent = tabButton,
        })
        list(textWrap, 2)

        local titleLabel = make("TextLabel", {
            Name = "Title",
            Text = string.upper(name),
            Font = Enum.Font.GothamBold,
            TextSize = 11.5,
            TextColor3 = self.Theme.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 15),
            Parent = textWrap,
        })

        local descLabel = make("TextLabel", {
            Name = "Desc",
            Text = subDesc,
            Font = Enum.Font.GothamMedium,
            TextSize = 9.5,
            TextColor3 = Color3.fromRGB(110, 140, 180),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 13),
            Parent = textWrap,
        })

        local page = make("ScrollingFrame", {
            Name = "Page_" .. name,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.fromScale(0, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticCanvasSize = Enum.AutomaticSize.None,
            ScrollingDirection = Enum.ScrollingDirection.Y,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = self.Theme.Accent,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Parent = pages,
        })
        padding(page, 4, 4, 12, 16)
        local pageLayout = list(page, 12)
        updateCanvas(page, pageLayout, 32)

        local pageApi = createPageApi(self, page)
        pageApi.Name = name

        self.Tabs[name] = {
            Button      = tabButton,
            Indicator   = tabIndicator,
            TitleLabel  = titleLabel,
            DescLabel   = descLabel,
            Icon        = tabIcon,
            Page        = page,
            Api         = pageApi,
        }

        tabButton.MouseButton1Click:Connect(function()
            self:SelectTab(name)
        end)

        if not self.SelectedTab then
            self:SelectTab(name)
        end

        return pageApi
    end

    function self:Notify(toastProps: { [string]: any })
        toastProps = toastProps or {}
        local toast = make("Frame", {
            Name = "Toast",
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -16, 1, -16),
            Size = UDim2.fromOffset(270, 68),
            BackgroundColor3 = self.Theme.Surface,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
            ZIndex = 50,
            Parent = root,
        })
        corner(toast, 12)
        stroke(toast, toastProps.Color or self.Theme.Accent, 1, 0.25)
        padding(toast, 14, 10, 14, 10)
        list(toast, 3)

        createText(toast, "ToastTitle", tostring(toastProps.Title or "Notification"), 11.5, toastProps.Color or self.Theme.Text, true, 1)
        createText(toast, "ToastDesc", tostring(toastProps.Desc or toastProps.Message or ""), 10, self.Theme.Muted, false, 2)

        toast.BackgroundTransparency = 1
        toast.Position = UDim2.new(1, 300, 1, -16)
        tween(toast, 0.25, {
            BackgroundTransparency = 0.05,
            Position = UDim2.new(1, -16, 1, -16),
        }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

        task.delay(toastProps.Duration or 3, function()
            if toast.Parent then
                tween(toast, 0.2, {
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, 300, 1, -16),
                }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
                task.wait(0.22)
                if toast then toast:Destroy() end
            end
        end)
        return toast
    end

    function self:SetVisible(val: boolean)
        shadow.Visible = val
    end

    function self:Destroy()
        screenGui:Destroy()
    end

    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == self.Keybind then
            shadow.Visible = not shadow.Visible
        end
    end)

    return self
end

return Library
