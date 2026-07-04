local cloneref = cloneref or function(o) return o end
local Players = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService = cloneref(game:GetService("RunService"))
local lp = Players.LocalPlayer
local username = lp.Name
local Camera = workspace.CurrentCamera
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local SoundService = cloneref(game:GetService("SoundService"))

local character
local hum
local root

local function uCR(char)
    character = char
    root = character:WaitForChild("HumanoidRootPart", 5)
    hum = character:WaitForChild("Humanoid", 5)
end

uCR(lp.Character or lp.CharacterAdded:Wait())
lp.CharacterAdded:Connect(function(newChar)
    uCR(newChar)
end)

local blacklist = {
    [1848960] = true
}
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/azurelw/azurehub/refs/heads/main/main.lua"))()
--getgenv().PREMIUM_KEY = true
local function getTag(name)
    return ""
end

local discordLink = "https://discord.gg/QmvpbPdw9J"

if blacklist[lp.UserId] then
getgenv().PREMIUM_KEY = true
    lp:Kick("Exploiting")
    return
end

local gid = 0
local bannedRanks = {}
local rankName = lp:GetRoleInGroup(0)
if bannedRanks[rankName] then
    lp:Kick("Exploiting")
end

print("Loaded!\nAzureHub By Cat\nDiscord: https://discord.gg/QmvpbPdw9J")

WindUI:SetNotificationLower(true)
local Window = WindUI:CreateWindow({
    Title = "Azure Hub | Murder Mystery 2",
    Author = "discord.gg/azurehub",
    Folder = "MurderMystery2Hub",
    Size = UDim2.fromOffset(500, 300),
    Theme = "Dark",
    User = {
        Enabled = false,
        Anonymous = false
    },
    Transparent = true,
    SideBarWidth = 220,
    ScrollBarEnabled = true
})
Window:SetToggleKey(Enum.KeyCode.K)

local isPremium = getgenv().PREMIUM_KEY == true
Window:EditOpenButton({
    Title = "ALEXX HUB",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    OnlyMobile = true,
    Enabled = true,
    Draggable = true,
})
Window:OnClose(function()
end)

Window:OnOpen(function()
end)

Window:OnDestroy(function()
end)

local corner = Instance.new("UICorner", btn)
corner.CornerRadius = UDim.new(0.25, 0)
local overlay = Instance.new("Frame", btn)
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.new(1, 1, 1)
overlay.BackgroundTransparency = 1
overlay.ZIndex = 2
overlay.Interactable = false
local overlayCorner = corner:Clone()
overlayCorner.Parent = overlay

