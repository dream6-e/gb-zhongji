-- 实时英文翻译
print("=== 实时英文翻译 ===")

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "🔄 实时翻译",
    Author = "文本翻译",
    Folder = "textreplace"
})

-- 创建翻译词典（基于你提供的文本）
local translationDict = {
    -- 单字母/缩写
    ["OK"] = "确定",
    ["ON"] = "开启",
    ["NO"] = "否",
    ["VS"] = "对战",
    ["OK"] = "确定",
    ["Tab"] = "标签页",
    ["CMD"] = "命令",
    ["Any"] = "任意",
    ["LOW"] = "低",
    ["AXE"] = "斧头",
    ["Dig"] = "挖掘",
    ["Axe"] = "斧头",
    ["YES"] = "是",
    ["MOVE"] = "移动",
    ["Fife"] = "短笛",
    ["NONE"] = "无",
    ["Gore"] = "血块",
    ["Edit"] = "编辑",
    ["DRUM"] = "鼓",
    ["Menu"] = "菜单",
    ["FIFE"] = "短笛",
    ["Void"] = "虚空",
    ["TYPE"] = "类型",
    ["VOTE"] = "投票",
    ["EXIT"] = "退出",
    ["Misc"] = "杂项",
    ["Boss"] = "首领",
    ["SHOP"] = "商店",
    ["NAVY"] = "海军",
    ["STOP"] = "停止",
    ["HIGH"] = "高",
    ["HELP"] = "帮助",
    ["Left"] = "左",
    ["Jump"] = "跳跃",
    ["Bald"] = "秃头",
    ["Map:"] = "地图:",
    ["HAIR"] = "头发",
    ["Right"] = "右",
    ["Space"] = "空格",
    ["Sabre"] = "军刀",
    ["RIFLE"] = "步枪",
    ["SABRE"] = "军刀",
    ["Siege"] = "围攻",
    ["BEARD"] = "胡须",
    ["Tags:"] = "标签:",
    ["WOMAN"] = "女性",
    ["Stake"] = "木桩",
    ["Piper"] = "吹笛者",
    ["BUGLE"] = "号角",
    ["Type:"] = "类型:",
    ["Mode:"] = "模式:",
    ["STAKE"] = "木桩",
    ["SPADE"] = "铲子",
    ["COLOR"] = "颜色",
    ["LANCE"] = "长矛",
    ["MELEE"] = "近战",
    ["Reset"] = "重置",
    ["EQUIP"] = "装备",
    ["Other"] = "其他",
    ["KILLS"] = "击杀数",
    ["<AFK>"] = "<离开>",
    ["RESET"] = "重置",
    ["TITLE"] = "标题",
    ["CLASS"] = "职业",
    ["Class"] = "职业",
    ["Hammer"] = "锤子",
    ["ZOMBIE"] = "僵尸",
    ["Status"] = "状态",
    ["Deaths"] = "死亡数",
    ["Burger"] = "汉堡",
    ["BROWSE"] = "浏览",
    ["DEATHS"] = "死亡数",
    ["MUSKET"] = "火枪",
    ["CANNON"] = "加农炮",
    ["RETURN"] = "返回",
    ["FINISH"] = "完成",
    ["Cancel"] = "取消",
    ["HAMMER"] = "锤子",
    ["Arcade"] = "街机",
    ["LOWEST"] = "最低",
    ["Gloves"] = "手套",
    ["Stakes"] = "木桩",
    ["MEDIUM"] = "中等",
    ["Sounds"] = "音效",
    ["Musket"] = "火枪",
    ["Sapper"] = "工兵",
    ["Seaman"] = "水手",
    ["Weapon"] = "武器",
    ["DAMAGE"] = "伤害",
    ["EXTRAS"] = "额外",
    ["Action"] = "动作",
    ["RUNNER"] = "红眼",
    ["SELECT"] = "选择",
    ["CANCEL"] = "取消",
    ["Lancer"] = "枪骑兵",
    ["SUBMIT"] = "提交",
    ["ZAPPER"] = "工兵",
    ["PISTOL"] = "手枪",
    ["BOMBER"] = "自爆",
    ["RELOAD"] = "重新加载",
    ["THANKS"] = "谢谢",
    ["Pistol"] = "手枪",
    ["Holdout"] = "坚守",
    ["REMATCH"] = "重赛",
    ["Generic"] = "通用",
    ["Region:"] = "地区:",
    ["SUPPORT"] = "支持",
    ["Stubble"] = "胡茬",
    ["BLEMISH"] = "瑕疵",
    ["LOADOUT"] = "装备配置",
    ["Vanilla"] = "原版",
    ["EMPEROR"] = "皇帝",
    ["Carbine"] = "卡宾枪",
    ["CAVALRY"] = "骑兵",
    ["Surgeon"] = "外科医生",
    ["Officer"] = "军官",
    ["CLASSES"] = "职业",
    ["NATIONS"] = "国家",
    ["REFRESH"] = "刷新",
    ["HEALING"] = "治疗",
    ["In Menu"] = "在菜单中",
    ["CREDITS"] = "制作人员",
    ["Endless"] = "无尽",
    ["UTILITY"] = "实用工具",
    ["PRIMARY"] = "主要",
    ["PELLETS"] = "弹丸",
    ["VISUALS"] = "视觉",
    ["General"] = "将军",
    ["WEAPONS"] = "武器",
    ["FIREARM"] = "火器",
    ["Vote No"] = "投反对票",
    ["IGNITER"] = "点灯人",
    ["Forward"] = "前进",
    ["H23Mini"] = "H23迷你",
    ["Callout"] = "喊话",
    ["CUIRASS"] = "胸甲",
    ["WARNING"] = "警告",
    ["PICKAXE"] = "镐",
    ["CARBINE"] = "卡宾枪",
    ["TextBox"] = "文本框",
    ["RETREAT"] = "撤退",
    ["VOIVODE"] = "沃伊沃德",
    ["Caltrops"] = "铁蒺藜",
    ["Keybinds"] = "按键绑定",
    ["HARDCORE"] = "硬核",
    ["CapsLock"] = "大写锁定",
    ["GAMEPLAY"] = "游戏玩法",
    ["SURVIVED"] = "幸存",
    ["EQUIPPED"] = "已装备",
    ["Crucifix"] = "十字架",
    ["Blessing"] = "祝福",
    ["Musician"] = "音乐家",
    ["Chaplain"] = "牧师",
    ["Interact"] = "互动",
    ["Infantry"] = "步兵",
    ["SHAMBLER"] = "山伯乐",
    ["INFANTRY"] = "步兵",
    ["Hardcore"] = "硬核",
    ["Graphics"] = "图形",
    ["Movement"] = "移动",
    ["SETTINGS"] = "设置",
    ["HAND AXE"] = "手斧",
    ["GRENADES"] = "手榴弹",
    ["OVERVIEW"] = "概览",
    ["Youthful"] = "年轻",
    ["Freckles"] = "雀斑",
    ["PURCHASE"] = "购买",
    ["Username"] = "用户名",
    ["Ragdolls"] = "布娃娃",
    ["SPONTOON"] = "短矛",
    ["NOCK GUN"] = "诺克枪",
    ["Not Full"] = "未满",
    ["SEMLEEEE"] = "塞姆利",
    ["HEADSHOT"] = "爆头",
    ["BLESSING"] = "祝福",
    ["Gamemode"] = "游戏模式",
    ["TEACHING"] = "教学",
    ["Vote Yes"] = "投赞成票",
    ["CLOTHING"] = "服装",
    ["CRUCIFIX"] = "十字架",
    ["Standard"] = "标准",
    ["SUPPLIES"] = "补给",
    ["MODELING"] = "建模",
    ["Official"] = "官方",
    ["CALLOUTS"] = "喊话",
    ["Open Menu"] = "打开菜单",
    ["CORE TEAM"] = "核心团队",
    ["ANIMATORS"] = "动画师",
    ["ON"] = "开",
    ["OFF"] = "关",
    ["NEXT"] = "下一个",
    ["CLICK"] = "点击",
    ["HOVER"] = "悬停",
    ["SOUNDS"] = "音效",
    ["AMBIENCE"] = "环境音",
    ["Barricade"] = "路障",
    ["UPDATING"] = "更新中",
    ["INSTRUMENTS"] = "乐器",
    ["CALLOUT PING"] = "喊话标记",
    ["Your Building"] = "你的建筑",
    ["IN-GAME MUSIC"] = "游戏内音乐",
    ["Brace Bayonet"] = "准备刺刀",
    ["DYNAMIC SOUNDS"] = "动态音效",
    ["CALLOUT TRIGGER"] = "喊话触发器",
    ["CALLOUT CHAT TEXT"] = "喊话聊天文本",
    ["BRITISH EMPIRE"] = "大英帝国",
    ["FIRST FRENCH EMPIRE"] = "第一法兰西帝国",
    ["SELECT GRAPHICS PRESET"] = "选择图形预设",
    
    -- 游戏术语
    ["Fly"] = "飞行",
    ["ESP"] = "透视",
    ["Sky"] = "天空",
    ["Red"] = "红色",
    ["Esp"] = "透视",
    ["Dark"] = "暗色",
    ["tilt"] = "倾斜",
    ["Open"] = "打开",
    ["gear"] = "齿轮",
    ["Rose"] = "玫瑰",
    ["Main"] = "主菜单",
    ["Light"] = "浅色",
    ["Medic"] = "医疗兵",
    ["Leave"] = "离开",
    ["Plant"] = "植物",
    ["Amber"] = "琥珀",
    ["Speed"] = "速度",
    ["Label"] = "标签",
    ["Theme"] = "主题",
    ["Clear"] = "清除",
    ["Reach"] = "范围",
    ["Events"] = "事件",
    ["Others"] = "其他",
    ["Search"] = "搜索",
    ["Visual"] = "视觉",
    ["Locked"] = "已锁定",
    ["Aiming"] = "瞄准",
    ["Silent"] = "静默",
    ["Violet"] = "紫色",
    ["No Fog"] = "无雾",
    ["Accept"] = "接受",
    ["People"] = "玩家",
    ["Zapper"] = "工兵",
    ["Report"] = "报告",
    ["Themes"] = "主题",
    ["Runner"] = "红眼",
    ["Hitbox"] = "命中框",
    ["Sapper"] = "工兵",
    ["Indigo"] = "靛蓝",
    ["Bomber"] = "自爆",
    ["Resume"] = "继续",
    ["RIVALS"] = "对手",
    ["Use FOV"] = "使用视野",
    ["Players"] = "玩家",
    ["Decline"] = "拒绝",
    ["Classes"] = "职业",
    ["Defusal"] = "拆弹",
    ["Execute"] = "执行",
    ["CoreGui"] = "核心界面",
    ["Configs"] = "配置",
    ["Igniter"] = "点灯人",
    ["Crimson"] = "深红",
    ["Gun Mod"] = "枪械模组",
    ["Rainbow"] = "彩虹",
    ["Emerald"] = "翡翠",
    ["Head Hit"] = "头部命中",
    ["Profiles"] = "配置文件",
    ["Show Fov"] = "显示视野",
    ["Fov Size"] = "视野大小",
    ["Show FOV"] = "显示视野",
    ["Feedback"] = "反馈",
    ["Executor"] = "执行器",
    ["Script 1"] = "脚本1",
    ["Sant Hub"] = "圣中心",
    ["Dev Mode"] = "开发者模式",
    ["Midnight"] = "午夜",
    ["Anti Grab"] = "反抓取",
    ["Hit Range"] = "命中范围",
    ["PlayerGui"] = "玩家界面",
    ["Dashboard"] = "仪表板",
    ["Fly Speed"] = "飞行速度",
    ["Kill Aura"] = "杀戮光环",
    ["WalkSpeed"] = "行走速度",
    ["Workspace"] = "工作区",
    ["Auto Jump"] = "自动跳跃",
    ["Community"] = "社区",
    ["Auto Look"] = "自动视角",
    ["Check Key"] = "检查密钥",
    ["FPS Limit"] = "帧数限制",
    ["Silent Aim"] = "静默瞄准",
    ["StarterGui"] = "起始界面",
    ["Script Hub"] = "脚本中心",
    ["Changelogs"] = "更新日志",
    ["Prediction"] = "预测",
    ["Mobile Fov"] = "手机视野",
    ["How to use"] = "如何使用",
    ["Server Hop"] = "服务器跳转",
    ["Auto Shoot"] = "自动射击",
    ["Shove Aura"] = "推击光环",
    ["ESP Colors"] = "透视颜色",
    ["Cuirassier"] = "胸甲骑兵",
    ["Fullbright"] = "高亮",
    ["Player ESP"] = "玩家透视",
    ["Wall Check"] = "穿墙检测",
    ["Add Script"] = "添加脚本",
    ["Silver ESP"] = "银色透视",
    ["Target ESP"] = "目标透视",
    ["Maps Hacks"] = "地图作弊",
    ["Fly Bypass"] = "飞行绕过",
    ["Max Targets"] = "最大目标",
    ["Performance"] = "性能",
    ["Auto Reload"] = "自动装弹",
    ["Hit Dracula"] = "命中德古拉",
    ["Auto Repair"] = "自动修复",
    ["Dracula ESP"] = "德古拉透视",
    ["Script List"] = "脚本列表",
    ["Shove Range"] = "推击范围",
    ["Your Desire"] = "你的愿望",
    ["Reach Range"] = "范围距离",
    ["Shove Delay"] = "推击延迟",
    ["Freecam Fly"] = "自由视角飞行",
    ["Copy Invite"] = "复制邀请",
    ["Information"] = "信息",
    ["Join Discord"] = "加入Discord",
    ["Profile Name"] = "配置文件名称",
    ["Save Profile"] = "保存配置文件",
    ["Refresh List"] = "刷新列表",
    ["Save Position"] = "保存位置",
    ["Loop Teleport"] = "循环传送",
    ["Auto Grab Log"] = "自动抓取日志",
    ["Load Selected"] = "加载选中项",
    ["Instant Shoot"] = "即时射击",
    ["Fly Button UI"] = "飞行按钮界面",
    ["Gun Modifiers"] = "枪械修改器",
    ["Legit Thingys"] = "合法项目",
    ["Rejoin Server"] = "重新加入服务器",
    ["Dracula Range"] = "德古拉范围",
    ["Loop Walkspeed"] = "循环行走速度",
    ["Refresh Themes"] = "刷新主题",
    ["Saved Profiles"] = "已保存的配置文件",
    ["Range of Reach"] = "范围距离",
    ["Show Billboard"] = "显示广告牌",
    ["No Fall Damage"] = "无跌落伤害",
    ["Auto Place Log"] = "自动放置日志",
    ["Close Backpack"] = "关闭背包",
    ["Target Settings"] = "目标设置",
    ["Delete Selected"] = "删除选中项",
    ["Toggle Keybinds"] = "切换按键绑定",
    ["Keybinds and UI"] = "按键绑定和界面",
    ["Aimlock Keybind"] = "瞄准锁定按键",
    ["Kill Aura Range"] = "击杀光环范围",
    ["Show Health Bar"] = "显示生命条",
    ["Force Walkspeed"] = "强制行走速度",
    ["Apply WalkSpeed"] = "应用行走速度",
    ["Select Position"] = "选择位置",
    ["Aim Button Size"] = "瞄准按钮大小",
    ["Allow Overwrite"] = "允许覆盖",
    ["Reach Button UI"] = "范围按钮界面",
    ["Submit Feedback"] = "提交反馈",
    ["Server Utilities"] = "服务器工具",
    ["Select ESP"] = "选择透视",
    ["you"] = "你",
    ["zombie"] = "僵尸",
    ["Zombie"] = "僵尸",
    ["Size"] = "尺寸",
    ["Range"] = "距离",
    ["Auto"] = "自动",
    ["Parry"] = "格挡",
    ["When"] = "当",
    ["hit"] = "打击",
    ["reload"] = "装弹",
    ["Types"] = "种类",
    ["Save"] = "拯救",
    ["Shoot"] = "射击",
    ["bombers"] = "自爆",
    ["Near"] = "靠近",
    ["Play"] = "演奏",
    ["Drum"] = "军鼓",
    ["Bagpipe"] = "小号",
    ["Pick Up"] = "捡起",
    ["Supplies"] = "补给",
    ["Buildings"] = "建筑",
    ["Bless"] = "祝福",
    ["Buttons"] = "按钮",
    ["save"] = "保存",
    ["Auto "] = "自动",
    ["Horses"] = "马匹",
    ["Remove"] = "移除",
}

