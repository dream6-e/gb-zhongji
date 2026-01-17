-- Rayfield UI 界面
local Rayfield = nil
local rayfieldLinks = {
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua",
    "https://sirius.menu/rayfield",
    "https://raw.githubusercontent.com/Syntaxx64/Rayfield/main/Rayfield.lua"
}

-- 尝试加载 Rayfield
for _, link in pairs(rayfieldLinks) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(link))()
    end)
    if success and result then
        Rayfield = result
        break
    end
end

if not Rayfield then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "错误",
        Text = "无法加载 Rayfield UI",
        Duration = 5
    })
    return
end

-- 创建窗口
local Window = Rayfield:CreateWindow({
    Name = "攻击脚本控制器",
    LoadingTitle = "正在加载...",
    LoadingSubtitle = "请稍候",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "AttackScripts",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = true
    },
    KeySystem = false,
})

-- 创建主标签页
local MainTab = Window:CreateTab("脚本控制", 4483362458)

-- 全局开关变量
local scriptStates = {
    rifleScript = false,
    sabreScript = false,
    shovelScript = false,
    ammoScript = false
}

-- 步枪脚本开关
MainTab:CreateSection("步枪自动攻击脚本")
local rifleToggle = MainTab:CreateToggle({
    Name = "步枪自动攻击 (攻击玩家)",
    CurrentValue = scriptStates.rifleScript,
    Callback = function(Value)
        scriptStates.rifleScript = Value
        if Value then
            loadstring([[

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local Settings = {
    Range = 15,
    AttackSpeed = 0.15,
    Enabled = true,
    AutoRotate = true
}

local function getClosestTarget()
    local target = nil
    local minDist = Settings.Range
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

local rifleLoop
rifleLoop = task.spawn(function()
    while task.wait(Settings.AttackSpeed) do
        if Settings.Enabled then
            local char = LocalPlayer.Character
            local rifle = char and char:FindFirstChild("Rifle")
            local swingRemote = rifle and rifle:FindFirstChild("Swing")
            
            if swingRemote then
                local targetPart = getClosestTarget()
                if targetPart then
                    if Settings.AutoRotate then
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

-- 保存引用以便关闭
_G.rifleScriptLoop = rifleLoop

]])()
        else
            -- 停止脚本
            if _G.rifleScriptLoop then
                task.cancel(_G.rifleScriptLoop)
                _G.rifleScriptLoop = nil
            end
        end
    end
})

-- 军刀脚本开关
MainTab:CreateSection("军刀自动攻击脚本")
local sabreToggle = MainTab:CreateToggle({
    Name = "军刀自动攻击 (攻击僵尸)",
    CurrentValue = scriptStates.sabreScript,
    Callback = function(Value)
        scriptStates.sabreScript = Value
        if Value then
            loadstring([[

local ATTACK_RANGE = 20
local ATTACK_SPEED = 0.1
local ATTACK_ARG = 2

local player = game.Players.LocalPlayer
local aliveZombies = game.Workspace:WaitForChild("AliveZombies")

local function getClosestZombie()
    local closestZombie = nil
    local shortestDistance = ATTACK_RANGE

    for _, zombie in pairs(aliveZombies:GetChildren()) do
        local root = zombie:FindFirstChild("HumanoidRootPart")
        local hum = zombie:FindFirstChild("Humanoid")
        
        if root and hum and hum.Health > 0 then
            local distance = (player.Character.HumanoidRootPart.Position - root.Position).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                closestZombie = zombie
            end
        end
    end
    return closestZombie
end

local sabreLoop
sabreLoop = task.spawn(function()
    while task.wait(ATTACK_SPEED) do
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        
        if hrp then
            local target = getClosestZombie()
            if target and target:FindFirstChild("HumanoidRootPart") then
                local targetPos = target.HumanoidRootPart.Position
                hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(targetPos.X, hrp.Position.Y, targetPos.Z))
                
                local weapon = char:FindFirstChild("Sabre")
                if weapon and weapon:FindFirstChild("Swing") then
                    weapon.Swing:FireServer(ATTACK_ARG)
                end
            end
        end
    end
end)

-- 保存引用以便关闭
_G.sabreScriptLoop = sabreLoop

]])()
        else
            -- 停止脚本
            if _G.sabreScriptLoop then
                task.cancel(_G.sabreScriptLoop)
                _G.sabreScriptLoop = nil
            end
        end
    end
})

