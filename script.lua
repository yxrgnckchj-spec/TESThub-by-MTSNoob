local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "My Testhub byMTSnoob",
    LoadingTitle = "Loading",
    LoadingSubtitle = "by Sirius",
    Theme = "Default",
    ToggleUIKeybind = "K"
})

local Tab = Window:CreateTab("メイン", 4483362458)

-- すり抜け (Noclip)
local noclipEnabled = false
local RunService = game:GetService("RunService")
local noclipConn

Tab:CreateToggle({
    Name = "すり抜け",
    CurrentValue = false,
    Callback = function(Value)
        noclipEnabled = Value
        if Value then
            noclipConn = RunService.Stepped:Connect(function()
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, part in pairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- Fly (シンプル版)
local flyEnabled = false
local flySpeed = 50
local bv

Tab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Callback = function(Value)
        flyEnabled = Value
        local char = game.Players.LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local root = char.HumanoidRootPart

        if Value then
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = root
            spawn(function()
                while flyEnabled and root and root.Parent do
                    local cam = workspace.CurrentCamera
                    local moveDir = cam.CFrame.LookVector * flySpeed
                    bv.Velocity = Vector3.new(moveDir.X, 0, moveDir.Z) + Vector3.new(0, flySpeed/2, 0)
                    game:GetService("RunService").Heartbeat:Wait()
                end
                if bv then bv:Destroy() end
            end)
        else
            if bv then bv:Destroy() end
        end
    end
})

-- Fly速度スライダー
Tab:CreateSlider({
    Name = "Fly速度",
    Range = {10, 200},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        flySpeed = Value
    end
})

-- スピード (WalkSpeed) 追加
local normalSpeed = 16  -- デフォルトの歩行速度
local speedEnabled = false
local currentSpeed = 16

Tab:CreateToggle({
    Name = "スピードハック",
    CurrentValue = false,
    Callback = function(Value)
        speedEnabled = Value
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            if Value then
                humanoid.WalkSpeed = currentSpeed
            else
                humanoid.WalkSpeed = normalSpeed
            end
        end
    end
})

-- スピード値スライダー
Tab:CreateSlider({
    Name = "スピード値",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(Value)
        currentSpeed = Value
        if speedEnabled then
            local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = currentSpeed
            end
        end
    end
})