-- 替换函数
local function replaceEnglishText(text)
    if not text or type(text) ~= "string" or text == "" then
        return text
    end
    
    -- 先尝试完全匹配
    if translationDict[text] then
        return translationDict[text]
    end
    
    -- 尝试单词替换
    local result = text
    for eng, chi in pairs(translationDict) do
        -- 使用单词边界匹配，避免替换部分单词
        result = result:gsub("%f[%a]" .. eng .. "%f[%A]", chi)
    end
    
    return result
end

-- 实时替换函数
local function startRealtimeReplacement()
    print("开始实时文本替换...")
    
    local function processObject(obj)
        if not obj or not obj.Parent then return end
        
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local text = obj.Text
            if text and text ~= "" then
                local translated = replaceEnglishText(text)
                if translated ~= text then
                    -- 保存原始文本
                    if not obj:GetAttribute("OriginalText") then
                        obj:SetAttribute("OriginalText", text)
                    end
                    
                    -- 应用翻译
                    obj.Text = translated
                end
            end
        end
    end
    
    -- 递归扫描函数
    local function scanAndReplace(parent)
        for _, child in ipairs(parent:GetChildren()) do
            processObject(child)
            scanAndReplace(child)
        end
    end
    
    -- 扫描主要位置
    local locations = {}
    local player = game:GetService("Players").LocalPlayer
    if player then
        local playerGui = player:FindFirstChild("PlayerGui")
        if playerGui then
            table.insert(locations, playerGui)
        end
    end
    
    table.insert(locations, game:GetService("Workspace"))
    table.insert(locations, game:GetService("StarterGui"))
    table.insert(locations, game:GetService("CoreGui"))
    
    -- 初始扫描
    for _, location in ipairs(locations) do
        if location then
            scanAndReplace(location)
        end
    end
    
    -- 监听新对象
    local function onDescendantAdded(descendant)
        task.wait(0.1) -- 等待文本加载
        processObject(descendant)
    end
    
    -- 监听文本变化
    local function setupTextListener(obj)
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj:GetPropertyChangedSignal("Text"):Connect(function()
                task.wait(0.1)
                processObject(obj)
            end)
        end
    end
    
    -- 设置所有现有对象的监听器
    local function setupListeners(parent)
        for _, child in ipairs(parent:GetChildren()) do
            setupTextListener(child)
            setupListeners(child)
        end
    end
    
    -- 为新对象设置监听
    local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    playerGui.DescendantAdded:Connect(onDescendantAdded)
    
    -- 为现有对象设置监听
    for _, location in ipairs(locations) do
        if location then
            setupListeners(location)
        end
    end
    
    print("✅ 实时翻译替换已启动")
