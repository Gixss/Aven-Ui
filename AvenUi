--[[
    AvenUI v1.0
    Author  : Gixss
    Discord : https://discord.gg/q7PZBsbpD
    License : MIT

    Usage:
        local AvenUI = loadstring(game:HttpGet("..."))()
        local Window = AvenUI:CreateWindow({ Name = "My Hub", Icon = "sparkle" })
        local Tab = Window:CreateTab("Main", "home")
        Tab:Toggle({ Name = "Auto Farm", Icon = "bolt", Callback = function(v) end })
]]

local AvenUI = {}
AvenUI.__index = AvenUI
AvenUI.Version = "1.0"

local Players      = game:GetService("Players")
local UserInput    = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP           = Players.LocalPlayer

local Theme = {
    Bg         = Color3.fromRGB(10, 11, 14),
    BgTop      = Color3.fromRGB(15, 17, 21),
    BgSide     = Color3.fromRGB(12, 13, 17),
    Item       = Color3.fromRGB(20, 22, 27),
    ItemHover  = Color3.fromRGB(27, 30, 36),
    Input      = Color3.fromRGB(14, 15, 19),
    Track      = Color3.fromRGB(34, 37, 44),
    Border     = Color3.fromRGB(30, 33, 40),
    BorderSoft = Color3.fromRGB(22, 24, 29),
    Text       = Color3.fromRGB(238, 240, 244),
    SubText    = Color3.fromRGB(148, 155, 167),
    Muted      = Color3.fromRGB(82, 88, 100),
    Accent     = Color3.fromRGB(132, 204, 22),
    AccentDim  = Color3.fromRGB(101, 163, 13),
    Danger     = Color3.fromRGB(239, 68, 68),
    Warn       = Color3.fromRGB(245, 158, 11),
    Info       = Color3.fromRGB(59, 130, 246),
    Success    = Color3.fromRGB(34, 197, 94),
    Font       = Enum.Font.Gotham,
    FontBold   = Enum.Font.GothamBold,
    FontMed    = Enum.Font.GothamMedium,
    FontBlack  = Enum.Font.GothamBlack,
    Radius     = 10,
    RadiusSm   = 7,
    RadiusLg   = 14,
    HeaderH    = 72,
    SidebarW   = 168,
}
AvenUI.Theme = Theme

function AvenUI:SetTheme(t)
    if type(t) ~= "table" then return end
    for k, v in pairs(t) do if Theme[k] ~= nil then Theme[k] = v end end
end
function AvenUI:GetTheme() return Theme end
function AvenUI:SetAccent(c)
    Theme.Accent = c
    Theme.AccentDim = Color3.new(
        math.max(0, c.R - 0.15),
        math.max(0, c.G - 0.18),
        math.max(0, c.B - 0.03)
    )
end

local function mk(c, p)
    local o = Instance.new(c)
    for k, v in pairs(p or {}) do o[k] = v end
    return o
end
local function cr(o, r) return mk("UICorner", { CornerRadius = UDim.new(0, r or Theme.Radius), Parent = o }) end
local function st(o, col, th) return mk("UIStroke", { Color = col or Theme.Border, Thickness = th or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = o }) end
local function pd(o, t, r, b, l) return mk("UIPadding", { PaddingTop = UDim.new(0, t or 0), PaddingRight = UDim.new(0, r or t or 0), PaddingBottom = UDim.new(0, b or t or 0), PaddingLeft = UDim.new(0, l or r or t or 0), Parent = o }) end
local function tw(o, ti, props, style, dir)
    TweenService:Create(o, TweenInfo.new(ti or 0.2, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
end
local function parentGui()
    local ok, h = pcall(function() return gethui() end)
    if ok and h then return h end
    local ok2, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok2 and cg then return cg end
    return LP:WaitForChild("PlayerGui")
end
local function drag(frame, handle)
    handle = handle or frame
    local dr, di, ds, sp
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dr = true; ds = i.Position; sp = frame.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dr = false end
            end)
        end
    end)
    handle.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then di = i end
    end)
    UserInput.InputChanged:Connect(function(i)
        if i == di and dr then
            local d = i.Position - ds
            frame.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y)
        end
    end)
end
local function round(v, inc) return math.floor(v / inc + 0.5) * inc end

-- ═══════════════════════════════════════════════════════════
--  ICON SYSTEM
-- ═══════════════════════════════════════════════════════════
local Icon = {}
AvenUI.Icon = Icon

local function sO(p, x, y, w, h, r, c, th, rot)
    local f = mk("Frame", {
        Position = UDim2.new(0, x, 0, y), Size = UDim2.new(0, w, 0, h),
        BackgroundTransparency = 1, BorderSizePixel = 0,
        Rotation = rot or 0, Parent = p,
    })
    cr(f, r or 0); st(f, c, th or 1.4)
    return f
end
local function fF(p, x, y, w, h, r, c, rot)
    local f = mk("Frame", {
        Position = UDim2.new(0, x, 0, y), Size = UDim2.new(0, w, 0, h),
        BackgroundColor3 = c, BorderSizePixel = 0,
        Rotation = rot or 0, Parent = p,
    })
    if r then cr(f, r) end
    return f
end
local function cS(p, cx, cy, r, c, th) return sO(p, cx - r, cy - r, r * 2, r * 2, r * 2, c, th or 1.4) end
local function cF(p, cx, cy, r, c) return fF(p, cx - r, cy - r, r * 2, r * 2, r * 2, c) end

local D = {}

D["gear"] = function(p, s, c)
    for i = 0, 7 do
        local a = math.rad(i * 45)
        local t = fF(p, 0, 0, s * 0.15, s * 0.15, 1.5, c, i * 45)
        t.AnchorPoint = Vector2.new(0.5, 0.5)
        t.Position = UDim2.new(0.5, math.cos(a) * s * 0.4, 0.5, math.sin(a) * s * 0.4)
    end
    cS(p, s/2, s/2, s * 0.36, c, 1.7)
    cS(p, s/2, s/2, s * 0.1, c, 1.7)
end
D["settings"] = D["gear"]; D["cog"] = D["gear"]

D["home"] = function(p, s, c)
    local l = sO(p, 0, 0, s * 0.5, 1.4, 0, c, 1.6, -43)
    l.AnchorPoint = Vector2.new(0.5, 0.5); l.Position = UDim2.new(0.32, 0, 0.34, 0)
    local r = sO(p, 0, 0, s * 0.5, 1.4, 0, c, 1.6, 43)
    r.AnchorPoint = Vector2.new(0.5, 0.5); r.Position = UDim2.new(0.68, 0, 0.34, 0)
    sO(p, s * 0.22, s * 0.55, s * 0.56, s * 0.33, 1, c, 1.6)
end
D["house"] = D["home"]

D["user"] = function(p, s, c)
    cS(p, s/2, s * 0.32, s * 0.17, c, 1.6)
    local b = sO(p, s * 0.2, s * 0.6, s * 0.6, s * 0.55, s * 0.5, c, 1.6)
    b.ClipsDescendants = true
end
D["profile"] = D["user"]; D["account"] = D["user"]

D["search"] = function(p, s, c)
    cS(p, s * 0.42, s * 0.42, s * 0.23, c, 1.7)
    local h = sO(p, 0, 0, s * 0.28, 1.6, 0, c, 1.7, 45)
    h.AnchorPoint = Vector2.new(0.5, 0.5); h.Position = UDim2.new(0.74, 0, 0.74, 0)
