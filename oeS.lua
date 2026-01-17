-- Rayfield UI 缝合脚本
local Rayfield = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Window = Rayfield:CreateWindow({
    Name = "多功能自动化攻击",
    LoadingTitle = "脚本加载中...",
    LoadingSubtitle = "by 脚本作者",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "MultiAttackScript",
        FileName = "Config"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink",
        RememberJoins = true
    },
    KeySystem = false,
})

-- 获取服务
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- 全局变量
local EnabledScripts = {
    RifleAutoAttack = false,
    SabreAutoAttack = false,
    ShovelAutoAttack = false,
    InfiniteAmmo = false
}

local Settings = {
    Rifle = {
        Range = 15,
        AttackSpeed = 0.15,
        AutoRotate = true
    },
    Sabre = {
        Range = 20,
        AttackSpeed = 0.1,
        AttackArg = 2
    },
    Shovel = {
        Range = 15,
        AttackSpeed = 0.1
    }
}

-- 通知函数
local function Notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 3
    })
end

-- 创建主标签页
local MainTab = Window:CreateTab("主控制", 4483362458)

-- 步枪自动攻击（玩家目标）
local RifleSection = MainTab:CreateSection("步枪自动攻击 - 攻击其他玩家")
RifleSection:CreateToggle({
    Name = "启用步枪自动攻击",
    CurrentValue = false,
    Flag = "RifleToggle",
    Callback = function(Value)
        EnabledScripts.RifleAutoAttack = Value
        Notify("步枪攻击", Value and "已启用" or "已禁用")
    end,
})

RifleSection:CreateSlider({
    Name = "步枪攻击范围",
    Range = {5, 50},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = Settings.Rifle.Range,
    Flag = "RifleRange",
    Callback = function(Value)
        Settings.Rifle.Range = Value
    end,
})

RifleSection:CreateSlider({
    Name = "步枪攻击速度",
    Range = {0.05, 1},
    Increment = 0.05,
    Suffix = "秒",
    CurrentValue = Settings.Rifle.AttackSpeed,
    Flag = "RifleSpeed",
    Callback = function(Value)
        Settings.Rifle.AttackSpeed = Value
    end,
})

RifleSection:CreateToggle({
    Name = "自动转向目标",
    CurrentValue = Settings.Rifle.AutoRotate,
    Flag = "RifleRotate",
    Callback = function(Value)
        Settings.Rifle.AutoRotate = Value
    end,
})

-- 军刀自动攻击（僵尸目标）
local SabreSection = MainTab:CreateSection("军刀自动攻击 - 攻击僵尸")
SabreSection:CreateToggle({
    Name = "启用军刀自动攻击",
    CurrentValue = false,
    Flag = "SabreToggle",
    Callback = function(Value)
        EnabledScripts.SabreAutoAttack = Value
        Notify("军刀攻击", Value and "已启用" or "已禁用")
    end,
})

SabreSection:CreateSlider({
    Name = "军刀攻击范围",
    Range = {5, 50},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = Settings.Sabre.Range,
    Flag = "SabreRange",
    Callback = function(Value)
        Settings.Sabre.Range = Value
    end,
})

SabreSection:CreateSlider({
    Name = "军刀攻击速度",
    Range = {0.05, 1},
    Increment = 0.05,
    Suffix = "秒",
    CurrentValue = Settings.Sabre.AttackSpeed,
    Flag = "SabreSpeed",
    Callback = function(Value)
        Settings.Sabre.AttackSpeed = Value
    end,
})

SabreSection:CreateSlider({
    Name = "军刀攻击参数",
    Range = {1, 5},
    Increment = 1,
    CurrentValue = Settings.Sabre.AttackArg,
    Flag = "SabreArg",
    Callback = function(Value)
        Settings.Sabre.AttackArg = Value
    end,
})

-- 铲子自动攻击（僵尸目标）
local ShovelSection = MainTab:CreateSection("铲子自动攻击 - 攻击僵尸")
ShovelSection:CreateToggle({
    Name = "启用铲子自动攻击",
    CurrentValue = false,
    Flag = "ShovelToggle",
    Callback = function(Value)
        EnabledScripts.ShovelAutoAttack = Value
        Notify("铲子攻击", Value and "已启用" or "已禁用")
    end,
})

ShovelSection:CreateSlider({
    Name = "铲子攻击范围",
    Range = {5, 50},
    Increment = 1,
    Suffix = "studs",
    CurrentValue = Settings.Shovel.Range,
    Flag = "ShovelRange",
    Callback = function(Value)
        Settings.Shovel.Range = Value
    end,
})

ShovelSection:CreateSlider({
    Name = "铲子攻击速度",
    Range = {0.05, 1},
    Increment = 0.05,
    Suffix = "秒",
    CurrentValue = Settings.Shovel.AttackSpeed,
    Flag = "ShovelSpeed",
    Callback = function(Value)
        Settings.Shovel.AttackSpeed = Value
    end,
})

-- 无限弹药功能
local AmmoSection = MainTab:CreateSection("无限弹药 - 支持霰弹枪和手枪")
AmmoSection:CreateToggle({
    Name = "启用无限弹药",
    CurrentValue = false,
    Flag = "InfiniteAmmoToggle",
    Callback = function(Value)
        EnabledScripts.InfiniteAmmo = Value
        Notify("无限弹药", Value and "已启用" or "已禁用")
    end,
})