if not game.UserInputService.TouchEnabled then WindUI:Notify({ Title = "Azure Hub", Content = "Use 'K' Button To Toggle UI.", Icon = "info", Duration = 3 }) end

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "Light" or "Dark")
    WindUI:Notify({
        Title = "Theme Changed",
        Content = "Current theme: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Logs = Window:Tab({ Title = "|  Update Logs", Icon = "scroll-text" })
Window:Divider()

local Tabs = {
    Features = Window:Section({ Title = "Features", Opened = true }),
    Utilities = Window:Section({ Title = "Utilities", Opened = true })
}local TabHandles = {
    Main = Tabs.Features:Tab({ Title = "| Main", Icon = "house" }),
    Esp = Tabs.Features:Tab({ Title = "| ESP", Icon = "eye" }),
    Player = Tabs.Features:Tab({ Title = "| Player", Icon = "users-round" }),
    Misc = Tabs.Features:Tab({ Title = "| Misc", Icon = "layout-grid" }),
    Config = Tabs.Utilities:Tab({ Title = "| Configuration", Icon = "settings" })
}
local updparagraph = Logs:Paragraph({
    Title = "Update Logs",
    Desc = "19.12.25\n[+] Murder Mystery 2\n[+] Fixed Detections",
    Locked = false,
    Buttons = {
        {
            Icon = "clipboard",
            Title = "Discord Server",
            Callback = function() setclipboard(discordLink) WindUI:Notify({ Title = "Discord Server", Content = "Link Copied!", Icon = "info", Duration = 2 }) end,
        }
    }
})

local KillAuraToggle = false
local KillAuraRadius = 15
local AutoKillToggle = false
local AutoShootToggle = false
local PredictionToggle = false
local AutoFarmToggle = false
local AutoGrabToggle = false
local AutoFarmAvoidToggle = false
local AutoFarmMethod = "Closest"
-- TABLÓN DE ANUNCIOS (Optimización)
getgenv().CurrentMurderer = nil

-- El "Ojo": Busca al asesino y lo guarda en el tablón
RunService.Heartbeat:Connect(function()
    local found = nil
    for _, p in ipairs(Players:GetPlayers()) do
        if p == lp or not p.Character then continue end
        
        -- Lista completa de objetos que identifican al asesino
        local isMurderer = p.Character:FindFirstChild("Knife") or p.Character:FindFirstChild("Footsteps") or 
                           p.Character:FindFirstChild("Sleight") or p.Character:FindFirstChild("Decoy") or 
                           p.Character:FindFirstChild("Ghost") or p.Character:FindFirstChild("Fake Gun") or 
                           p.Character:FindFirstChild("Xray") or p.Character:FindFirstChild("Haste") or 
                           p.Character:FindFirstChild("Trap") or p.Character:FindFirstChild("Sprint") or 
                           p.Character:FindFirstChild("Ninja")
                           
        if isMurderer then
            found = p
            break
        end
    end
    getgenv().CurrentMurderer = found
end)

local WalkToggle = false
local currentSpeed = 28
local Noclip = nil
local Clip = nil
local NoclipToggle = false

local antiAfkToggle = false
local FlingToggle = false
local antiFlingToggle = false
local flingThread

local function fling()
    local movel = 0.1
    while FlingToggle do
        RunService.Heartbeat:Wait()
        local c = lp.Character
        local hrp = c and c:FindFirstChild("HumanoidRootPart")
        if hrp then
            local vel = hrp.Velocity
            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            hrp.Velocity = vel
            RunService.Stepped:Wait()
            hrp.Velocity = vel + Vector3.new(0, movel, 0)
            movel = -movel
        end
    end
end

task.spawn(function()
	while task.wait(60) do
		if antiAfkToggle then
			root.CFrame = root.CFrame + Vector3.new(0, 3, 0)
		end
	end
end)

local function autograb()
    task.spawn(function()
        while AutoGrabToggle do
            local gun = workspace:FindFirstChild("GunDrop", true)
            
            if gun and gun:IsA("BasePart") and root then
                local oldPos = root.CFrame
                root.CFrame = gun.CFrame
                task.wait(0.3)
                root.CFrame = oldPos
                task.wait(1) 
            end
            task.wait(0.5)
        end
    end)
end

local function autoshoot()
    task.spawn(function()
        while AutoShootToggle do
            local gun = lp.Character and lp.Character:FindFirstChild("Gun")
            if gun and gun:FindFirstChild("Shoot") then
                local murderer = nil
                local targetHRP = nil
                
                for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
                    if p ~= lp and p.Character then
                        local char = p.Character
                        local isMrd = char:FindFirstChild("Footsteps") or char:FindFirstChild("Sleight") or 
                                       char:FindFirstChild("Decoy") or char:FindFirstChild("Ghost") or 
                                       char:FindFirstChild("Fake Gun") or char:FindFirstChild("Xray") or 
                                       char:FindFirstChild("Haste") or char:FindFirstChild("Trap") or 
                                       char:FindFirstChild("Sprint") or char:FindFirstChild("Ninja")
                        
                        if isMrd then
                            targetHRP = char:FindFirstChild("HumanoidRootPart")
                            murderer = char
                            break
                        end
                    end
                end

                if targetHRP and root then
                    local origin = root.Position
                    local direction = (targetHRP.Position - origin)
                    
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {lp.Character, workspace.CurrentCamera}
                    rayParams.FilterType = Enum.RaycastFilterType.Exclude

                    local result = workspace:Raycast(origin, direction, rayParams)

                    if result and result.Instance:IsDescendantOf(murderer) then
                        local finalTargetCFrame = targetHRP.CFrame
                        
                        if PredictionToggle then
                            local velocity = targetHRP.Velocity
                            local predictionOffset = velocity * 0.15
                            finalTargetCFrame = targetHRP.CFrame + predictionOffset
                        end

                        local args = {
                            root.CFrame,
                            finalTargetCFrame
                        }
                        
                        gun.Shoot:FireServer(unpack(args))
                        task.wait(0.5)
                    end
                end
            end
            task.wait()
        end
    end)
end

local function loopkillaura()
    task.spawn(function()
        while KillAuraToggle do
            local isMurderer = character:FindFirstChild("Footsteps") or character:FindFirstChild("Sleight") or character:FindFirstChild("Decoy") or character:FindFirstChild("Ghost") or character:FindFirstChild("Fake Gun") or character:FindFirstChild("Xray") or character:FindFirstChild("Haste") or character:FindFirstChild("Trap") or character:FindFirstChild("Sprint") or character:FindFirstChild("Ninja")

            if isMurderer and root then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local targetRoot = plr.Character.HumanoidRootPart
                        local distance = (root.Position - targetRoot.Position).Magnitude

                        if distance <= KillAuraRadius then
                            local targetPos = root.CFrame:ToWorldSpace(CFrame.new(0, 0, -1.5))

                            targetRoot.CFrame = CFrame.new(targetPos.Position) * targetRoot.CFrame.Rotation
                        end
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

local function killplayers()
    task.spawn(function()
        while AutoKillToggle do
            local isMurderer = character:FindFirstChild("Footsteps") or character:FindFirstChild("Sleight") or character:FindFirstChild("Decoy") or character:FindFirstChild("Ghost") or character:FindFirstChild("Fake Gun") or character:FindFirstChild("Xray") or character:FindFirstChild("Haste") or character:FindFirstChild("Trap") or character:FindFirstChild("Sprint") or character:FindFirstChild("Ninja")

            if isMurderer and root then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local targetRoot = plr.Character.HumanoidRootPart
                        local targetPos = root.CFrame:ToWorldSpace(CFrame.new(0, 0, -1.5))
                        targetRoot.CFrame = CFrame.new(targetPos.Position) * targetRoot.CFrame.Rotation
                    end
                end
            end
            task.wait(0.05)
        end
    end)
end

local function autofarm()
    task.spawn(function()
        while AutoFarmToggle do
            local myChar = lp.Character
            local isMurderer = myChar and (myChar:FindFirstChild("Footsteps") or myChar:FindFirstChild("Sleight") or myChar:FindFirstChild("Decoy") or myChar:FindFirstChild("Ghost") or myChar:FindFirstChild("Fake Gun") or myChar:FindFirstChild("Xray") or myChar:FindFirstChild("Haste") or myChar:FindFirstChild("Trap") or myChar:FindFirstChild("Sprint") or myChar:FindFirstChild("Ninja"))
            
            local CoinContainer = workspace:FindFirstChild("CoinContainer", true)
            
            if CoinContainer then
                local currentMurderer = nil
                for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
                    if p ~= lp and p.Character then
                        local char = p.Character
                        if char:FindFirstChild("Footsteps") or char:FindFirstChild("Decoy") or char:FindFirstChild("Sleight") or char:FindFirstChild("Ghost") or char:FindFirstChild("Ninja") or char:FindFirstChild("Fake Gun") or char:FindFirstChild("Xray") or char:FindFirstChild("Haste") or char:FindFirstChild("Trap") or char:FindFirstChild("Sprint") or char:FindFirstChild("Ninja") then
                            currentMurderer = char:FindFirstChild("HumanoidRootPart")
                            break
                        end
                    end
                end

                local allCoins = {}
                for _, c in ipairs(CoinContainer:GetChildren()) do
                    if c:IsA("BasePart") and string.find(c.Name, "Coin_Server") then
                        local isDangerous = false
                        if AutoFarmAvoidToggle and currentMurderer then
                            if (c.Position - currentMurderer.Position).Magnitude < 15 then
                                isDangerous = true
                            end
                        end
                        if not isDangerous then table.insert(allCoins, c) end
                    end
                end

                local targetCoin = nil
                local tweenTime = 1
                local waitTime = 1.1

                if #allCoins > 0 then
                    if AutoFarmMethod == "Closest" and root then
                        local closestDist = math.huge
                        for _, coin in ipairs(allCoins) do
                            local dist = (root.Position - coin.Position).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                targetCoin = coin
                            end
                        end
                    elseif AutoFarmMethod == "Randomized" then
                        targetCoin = allCoins[math.random(1, #allCoins)]
                        tweenTime = 3
                        waitTime = 3.1
                    end
                end

                if targetCoin and root then
                    local distance = (root.Position - targetCoin.Position).Magnitude
                    if distance > 10 then
                        tweenTime = tweenTime + 0.5; waitTime = waitTime + 0.6
                    elseif distance < 5 then
                        tweenTime = 0.3; waitTime = 0.4
                    end

                    local tween = TweenService:Create(root, TweenInfo.new(tweenTime, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetCoin.Position)})
                    tween:Play()

                    local start = tick()
                    local cancelled = false
                    while tick() - start < waitTime do
                        if not AutoFarmToggle then tween:Cancel(); break end
                        if AutoFarmAvoidToggle and currentMurderer and not isMurderer then
                            if (root.Position - currentMurderer.Position).Magnitude < 7 then
                                tween:Cancel()
                                cancelled = true
                                break
                            end
                        end
                        task.wait(0.1)
                    end

                    if not cancelled and targetCoin and targetCoin.Parent then
                        targetCoin:Destroy()
                    end
                else
                    task.wait(0.5) 
                end
            else
                task.wait(1)
            end
        end
    end)
end

local function contains(tbl, val)
    if not tbl or type(tbl) ~= "table" then return false end
    for _, v in ipairs(tbl) do
        if v == val then return true end
    end
    return false
end

local function isMurderObject(obj)
    local child = obj:FindFirstChild("Footsteps") or obj:FindFirstChild("Sleight") or obj:FindFirstChild("Decoy") or obj:FindFirstChild("Ghost") or obj:FindFirstChild("Fake Gun") or obj:FindFirstChild("Xray") or obj:FindFirstChild("Haste") or obj:FindFirstChild("Trap") or obj:FindFirstChild("Sprint") or obj:FindFirstChild("Ninja")
    return child and child:IsA("Folder")
end

local function isSheriffObject(obj)
    if obj.Name == "Gun" and obj:IsA("Tool") then
        return true
    end
    return false
end

local function isPlayerObject(obj)
    if obj:IsA("Model") and obj:FindFirstChild("Head") and obj.Name ~= lp.Name then
        if not isMurderObject(obj) and not isSheriffObject(obj) then
            return true
        end
    end
    return false
end

local function isGunObject(obj)
    if obj.Name == "GunDrop" and obj:IsA("BasePart") then
        return true
    end
    return false
end

local function passesDropdownFilter(obj)
    if not selectedESPTypes or #selectedESPTypes == 0 then
        return false
    end
    if contains(selectedESPTypes, "Murderer") and isMurderObject(obj) then return true end
    if contains(selectedESPTypes, "Sheriff") and isSheriffObject(obj) then return true end
    if contains(selectedESPTypes, "Players") and isPlayerObject(obj) then return true end
    if contains(selectedESPTypes, "Gun") and isGunObject(obj) then return true end
    return false
end

local function getObjColor(obj)
    if isPlayerObject(obj) then return Color3.fromRGB(0, 255, 0) end
    if isSheriffObject(obj) then return Color3.fromRGB(0, 0, 255) end 
    if isMurderObject(obj) then return Color3.fromRGB(255, 0, 0) end
    if isGunObject(obj) then return Color3.fromRGB(0, 0, 255) end
    return Color3.fromRGB(0, 255, 0)                           
end

local function getRootPosition(target)
    if target:IsA("BasePart") then 
        return target.Position 
    end
    
    if target:IsA("Model") then
        if target.PrimaryPart then return target.PrimaryPart.Position end
        
        local root = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("VisibleParts")
        if root and root:IsA("BasePart") then return root.Position end
        
        return target:GetPivot().Position
    end
    
    return Vector3.new(0, 0, 0)
end

-- Función para identificar el rol
local function getRoleColor(player)
    local char = player.Character
    if not char then return nil end
    
    -- Lógica simple de Murder Mystery 2
    if char:FindFirstChild("Knife") or char:FindFirstChild("Footsteps") then 
        return Color3.fromRGB(255, 0, 0) -- Asesino (Rojo)
    elseif char:FindFirstChild("Gun") or player.Backpack:FindFirstChild("Gun") then 
        return Color3.fromRGB(0, 0, 255) -- Sheriff (Azul)
    else 
        return Color3.fromRGB(0, 255, 0) -- Inocente (Verde)
    end
end
-- Primero, define esta tabla al inicio de tus variables
local ESP_Settings = { Murderer = false, Sheriff = false, Innocent = false }

-- Motor de ESP Optimizado (Colócalo donde tenías tu lógica vieja)
RunService.RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            -- Detección en Character o en Backpack
            local isMurderer = plr.Character:FindFirstChild("Knife") or plr:FindFirstChild("Backpack"):FindFirstChild("Knife")
            local isSheriff = plr.Character:FindFirstChild("Gun") or plr:FindFirstChild("Backpack"):FindFirstChild("Gun")
            local isInnocent = not isMurderer and not isSheriff
            
            -- Lógica de visibilidad según tus toggles
            local shouldShow = (isMurderer and ESP_Settings.Murderer) or 
                               (isSheriff and ESP_Settings.Sheriff) or 
                               (isInnocent and ESP_Settings.Innocent)
            
            -- Crear/Actualizar Highlight
            local hl = plr.Character:FindFirstChild("ESP_Highlight")
            if shouldShow then
                if not hl then
                    hl = Instance.new("Highlight", plr.Character)
                    hl.Name = "ESP_Highlight"
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
                -- Colores: Rojo (Murderer), Azul (Sheriff), Verde (Inocente)
                hl.FillColor = isMurderer and Color3.fromRGB(255, 0, 0) or 
                               (isSheriff and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(0, 255, 0))
                hl.Enabled = true
            else
                if hl then hl.Enabled = false end
            end
        end
    end
end)


local lR, rI = 0, 1.5
local rootCache = {}

RunService.Heartbeat:Connect(function()
    local now = tick()
    
    if now - lR > rI then
        lR = now
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj ~= lp.Character and passesDropdownFilter(obj) then 
                ensureAllFor(obj) 
            end
        end

        local dropgun = workspace:FindFirstChild("GunDrop", true)
        if dropgun and passesDropdownFilter(dropgun) then
            ensureAllFor(dropgun)
        end
    end

    local viewportSize = Camera.ViewportSize
    local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")

    for obj, data in pairs(esp) do
        local color = getObjColor(obj)
        
        if not obj or not obj.Parent or not passesDropdownFilter(obj) then
            removeESP(obj)
            rootCache[obj] = nil
            continue
        end

        if obj:IsA("Model") and obj:FindFirstChild("Head") then
            local p = Players:GetPlayerFromCharacter(obj)
            if p then
                local b = p:FindFirstChild("Backpack")
                if obj:FindFirstChild("Gun") or (b and b:FindFirstChild("Gun")) then
                    color = Color3.fromRGB(0, 0, 255)
                --[[elseif obj:FindFirstChild("Knife") or (b and b:FindFirstChild("Knife")) then
                    color = Color3.fromRGB(255, 0, 0)]]
                end 
            end
        end

        local worldPos = getRootPosition(obj)
        local screenPos, onScreen = Camera:WorldToViewportPoint(worldPos)
        local isVisible = onScreen and screenPos.Z > 0
        
        if tracers[obj] then
            tracers[obj].Visible = isVisible and ESPTracers
            if tracers[obj].Visible then
                tracers[obj].Color = color
                tracers[obj].From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                tracers[obj].To = Vector2.new(screenPos.X, screenPos.Y)
            end
        end

        if data.billboard then
            data.billboard.Enabled = isVisible and (ESPNames or ESPStuds)
            if data.billboard.Enabled and myRoot then
                local targetLabel = data.nameLabel or data.billboard:FindFirstChildOfClass("TextLabel")
                if targetLabel then
                     targetLabel.Visible = true
                     local dist = (Camera.CFrame.Position - worldPos).Magnitude
                     
                     if ESPNames and ESPStuds then
                         targetLabel.Text = obj.Name .. " (" .. string.format("%.0fm", dist) .. ")"
                     elseif ESPNames then
                         targetLabel.Text = obj.Name
                     elseif ESPStuds then
                         targetLabel.Text = string.format("%.0fm", dist)
                     end
                     targetLabel.TextColor3 = color
                end
            end
        end

        if boxes[obj] then
            local box = boxes[obj]
            local showBox = isVisible and ESPBoxes
            for _, line in pairs(box) do line.Visible = showBox; line.Color = color end
            if showBox then
                local size = (1 / screenPos.Z) * 1000 
                local w, h = size * 0.6, size
                local x, y = screenPos.X, screenPos.Y
                box.tl.From = Vector2.new(x-w, y-h); box.tl.To = Vector2.new(x+w, y-h)
                box.tr.From = Vector2.new(x+w, y-h); box.tr.To = Vector2.new(x+w, y+h)
                box.br.From = Vector2.new(x+w, y+h); box.br.To = Vector2.new(x-w, y+h)
                box.bl.From = Vector2.new(x-w, y+h); box.bl.To = Vector2.new(x-w, y-h)
            end
        end
        
        if data.highlight then
            data.highlight.FillColor = color
        end
    end
end)

Workspace.ChildAdded:Connect(function(child)
    task.wait(0.5)
    if passesDropdownFilter(child) then ensureAllFor(child) end
end)

Workspace.ChildRemoved:Connect(function(child)
    removeESP(child)
end)

local function noclip()
	Clip = false
	if Noclip then Noclip:Disconnect() end
	Noclip = RunService.Stepped:Connect(function()
		if Clip == false and lp.Character then
			for _, v in ipairs(lp.Character:GetChildren()) do
				if v:IsA("BasePart") and v.CanCollide then
					v.CanCollide = false
				end
			end
		end
	end)
end

local function clip()
	Clip = true
	if Noclip then
		Noclip:Disconnect()
		Noclip = nil
	end
end

local function applyBypassSpeed()
    task.spawn(function()
        while task.wait(0.2) do
            if not WalkToggle then continue end
            
            if hum then
                for _, conn in ipairs(getconnections(hum:GetPropertyChangedSignal("WalkSpeed"))) do
                    conn:Disable()
                end
                hum.WalkSpeed = currentSpeed
            end
        end
    end)
end
applyBypassSpeed()

local MurderSection = TabHandles.Main:Section({ 
    Title = "Murderer",
    Icon = "slice"
})
local KillAuraHandle = MurderSection:Toggle({
    Title = "Kill Aura",
    Desc = "Kills players inside the radius studs you can set below.",
    Value = false,
    Callback = function(state)
        KillAuraToggle = state
        if state then loopkillaura() end
    end
})
local KillAuraRHandle = MurderSection:Slider({
       Title = "Kill Aura Radius",
	Value = { Min = 1, Max = 50, Default = 15 },
	Callback = function(Value)
		KillAuraRadius = tonumber(Value)
	end
})
local AutoKillHandle = MurderSection:Toggle({
    Title = "Kill Everyone",
    Desc = "Kills everyone once round started and you're murder.",
    Value = false,
    Callback = function(state)
        AutoKillToggle = state
        if state then killplayers() end
    end
})

local SheriffSection = TabHandles.Main:Section({ 
    Title = "Sheriff",
    Icon = "bow-arrow"
})
local AutoShootHandle = SheriffSection:Toggle({
    Title = "Auto Shoot Murder",
    Desc = "Must be sheriff, automatically shoots murder once in FOV.",
    Value = false,
    Callback = function(state)
        AutoShootToggle = state
        if state then autoshoot() end
    end
})

local PredictionHandle
PredictionHandle = SheriffSection:Toggle({
    Title = "Auto Shoot Prediction",
    Desc = "Versión Potente: Predicción de alta precisión y disparo directo.",
    Value = false,
    Callback = function(state)
        PredictionToggle = state
        
        if state then
            task.spawn(function()
                while PredictionToggle do
                    -- Usamos la variable global optimizada
                    local murdererPlayer = getgenv().CurrentMurderer
                    local gun = lp.Character and lp.Character:FindFirstChild("Gun")
                    
                    -- Verificamos que el asesino sea válido y tengamos el arma
                    if murdererPlayer and murdererPlayer.Character and gun and gun:FindFirstChild("Shoot") and root then
                        local targetHRP = murdererPlayer.Character:FindFirstChild("HumanoidRootPart")
                        
                        if targetHRP then
                            local direction = (targetHRP.Position - root.Position)
                            
                            -- Raycast para verificar visibilidad
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {lp.Character, workspace.CurrentCamera}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude
                            
                            local result = workspace:Raycast(root.Position, direction, rayParams)
                            
                            -- Si vemos al asesino, disparamos con predicción
                            if result and result.Instance:IsDescendantOf(murdererPlayer.Character) then
                                local vel = targetHRP.AssemblyLinearVelocity
                                local dist = direction.Magnitude
                                -- Ajuste de predicción mejorado
                                local prediction = vel * (dist / 500) * 0.30
                                local targetPos = targetHRP.CFrame + prediction
                                
                                gun.Shoot:FireServer(root.CFrame, targetPos)
                                
                                task.wait(0.15) -- Delay de seguridad
                            end
                        end
                    end
                    task.wait(0.02)
                end
            end)
        end
    end
})


local InnocentSection = TabHandles.Main:Section({ 
    Title = "Innocent",
    Icon = "user"
})
local AutoGrabHandle = InnocentSection:Toggle({
    Title = "Auto Grab",
    Desc = "Teleports to gun when its dropped and teleports back to your original position.",
    Value = false,
    Callback = function(state)
        AutoGrabToggle = state
        if state then 
            autograb()
        end
    end
})

local FarmSection = TabHandles.Main:Section({ 
    Title = "Farming",
    Icon = "tractor"
})
local AutoFarmHandle = FarmSection:Toggle({
    Title = "Auto Farm Coins",
    Desc = "Automatically tweens to coins and farms.",
    Value = false,
    Callback = function(state)
        AutoFarmToggle = state
        if state then 
            NoclipToggle = true
            autofarm()
            noclip()
        else
            NoclipToggle = false
            clip()
        end
    end
})
local AutoFarmAHandle = FarmSection:Toggle({
    Title = "Avoid Murder?",
    Desc = "If you get close to murder with auto farm, it goes to another coin.",
    Value = false,
    Callback = function(state)
        AutoFarmAvoidToggle = state
    end
})
local AutoFarmDHandle = FarmSection:Dropdown({
       Title =  "Farm Method",
       Values = { "Closest", "Randomized" },
       Value = "Closest",
       Multi = false,
       AllowNone = false,
       Callback = function(option)
             AutoFarmMethod = option
       end
})

TabHandles.Esp:Toggle({
    Title = "ESP Asesino (Rojo)",
    Value = false,
    Callback = function(state) ESP_Settings.Murderer = state end
})

TabHandles.Esp:Toggle({
    Title = "ESP Sheriff (Azul)",
    Value = false,
    Callback = function(state) ESP_Settings.Sheriff = state end
})

TabHandles.Esp:Toggle({
    Title = "ESP Inocentes (Verde)",
    Value = false,
    Callback = function(state) ESP_Settings.Innocent = state end
})



local NoclipHandle = TabHandles.Player:Toggle({
	Title = "Noclip",
	Desc = "Pass through walls with this toggle on.",
	Value = false,
	Callback = function(state)
		NoclipToggle = state
		if state then
			noclip()
		else
			clip()
		end
	end
})
local WsToggleHandle = TabHandles.Player:Toggle({
	Title = "WalkSpeed Changer",
	Desc = "Set your speed to your preference.",
	Value = false,
	Callback = function(state)
		WalkToggle = state
	end
})
local WsSliderHandle = TabHandles.Player:Slider({
       Title = "WalkSpeed",
	Value = { Min = 16, Max = 100, Default = 16 },
	Callback = function(Value)
		currentSpeed = Value
	end
})

local idConn
local ProtectIdentityHandle = TabHandles.Misc:Toggle({
    Title = "Protect Identity",
    Desc = "Hides user, avatar, etc.",
    Value = false,
    Callback = function(state)
        local function bacon(c)
            if not character then return end
            for _, v in pairs(character:GetChildren()) do 
                if v:IsA("Accessory") or v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("CharacterMesh") then v:Destroy() end 
            end
            if character:FindFirstChild("Head") and character.Head:FindFirstChild("face") then character.Head.face.Texture = "rbxassetid://144075659" end
            local bc = character:FindFirstChild("BodyColors") or Instance.new("BodyColors", c)
            bc.HeadColor3 = Color3.fromRGB(234, 184, 146); bc.TorsoColor3 = Color3.fromRGB(116, 134, 157); bc.LeftLegColor3 = Color3.fromRGB(82, 84, 82); bc.RightLegColor3 = Color3.fromRGB(82, 84, 82); bc.LeftArmColor3 = bc.HeadColor3; bc.RightArmColor3 = bc.HeadColor3
            if lp then
                lp.Name = "azurehub"
                lp.DisplayName = "azurehub"
            end
        end

        if state then
            bacon(character)
            if idConn then idConn:Disconnect() end
            idConn = lp.CharacterAdded:Connect(function(c)
                bacon(c)
                task.wait(2)
                bacon(c) 
            end)
        else
            if idConn then idConn:Disconnect() end
        end
    end
})
local antiAfkHandle = TabHandles.Misc:Toggle({
    Title = "Anti AFK",
    Desc = "If enabled, jumps every minute so you wouldn't get kicked out for AFK.",
    Value = false,
    Callback = function(state)
        antiAfkToggle = state
    end
})

local antiFlingHandle = TabHandles.Misc:Toggle({
    Title = "Anti Fling",
    Desc = "If enabled, no one could fling you off map.",
    Value = false,
    Callback = function(state)
        antiFlingToggle = state
        if not state then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lp and plr.Character then
                    for _, part in ipairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = true
                        end
                    end
                end
            end
        end
    end
})

local FlingHandle = TabHandles.Misc:Toggle({
    Title = "Touch Fling",
    Desc = "If enabled, you could fling anyone in map by touching them.",
    Value = false,
    Callback = function(state)
        FlingToggle = state
        if state then fling() end
    end
})

local antiAdminToggle = false
local antiAdminHandle = TabHandles.Misc:Toggle({
    Title = "Anti Admin",
    Desc = "If enabled, kicks you out if there's admin in your experience.",
    Value = false,
    Callback = function(state)
        antiAdminToggle = state
    end
})

task.spawn(function()
	while task.wait(1) do
		if antiAdminToggle then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= lp and (table.find(blacklist, plr.UserId) or bannedRanks[plr:GetRoleInGroup(gid)]) then
					lp:Kick("Admin detected: " .. plr.Name)
				end
			end
		end
		local target = workspace:FindFirstChild("GlitchProof",  true)
		if target then
		    target:Destroy()
		end
	end
end)

local configName = "Config Name"
TabHandles.Config:Input({
    Title = "Config Name",
    Value = configName,
    Callback = function(value)
        configName = value
        if ConfigManager then
            configFile = ConfigManager:CreateConfig(configName)
            configFile:Register("AutoGrabHandle", AutoGrabHandle)
            configFile:Register("PredictionHandle", PredictionHandle)
            configFile:Register("KillAuraRHandle", KillAuraRHandle)
            configFile:Register("KillAuraHandle", KillAuraHandle)
            configFile:Register("AutoKillHandle", AutoKillHandle)
            configFile:Register("AutoShootHandle", AutoShootHandle)
            configFile:Register("AutoFarmAHandle", AutoFarmAHandle)
            configFile:Register("AutoFarmHandle", AutoFarmHandle)
            configFile:Register("AutoFarmDHandle", AutoFarmDHandle)
            configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
            configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
            configFile:Register("ESPTracersHandle", ESPTracersHandle)
            configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
            configFile:Register("ESPStudsHandle", ESPStudsHandle)
            configFile:Register("NoclipHandle", NoclipHandle)
            configFile:Register("WsToggleHandle", WsToggleHandle)
            configFile:Register("WsSliderHandle", WsSliderHandle)
            configFile:Register("ProtectIdentityHandle", ProtectIdentityHandle)
            configFile:Register("antiAfkHandle", antiAfkHandle)
            configFile:Register("antiFlingHandle", antiFlingHandle)
            configFile:Register("FlingHandle", FlingHandle)
            configFile:Register("antiAdminHandle", antiAdminHandle)
        end
    end
})

local ConfigManager = Window.ConfigManager
local configFile
local autoLoadFile = "AZUREHUB_ALC_MM.txt"
local ALC = false

if ConfigManager then
    ConfigManager:Init(Window)
    
    configFile = ConfigManager:CreateConfig(configName)
    configFile:Register("AutoGrabHandle", AutoGrabHandle)
    configFile:Register("PredictionHandle", PredictionHandle)
    configFile:Register("KillAuraRHandle", KillAuraRHandle)
    configFile:Register("KillAuraHandle", KillAuraHandle)
    configFile:Register("AutoKillHandle", AutoKillHandle)
    configFile:Register("AutoShootHandle", AutoShootHandle)
    configFile:Register("AutoFarmAHandle", AutoFarmAHandle)
    configFile:Register("AutoFarmHandle", AutoFarmHandle)
    configFile:Register("AutoFarmDHandle", AutoFarmDHandle)
    configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
    configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
    configFile:Register("ESPTracersHandle", ESPTracersHandle)
    configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
    configFile:Register("ESPStudsHandle", ESPStudsHandle)
    configFile:Register("NoclipHandle", NoclipHandle)
    configFile:Register("WsToggleHandle", WsToggleHandle)
    configFile:Register("WsSliderHandle", WsSliderHandle)
    configFile:Register("ProtectIdentityHandle", ProtectIdentityHandle)
    configFile:Register("antiAfkHandle", antiAfkHandle)
    configFile:Register("antiFlingHandle", antiFlingHandle)
    configFile:Register("FlingHandle", FlingHandle)
    configFile:Register("antiAdminHandle", antiAdminHandle)
    
    TabHandles.Config:Button({
        Title = "Save Config",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            configFile:Save()
            WindUI:Notify({ 
                Title = "Saved Config", 
                Content = "Saved as: "..configName,
                Icon = "check",
                Duration = 3
            })
        end
    })

    TabHandles.Config:Button({
        Title = "Load Config",
        Icon = "folder",
        Callback = function()
           if not configFile then
                configFile = ConfigManager:CreateConfig(configName)
                configFile:Register("AutoGrabHandle", AutoGrabHandle)
                configFile:Register("PredictionHandle", PredictionHandle)
                configFile:Register("KillAuraRHandle", KillAuraRHandle)
                configFile:Register("KillAuraHandle", KillAuraHandle)
                configFile:Register("AutoKillHandle", AutoKillHandle)
                configFile:Register("AutoShootHandle", AutoShootHandle)
                configFile:Register("AutoFarmAHandle", AutoFarmAHandle)
                configFile:Register("AutoFarmHandle", AutoFarmHandle)
                configFile:Register("AutoFarmDHandle", AutoFarmDHandle)
                configFile:Register("ESPDropdownHandle", ESPDropdownHandle)
                configFile:Register("ESPHighlightHandle", ESPHighlightHandle)
                configFile:Register("ESPTracersHandle", ESPTracersHandle)
                configFile:Register("ESPBoxesHandle", ESPBoxesHandle)
                configFile:Register("ESPStudsHandle", ESPStudsHandle)
                configFile:Register("NoclipHandle", NoclipHandle)
                configFile:Register("WsToggleHandle", WsToggleHandle)
                configFile:Register("WsSliderHandle", WsSliderHandle)
                configFile:Register("ProtectIdentityHandle", ProtectIdentityHandle)
                configFile:Register("antiAfkHandle", antiAfkHandle)
                configFile:Register("antiFlingHandle", antiFlingHandle)
                configFile:Register("FlingHandle", FlingHandle)
                configFile:Register("antiAdminHandle", antiAdminHandle)
            end

            local loadedData = configFile:Load()

            if loadedData then
                WindUI:Notify({ 
                    Title = "Load Config", 
                    Content = "Loaded: "..configName.."\nLast save: "..(loadedData.lastSave or "Unknown"),
                    Icon = "refresh-cw",
                    Duration = 5
                })
            else
                WindUI:Notify({ 
                    Title = "Load Config", 
                    Content = "Failed to load config: "..configName,
                    Icon = "x",
                    Duration = 5
                })
            end
        end
    })
    local autoloadconfig
    autoloadconfig = TabHandles.Config:Toggle({
        Title = "Auto Load Config",
        Desc = "Automatically load the last used config on execute.",
        Callback = function(state)
            ALC = state
            writefile(autoLoadFile, tostring(state))
        end
    })

    if isfile(autoLoadFile) and readfile(autoLoadFile) == "true" then
        local success, err = pcall(function()
            if not configFile then
                configFile = ConfigManager:CreateConfig(configName)
            end

            local loadedData = configFile:Load()
            if loadedData then
                autoloadconfig:Set(true)
                WindUI:Notify({
                    Title = "Auto Load Config",
                    Content = "Automatically loaded config: " .. configName,
                    Icon = "refresh-ccw",
                    Duration = 2
                })
            end
        end)
    end
end

task.spawn(function()
    while task.wait(0.02) do
        if antiFlingToggle then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= lp and plr.Character then
                    for _, part in ipairs(plr.Character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end
        end
    end
end)

-- // Lógica copiada exactamente de FlingGui.lua[span_1](start_span)[span_1](end_span)
local AntiFlingEnabled = false

local function setCanCollideOfModelDescendants(model, bval)
    if not model then return end
    for i, v in pairs(model:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = bval
        end
    end
end

-- // Conexión de Anti Fling[span_2](start_span)[span_2](end_span)
RunService.Stepped:Connect(function()
    if AntiFlingEnabled then
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= Players.LocalPlayer and v.Character then
                setCanCollideOfModelDescendants(v.Character, false)
            end
        end
    end
end)

-- // Botón en tu pestaña de ESP
TabHandles.Esp:Toggle({
    Title = "Anti Fling (Original Logic)",
    Value = false,
    Callback = function(state)
        AntiFlingEnabled = state
        
        -- Si se apaga, restaura colisiones[span_3](start_span)[span_3](end_span)
        if not AntiFlingEnabled then
            for i, v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer and v.Character then
                    setCanCollideOfModelDescendants(v.Character, true)
                end
            end
        end
    end
})