end
D["find"] = D["search"]

D["close"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.7, 1.7, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.5, 0)
    local b = sO(p, 0, 0, s * 0.7, 1.7, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.5, 0, 0.5, 0)
end
D["x"] = D["close"]; D["exit"] = D["close"]

D["check"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.32, 0, 0.55, 0)
    local b = sO(p, 0, 0, s * 0.62, 1.7, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.6, 0, 0.48, 0)
end
D["tick"] = D["check"]

D["plus"] = function(p, s, c)
    fF(p, s * 0.44, s * 0.18, s * 0.12, s * 0.64, 1, c)
    fF(p, s * 0.18, s * 0.44, s * 0.64, s * 0.12, 1, c)
end
D["add"] = D["plus"]

D["minus"] = function(p, s, c)
    fF(p, s * 0.18, s * 0.44, s * 0.64, s * 0.12, 1, c)
end
D["remove"] = D["minus"]

D["chevron-right"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.42, 0, 0.3, 0)
    local b = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.42, 0, 0.7, 0)
end
D["chevron-left"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, -45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.58, 0, 0.3, 0)
    local b = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.58, 0, 0.7, 0)
end
D["chevron-down"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.3, 0, 0.42, 0)
    local b = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.7, 0, 0.42, 0)
end
D["chevron-up"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, -45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.3, 0, 0.58, 0)
    local b = sO(p, 0, 0, s * 0.32, 1.7, 0, c, 0, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.7, 0, 0.58, 0)
end

D["bell"] = function(p, s, c)
    sO(p, s * 0.18, s * 0.2, s * 0.64, s * 0.62, s * 0.36, c, 1.7)
    fF(p, s * 0.24, s * 0.78, s * 0.52, 1.6, 1, c)
    cF(p, s / 2, s * 0.9, s * 0.055, c)
end
D["notif"] = D["bell"]; D["notification"] = D["bell"]

D["lock"] = function(p, s, c)
    local sh = sO(p, s * 0.3, s * 0.14, s * 0.4, s * 0.4, s * 0.2, c, 1.7)
    sh.ClipsDescendants = true
    sO(p, s * 0.22, s * 0.46, s * 0.56, s * 0.42, 2, c, 1.7)
    cF(p, s / 2, s * 0.68, s * 0.055, c)
end
D["secure"] = D["lock"]

D["eye"] = function(p, s, c)
    sO(p, s * 0.1, s * 0.34, s * 0.8, s * 0.32, s * 0.3, c, 1.7)
    cS(p, s / 2, s / 2, s * 0.13, c, 1.7)
    cF(p, s / 2, s / 2, s * 0.05, c)
end
D["view"] = D["eye"]

D["star"] = function(p, s, c)
    for i = 0, 4 do
        local a = math.rad(-90 + i * 72)
        local leg = fF(p, 0, 0, s * 0.22, s * 0.52, 2, c, i * 72)
        leg.AnchorPoint = Vector2.new(0.5, 1)
        leg.Position = UDim2.new(0.5 + math.cos(a) * 0.08, 0, 0.5 + math.sin(a) * 0.08, 0)
    end
end
D["favorite"] = D["star"]

D["heart"] = function(p, s, c)
    cF(p, s * 0.35, s * 0.38, s * 0.18, c)
    cF(p, s * 0.65, s * 0.38, s * 0.18, c)
    fF(p, s * 0.26, s * 0.32, s * 0.48, s * 0.48, 2, c, 45)
end
D["like"] = D["heart"]

D["info"] = function(p, s, c)
    cS(p, s / 2, s / 2, s * 0.37, c, 1.7)
    cF(p, s / 2, s * 0.32, s * 0.055, c)
    fF(p, s * 0.46, s * 0.44, s * 0.08, s * 0.3, 1, c)
end
D["about"] = D["info"]

D["warning"] = function(p, s, c)
    local t = fF(p, 0, 0, s * 0.72, s * 0.72, 2, c, 45)
    t.AnchorPoint = Vector2.new(0.5, 0.5); t.Position = UDim2.new(0.5, 0, 0.56, 0)
    fF(p, s * 0.46, s * 0.42, s * 0.08, s * 0.2, 1, Theme.Bg)
    cF(p, s / 2, s * 0.74, s * 0.045, Theme.Bg)
end
D["alert"] = D["warning"]

D["shield"] = function(p, s, c)
    sO(p, s * 0.2, s * 0.14, s * 0.6, s * 0.36, 2, c, 1.7)
    local b = sO(p, 0, 0, s * 0.44, s * 0.44, 2, c, 1.7, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.5, 0, 0.7, 0)
end
D["protect"] = D["shield"]

D["sword"] = function(p, s, c)
    local b = sO(p, 0, 0, s * 0.62, 1.7, 0, c, 0, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.44, 0, 0.44, 0)
    local g = sO(p, 0, 0, 1.7, s * 0.24, 0, c, 0, 45)
    g.AnchorPoint = Vector2.new(0.5, 0.5); g.Position = UDim2.new(0.74, 0, 0.74, 0)
    local h = sO(p, 0, 0, s * 0.22, 1.7, 0, c, 0, 45)
    h.AnchorPoint = Vector2.new(0.5, 0.5); h.Position = UDim2.new(0.84, 0, 0.84, 0)
end
D["combat"] = D["sword"]

D["code"] = function(p, s, c)
    local a = sO(p, 0, 0, s * 0.36, 1.7, 0, c, 0, -45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.28, 0, 0.35, 0)
    local b = sO(p, 0, 0, s * 0.36, 1.7, 0, c, 0, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.28, 0, 0.65, 0)
    local d = sO(p, 0, 0, s * 0.36, 1.7, 0, c, 0, 45)
    d.AnchorPoint = Vector2.new(0.5, 0.5); d.Position = UDim2.new(0.72, 0, 0.35, 0)
    local e = sO(p, 0, 0, s * 0.36, 1.7, 0, c, 0, -45)
    e.AnchorPoint = Vector2.new(0.5, 0.5); e.Position = UDim2.new(0.72, 0, 0.65, 0)
end
D["dev"] = D["code"]; D["script"] = D["code"]; D["terminal"] = D["code"]

D["bolt"] = function(p, s, c)
    local a = fF(p, 0, 0, s * 0.15, s * 0.35, 1, c, -25)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.56, 0, 0.32, 0)
    local b = fF(p, 0, 0, s * 0.15, s * 0.42, 1, c, 25)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.44, 0, 0.68, 0)
    fF(p, s * 0.34, s * 0.44, s * 0.3, s * 0.12, 1, c)
end
D["power"] = D["bolt"]; D["zap"] = D["bolt"]; D["lightning"] = D["bolt"]

D["play"] = function(p, s, c)
    local t = fF(p, 0, 0, s * 0.62, s * 0.62, 2, c, 45)
    t.AnchorPoint = Vector2.new(0.5, 0.5); t.Position = UDim2.new(0.56, 0, 0.5, 0)
end
D["pause"] = function(p, s, c)
    fF(p, s * 0.3, s * 0.24, s * 0.1, s * 0.52, 1, c)
    fF(p, s * 0.6, s * 0.24, s * 0.1, s * 0.52, 1, c)
end

