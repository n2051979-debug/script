-- ==========================================
-- MODGAMEIOS // BLOX FRUITS ULTIMATE HUB V10
-- ==========================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
local CommF = Remotes and Remotes:WaitForChild("CommF_", 10)

getgenv().ModGameios_Cfg = {
    Weapon = "Melee",
    TweenSpeed = 300,
    BringMob = true,
    FastAttack = true,
    AutoHaki = true,
    AutoFarmLevel = false,
    AutoFarmBone = false,
    AutoMastery = false,
    AutoChest = false,
    AutoSeaBeast = false,
    AutoDungeon = false,
    WalkSpeed = 16,
    JumpPower = 50,
    Noclip = false,
    ESPPlayer = false,
    ESPFruit = false
}

local AllCodes = {
    "KITT_RESET", "Sub2CaptainMaui", "kittgaming", "Sub2Fer999",
    "Enyu_is_Pro", "Magicbus", "JCWK", "Starcodeheo", "Bluxxy",
    "fudd10_v2", "SUB2GAMERROBOT_EXP1", "Sub2NoobMaster123",
    "Sub2UncleKizaru", "Sub2Daigrock", "Axiore", "TantaiGaming"
}

local function SendCommF(...)
    if CommF then
        local args = {...}
        task.spawn(function()
            pcall(function() CommF:InvokeServer(unpack(args)) end)
        end)
    end
end

-- ==========================================
-- KHỞI TẠO UI MODGAMEIOS
-- ==========================================
local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
if CoreGui:FindFirstChild("ModGameios_BloxFruits") then
    CoreGui.ModGameios_BloxFruits:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ModGameios_BloxFruits"
ScreenGui.ResetOnSpawn = false

-- Nút mở lại menu khi ẩn
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 130, 0, 36)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -18)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
ToggleBtn.Text = "MODGAMEIOS"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 157)
ToggleBtn.Font = Enum.Font.Code
ToggleBtn.TextSize = 13
ToggleBtn.Visible = false
ToggleBtn.Active = true
ToggleBtn.Draggable = true
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", ToggleBtn).Color = Color3.fromRGB(0, 255, 157)

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 720, 0, 440)
Main.Position = UDim2.new(0.5, -360, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(8, 10, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main.Main or Main).CornerRadius = UDim.new(0, 12)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(0, 255, 157)
MainStroke.Thickness = 1.2

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 16, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MODGAMEIOS // BLOX FRUITS CORE"
Title.TextColor3 = Color3.fromRGB(0, 255, 157)
Title.Font = Enum.Font.Code
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Header)
Close.Size = UDim2.new(0, 32, 0, 32)
Close.Position = UDim2.new(1, -40, 0, 5)
Close.BackgroundTransparency = 1
Close.Text = "✕"
Close.TextColor3 = Color3.fromRGB(255, 0, 60)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16

local Minimize = Instance.new("TextButton", Header)
Minimize.Size = UDim2.new(0, 32, 0, 32)
Minimize.Position = UDim2.new(1, -76, 0, 5)
Minimize.BackgroundTransparency = 1
Minimize.Text = "—"
Minimize.TextColor3 = Color3.fromRGB(200, 200, 210)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 14

Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    ToggleBtn.Visible = true
end)
ToggleBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    ToggleBtn.Visible = false
end)

-- Sidebar Tabs
local Sidebar = Instance.new("ScrollingFrame", Main)
Sidebar.Size = UDim2.new(0, 200, 1, -54)
Sidebar.Position = UDim2.new(0, 12, 0, 46)
Sidebar.BackgroundTransparency = 1
Sidebar.ScrollBarThickness = 0
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
local SideLayout = Instance.new("UIListLayout", Sidebar)
SideLayout.Padding = UDim.new(0, 6)

-- Content Area
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, -230, 1, -54)
Content.Position = UDim2.new(0, 222, 0, 46)
Content.BackgroundTransparency = 1

local Pages = {}
local TabBtns = {}