end

-- 恢复原始文本函数
local function restoreOriginalTexts()
    print("恢复原始文本...")
    
    local function restoreObject(obj)
        if not obj or not obj.Parent then return end
        
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            local originalText = obj:GetAttribute("OriginalText")
            if originalText then
                obj.Text = originalText
                obj:SetAttribute("OriginalText", nil)
            end
        end
    end
    
    local function scanAndRestore(parent)
        for _, child in ipairs(parent:GetChildren()) do
            restoreObject(child)
            scanAndRestore(child)
        end
    end
    
    local locations = {
        game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
        game:GetService("Workspace"),
        game:GetService("StarterGui"),
        game:GetService("CoreGui")
    }
    
    for _, location in ipairs(locations) do
        if location then
            scanAndRestore(location)
        end
    end
    
    print("✅ 原始文本已恢复")
end

-- 创建控制界面
local ControlTab = Window:Tab({
    Title = "文本翻译控制",
    Icon = "settings"
})

-- 启动替换按钮
ControlTab:Button({
    Title = "🚀 启动实时文本翻译",
    Icon = "play",
    Justify = "Center",
    Color = Color3.fromHex("#30ff6a"),
    Callback = function()
        startRealtimeReplacement()
        WindUI:Notify({
            Title = "替换启动",
            Content = "实时文本翻译已启动"
        })
    end
})