D["trash"] = function(p, s, c)
    fF(p, s * 0.28, s * 0.14, s * 0.44, 1.6, 0, c)
    fF(p, s * 0.4, s * 0.1, s * 0.2, 1.6, 0, c)
    sO(p, s * 0.3, s * 0.26, s * 0.4, s * 0.56, 1, c, 1.5)
end
D["delete"] = D["trash"]

D["edit"] = function(p, s, c)
    local pn = fF(p, 0, 0, s * 0.18, s * 0.6, 1, c, 45)
    pn.AnchorPoint = Vector2.new(0.5, 0.5); pn.Position = UDim2.new(0.5, 0, 0.5, 0)
    fF(p, s * 0.66, s * 0.14, s * 0.16, s * 0.16, 1, c, 45)
end
D["pencil"] = D["edit"]

D["copy"] = function(p, s, c)
    sO(p, s * 0.16, s * 0.16, s * 0.46, s * 0.52, 2, c, 1.5)
    sO(p, s * 0.4, s * 0.34, s * 0.46, s * 0.52, 2, c, 1.5)
end

D["download"] = function(p, s, c)
    sO(p, s * 0.5 - 0.8, s * 0.16, 1.6, s * 0.32, 0, c, 0, 0)
    local a = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.32, 0, 0.58, 0)
    local b = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.68, 0, 0.58, 0)
    sO(p, s * 0.28, s * 0.78, s * 0.44, 1.5, 0, c, 0, 0)
end

D["upload"] = function(p, s, c)
    sO(p, s * 0.5 - 0.8, s * 0.16, 1.6, s * 0.32, 0, c, 0, 0)
    local a = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, -45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.32, 0, 0.42, 0)
    local b = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, 45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.68, 0, 0.42, 0)
    sO(p, s * 0.28, s * 0.78, s * 0.44, 1.5, 0, c, 0, 0)
end

D["folder"] = function(p, s, c)
    fF(p, s * 0.14, s * 0.24, s * 0.22, s * 0.1, 1, c)
    sO(p, s * 0.14, s * 0.32, s * 0.72, s * 0.52, 2, c, 1.5)
end

D["file"] = function(p, s, c)
    sO(p, s * 0.24, s * 0.14, s * 0.52, s * 0.74, 2, c, 1.5)
    local f = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, 45)
    f.AnchorPoint = Vector2.new(0.5, 0.5); f.Position = UDim2.new(0.62, 0, 0.22, 0)
end
D["document"] = D["file"]

D["link"] = function(p, s, c)
    cS(p, s * 0.35, s * 0.5, s * 0.16, c, 1.6)
    cS(p, s * 0.65, s * 0.5, s * 0.16, c, 1.6)
    fF(p, s * 0.35, s * 0.46, s * 0.3, 1.5, 0, c)
end

D["cart"] = function(p, s, c)
    sO(p, s * 0.14, s * 0.28, s * 0.62, s * 0.38, 2, c, 1.5)
    local h = sO(p, 0, 0, s * 0.24, 1.5, 0, c, 0, 25)
    h.AnchorPoint = Vector2.new(0.5, 0.5); h.Position = UDim2.new(0.2, 0, 0.22, 0)
    cF(p, s * 0.32, s * 0.8, s * 0.075, c)
    cF(p, s * 0.66, s * 0.8, s * 0.075, c)
end
D["shop"] = D["cart"]; D["store"] = D["cart"]

D["crown"] = function(p, s, c)
    fF(p, s * 0.18, s * 0.62, s * 0.64, s * 0.2, 1, c)
    cF(p, s * 0.24, s * 0.48, s * 0.08, c)
    cF(p, s * 0.5, s * 0.32, s * 0.09, c)
    cF(p, s * 0.76, s * 0.48, s * 0.08, c)
    local t1 = fF(p, 0, 0, s * 0.34, s * 0.34, 1, c, 45)
    t1.AnchorPoint = Vector2.new(0.5, 0.5); t1.Position = UDim2.new(0.28, 0, 0.55, 0)
    local t2 = fF(p, 0, 0, s * 0.38, s * 0.38, 1, c, 45)
    t2.AnchorPoint = Vector2.new(0.5, 0.5); t2.Position = UDim2.new(0.5, 0, 0.48, 0)
    local t3 = fF(p, 0, 0, s * 0.34, s * 0.34, 1, c, 45)
    t3.AnchorPoint = Vector2.new(0.5, 0.5); t3.Position = UDim2.new(0.72, 0, 0.55, 0)
end
D["vip"] = D["crown"]

D["diamond"] = function(p, s, c)
    local d = fF(p, 0, 0, s * 0.52, s * 0.52, 2, c, 45)
    d.AnchorPoint = Vector2.new(0.5, 0.5); d.Position = UDim2.new(0.5, 0, 0.5, 0)
end
D["gem"] = D["diamond"]

D["fire"] = function(p, s, c)
    local a = fF(p, 0, 0, s * 0.3, s * 0.46, 3, c, 20)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.52, 0)
    local b = fF(p, 0, 0, s * 0.26, s * 0.42, 3, c, -20)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.42, 0, 0.58, 0)
    cF(p, s * 0.5, s * 0.72, s * 0.14, c)
end
D["flame"] = D["fire"]

D["sun"] = function(p, s, c)
    cS(p, s / 2, s / 2, s * 0.2, c, 1.6)
    for i = 0, 7 do
        local a = math.rad(i * 45)
        local ray = fF(p, 0, 0, 1.6, s * 0.13, 0, c, i * 45)
        ray.AnchorPoint = Vector2.new(0.5, 0.5)
        ray.Position = UDim2.new(0.5 + math.cos(a) * 0.38, 0, 0.5 + math.sin(a) * 0.38, 0)
    end
end

D["moon"] = function(p, s, c)
    fF(p, s * 0.22, s * 0.22, s * 0.56, s * 0.56, s * 0.56, c)
    cF(p, s * 0.62, s * 0.42, s * 0.28, Theme.Bg)
end

D["wifi"] = function(p, s, c)
    for i = 1, 3 do
        local a = sO(p, 0, 0, s * (0.2 + i * 0.18), s * 0.1, s * 0.3, c, 1.5)
        a.AnchorPoint = Vector2.new(0.5, 1)
        a.Position = UDim2.new(0.5, 0, 0.75, 0)
    end
    cF(p, s * 0.5, s * 0.78, s * 0.055, c)
end

D["volume"] = function(p, s, c)
    fF(p, s * 0.2, s * 0.4, s * 0.16, s * 0.2, 1, c)
    local t = fF(p, 0, 0, s * 0.26, s * 0.26, 1, c, 45)
    t.AnchorPoint = Vector2.new(0.5, 0.5); t.Position = UDim2.new(0.45, 0, 0.5, 0)
    for i = 1, 2 do
        local a = sO(p, 0, 0, s * (0.14 + i * 0.16), s * (0.14 + i * 0.16), s, c, 1.5)
        a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.5, 0)
    end
end

D["key"] = function(p, s, c)
    cS(p, s * 0.34, s * 0.5, s * 0.17, c, 1.6)
    cF(p, s * 0.34, s * 0.5, s * 0.055, c)
    fF(p, s * 0.5, s * 0.47, s * 0.32, 1.6, 0, c)
    fF(p, s * 0.72, s * 0.47, 1.6, s * 0.14, 0, c)
end

