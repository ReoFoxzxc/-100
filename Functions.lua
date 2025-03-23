-- Functions.lua
local Functions = {}

function Functions.Init(VisualsContent, CombatContent, MiscContent)
    -- Visuals: ESP (чекбокс)
    local ESPLabel = Instance.new("TextLabel")
    ESPLabel.Size = UDim2.new(0, 100, 0, 20)
    ESPLabel.Position = UDim2.new(0, 10, 0, 10)
    ESPLabel.BackgroundTransparency = 1
    ESPLabel.Text = "ESP"
    ESPLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ESPLabel.TextSize = 14
    ESPLabel.Parent = VisualsContent

    local ESPToggle = Instance.new("TextButton")
    ESPToggle.Size = UDim2.new(0, 20, 0, 20)
    ESPToggle.Position = UDim2.new(0, 120, 0, 10)
    ESPToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ESPToggle.Text = ""
    ESPToggle.Parent = VisualsContent

    local ESPCorner = Instance.new("UICorner")
    ESPCorner.CornerRadius = UDim.new(0, 5)
    ESPCorner.Parent = ESPToggle

    local espEnabled = false
    local highlights = {}

    local function updateESP()
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local character = player.Character
                if character then
                    if highlights[player] then
                        highlights[player]:Destroy()
                        highlights[player] = nil
                    end
                    if espEnabled then
                        local highlight = Instance.new("Highlight")
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = character
                        highlights[player] = highlight
                    end
                end
            end
        end
    end

    ESPToggle.MouseButton1Click:Connect(function()
        espEnabled = not espEnabled
        ESPToggle.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        updateESP()
    end)

    game.Players.PlayerAdded:Connect(function(player)
        if player ~= game.Players.LocalPlayer then
            player.CharacterAdded:Connect(function(character)
                if espEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = character
                    highlights[player] = highlight
                end
            end)
        end
    end)

    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            player.CharacterAdded:Connect(function(character)
                if espEnabled then
                    local highlight = Instance.new("Highlight")
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = character
                    highlights[player] = highlight
                end
            end)
        end
    end)

    game.Players.PlayerRemoving:Connect(function(player)
        if highlights[player] then
            highlights[player]:Destroy()
            highlights[player] = nil
        end
    end)
end

return Functions
