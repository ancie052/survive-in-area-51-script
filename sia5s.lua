本地OrionLib=load string(游戏：HttpGet("https://raw.githubusercontent.com/Giangplay/Script/main/Orion_Library_PE_V2.lua"))()

本地窗口=OrionLib:MakeWindow({
姓名="在51区生存"，
HidePremium=false，
saveconfig=false，
configFolder="CoordTool"
})

_G.SavedCoords=_G.SavedCoords或{}

本地电流X=""
本地当前y=""
本地电流Z=""
本地savedName=""
局部矿石环=假的
局部pickaxeLooping=false

本地玩家=game.Players.LocalPlayer
本地复制存储=游戏：GetService("ReplicatedStorage")

局部函数getRoot()
局部c=player.Character
返回c和c:FindFirstChild("HumanoidRootPart")
结束

本地功能瞬移(x，y，z)
局部r=getRoot()
如果r，则
r.CFrame=CFrame.new(x，y，z)
返回true
结束
返回false
结束

本地函数单击Pickaxe(名称)
    local char = player.Character
    if not char then return false end
    local tool = char:FindFirstChild(name)
    if tool then
        replicatedStorage:WaitForChild("Mine"):FireServer(tool)
        return true
    end
    return false
end

local OreCoords = {
    {-395, 717, 713},
    {-373, 717, 768},
    {-331, 717, 726},
    {-486, 717, 747},
    {-483, 717, 709},
    {-547, 717, 713},
    {-566, 717, 786},
    {-548, 717, 760},
    {-617, 717, 746},
    {-568, 717, 687},
    {-460, 717, 727},
}

local Area51Coords = {
    {"传送门", -104, 1033, 833},
    {"乱码枪", -1366, 1066, 985},
    {"腐蚀枪", -2104, 944, -432},
    {"双持红枪", 77, 1099, 1948},
    {"黑枪", 2240, 1151, 56},
    {"白枪", -14, 875, -45},
    {"冰弩", 244, 696, 944},
    {"火神", -601, 953, 155},
    {"红炮", -353, 1073, 421},
    {"火刀终点", 62, 1062, 1158},
    {"水枪", -363, 963, -55},
    {"水枪1", -441, 971, -198},
    {"水枪2", -285, 971, -92},
    {"出生点", 709, 1150, 744},
    {"合成", 622, 985, 724},
    {"超市", 585, 1150, 660},
    {"南瓜", -471, 877, -277},
    {"机械南瓜", 950, 850, -617},
    {"死神", -120, 992, 271},
    {"石镐", -484, 753, 881},
    {"铁镐", -484, 753, 876},
    {"金镐", -484, 753, 871},
    {"钻石镐", -484, 753, 866},
    {"监狱马桶", -584, 1089, 1088},
}

local Pickaxes = {
    "Diamond Pickaxe",
    "Golden Pickaxe",
    "Silver Pickaxe",
    "Iron Pickaxe",
}

local TeleportTab = Window:MakeTab({
    Name = "传送",
    Icon = "rbxassetid://7734091286",
    PremiumOnly = false
})

local coordDisplay = TeleportTab:AddLabel("等待加载...")
TeleportTab:AddLabel("本脚本只为减少时间而生，被ban概不负责")

TeleportTab:AddTextbox({
    Name = "X 坐标",
    Default = "",
    TextDisappear = false,
    Callback = function(v)
        currentX = v
    end
})

TeleportTab:AddTextbox({
    Name = "Y 坐标",
    Default = "",
    TextDisappear = false,
    Callback = function(v)
        currentY = v
    end
})

TeleportTab:AddTextbox({
    Name = "Z 坐标",
    Default = "",
    TextDisappear = false,
    Callback = function(v)
        currentZ = v
    end
})

TeleportTab:AddButton({
    Name = "获取当前位置",
    Callback = function()
        local r = getRoot()
        if r then
            currentX = string.format("%.2f", r.Position.X)
            currentY = string.format("%.2f", r.Position.Y)
            currentZ = string.format("%.2f", r.Position.Z)
            coordDisplay:Set(currentX .. ", " .. currentY .. ", " .. currentZ)
        end
    end
})