D["tag"] = function(p, s, c)
    local d = fF(p, 0, 0, s * 0.62, s * 0.62, 2, c, 45)
    d.AnchorPoint = Vector2.new(0.5, 0.5); d.Position = UDim2.new(0.5, 0, 0.5, 0)
    cF(p, s * 0.62, s * 0.38, s * 0.065, Theme.Bg)
end

D["crosshair"] = function(p, s, c)
    cS(p, s / 2, s / 2, s * 0.32, c, 1.6)
    fF(p, s * 0.5 - 0.8, s * 0.1, 1.6, s * 0.16, 0, c)
    fF(p, s * 0.5 - 0.8, s * 0.74, 1.6, s * 0.16, 0, c)
    fF(p, s * 0.1, s * 0.5 - 0.8, s * 0.16, 1.6, 0, c)
    fF(p, s * 0.74, s * 0.5 - 0.8, s * 0.16, 1.6, 0, c)
    cF(p, s / 2, s / 2, s * 0.045, c)
end
D["target"] = D["crosshair"]; D["aim"] = D["crosshair"]

D["pin"] = function(p, s, c)
    cS(p, s / 2, s * 0.4, s * 0.23, c, 1.6)
    cF(p, s / 2, s * 0.4, s * 0.085, c)
    local t = fF(p, 0, 0, s * 0.28, s * 0.28, 1, c, 45)
    t.AnchorPoint = Vector2.new(0.5, 0.5); t.Position = UDim2.new(0.5, 0, 0.74, 0)
end
D["location"] = D["pin"]; D["map"] = D["pin"]

D["menu"] = function(p, s, c)
    fF(p, s * 0.18, s * 0.3, s * 0.64, 1.7, 1, c)
    fF(p, s * 0.18, s * 0.48, s * 0.64, 1.7, 1, c)
    fF(p, s * 0.18, s * 0.66, s * 0.64, 1.7, 1, c)
end
D["list"] = D["menu"]

D["refresh"] = function(p, s, c)
    cS(p, s / 2, s / 2, s * 0.31, c, 1.6)
    local a = sO(p, 0, 0, s * 0.15, 1.5, 0, c, 0, 45)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.76, 0, 0.24, 0)
    local b = sO(p, 0, 0, s * 0.15, 1.5, 0, c, 0, -45)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.86, 0, 0.3, 0)
end
D["reload"] = D["refresh"]; D["sync"] = D["refresh"]

D["sparkle"] = function(p, s, c)
    local a = fF(p, 0, 0, s * 0.13, s * 0.62, 1, c)
    a.AnchorPoint = Vector2.new(0.5, 0.5); a.Position = UDim2.new(0.5, 0, 0.5, 0)
    local b = fF(p, 0, 0, s * 0.62, s * 0.13, 1, c)
    b.AnchorPoint = Vector2.new(0.5, 0.5); b.Position = UDim2.new(0.5, 0, 0.5, 0)
end

D["discord"] = function(p, s, c)
    sO(p, s * 0.14, s * 0.28, s * 0.72, s * 0.44, s * 0.24, c, 1.6)
    cF(p, s * 0.38, s * 0.5, s * 0.06, c)
    cF(p, s * 0.62, s * 0.5, s * 0.06, c)
end

D["globe"] = function(p, s, c)
    cS(p, s / 2, s / 2, s * 0.36, c, 1.6)
    sO(p, s / 2 - 0.7, s * 0.14, 1.4, s * 0.72, 0, c, 0, 0)
    sO(p, s * 0.14, s / 2 - 0.7, s * 0.72, 1.4, 0, c, 0, 0)
end
D["world"] = D["globe"]

D["filter"] = function(p, s, c)
    fF(p, s * 0.15, s * 0.25, s * 0.7, 1.7, 0, c)
    fF(p, s * 0.28, s * 0.47, s * 0.44, 1.7, 0, c)
    fF(p, s * 0.4, s * 0.69, s * 0.2, 1.7, 0, c)
end

D["grid"] = function(p, s, c)
    fF(p, s * 0.15, s * 0.15, s * 0.3, s * 0.3, 2, c)
    fF(p, s * 0.55, s * 0.15, s * 0.3, s * 0.3, 2, c)
    fF(p, s * 0.15, s * 0.55, s * 0.3, s * 0.3, 2, c)
    fF(p, s * 0.55, s * 0.55, s * 0.3, s * 0.3, 2, c)
end

D["activity"] = function(p, s, c)
    local pts = {0.15, 0.35, 0.55, 0.75, 0.85}
    local hs  = {0.5, 0.35, 0.6, 0.28, 0.45}
    for i = 1, 5 do
        fF(p, s * pts[i] - 1, s * (1 - hs[i]), 2, s * hs[i], 1, c)
    end
end
D["stats"] = D["activity"]

D["chip"] = function(p, s, c)
    sO(p, s * 0.2, s * 0.2, s * 0.6, s * 0.6, 2, c, 1.6)
    fF(p, s * 0.36, s * 0.36, s * 0.28, s * 0.28, 1, c)
    for i = 0, 2 do
        fF(p, s * (0.3 + i * 0.2), s * 0.1, 1.6, s * 0.1, 0, c)
        fF(p, s * (0.3 + i * 0.2), s * 0.8, 1.6, s * 0.1, 0, c)
        fF(p, s * 0.1, s * (0.3 + i * 0.2), s * 0.1, 1.6, 0, c)
        fF(p, s * 0.8, s * (0.3 + i * 0.2), s * 0.1, 1.6, 0, c)
    end
end
D["cpu"] = D["chip"]

function Icon.Create(parent, icon, size, color)
    size  = size or 18
    color = color or Theme.Text
    local box = mk("Frame", {
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1,
        Parent = parent,
    })
    if type(icon) == "number" then
        mk("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = "rbxassetid://" .. icon,
            ImageColor3 = color,
            Parent = box,
        })
        return box
    end
    if type(icon) == "string" and (icon:match("^rbxassetid://") or icon:match("^rbxasset://") or icon:match("^http")) then
        mk("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = icon,
            ImageColor3 = color,
            Parent = box,
        })
        return box
    end
    local n = tostring(icon or "star"):lower()
    if D[n] then
        local ok = pcall(D[n], box, size, color)
        if ok then return box end
    end
    pcall(D["star"], box, size, color)
    return box
end

AvenUI.IconNames = (function()
    local t = {}
    for k in pairs(D) do table.insert(t, k) end
    table.sort(t)
    return t
end)()

-- ═══════════════════════════════════════════════════════════
--  NOTIFICATIONS
-- ═══════════════════════════════════════════════════════════
local notifHolder

local function ensureNotif()
    if notifHolder and notifHolder.Parent then return end
    local sg = mk("ScreenGui", {
        Name = "AvenUINotif",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = parentGui(),
    })
    notifHolder = mk("Frame", {
        Size = UDim2.new(0, 320, 1, -40),
        Position = UDim2.new(1, -336, 0, 20),
        BackgroundTransparency = 1,
        Parent = sg,
    })
    mk("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = notifHolder,
    })
end