ControlTab:Space()

-- 停止替换按钮
ControlTab:Button({
    Title = "⏹️ 停止并恢复原文",
    Icon = "stop",
    Justify = "Center",
    Color = Color3.fromHex("#ff4830"),
    Callback = function()
        restoreOriginalTexts()
        WindUI:Notify({
            Title = "替换停止",
            Content = "已恢复原始文本"
        })
    end
})

ControlTab:Space()

-- 测试翻译按钮
ControlTab:Input({
    Title = "测试文本翻译",
    Placeholder = "输入英文测试翻译",
    Callback = function(text)
        if text and #text > 0 then
            local translated = replaceEnglishText(text)
            WindUI:Notify({
                Title = "翻译测试",
                Content = "原文: " .. text .. "\n译文: " .. translated
            })
        end
    end
})

-- 词典管理标签页
local DictTab = Window:Tab({
    Title = "词典管理",
    Icon = "book"
})

-- 显示词典统计
local function getDictStats()
    local count = 0
    for _ in pairs(translationDict) do
        count = count + 1
    end
    return count
end

DictTab:Section({
    Title = "词典统计: " .. getDictStats() .. " 条翻译",
    TextSize = 14
})

DictTab:Space()

-- 添加新翻译
DictTab:Input({
    Title = "添加新翻译 (英文)",
    Placeholder = "输入英文单词",
    Callback = function(english)
        if english and #english > 0 then
            -- 保存输入的英文
            _G.tempEnglish = english
            
            WindUI:Notify({
                Title = "下一步",
                Content = "请输入中文翻译"
            })
        end
    end
})