-- 铲子脚本开关
MainTab:CreateSection("铲子自动攻击脚本")
local shovelToggle = MainTab:CreateToggle({
    Name = "铲子自动攻击 (攻击僵尸)",
    CurrentValue = scriptStates.shovelScript,
    Callback = function(Value)
        scriptStates.shovelScript = Value
        if Value then
            loadstring([[

local RANGE = 15 
local ATTACK_SPEED = 0.1 

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local zombieFolder = game.Workspace:WaitForChild("AliveZombies")

local function getClosestZombie()
    local closest = nil
    local dist = RANGE

    for _, v in pairs(zombieFolder:GetChildren()) do
        local hum = v:FindFirstChild("Humanoid")
        local vRoot = v:FindFirstChild("HumanoidRootPart")
        
        if hum and vRoot and hum.Health > 0 then
            local magnitude = (rootPart.Position - vRoot.Position).Magnitude
            if magnitude < dist then
                dist = magnitude
                closest = v
            end
        end
    end
    return closest
end

local shovelLoop
shovelLoop = task.spawn(function()
    while task.wait(ATTACK_SPEED) do
        local shovel = character:FindFirstChild("Shovel")
        
        if shovel and shovel:FindFirstChild("Swing") then
            local target = getClosestZombie()
            
            if target then
                shovel.Swing:FireServer(1)
                
                local targetPos = target.HumanoidRootPart.Position
                rootPart.CFrame = CFrame.new(rootPart.Position, Vector3.new(targetPos.X, rootPart.Position.Y, targetPos.Z))
            end
        end
    end
end)

-- 保存引用以便关闭
_G.shovelScriptLoop = shovelLoop

]])()
        else
            -- 停止脚本
            if _G.shovelScriptLoop then
                task.cancel(_G.shovelScriptLoop)
                _G.shovelScriptLoop = nil
            end
        end
    end
})

-- 无限弹药脚本开关
MainTab:CreateSection("无限弹药脚本")
local ammoToggle = MainTab:CreateToggle({
    Name = "无限弹药 (霰弹枪/手枪)",
    CurrentValue = scriptStates.ammoScript,
    Callback = function(Value)
        scriptStates.ammoScript = Value
        if Value then
            loadstring([[

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

_G.InfiniteAmmo = true

local function startInfiniteAmmo()
    RunService.RenderStepped:Connect(function()
        if _G.InfiniteAmmo then
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
    end)
end

-- 启动脚本
startInfiniteAmmo()

]])()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "无限弹药启用",
      Text = "目前只支持断线器的初始枪和军官的初始枪",
                Duration = 3
            })
        else
            -- 关闭无限弹药
            _G.InfiniteAmmo = false
        end
    end
})

-- 添加说明标签页
local InfoTab = Window:CreateTab("说明", 4483362458)
InfoTab:CreateSection("脚本说明")
InfoTab:CreateParagraph({
    Title = "功能说明",
    Content = "每个开关对应一个独立的攻击脚本，可以单独启用/禁用：\n\n1. 步枪自动攻击 - 自动攻击其他玩家\n2. 军刀自动攻击 - 自动攻击僵尸\n3. 铲子自动攻击 - 自动攻击僵尸\n4. 无限弹药 - 自动瞄准射击"
})

InfoTab:CreateSection("使用提示")
InfoTab:CreateLabel("• 确保角色装备对应的武器才能生效")
InfoTab:CreateLabel("• 可以同时启用多个脚本")
InfoTab:CreateLabel("• 关闭开关会停止对应的脚本")

-- 添加关闭窗口按钮
MainTab:CreateSection("界面控制")
MainTab:CreateButton({
    Name = "关闭界面",
    Callback = function()
        Rayfield:Destroy()
    end
})