function AvenUI:Notify(o)
    o = o or {}
    ensureNotif()
    local title   = o.Title or "Notification"
    local content = o.Content or ""
    local dur     = o.Duration or 4
    local accent  = o.Accent or Theme.Accent
    local ic      = o.Icon or "bell"

    local n = mk("Frame", {
        Size = UDim2.new(1, 0, 0, 68),
        BackgroundColor3 = Theme.BgTop,
        BorderSizePixel = 0,
        Parent = notifHolder,
    })
    cr(n, Theme.Radius)
    local stk = st(n, Theme.Border, 1)

    local bar = mk("Frame", {
        Size = UDim2.new(0, 3, 0, 36),
        Position = UDim2.new(0, 0, 0.5, -18),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = n,
    })
    cr(bar, 3)

    local ih = mk("Frame", {
        Size = UDim2.new(0, 24, 0, 24),
        Position = UDim2.new(0, 16, 0.5, -18),
        BackgroundTransparency = 1,
        Parent = n,
    })
    Icon.Create(ih, ic, 24, accent)

    mk("TextLabel", {
        Size = UDim2.new(1, -60, 0, 18),
        Position = UDim2.new(0, 48, 0, 14),
        BackgroundTransparency = 1,
        Font = Theme.FontBold,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = n,
    })
    mk("TextLabel", {
        Size = UDim2.new(1, -60, 0, 16),
        Position = UDim2.new(0, 48, 0, 34),
        BackgroundTransparency = 1,
        Font = Theme.Font,
        Text = content,
        TextColor3 = Theme.SubText,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = n,
    })

    local progBg = mk("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = Theme.BorderSoft,
        BorderSizePixel = 0,
        Parent = n,
    })
    cr(progBg, 2)
    local progFill = mk("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = progBg,
    })
    cr(progFill, 2)

    n.Position = UDim2.new(1, 30, n.Position.Y.Scale, n.Position.Y.Offset)
    tw(n, 0.32, { Position = UDim2.new(0, 0, n.Position.Y.Scale, n.Position.Y.Offset) })
    tw(progFill, dur, { Size = UDim2.new(0, 0, 1, 0) }, Enum.EasingStyle.Linear)

    task.delay(dur, function()
        if n and n.Parent then
            tw(n, 0.3, { BackgroundTransparency = 1, Position = UDim2.new(1, 30, n.Position.Y.Scale, n.Position.Y.Offset) })
            tw(stk, 0.3, { Transparency = 1 })
            for _, c in ipairs(n:GetDescendants()) do
                if c:IsA("TextLabel") then tw(c, 0.3, { TextTransparency = 1 })
                elseif c:IsA("Frame") then tw(c, 0.3, { BackgroundTransparency = 1 })
                elseif c:IsA("UIStroke") then tw(c, 0.3, { Transparency = 1 })
                end
            end
            task.wait(0.35)
            n:Destroy()
        end
    end)
end

