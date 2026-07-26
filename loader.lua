-- ============================================================
--  Plalette Scripts · Knife Duels · Silent Aim PRO
--  Silent Aim nur beim Wurf aktiv – kein FPS-Verlust
--  Inkl. Passwort-UI, Config, FPS Boost, ESP
-- ============================================================

local PassScreen = Instance.new("ScreenGui")
PassScreen.Parent = game:GetService("CoreGui")

local PassFrame = Instance.new("Frame")
PassFrame.Size = UDim2.new(0, 280, 0, 170)
PassFrame.Position = UDim2.new(0.5, -140, 0.5, -85)
PassFrame.BackgroundColor3 = Color3.fromRGB(14, 12, 24)
PassFrame.BorderSizePixel = 0
PassFrame.Active = true
PassFrame.Draggable = true
PassFrame.Parent = PassScreen
Instance.new("UICorner", PassFrame).CornerRadius = UDim.new(0, 10)

local PGL = Instance.new("Frame")
PGL.Size = UDim2.new(1, 2, 1, 2)
PGL.Position = UDim2.new(0, -1, 0, -1)
PGL.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
PGL.BackgroundTransparency = 0.5
PGL.BorderSizePixel = 0
PGL.Parent = PassFrame
Instance.new("UICorner", PGL).CornerRadius = UDim.new(0, 10)

local PT = Instance.new("TextLabel")
PT.Size = UDim2.new(1, 0, 0, 26)
PT.Position = UDim2.new(0, 0, 0, 18)
PT.BackgroundTransparency = 1
PT.TextColor3 = Color3.fromRGB(255, 255, 255)
PT.Text = "Knife Duels PRO"
PT.Font = Enum.Font.SourceSansBold
PT.TextSize = 20
PT.Parent = PassFrame

local PS = Instance.new("TextLabel")
PS.Size = UDim2.new(1, 0, 0, 16)
PS.Position = UDim2.new(0, 0, 0, 46)
PS.BackgroundTransparency = 1
PS.TextColor3 = Color3.fromRGB(180, 140, 200)
PS.Text = "Plalette Scripts"
PS.Font = Enum.Font.SourceSans
PS.TextSize = 13
PS.Parent = PassFrame

local PI = Instance.new("TextBox")
PI.Size = UDim2.new(1, -40, 0, 28)
PI.Position = UDim2.new(0, 20, 0, 70)
PI.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
PI.TextColor3 = Color3.fromRGB(255, 255, 255)
PI.PlaceholderText = "Passwort..."
PI.Text = ""
PI.Font = Enum.Font.SourceSans
PI.TextSize = 14
PI.Parent = PassFrame
Instance.new("UICorner", PI).CornerRadius = UDim.new(0, 8)

local PB = Instance.new("TextButton")
PB.Size = UDim2.new(1, -40, 0, 26)
PB.Position = UDim2.new(0, 20, 0, 105)
PB.BackgroundColor3 = Color3.fromRGB(140, 80, 255)
PB.TextColor3 = Color3.fromRGB(255, 255, 255)
PB.Text = "Freischalten"
PB.Font = Enum.Font.SourceSansBold
PB.TextSize = 14
PB.Parent = PassFrame
Instance.new("UICorner", PB).CornerRadius = UDim.new(0, 8)

local DiscFrame = Instance.new("Frame")
DiscFrame.Size = UDim2.new(1, -40, 0, 20)
DiscFrame.Position = UDim2.new(0, 20, 0, 138)
DiscFrame.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscFrame.BackgroundTransparency = 0.1
DiscFrame.Parent = PassFrame
Instance.new("UICorner", DiscFrame).CornerRadius = UDim.new(0, 5)

local DiscLabel = Instance.new("TextLabel")
DiscLabel.Size = UDim2.new(0.7, 0, 1, 0)
DiscLabel.Position = UDim2.new(0, 6, 0, 0)
DiscLabel.BackgroundTransparency = 1
DiscLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscLabel.Text = "Get Password"
DiscLabel.Font = Enum.Font.SourceSans
DiscLabel.TextSize = 10
DiscLabel.TextXAlignment = Enum.TextXAlignment.Left
DiscLabel.Parent = DiscFrame

local CopyBtn = Instance.new("TextButton")
CopyBtn.Size = UDim2.new(0.25, 0, 0, 16)
CopyBtn.Position = UDim2.new(0.72, 0, 0, 2)
CopyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.BackgroundTransparency = 0.2
CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyBtn.Text = "Copy"
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.TextSize = 9
CopyBtn.Parent = DiscFrame
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 3)

CopyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/duhxrB85tW")
    CopyBtn.Text = "OK"
    task.wait(2)
    CopyBtn.Text = "Copy"
end)

local function Try()
    if PI.Text == "plalettescripts3754356" then
        PassScreen:Destroy()
        LoadRayfield()
    else
        PI.Text = ""
        PI.PlaceholderText = "Falsch!"
        task.wait(0.8)
        PI.PlaceholderText = "Passwort..."
    end
end
PB.MouseButton1Click:Connect(Try)
PI.FocusLost:Connect(function(ep) if ep then Try() end end)

