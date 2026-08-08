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

-- TABS (Nativo de WindUI)
local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "eye"
})

-- VARIABLES
local ESP_Enabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- FUNCIÓN DE TEAM CHECK PERSONALIZADA
local function isEnemy(target)
    if target == player then return false end
    local myTeam = player:GetAttribute("Team") or player.Team
    local targetTeam = target:GetAttribute("Team") or target.Team
    return myTeam ~= targetTeam
end

-- FUNCIÓN DEL ESP
local function UpdateESP()
    for _, target in pairs(Players:GetPlayers()) do
        local character = target.Character
        
        if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 then
            
            local highlight = character:FindFirstChild("ESPHighlight")

            if ESP_Enabled and isEnemy(target) then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.Parent = character
                    
                    highlight.FillTransparency = 1
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
                highlight.OutlineColor = espColor
            else
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    UpdateESP()
end)

-- COMPONENTES UI (Sintaxis 100% de WindUI)
VisualsTab:Toggle({
    Title = "Enemy ESP (Outline)",
    Desc = "Muestra el contorno de los enemigos a través de las paredes.",
    Default = false,
    Callback = function(state)
        ESP_Enabled = state
    end
})


VisualsTab:Colorpicker({
    Title = "Color del ESP",
    Desc = "Selecciona el color del contorno.",
    Default = Color3.fromRGB(255, 0, 0),
    Transparency = 0,
    Size = UDim2.fromOffset(300, 70),

    Callback = function(color)
        espColor = color

        for _, target in ipairs(Players:GetPlayers()) do
            local character = target.Character
            if character then
                local highlight = character:FindFirstChild("ESPHighlight")
                if highlight then
                    highlight.OutlineColor = color
                end
            end
        end
    end
})