-- ═══════════════════════════════════════════════════════════
--  WINDOW
-- ═══════════════════════════════════════════════════════════
function AvenUI:CreateWindow(o)
    o = o or {}
    local title     = o.Name or "AvenUI"
    local subtitle  = o.Subtitle or ""
    local width     = o.Width or 560
    local height    = o.Height or 400
    local ic        = o.Icon
    local toggleKey = o.ToggleKey or Enum.KeyCode.RightControl

    local self = setmetatable({ Tabs = {}, Flags = {} }, AvenUI)
    self.Name = title
    self.Width = width
    self.Height = height
    self.Minimized = false

    local sg = mk("ScreenGui", {
        Name = "AvenUI_" .. tostring(math.random(1000, 9999)),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        Parent = parentGui(),
    })
    self.ScreenGui = sg

    local main = mk("Frame", {
        Name = "Main",
        Size = UDim2.new(0, width, 0, height),
        Position = UDim2.new(0.5, -width / 2, 0.5, -height / 2),
        BackgroundColor3 = Theme.Bg,
        BorderSizePixel = 0,
        Active = true,
        Parent = sg,
    })
    cr(main, Theme.RadiusLg)
    st(main, Theme.Border, 1)
    self.Main = main

    mk("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 6),
        Size = UDim2.new(1, 50, 1, 50),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.new(0, 0, 0),
        ImageTransparency = 0.5,
        ZIndex = -1,
        Parent = main,
    })

    local top = mk("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, Theme.HeaderH),
        BackgroundColor3 = Theme.BgTop,
        BorderSizePixel = 0,
        Parent = main,
    })
    cr(top, Theme.RadiusLg)
    mk("Frame", {
        Size = UDim2.new(1, 0, 0, Theme.RadiusLg),
        Position = UDim2.new(0, 0, 1, -Theme.RadiusLg),
        BackgroundColor3 = Theme.BgTop,
        BorderSizePixel = 0,
        Parent = top,
    })
    mk("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = Theme.Border,
        BorderSizePixel = 0,
        Parent = top,
    })

    if ic then
        local iconWrap = mk("Frame", {
            Size = UDim2.new(0, 32, 0, 32),
            Position = UDim2.new(0, 22, 0.5, -16),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 0.85,
            BorderSizePixel = 0,
            Parent = top,
        })
        cr(iconWrap, 9)
        local iStroke = st(iconWrap, Theme.Accent, 1)
        iStroke.Transparency = 0.6
        local icon = Icon.Create(iconWrap, ic, 18, Theme.Accent)
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    end

    local titleX = ic and 66 or 22
    local titleLbl = mk("TextLabel", {
        Size = UDim2.new(1, -180, 0, 26),
        Position = UDim2.new(0, titleX, 0, 15),
        BackgroundTransparency = 1,
        Font = Theme.FontBlack,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = top,
    })

    local subLbl
    if subtitle ~= "" then
        subLbl = mk("TextLabel", {
            Size = UDim2.new(1, -180, 0, 16),
            Position = UDim2.new(0, titleX, 0, 42),
            BackgroundTransparency = 1,
            Font = Theme.FontMed,
            Text = subtitle,
            TextColor3 = Theme.Accent,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = top,
        })
    end

    local clock = mk("TextLabel", {
        Size = UDim2.new(0, 60, 0, 16),
        Position = UDim2.new(1, -150, 0.5, 10),
        BackgroundTransparency = 1,
        Font = Theme.FontMed,
        Text = "00:00",
        TextColor3 = Theme.Muted,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Right,
        Parent = top,
    })
    task.spawn(function()
        while clock.Parent do
            clock.Text = os.date("%H:%M")
            task.wait(15)
        end
    end)

    local minBtn = mk("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -76, 0.5, -15),
        BackgroundColor3 = Theme.Item,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = top,
    })
    cr(minBtn, 8)
    local minHolder = mk("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = minBtn })
    local mi = Icon.Create(minHolder, "minus", 13, Theme.SubText)
    mi.AnchorPoint = Vector2.new(0.5, 0.5); mi.Position = UDim2.new(0.5, 0, 0.5, 0)

    local closeBtn = mk("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 0.5, -15),
        BackgroundColor3 = Theme.Item,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        Parent = top,
    })
    cr(closeBtn, 8)
    local closeHolder = mk("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Parent = closeBtn })
    local ci = Icon.Create(closeHolder, "close", 11, Theme.SubText)
    ci.AnchorPoint = Vector2.new(0.5, 0.5); ci.Position = UDim2.new(0.5, 0, 0.5, 0)

    closeBtn.MouseEnter:Connect(function()
        tw(closeBtn, 0.15, { BackgroundColor3 = Theme.Danger })
        for _, c in ipairs(closeHolder:GetChildren()) do c:Destroy() end
        local x = Icon.Create(closeHolder, "close", 11, Color3.new(1, 1, 1))
        x.AnchorPoint = Vector2.new(0.5, 0.5); x.Position = UDim2.new(0.5, 0, 0.5, 0)
    end)
    closeBtn.MouseLeave:Connect(function()
        tw(closeBtn, 0.15, { BackgroundColor3 = Theme.Item })
        for _, c in ipairs(closeHolder:GetChildren()) do c:Destroy() end
        local x = Icon.Create(closeHolder, "close", 11, Theme.SubText)
        x.AnchorPoint = Vector2.new(0.5, 0.5); x.Position = UDim2.new(0.5, 0, 0.5, 0)
    end)
    minBtn.MouseEnter:Connect(function() tw(minBtn, 0.15, { BackgroundColor3 = Theme.ItemHover }) end)
    minBtn.MouseLeave:Connect(function() tw(minBtn, 0.15, { BackgroundColor3 = Theme.Item }) end)

    local side = mk("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, Theme.SidebarW, 1, -Theme.HeaderH - 8),
        Position = UDim2.new(0, 8, 0, Theme.HeaderH),
        BackgroundColor3 = Theme.BgSide,
        BorderSizePixel = 0,
        Parent = main,
    })
    cr(side, Theme.Radius)
    st(side, Theme.BorderSoft, 1)

    local searchWrap = mk("Frame", {
        Size = UDim2.new(1, -16, 0, 32),
        Position = UDim2.new(0, 8, 0, 8),
        BackgroundColor3 = Theme.Input,
        BorderSizePixel = 0,
        Parent = side,
    })
    cr(searchWrap, Theme.RadiusSm)
    st(searchWrap, Theme.BorderSoft, 1)
    local si = Icon.Create(searchWrap, "search", 13, Theme.Muted)
    si.Position = UDim2.new(0, 10, 0.5, -6.5)
    local searchBox = mk("TextBox", {
        Size = UDim2.new(1, -34, 1, 0),
        Position = UDim2.new(0, 30, 0, 0),
        BackgroundTransparency = 1,
        Font = Theme.Font,
        Text = "",
        PlaceholderText = "Search...",
        PlaceholderColor3 = Theme.Muted,
        TextColor3 = Theme.Text,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = searchWrap,
    })

    local tabHolder = mk("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -50),
        Position = UDim2.new(0, 0, 0, 46),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = side,
    })
    mk("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 3),
        Parent = tabHolder,
    })
    pd(tabHolder, 0, 8, 12, 8)

    local content = mk("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -Theme.SidebarW - 24, 1, -Theme.HeaderH - 8),
        Position = UDim2.new(0, Theme.SidebarW + 16, 0, Theme.HeaderH),
        BackgroundTransparency = 1,
        Parent = main,
    })
    self.Sidebar = side
    self.Content = content
    self.TabHolder = tabHolder

    drag(main, top)

    minBtn.MouseButton1Click:Connect(function()
        self.Minimized = not self.Minimized
        local target
        if self.Minimized then
            target = UDim2.new(0, width, 0, Theme.HeaderH)
            side.Visible = false
            content.Visible = false
            for _, c in ipairs(minHolder:GetChildren()) do c:Destroy() end
            local e = Icon.Create(minHolder, "plus", 13, Theme.Accent)
            e.AnchorPoint = Vector2.new(0.5, 0.5); e.Position = UDim2.new(0.5, 0, 0.5, 0)
        else
            target = UDim2.new(0, width, 0, height)
            side.Visible = true
            content.Visible = true
            for _, c in ipairs(minHolder:GetChildren()) do c:Destroy() end
            local e = Icon.Create(minHolder, "minus", 13, Theme.SubText)
            e.AnchorPoint = Vector2.new(0.5, 0.5); e.Position = UDim2.new(0.5, 0, 0.5, 0)
        end
        tw(main, 0.3, { Size = target }, Enum.EasingStyle.Quint)
    end)

    closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

    UserInput.InputBegan:Connect(function(i, p)
        if p then return end
        if i.KeyCode == toggleKey then main.Visible = not main.Visible end
    end)

    self.Destroy = function() sg:Destroy() end
    self.SetTitle = function(t) titleLbl.Text = t end
    self.SetSubtitle = function(t) if subLbl then subLbl.Text = t end end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = searchBox.Text:lower()
        for _, t in ipairs(self.Tabs) do
            t.Button.Visible = q == "" or t.Name:lower():find(q, 1, true) ~= nil
        end
    end)

    -- ─── Tab ────────────────────────────────────────────────
    function self:CreateTab(name, ic)
        local tab = {}
        tab.Name = name

        local btn = mk("TextButton", {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Theme.Item,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Text = "",
            AutoButtonColor = false,
            LayoutOrder = #self.Tabs + 1,
            Parent = tabHolder,
        })
        cr(btn, Theme.RadiusSm)
        local bStroke = st(btn, Theme.Border, 1)
        bStroke.Transparency = 1

        local accent = mk("Frame", {
            Size = UDim2.new(0, 3, 0, 18),
            Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Parent = btn,
        })
        cr(accent, 3)
        accent.BackgroundTransparency = 1

        local iHolder = mk("Frame", {
            Size = UDim2.new(0, 16, 0, 16),
            Position = UDim2.new(0, 14, 0.5, -8),
            BackgroundTransparency = 1,
            Parent = btn,
        })
        Icon.Create(iHolder, ic or "star", 16, Theme.SubText)

        local label = mk("TextLabel", {
            Size = UDim2.new(1, -48, 1, 0),
            Position = UDim2.new(0, 38, 0, 0),
            BackgroundTransparency = 1,
            Font = Theme.FontMed,
            Text = name,
            TextColor3 = Theme.SubText,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = btn,
        })

        local container = mk("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Border,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = content,
        })
        mk("UIListLayout", {
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 6),
            Parent = container,
        })
        pd(container, 4, 4, 24, 4)

        tab.Button = btn
        tab.Container = container
        tab.Label = label
        tab.Stroke = bStroke
        tab.Accent = accent
        tab.IconHolder = iHolder
        tab.IconName = ic or "star"

        local function select()
            for _, t in ipairs(self.Tabs) do
                t.Button.BackgroundTransparency = 1
                t.Stroke.Transparency = 1
                t.Accent.BackgroundTransparency = 1
                t.Container.Visible = false
                tw(t.Label, 0.15, { TextColor3 = Theme.SubText })
                for _, c in ipairs(t.IconHolder:GetChildren()) do c:Destroy() end
                Icon.Create(t.IconHolder, t.IconName, 16, Theme.SubText)
            end
            tw(btn, 0.15, { BackgroundTransparency = 0.88, BackgroundColor3 = Theme.Accent })
            bStroke.Transparency = 0
            bStroke.Color = Theme.Accent
            accent.BackgroundTransparency = 0
            tw(label, 0.15, { TextColor3 = Theme.Accent })
            for _, c in ipairs(iHolder:GetChildren()) do c:Destroy() end
            Icon.Create(iHolder, ic or "star", 16, Theme.Accent)
            container.Visible = true
            self.ActiveTab = tab
        end

        btn.MouseButton1Click:Connect(select)
        table.insert(self.Tabs, tab)
        if #self.Tabs == 1 then task.defer(select) end

        -- Section
        function tab:Section(txt, ic)
            local wrap = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 26),
                BackgroundTransparency = 1,
                Parent = container,
            })
            local x = 12
            if ic then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 2, 0.5, -7),
                    BackgroundTransparency = 1,
                    Parent = wrap,
                })
                Icon.Create(h, ic, 14, Theme.Accent)
                x = 22
            else
                mk("Frame", {
                    Size = UDim2.new(0, 3, 0, 14),
                    Position = UDim2.new(0, 2, 0.5, -7),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = wrap,
                })
            end
            mk("TextLabel", {
                Size = UDim2.new(1, -x, 1, 0),
                Position = UDim2.new(0, x, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = txt:upper(),
                TextColor3 = Theme.Muted,
                TextSize = 10.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = wrap,
            })
        end

        -- Toggle
        function tab:Toggle(o)
            o = o or {}
            local state = o.CurrentValue or false
            local flag = o.Flag
            if flag then self.Flags[flag] = { type = "toggle", value = state } end

            local row = mk("TextButton", {
                Size = UDim2.new(1, -8, 0, 40),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            local stk = st(row, Theme.BorderSoft, 1)

            local tx = 14
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 13, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, Theme.SubText)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 56, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = o.Name or "Toggle",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local sw = mk("Frame", {
                Size = UDim2.new(0, 34, 0, 18),
                Position = UDim2.new(1, -46, 0.5, -9),
                BackgroundColor3 = Theme.Track,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(sw, 100)

            local knob = mk("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(0, 2, 0.5, -7),
                BackgroundColor3 = Theme.SubText,
                BorderSizePixel = 0,
                Parent = sw,
            })
            cr(knob, 100)

            local function render()
                if state then
                    tw(knob, 0.22, { Position = UDim2.new(1, -16, 0.5, -7), BackgroundColor3 = Color3.new(1, 1, 1) }, Enum.EasingStyle.Back)
                    tw(sw, 0.2, { BackgroundColor3 = Theme.Accent })
                    tw(stk, 0.15, { Color = Theme.Accent, Transparency = 0.6 })
                else
                    tw(knob, 0.22, { Position = UDim2.new(0, 2, 0.5, -7), BackgroundColor3 = Theme.SubText }, Enum.EasingStyle.Back)
                    tw(sw, 0.2, { BackgroundColor3 = Theme.Track })
                    tw(stk, 0.15, { Color = Theme.BorderSoft, Transparency = 0 })
                end
            end

            row.MouseEnter:Connect(function()
                if not state then tw(row, 0.15, { BackgroundColor3 = Theme.ItemHover }) end
            end)
            row.MouseLeave:Connect(function()
                if not state then tw(row, 0.15, { BackgroundColor3 = Theme.Item }) end
            end)
            row.MouseButton1Click:Connect(function()
                state = not state
                render()
                if flag then self.Flags[flag].value = state end
                task.spawn(o.Callback or function() end, state)
            end)
            render()

            return {
                Set = function(v) state = v; render(); if flag then self.Flags[flag].value = v end; task.spawn(o.Callback or function() end, v) end,
                Get = function() return state end,
            }
        end

        -- Slider
        function tab:Slider(o)
            o = o or {}
            local mn = (o.Range and o.Range[1]) or 0
            local mx = (o.Range and o.Range[2]) or 100
            local inc = o.Increment or 1
            local val = o.CurrentValue or mn
            local sfx = o.Suffix or ""
            local flag = o.Flag

            local row = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 54),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 13, 0, 12),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, Theme.SubText)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 90, 0, 18),
                Position = UDim2.new(0, tx, 0, 9),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = o.Name or "Slider",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local valBubble = mk("Frame", {
                Size = UDim2.new(0, 62, 0, 22),
                Position = UDim2.new(1, -76, 0, 8),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(valBubble, 6)
            local valLbl = mk("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = tostring(val) .. sfx,
                TextColor3 = Color3.fromRGB(10, 11, 13),
                TextSize = 11,
                Parent = valBubble,
            })

            local track = mk("Frame", {
                Size = UDim2.new(1, -28, 0, 6),
                Position = UDim2.new(0, 14, 0, 36),
                BackgroundColor3 = Theme.Track,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(track, 100)

            local fill = mk("Frame", {
                Size = UDim2.new((val - mn) / (mx - mn), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
                Parent = track,
            })
            cr(fill, 100)

            local knob = mk("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new((val - mn) / (mx - mn), -7, 0.5, -7),
                BackgroundColor3 = Color3.new(1, 1, 1),
                BorderSizePixel = 0,
                Parent = track,
            })
            cr(knob, 100)
            mk("UIStroke", { Color = Theme.Accent, Thickness = 2, Parent = knob })

            local dragging = false
            track.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tw(knob, 0.15, { Size = UDim2.new(0, 18, 0, 18) }, Enum.EasingStyle.Back)
                    knob.Position = UDim2.new(knob.Position.X.Scale, -9, 0.5, -9)
                end
            end)
            UserInput.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        tw(knob, 0.15, { Size = UDim2.new(0, 14, 0, 14) }, Enum.EasingStyle.Back)
                        knob.Position = UDim2.new(knob.Position.X.Scale, -7, 0.5, -7)
                    end
                end
            end)
            UserInput.InputChanged:Connect(function(i)
                if not dragging then return end
                if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then return end
                local rel = math.clamp((i.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local nv = mn + round(rel * (mx - mn), inc)
                nv = math.clamp(nv, mn, mx)
                if nv == val then return end
                val = nv
                fill.Size = UDim2.new(rel, 0, 1, 0)
                knob.Position = UDim2.new(rel, -9, 0.5, -9)
                valLbl.Text = tostring(val) .. sfx
                if flag then self.Flags[flag].value = val end
                task.spawn(o.Callback or function() end, val)
            end)

            return {
                Set = function(v)
                    val = math.clamp(v, mn, mx)
                    local rel = (val - mn) / (mx - mn)
                    fill.Size = UDim2.new(rel, 0, 1, 0)
                    knob.Position = UDim2.new(rel, -7, 0.5, -7)
                    valLbl.Text = tostring(val) .. sfx
                    if flag then self.Flags[flag].value = val end
                    task.spawn(o.Callback or function() end, val)
                end,
                Get = function() return val end,
            }
        end

        -- Button
        function tab:Button(o)
            o = o or {}
            local danger = o.Danger or false
            local bg = danger and Theme.Danger or Theme.Accent
            local txtCol = danger and Color3.new(1, 1, 1) or Color3.fromRGB(10, 11, 13)

            local row = mk("TextButton", {
                Size = UDim2.new(1, -8, 0, 38),
                BackgroundColor3 = bg,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)

            local tx = 0
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, txtCol)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = o.Name or "Button",
                TextColor3 = txtCol,
                TextSize = 12,
                Parent = row,
            })

            row.MouseEnter:Connect(function()
                tw(row, 0.15, { BackgroundColor3 = danger and Color3.fromRGB(220, 38, 38) or Theme.AccentDim })
            end)
            row.MouseLeave:Connect(function()
                tw(row, 0.15, { BackgroundColor3 = bg })
            end)
            row.MouseButton1Click:Connect(function()
                task.spawn(o.Callback or function() end)
            end)
        end

        -- Input
        function tab:Input(o)
            o = o or {}
            local row = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 56),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 13, 0, 11),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, Theme.SubText)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 20, 0, 16),
                Position = UDim2.new(0, tx, 0, 8),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = o.Name or "Input",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local box = mk("TextBox", {
                Size = UDim2.new(1, -24, 0, 24),
                Position = UDim2.new(0, 12, 0, 28),
                BackgroundColor3 = Theme.Input,
                BorderSizePixel = 0,
                Font = Theme.Font,
                Text = o.CurrentValue or "",
                PlaceholderText = o.Placeholder or "Type here...",
                TextColor3 = Theme.Text,
                PlaceholderColor3 = Theme.Muted,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                Parent = row,
            })
            cr(box, 6)
            st(box, Theme.BorderSoft, 1)
            pd(box, 0, 10, 0, 10)

            box.FocusLost:Connect(function()
                task.spawn(o.Callback or function() end, box.Text)
            end)
            box.Focused:Connect(function()
                tw(box, 0.15, { BackgroundColor3 = Theme.BgTop })
            end)

            return {
                Set = function(v) box.Text = v end,
                Get = function() return box.Text end,
            }
        end

        -- Dropdown
        function tab:Dropdown(o)
            o = o or {}
            local opts = o.Options or {}
            local cur = o.CurrentOption or (opts[1] or "")

            local wrap = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 40),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = container,
            })

            local row = mk("TextButton", {
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = wrap,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 13, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, Theme.SubText)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 100, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = o.Name or "Dropdown",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local valLbl = mk("TextLabel", {
                Size = UDim2.new(0, 84, 1, 0),
                Position = UDim2.new(1, -102, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = tostring(cur),
                TextColor3 = Theme.Accent,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = row,
            })

            local chev = mk("Frame", {
                Size = UDim2.new(0, 10, 0, 10),
                Position = UDim2.new(1, -22, 0.5, -5),
                BackgroundTransparency = 1,
                Parent = row,
            })
            local chevIcon = Icon.Create(chev, "chevron-down", 10, Theme.SubText)

            local list = mk("Frame", {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = Theme.BgTop,
                BorderSizePixel = 0,
                ClipsDescendants = true,
                Visible = false,
                Parent = wrap,
            })
            cr(list, Theme.RadiusSm)
            st(list, Theme.BorderSoft, 1)
            mk("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2), Parent = list })
            pd(list, 4)

            for _, opt in ipairs(opts) do
                local ob = mk("TextButton", {
                    Size = UDim2.new(1, -8, 0, 28),
                    BackgroundColor3 = Theme.Item,
                    BorderSizePixel = 0,
                    Font = Theme.Font,
                    Text = tostring(opt),
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    AutoButtonColor = false,
                    Parent = list,
                })
                cr(ob, 6)
                ob.MouseEnter:Connect(function() tw(ob, 0.1, { BackgroundColor3 = Theme.ItemHover }) end)
                ob.MouseLeave:Connect(function() tw(ob, 0.1, { BackgroundColor3 = Theme.Item }) end)
                ob.MouseButton1Click:Connect(function()
                    cur = opt
                    valLbl.Text = tostring(opt)
                    list.Visible = false
                    list.Size = UDim2.new(1, 0, 0, 0)
                    for _, c in ipairs(chev:GetChildren()) do c:Destroy() end
                    local ci2 = Icon.Create(chev, "chevron-down", 10, Theme.SubText)
                    ci2.AnchorPoint = Vector2.new(0.5, 0.5); ci2.Position = UDim2.new(0.5, 0, 0.5, 0)
                    task.spawn(o.Callback or function() end, opt)
                end)
            end

            local exp = false
            row.MouseButton1Click:Connect(function()
                exp = not exp
                list.Visible = exp
                local th = (#opts * 30) + 8
                tw(list, 0.22, { Size = UDim2.new(1, 0, 0, exp and th or 0) })
                for _, c in ipairs(chev:GetChildren()) do c:Destroy() end
                local ci2 = Icon.Create(chev, exp and "chevron-up" or "chevron-down", 10, Theme.SubText)
                ci2.AnchorPoint = Vector2.new(0.5, 0.5); ci2.Position = UDim2.new(0.5, 0, 0.5, 0)
            end)

            return {
                Set = function(v) cur = v; valLbl.Text = tostring(v) end,
                Get = function() return cur end,
            }
        end

        -- Keybind
        function tab:Keybind(o)
            o = o or {}
            local cur = o.CurrentKeybind or Enum.KeyCode.E
            local listening = false

            local row = mk("TextButton", {
                Size = UDim2.new(1, -8, 0, 40),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if o.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 13, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, o.Icon, 16, Theme.SubText)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 90, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = o.Name or "Keybind",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local keyBox = mk("Frame", {
                Size = UDim2.new(0, 72, 0, 24),
                Position = UDim2.new(1, -84, 0.5, -12),
                BackgroundColor3 = Theme.Input,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(keyBox, 6)
            st(keyBox, Theme.BorderSoft, 1)

            local keyLbl = mk("TextLabel", {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = cur.Name,
                TextColor3 = Theme.Accent,
                TextSize = 11,
                Parent = keyBox,
            })

            row.MouseButton1Click:Connect(function()
                listening = true
                keyLbl.Text = "press..."
                keyLbl.TextColor3 = Theme.SubText
                tw(keyBox, 0.15, { BackgroundColor3 = Theme.BgTop })
            end)

            UserInput.InputBegan:Connect(function(i, p)
                if not listening then return end
                if p then return end
                if i.UserInputType == Enum.UserInputType.Keyboard then
                    cur = i.KeyCode
                    keyLbl.Text = cur.Name
                    keyLbl.TextColor3 = Theme.Accent
                    listening = false
                    task.spawn(o.Callback or function() end, cur)
                end
            end)

            return { Get = function() return cur end }
        end

        -- Label
        function tab:Label(o)
            o = o or {}
            local wrap = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = container,
            })
            local lbl = mk("TextLabel", {
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.Font,
                Text = o.Text or "",
                TextColor3 = Theme.SubText,
                TextSize = 11,
                TextWrapped = true,
                TextXAlignment = Enum.TextXAlignment.Left,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = wrap,
            })
            pd(lbl, 4, 4, 4, 4)
        end

        -- Divider
        function tab:Divider(txt)
            if txt then
                local wrap = mk("Frame", {
                    Size = UDim2.new(1, -8, 0, 20),
                    BackgroundTransparency = 1,
                    Parent = container,
                })
                mk("Frame", {
                    Size = UDim2.new(0.42, -6, 0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    BackgroundColor3 = Theme.BorderSoft,
                    BorderSizePixel = 0,
                    Parent = wrap,
                })
                mk("TextLabel", {
                    Size = UDim2.new(0.16, 0, 1, 0),
                    Position = UDim2.new(0.42, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Font = Theme.FontMed,
                    Text = txt:upper(),
                    TextColor3 = Theme.Muted,
                    TextSize = 9,
                    Parent = wrap,
                })
                mk("Frame", {
                    Size = UDim2.new(0.42, -6, 0, 1),
                    Position = UDim2.new(0.58, 6, 0.5, 0),
                    BackgroundColor3 = Theme.BorderSoft,
                    BorderSizePixel = 0,
                    Parent = wrap,
                })
            else
                mk("Frame", {
                    Size = UDim2.new(1, -8, 0, 1),
                    BackgroundColor3 = Theme.BorderSoft,
                    BorderSizePixel = 0,
                    Parent = container,
                })
            end
        end

        return tab
    end

    return self
end

return AvenUI