AmmoSection:CreateLabel("说明：支持断线器的初始枪和军官的初始枪")

-- 创建第二个标签页用于信息显示
local InfoTab = Window:CreateTab("信息", 4483362458)

InfoTab:CreateSection("脚本说明")
InfoTab:CreateParagraph({
    Title = "功能说明",
    Content = "本脚本集成了多种自动化攻击功能：\n1. 步枪自动攻击 - 自动攻击其他玩家\n2. 军刀自动攻击 - 自动攻击僵尸\n3. 铲子自动攻击 - 自动攻击僵尸\n4. 无限弹药 - 自动瞄准射击"
})

InfoTab:CreateSection("使用提示")
InfoTab:CreateLabel("每个功能都有独立的开关，可以同时启用多个")
InfoTab:CreateLabel("攻击范围、速度等参数可以根据需要调整")
InfoTab:CreateLabel("确保角色装备对应的武器才能生效")

-- 功能函数
local function getClosestPlayer()
    local target = nil
    local minDist = Settings.Rifle.Range
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local tChar = player.Character
            local hum = tChar:FindFirstChild("Humanoid")
            local root = tChar:FindFirstChild("HumanoidRootPart")

            if hum and hum.Health > 0 and root then
                local dist = (root.Position - char.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = root
                end
            end
        end
    end
    return target
end

local function getClosestZombie(range)
    local zombieFolder = workspace:FindFirstChild("AliveZombies")
    if not zombieFolder then return nil end
    
    local closest = nil
    local shortestDistance = range or 20
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    for _, zombie in pairs(zombieFolder:GetChildren()) do
        local root = zombie:FindFirstChild("HumanoidRootPart")
        local hum = zombie:FindFirstChild("Humanoid")
        
        if root and hum and hum.Health > 0 then
            local distance = (char.HumanoidRootPart.Position - root.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closest = zombie
            end
        end
    end
    return closest
end

-- 步枪自动攻击循环
task.spawn(function()
    while true do
        task.wait(Settings.Rifle.AttackSpeed)
        
        if EnabledScripts.RifleAutoAttack then
            local char = LocalPlayer.Character
            local rifle = char and char:FindFirstChild("Rifle")
            local swingRemote = rifle and rifle:FindFirstChild("Swing")
            
            if swingRemote then
                local targetPart = getClosestPlayer()
                if targetPart then
                    if Settings.Rifle.AutoRotate then
                        local myRoot = char:FindFirstChild("HumanoidRootPart")
                        if myRoot then
                            local targetPos = Vector3.new(targetPart.Position.X, myRoot.Position.Y, targetPart.Position.Z)
                            myRoot.CFrame = CFrame.new(myRoot.Position, targetPos)
                        end
                    end
                    swingRemote:FireServer(1)
                end
            end
        end
    end
end)

-- 军刀自动攻击循环
task.spawn(function()
    while true do
        task.wait(Settings.Sabre.AttackSpeed)
        
        if EnabledScripts.SabreAutoAttack then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                local target = getClosestZombie(Settings.Sabre.Range)
                if target and target:FindFirstChild("HumanoidRootPart") then
                    local targetPos = target.HumanoidRootPart.Position
                    hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z))
                    
                    local weapon = char:FindFirstChild("Sabre")
                    if weapon and weapon:FindFirstChild("Swing") then
                        weapon.Swing:FireServer(Settings.Sabre.AttackArg)
                    end
                end
            end
        end
    end
end)

-- 铲子自动攻击循环
task.spawn(function()
    while true do
        task.wait(Settings.Shovel.AttackSpeed)
        
        if EnabledScripts.ShovelAutoAttack then
            local char = LocalPlayer.Character
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                local shovel = char:FindFirstChild("Shovel")
                
                if shovel and shovel:FindFirstChild("Swing") then
                    local target = getClosestZombie(Settings.Shovel.Range)
                    
                    if target then
                        shovel.Swing:FireServer(1)
                        
                        local targetPos = target.HumanoidRootPart.Position
                        rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z))
                    end
                end
            end
        end
    end
end)

-- 无限弹药循环
task.spawn(function()
    while true do
        task.wait()
        
        local Character = LocalPlayer.Character
            if Character then
                local Weapon = Character:FindFirstChild("Shotgun") or Character:FindFirstChild("Pistol")
                
                if Weapon and Weapon:FindFirstChild("Firing") then
                    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or #UserInputService:GetTouchIndices() > 0 then
                        
                        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        local unitRay = Camera:ViewportPointToRay(screenCenter.X, screenCenter.Y)
                        
                        local raycastResult = workspace:Raycast(unitRay.Origin, unitRay.Direction * 1000)
                        local targetPos = raycastResult and raycastResult.Position or (unitRay.Origin + unitRay.Direction * 1000)

                        local remote = Weapon.Firing
                        local args = {
                            [1] = "real",
                            [2] = targetPos
                        }
                        remote:FireServer(unpack(args))
                    end
                end
            end
        end
    end
end)