DictTab:Input({
    Title = "添加新翻译 (中文)",
    Placeholder = "输入中文翻译",
    Callback = function(chinese) if chinese and #chinese > 0 and _G.tempEnglish then
            translationDict[_G.tempEnglish] = chinese
            
            WindUI:Notify({
                Title = "翻译添加成功",
                Content = _G.tempEnglish .. " → " .. chinese
            })
            
            _G.tempEnglish = nil
        end
    end
})

DictTab:Space()

-- 查看词典内容
DictTab:Button({
    Title = "📖 查看词典内容",
    Icon = "eye",
    Justify = "Center",
    Callback = function()
        local displayText = "📚 词典内容 (前20条)\n\n"
        local count = 0
        
        for eng, chi in pairs(translationDict) do
            count = count + 1
            if count <= 20 then
                displayText = displayText .. count .. ". " .. eng .. " → " .. chi .. "\n"
            else
                displayText = displayText .. "... 还有 " .. (getDictStats() - 20) .. " 条"
                break
            end
        end
        
        WindUI:Notify({
            Title = "词典内容",
            Content = displayText,
            Duration = 15
        })
    end
})

-- 立即应用标签页
local ApplyTab = Window:Tab({
    Title = "立即应用",
    Icon = "refresh-cw"
})

ApplyTab:Button({
    Title = "🔍 立即扫描并替换",
    Icon = "search",
    Justify = "Center",
    Color = Color3.fromHex("#305dff"),
    Callback = function()
        local function scanAndApply()
            local replacedCount = 0
            
            local function processObject(obj)
                if not obj or not obj.Parent then return 0 end
                
                local count = 0
                if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                    local text = obj.Text
                    if text and text ~= "" then
                        local translated = replaceEnglishText(text)
                        if translated ~= text then
                            if not obj:GetAttribute("OriginalText") then
                                obj:SetAttribute("OriginalText", text)
                            end
                            obj.Text = translated
                            count = 1
                        end
                    end
                end
                
                for _, child in ipairs(obj:GetChildren()) do
                    count = count + processObject(child)
                end
                
                return count
            end
            
            local locations = {
                game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"),
                game:GetService("Workspace"),
                game:GetService("StarterGui"),
                game:GetService("CoreGui")
            }
            
            for _, location in ipairs(locations) do
                if location then
                    replacedCount = replacedCount + processObject(location)
                end
            end
            
            return replacedCount
        end
        
        WindUI:Notify({
            Title = "扫描中",
            Content = "正在扫描并翻译文本..."
        })
        
        local replaced = scanAndApply()
        
        WindUI:Notify({
            Title = "替换完成",
            Content = "成功替换 " .. replaced .. " 个文本"
        })
    end
})

print("✅ by Q 1072347228")
print("提示：点击'启动实时文本替换'开始自动翻译")