local function CreatePage(name, isDefault)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1, 0, 0, 34)
    Btn.BackgroundColor3 = isDefault and Color3.fromRGB(0, 255, 157) or Color3.fromRGB(16, 20, 30)
    Btn.TextColor3 = isDefault and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(200, 210, 225)
    Btn.Text = "  " .. name
    Btn.Font = Enum.Font.Code
    Btn.TextSize = 12.5
    Btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 157)
    Page.Visible = isDefault
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local PLayout = Instance.new("UIListLayout", Page)
    PLayout.Padding = UDim.new(0, 6)

    table.insert(Pages, Page)
    table.insert(TabBtns, {Button = Btn, Text = name})

    Btn.MouseButton1Click:Connect(function()
        for _, p in ipairs(Pages) do p.Visible = false end
        for _, b in ipairs(TabBtns) do
            b.Button.BackgroundColor3 = Color3.fromRGB(16, 20, 30)
            b.Button.TextColor3 = Color3.fromRGB(200, 210, 225)
        end
        Page.Visible = true
        Btn.BackgroundColor3 = Color3.fromRGB(0, 255, 157)
        Btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    return Page
end

local function AddButton(page, text, callback)
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(1, -6, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
    b.Text = "  > " .. text
    b.TextColor3 = Color3.fromRGB(220, 230, 245)
    b.Font = Enum.Font.Code
    b.TextSize = 12
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
end

local function AddToggle(page, text, default, callback)
    local state = default
    local b = Instance.new("TextButton", page)
    b.Size = UDim2.new(1, -6, 0, 38)
    b.BackgroundColor3 = Color3.fromRGB(18, 22, 32)
    b.TextColor3 = Color3.fromRGB(220, 230, 245)
    b.Font = Enum.Font.Code
    b.TextSize = 12
    b.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

    local function update()
        b.Text = string.format("  [%s] %s", state and "ON" or "OFF", text)
        b.TextColor3 = state and Color3.fromRGB(0, 255, 157) or Color3.fromRGB(220, 230, 245)
    end
    update()

    b.MouseButton1Click:Connect(function()
        state = not state
        update()
        callback(state)
    end)
end

-- TẠO CÁC TAB CHỨC NĂNG
local Tab1 = CreatePage("🛒 Cửa Hàng & Code", true)
local Tab2 = CreatePage("⚡ Auto Farm", false)
local Tab3 = CreatePage("⚔️ Săn Boss & Sea Event", false)
local Tab4 = CreatePage("⚙️ Cài Đặt Cá Nhân", false)

-- TAB 1
AddButton(Tab1, "Nhập Tất Cả Code X2 EXP", function()
    for _, c in ipairs(AllCodes) do
        pcall(function() ReplicatedStorage.Remotes.Redeem:InvokeServer(c) end)
    end
end)
AddButton(Tab1, "Teleport Sang Sea 1", function() SendCommF("TravelMain") end)
AddButton(Tab1, "Teleport Sang Sea 2", function() SendCommF("TravelDressrosa") end)
AddButton(Tab1, "Teleport Sang Sea 3", function() SendCommF("TravelZou") end)
AddButton(Tab1, "Mua Godhuman", function() SendCommF("BuyGodhuman") end)
AddButton(Tab1, "Mua Sanguine Art", function() SendCommF("BuySanguineArt") end)

-- TAB 2
AddToggle(Tab2, "Auto Farm Level (Quest + Mob)", false, function(v) getgenv().ModGameios_Cfg.AutoFarmLevel = v end)
AddToggle(Tab2, "Bring Mob (Gom Quái Lại Gần)", true, function(v) getgenv().ModGameios_Cfg.BringMob = v end)
AddToggle(Tab2, "Fast Attack (Đánh Siêu Tốc)", true, function(v) getgenv().ModGameios_Cfg.FastAttack = v end)
AddToggle(Tab2, "Tự Động Bật Buso Haki", true, function(v) getgenv().ModGameios_Cfg.AutoHaki = v end)

-- TAB 3
AddToggle(Tab3, "Auto Farm Xương (Haunted Castle)", false, function(v) getgenv().ModGameios_Cfg.AutoFarmBone = v end)
AddToggle(Tab3, "Auto Săn Sea Beast", false, function(v) getgenv().ModGameios_Cfg.AutoSeaBeast = v end)
AddToggle(Tab3, "Auto Nhặt Trái Ác Quỷ Trên Map", false, function(v) getgenv().ModGameios_Cfg.ESPFruit = v end)

-- TAB 4
AddToggle(Tab4, "Chạy Nhanh (WalkSpeed Boost)", false, function(v) getgenv().ModGameios_Cfg.WalkSpeed = v and 80 or 16 end)
AddToggle(Tab4, "Nhảy Cao (JumpPower Boost)", false, function(v) getgenv().ModGameios_Cfg.JumpPower = v and 150 or 50 end)
AddToggle(Tab4, "Xuyên Tường (Noclip)", false, function(v) getgenv().ModGameios_Cfg.Noclip = v end)

-- ==========================================
-- ENGINE THỰC THI (CORE LOOP)
-- ==========================================
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        if getgenv().ModGameios_Cfg.WalkSpeed ~= 16 then hum.WalkSpeed = getgenv().ModGameios_Cfg.WalkSpeed end
        if getgenv().ModGameios_Cfg.JumpPower ~= 50 then
            hum.UseJumpPower = true
            hum.JumpPower = getgenv().ModGameios_Cfg.JumpPower
        end
    end
    if getgenv().ModGameios_Cfg.Noclip or getgenv().ModGameios_Cfg.AutoFarmLevel then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

task.spawn(function()
    while task.wait(0.12) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            if getgenv().ModGameios_Cfg.AutoHaki and not char:FindFirstChild("HasBuso") then
                SendCommF("Buso")
            end

            if getgenv().ModGameios_Cfg.AutoFarmLevel then
                local enemies = Workspace:FindFirstChild("Enemies")
                if enemies then
                    for _, mob in ipairs(enemies:GetChildren()) do
                        if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                            hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 16, 0)
                            if getgenv().ModGameios_Cfg.BringMob then
                                mob.HumanoidRootPart.CanCollide = false
                                mob.Humanoid.WalkSpeed = 0
                            end
                            VirtualUser:CaptureController()
                            VirtualUser:Button1Down(Vector2.new(1280, 672))
                            break
                        end
                    end
                end
            end
        end)
    end
end)
