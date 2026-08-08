local versao = "1.6.65"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. versao .. "/main.lua"))()

-- TEMAS
WindUI:AddTheme({
    Name = "Green",
    Accent = Color3.fromHex("00FF00"),
    Background = Color3.fromHex("0a1f0a"),
    Outline = Color3.fromHex("1a3d1a"),
    Text = Color3.fromHex("ffffff"),
    Placeholder = Color3.fromHex("71717a"),
    Button = Color3.fromHex("0d2b0d"),
    Icon = Color3.fromHex("66ff66"),
})

WindUI:AddTheme({
    Name = "Blue",
    Accent = Color3.fromHex("0080FF"),
    Background = Color3.fromHex("060a14"),
    Outline = Color3.fromHex("0d1a3d"),
    Text = Color3.fromHex("ffffff"),
    Placeholder = Color3.fromHex("71717a"),
    Button = Color3.fromHex("0a1429"),
    Icon = Color3.fromHex("66b3ff"),
})

WindUI:AddTheme({
    Name = "White",
    Accent = Color3.fromHex("ffffff"),
    Background = Color3.fromHex("f5f5f5"),
    Outline = Color3.fromHex("d4d4d4"),
    Text = Color3.fromHex("000000"),
    Placeholder = Color3.fromHex("71717a"),
    Button = Color3.fromHex("e8e8e8"),
    Icon = Color3.fromHex("333333"),
})

WindUI:AddTheme({
    Name = "Pink",
    Accent = Color3.fromHex("FF69B4"),
    Background = Color3.fromHex("1a060f"),
    Outline = Color3.fromHex("3d1a2b"),
    Text = Color3.fromHex("ffffff"),
    Placeholder = Color3.fromHex("71717a"),
    Button = Color3.fromHex("2b0d1a"),
    Icon = Color3.fromHex("ff99cc"),
})

-- VENTANA PRINCIPAL
local Window = WindUI:CreateWindow({
    Title = "Mario Hub VIP",
    Icon = "door-open",
    Author = "by Mario J.",
    Size = UDim2.fromOffset(650, 500),
    OpenButton = {
        Title = "Open Mario Hub",
        Icon = "monitor",
        CornerRadius = UDim.new(0, 16),
        StrokeThickness = 2,
        Color = ColorSequence.new(
            Color3.fromHex("FF0F7B"),
            Color3.fromHex("F89B29")
        ),
        OnlyMobile = false,
        Enabled = true,
        Draggable = true,
    }
})