TeleportTab:AddButton({
    Name = "传送",
    Callback = function()
        local x = tonumber(currentX)
        local y = tonumber(currentY)
        local z = tonumber(currentZ)
        if x and y and z then
            if teleport(x, y, z) then
                coordDisplay:Set("已传送到: " .. string.format("%.1f, %.1f, %.1f", x, y, z))
            end
        else
            coordDisplay:Set("请先获取位置或输入坐标")
        end
    end
})

TeleportTab:AddButton({
    Name = "开始循环传送矿石",
    Callback = function()
        if oreLooping then return end
        oreLooping = true
        coordDisplay:Set("开始循环传送矿石")
        spawn(function()
            local index = 1
            while oreLooping do
                local ore = OreCoords[index]
                local r = getRoot()
                if r then
                    r.CFrame = CFrame.new(ore[1], ore[2] + 3, ore[3])
                    coordDisplay:Set("矿石 " .. index .. "/" .. #OreCoords .. " (" .. ore[1] .. ", " .. ore[2] .. ", " .. ore[3] .. ")")
                end
                index = index + 1
                if index > #OreCoords then
                    index = 1
                end
                task.wait(1)
            end
        end)
    end
})

TeleportTab:AddButton({
    Name = "停止循环传送矿石",
    Callback = function()
        oreLooping = false
        coordDisplay:Set("已停止")
    end
})

TeleportTab:AddButton({
    Name = "开始循环点击镐子",
    Callback = function()
        if pickaxeLooping then return end
        pickaxeLooping = true
        spawn(function()
            local index = 1
            while pickaxeLooping do
                local name = Pickaxes[index]
                clickPickaxe(name)
                coordDisplay:Set("点击: " .. name)
                index = index + 1
                if index > #Pickaxes then index = 1 end
                task.wait(0.1)
            end
        end)
结束
})

TeleportTab:AddButton({
name="停止循环点击镐子"，
callback=函数()
pickaxeLooping=false
结束
})

本地SaveTab=窗口：MakeTab({
Name="保存位置"，
icon="rbxassetid://7734091286"，
PremiumOnly=false
})

SaveTab:AddTextbox({
name="位置名称"，
默认值=""，
文本消失=false，
回调=函数(v)
savedName=v
结束
})

SaveTab:AddButton({
name="保存传送区坐标"，
callback=函数()
如果savedName==""，则返回结束
局部x=tonumber(当前X)
本地y=tonumber(当前y)
local z=tonumber(当前Z)
如果x，y，z，那么
_G.SavedCoords[savedName]={x=x，y=y，z=z}
SaveTab:AddButton({
name=savedName.."("..string.format("%.0f，%.0f，%.0f"，x，y，z)..")"，
callback=函数()
传送(x，y，z)
结束
            })
结束
结束
})

SaveTab:AddButton({
姓名="保存当前位置"，
callback=函数()
如果savedName==""，则返回结束
局部R=getroot()
如果r，则
局部X=r.Position.X
局部y=r.Position.Y
局部Z=r.Position.Z
_G.SavedCoords[savedName]={x=x，y=y，z=z}
SaveTab:AddButton({
name=savedName.."("..string.format("%.0f，%.0f，%.0f"，x，y，z)..")"，
callback=函数()
传送(x，y，z)
结束
            })
结束
结束
})

对于名称，成对POS(_G.SavedCoords)do
局部X，y，z=pos.x，pos.y，pos.z
SaveTab:AddButton({
Name=name.."("..string.format("%.0f，%.0f，%.0f"，x，y，z)..")"，
callback=函数()
传送(x，y，z)
结束
    })
结束

local Area51Tab=窗口：MakeTab({
name="51区生存"，
icon="rbxassetid://7734091286"，
PremiumOnly=false
})

对于_，ipairs中的数据(Area51Coords)do
本地名称=数据[1]
本地x=数据[2]
本地y=数据[3]
局部z=数据[4]
Area51选项卡：addButton({
name=name.."("..x.."，"..y.."，"..z..")"，
callback=函数()
传送(x，y，z)
结束
    })
结束

派生(函数()
而真做
局部R=getroot()
如果r，则
局部p=r.位置
coordDisplay:Set(string.format("%.1f，%.1f，%.1f"，p.x，P.Y，P.Z))
结束
task.wait(0.1)
结束
结束)

OrionLib：初始化()