function LoadRayfield()
    local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    -- ========== FEATURES ==========
    local SilentAimEnabled = false
    local FOVRadius = 120
    local HitPart = "Head"
    local ESPOn = false
    local FPSBoostOn = false
    local FullbrightOn = false

    local FOVCircle = Drawing.new("Circle")
    FOVCircle.Filled = false
    FOVCircle.Visible = false
    local ESPDrawings = {}

    -- ========== GET NEAREST PLAYER IN FOV ==========
    local function GetNearestPlayer()
        local nearest = nil
        local shortestDist = FOVRadius
        local centerX = Camera.ViewportSize.X / 2
        local centerY = Camera.ViewportSize.Y / 2

        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetPart = player.Character:FindFirstChild(HitPart) or player.Character:FindFirstChild("HumanoidRootPart")
                if targetPart then
                    local pos, onScreen = Camera:WorldToViewportPoint(targetPart.Position)
                    if onScreen then
                        local dx = pos.X - centerX
                        local dy = pos.Y - centerY
                        local dist = math.sqrt(dx*dx + dy*dy)
                        if dist < shortestDist then
                            shortestDist = dist
                            nearest = player
                        end
                    end
                end
            end
        end
        return nearest
    end

    -- ========== SILENT AIM ==========
    local function OnThrow()
        if not SilentAimEnabled then return end
        local target = GetNearestPlayer()
        if not target or not target.Character then return end
        local targetPart = target.Character:FindFirstChild(HitPart) or target.Character:FindFirstChild("HumanoidRootPart")
        if not targetPart then return end
        Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            task.wait(0.05)
            OnThrow()
        end
        if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.R then
            task.wait(0.05)
            OnThrow()
        end
    end)

    -- ========== FOV CIRCLE ==========
    task.spawn(function()
        while task.wait(0.1) do
            if SilentAimEnabled then
                FOVCircle.Visible = true
                FOVCircle.Radius = FOVRadius
                FOVCircle.Thickness = 1.5
                FOVCircle.Color = Color3.fromRGB(140, 80, 255)
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
            else
                FOVCircle.Visible = false
            end
        end
    end)

    -- ========== ESP ==========
    local function ClearESP()
        for _, d in pairs(ESPDrawings) do pcall(function() d:Remove() end) end
        ESPDrawings = {}
    end

    task.spawn(function()
        while task.wait(0.06) do
            ClearESP()
            if ESPOn then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local head = player.Character:FindFirstChild("Head")
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if head and hrp then
                            local pos, on = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            if on then
                                local fp = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                                local height = math.abs(pos.Y - fp.Y)
                                local width = height / 2
                                local box = Drawing.new("Square")
                                box.Color = Color3.fromRGB(140, 80, 255)
                                box.Thickness = 1
                                box.Size = Vector2.new(width, height)
                                box.Position = Vector2.new(pos.X - width/2, pos.Y)
                                box.Filled = false
                                box.Visible = true
                                table.insert(ESPDrawings, box)
                                local name = Drawing.new("Text")
                                name.Text = player.Name
                                name.Color = Color3.fromRGB(255, 255, 255)
                                name.Size = 11
                                name.Position = Vector2.new(pos.X, pos.Y - 14)
                                name.Center = true
                                name.Visible = true
                                table.insert(ESPDrawings, name)
                            end
                        end
                    end
                end
            end
        end
    end)

    -- ========== FPS BOOST ==========
    task.spawn(function()
        while task.wait(1) do
            if FPSBoostOn then
                Lighting.GlobalShadows = false
                Lighting.FogEnd = 0
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v:IsA("ParticleEmitter") then v.Enabled = false end
                end
            else
                Lighting.GlobalShadows = true
                Lighting.FogEnd = 10000
            end
        end
    end)

    -- ========== FULLBRIGHT ==========
    task.spawn(function()
        while task.wait(1) do
            if FullbrightOn then
                Lighting.Brightness = 2
            else
                Lighting.Brightness = 1
            end
        end
    end)

    -- ========== ANTI-AFK ==========
    task.spawn(function()
        while task.wait(60) do
            pcall(function()
                local VIM = game:GetService("VirtualInputManager")
                VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, nil)
                task.wait(0.1)
                VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, nil)
            end)
        end
    end)

    -- ========== UI ==========
    local Window = Rayfield:CreateWindow({
        name = "Knife Duels PRO",
        subtitle = "Plalette Scripts | Silent Aim",
    })

    local CombatTab = Window:CreateTab({ name = "Combat", icon = "crosshair" })
    local VisualTab = Window:CreateTab({ name = "Visuals", icon = "eye" })
    local UtilityTab = Window:CreateTab({ name = "Utility", icon = "gear" })

    CombatTab:CreateSection("Silent Aim")
    CombatTab:CreateToggle({ name = "Silent Aim (100% Treffer)", currentValue = false, callback = function(v) SilentAimEnabled = v end })
    CombatTab:CreateSlider({ name = "FOV Radius", range = {30, 300}, increment = 5, currentValue = 120, callback = function(v) FOVRadius = v end })
    CombatTab:CreateDropdown({ name = "Ziel-Hitbox", options = {"Head", "HumanoidRootPart", "Torso"}, currentOption = "Head", callback = function(v) HitPart = v end })

    VisualTab:CreateSection("FOV")
    VisualTab:CreateToggle({ name = "FOV Circle anzeigen", currentValue = false, callback = function(v) end })
    VisualTab:CreateSection("ESP")
    VisualTab:CreateToggle({ name = "ESP (Box + Name)", currentValue = false, callback = function(v) ESPOn = v end })

    UtilityTab:CreateSection("Performance")
    UtilityTab:CreateToggle({ name = "FPS Boost", currentValue = false, callback = function(v) FPSBoostOn = v end })
    UtilityTab:CreateToggle({ name = "Fullbright", currentValue = false, callback = function(v) FullbrightOn = v end })
    UtilityTab:CreateLabel({ name = "💡 Silent Aim nur beim Wurf aktiv – kein Lag" })

    Window:Notify({ title = "Plalette Scripts", content = "Knife Duels PRO geladen!" })
end
