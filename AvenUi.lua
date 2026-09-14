--[[
    AvenUI v2.1
    Author  : Gixss
    Discord : https://discord.gg/q7PZBsbpD
    Fixes   : flag init, icon stroke, error isolation
]]

local AvenUI = {}
AvenUI.__index = AvenUI
AvenUI.Version = "2.1.0"

local Players      = game:GetService("Players")
local UserInput    = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService  = game:GetService("HttpService")
local LP           = Players.LocalPlayer

local FOLDER = "Aven UI"
AvenUI.Folder = FOLDER

local function hasFileAPI()
    return (type(makefolder) == "function") and (type(writefile) == "function")
end

if hasFileAPI() then
    pcall(function()
        if type(isfolder) == "function" and not isfolder(FOLDER) then
            makefolder(FOLDER)
        end
    end)
end

function AvenUI:SaveFile(name, content)
    if not hasFileAPI() then return false end
    return pcall(function() writefile(FOLDER .. "/" .. name, content) end)
end

function AvenUI:LoadFile(name)
    if not hasFileAPI() then return nil end
    local ok, c = pcall(function()
        if type(isfile) == "function" and isfile(FOLDER .. "/" .. name) then
            return readfile(FOLDER .. "/" .. name)
        end
        return nil
    end)
    return ok and c or nil
end

function AvenUI:ListFiles()
    if not hasFileAPI() or type(listfiles) ~= "function" then return {} end
    local ok, f = pcall(function() return listfiles(FOLDER) end)
    return (ok and f) or {}
end

-- ═══ THEME ═══
local Theme = {
    Bg          = Color3.fromRGB(10, 11, 14),
    BgTop       = Color3.fromRGB(15, 16, 20),
    BgSide      = Color3.fromRGB(12, 13, 17),
    Item        = Color3.fromRGB(19, 20, 25),
    ItemHover   = Color3.fromRGB(25, 27, 33),
    Input       = Color3.fromRGB(13, 14, 18),
    Track       = Color3.fromRGB(32, 35, 42),
    Border      = Color3.fromRGB(28, 31, 38),
    BorderSoft  = Color3.fromRGB(22, 24, 30),
    BorderFocus = Color3.fromRGB(132, 204, 22),
    Text        = Color3.fromRGB(237, 239, 243),
    SubText     = Color3.fromRGB(155, 162, 174),
    Muted       = Color3.fromRGB(78, 84, 96),
    Accent      = Color3.fromRGB(132, 204, 22),
    AccentDim   = Color3.fromRGB(101, 163, 13),
    AccentText  = Color3.fromRGB(10, 11, 14),
    Danger      = Color3.fromRGB(239, 68, 68),
    Font        = Enum.Font.Gotham,
    FontBold    = Enum.Font.GothamBold,
    FontMed     = Enum.Font.GothamMedium,
    FontBlack   = Enum.Font.GothamBlack,
    Radius      = 8,
    RadiusSm    = 6,
    RadiusLg    = 12,
    HeaderH     = 62,
    SidebarW    = 172,
}
AvenUI.Theme = Theme

function AvenUI:SetTheme(t)
    if type(t) ~= "table" then return end
    for k, v in pairs(t) do if Theme[k] ~= nil then Theme[k] = v end end
end
function AvenUI:GetTheme() return Theme end
function AvenUI:SetAccent(c)
    Theme.Accent = c
    Theme.AccentDim = Color3.new(c.R * 0.76, c.G * 0.80, c.B * 0.59)
    Theme.BorderFocus = c
end

-- ═══ HELPERS ═══
local function mk(c, p)
    local o = Instance.new(c)
    for k, v in pairs(p or {}) do
        pcall(function() o[k] = v end)
    end
    return o
end
local function cr(o, r) return mk("UICorner", { CornerRadius = UDim.new(0, r or Theme.Radius), Parent = o }) end
local function st(o, col, th) return mk("UIStroke", { Color = col or Theme.Border, Thickness = th or 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = o }) end
local function pd(o, t, r, b, l) return mk("UIPadding", { PaddingTop = UDim.new(0, t or 0), PaddingRight = UDim.new(0, r or t or 0), PaddingBottom = UDim.new(0, b or t or 0), PaddingLeft = UDim.new(0, l or r or t or 0), Parent = o }) end
local function tw(o, ti, props, style, dir)
    pcall(function()
        TweenService:Create(o, TweenInfo.new(ti or 0.22, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out), props):Play()
    end)
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
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dr = false end end)
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

-- ═══ ICONS — thicker lines, visible at small sizes ═══
local Icon = {}
AvenUI.Icon = Icon

local function ln(p, x1, y1, x2, y2, c, w)
    w = math.max(w or 2, 1.6)
    local dx, dy = x2 - x1, y2 - y1
    local len = math.sqrt(dx * dx + dy * dy)
    local angle = math.deg(math.atan2(dy, dx))
    local f = mk("Frame", {
        Position = UDim2.new(0, x1, 0, y1),
        Size = UDim2.new(0, len, 0, w),
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = c,
        BorderSizePixel = 0,
        Rotation = angle,
        Parent = p,
    })
    cr(f, w * 0.5)
    return f
end

local function circ(p, cx, cy, r, c, filled)
    local f = mk("Frame", {
        Position = UDim2.new(0, cx - r, 0, cy - r),
        Size = UDim2.new(0, r * 2, 0, r * 2),
        BackgroundColor3 = c,
        BackgroundTransparency = filled and 0 or 1,
        BorderSizePixel = 0,
        Parent = p,
    })
    cr(f, r * 2)
    if not filled then st(f, c, math.max(1.6, r * 0.25)) end
    return f
end

local function rect(p, x, y, w, h, r, c, filled)
    local f = mk("Frame", {
        Position = UDim2.new(0, x, 0, y),
        Size = UDim2.new(0, w, 0, h),
        BackgroundColor3 = c,
        BackgroundTransparency = filled and 0 or 1,
        BorderSizePixel = 0,
        Parent = p,
    })
    if r then cr(f, r) end
    if not filled then st(f, c, 1.8) end
    return f
end

local D = {}

D["home"] = function(p, s, c)
    local k = s / 24
    ln(p, 3*k, 11*k, 12*k, 3*k, c, 2*k)
    ln(p, 12*k, 3*k, 21*k, 11*k, c, 2*k)
    rect(p, 6*k, 11*k, 12*k, 10*k, 1.5*k, c)
end
D["house"] = D["home"]

D["menu"] = function(p, s, c)
    local k = s / 24
    ln(p, 4*k, 7*k, 20*k, 7*k, c, 2*k)
    ln(p, 4*k, 12*k, 20*k, 12*k, c, 2*k)
    ln(p, 4*k, 17*k, 20*k, 17*k, c, 2*k)
end
D["list"] = D["menu"]

D["grid"] = function(p, s, c)
    local k = s / 24
    rect(p, 5*k, 5*k, 5*k, 5*k, 1*k, c, true)
    rect(p, 14*k, 5*k, 5*k, 5*k, 1*k, c, true)
    rect(p, 5*k, 14*k, 5*k, 5*k, 1*k, c, true)
    rect(p, 14*k, 14*k, 5*k, 5*k, 1*k, c, true)
end

D["chevron-down"] = function(p, s, c)
    local k = s / 24
    ln(p, 7*k, 10*k, 12*k, 15*k, c, 2*k)
    ln(p, 12*k, 15*k, 17*k, 10*k, c, 2*k)
end
D["arrow-down"] = D["chevron-down"]

D["chevron-up"] = function(p, s, c)
    local k = s / 24
    ln(p, 7*k, 14*k, 12*k, 9*k, c, 2*k)
    ln(p, 12*k, 9*k, 17*k, 14*k, c, 2*k)
end
D["arrow-up"] = D["chevron-up"]

D["chevron-right"] = function(p, s, c)
    local k = s / 24
    ln(p, 10*k, 7*k, 15*k, 12*k, c, 2*k)
    ln(p, 15*k, 12*k, 10*k, 17*k, c, 2*k)
end
D["arrow-right"] = D["chevron-right"]

D["chevron-left"] = function(p, s, c)
    local k = s / 24
    ln(p, 14*k, 7*k, 9*k, 12*k, c, 2*k)
    ln(p, 9*k, 12*k, 14*k, 17*k, c, 2*k)
end
D["arrow-left"] = D["chevron-left"]

D["plus"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 5*k, 12*k, 19*k, c, 2*k)
    ln(p, 5*k, 12*k, 19*k, 12*k, c, 2*k)
end
D["add"] = D["plus"]

D["minus"] = function(p, s, c)
    local k = s / 24
    ln(p, 5*k, 12*k, 19*k, 12*k, c, 2*k)
end
D["remove"] = D["minus"]

D["close"] = function(p, s, c)
    local k = s / 24
    ln(p, 7*k, 7*k, 17*k, 17*k, c, 2*k)
    ln(p, 17*k, 7*k, 7*k, 17*k, c, 2*k)
end
D["x"] = D["close"]; D["exit"] = D["close"]

D["check"] = function(p, s, c)
    local k = s / 24
    ln(p, 5*k, 12*k, 10*k, 17*k, c, 2.2*k)
    ln(p, 10*k, 17*k, 19*k, 7*k, c, 2.2*k)
end
D["tick"] = D["check"]

D["search"] = function(p, s, c)
    local k = s / 24
    circ(p, 10*k, 10*k, 6*k, c, false)
    ln(p, 15*k, 15*k, 20*k, 20*k, c, 2*k)
end

D["refresh"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 8*k, c, false)
    ln(p, 13*k, 4*k, 18*k, 4*k, c, 2*k)
    ln(p, 18*k, 4*k, 18*k, 9*k, c, 2*k)
end
D["reload"] = D["refresh"]

D["user"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 8*k, 4*k, c, false)
    ln(p, 4*k, 20*k, 4*k, 18*k, c, 2*k)
    ln(p, 4*k, 18*k, 6*k, 16*k, c, 2*k)
    ln(p, 6*k, 16*k, 18*k, 16*k, c, 2*k)
    ln(p, 18*k, 16*k, 20*k, 18*k, c, 2*k)
    ln(p, 20*k, 18*k, 20*k, 20*k, c, 2*k)
end
D["profile"] = D["user"]

D["settings"] = function(p, s, c)
    local k = s / 24
    for i = 0, 7 do
        local a = math.rad(i * 45)
        local x1 = 12 + math.cos(a) * 6
        local y1 = 12 + math.sin(a) * 6
        local x2 = 12 + math.cos(a) * 10
        local y2 = 12 + math.sin(a) * 10
        ln(p, x1*k, y1*k, x2*k, y2*k, c, 2*k)
    end
    circ(p, 12*k, 12*k, 7*k, c, false)
    circ(p, 12*k, 12*k, 3*k, c, false)
end
D["gear"] = D["settings"]; D["cog"] = D["settings"]

D["bell"] = function(p, s, c)
    local k = s / 24
    ln(p, 7*k, 16*k, 7*k, 11*k, c, 2*k)
    ln(p, 7*k, 11*k, 9*k, 8*k, c, 2*k)
    ln(p, 9*k, 8*k, 12*k, 6*k, c, 2*k)
    ln(p, 12*k, 6*k, 15*k, 8*k, c, 2*k)
    ln(p, 15*k, 8*k, 17*k, 11*k, c, 2*k)
    ln(p, 17*k, 11*k, 17*k, 16*k, c, 2*k)
    ln(p, 5*k, 16*k, 19*k, 16*k, c, 2*k)
    ln(p, 10*k, 19*k, 14*k, 19*k, c, 2*k)
end
D["notif"] = D["bell"]; D["notification"] = D["bell"]

D["lock"] = function(p, s, c)
    local k = s / 24
    ln(p, 8*k, 11*k, 8*k, 8*k, c, 2*k)
    ln(p, 8*k, 8*k, 12*k, 5*k, c, 2*k)
    ln(p, 12*k, 5*k, 16*k, 8*k, c, 2*k)
    ln(p, 16*k, 8*k, 16*k, 11*k, c, 2*k)
    rect(p, 6*k, 11*k, 12*k, 9*k, 1.5*k, c)
end

D["shield"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 4*k, 20*k, 7*k, c, 2*k)
    ln(p, 20*k, 7*k, 20*k, 12*k, c, 2*k)
    ln(p, 20*k, 12*k, 12*k, 20*k, c, 2*k)
    ln(p, 12*k, 20*k, 4*k, 12*k, c, 2*k)
    ln(p, 4*k, 12*k, 4*k, 7*k, c, 2*k)
    ln(p, 4*k, 7*k, 12*k, 4*k, c, 2*k)
end
D["protect"] = D["shield"]

D["star"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 3*k, 14*k, 10*k, c, 1.8*k)
    ln(p, 14*k, 10*k, 21*k, 10*k, c, 1.8*k)
    ln(p, 21*k, 10*k, 16*k, 14*k, c, 1.8*k)
    ln(p, 16*k, 14*k, 18*k, 21*k, c, 1.8*k)
    ln(p, 18*k, 21*k, 12*k, 17*k, c, 1.8*k)
    ln(p, 12*k, 17*k, 6*k, 21*k, c, 1.8*k)
    ln(p, 6*k, 21*k, 8*k, 14*k, c, 1.8*k)
    ln(p, 8*k, 14*k, 3*k, 10*k, c, 1.8*k)
    ln(p, 3*k, 10*k, 10*k, 10*k, c, 1.8*k)
    ln(p, 10*k, 10*k, 12*k, 3*k, c, 1.8*k)
end
D["favorite"] = D["star"]

D["sparkle"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 3*k, 12*k, 21*k, c, 2*k)
    ln(p, 3*k, 12*k, 21*k, 12*k, c, 2*k)
end

D["heart"] = function(p, s, c)
    local k = s / 24
    circ(p, 8*k, 9*k, 3*k, c, true)
    circ(p, 16*k, 9*k, 3*k, c, true)
    local t = mk("Frame", {
        Position = UDim2.new(0, 5*k, 0, 9*k),
        Size = UDim2.new(0, 14*k, 0, 14*k),
        BackgroundColor3 = c,
        BorderSizePixel = 0,
        Rotation = 45,
        Parent = p,
    })
    cr(t, 2*k)
end
D["like"] = D["heart"]

D["info"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 9*k, c, false)
    circ(p, 12*k, 8*k, 1.2*k, c, true)
    ln(p, 12*k, 11*k, 12*k, 17*k, c, 2*k)
end
D["about"] = D["info"]

D["warning"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 4*k, 21*k, 20*k, c, 2*k)
    ln(p, 21*k, 20*k, 3*k, 20*k, c, 2*k)
    ln(p, 3*k, 20*k, 12*k, 4*k, c, 2*k)
    ln(p, 12*k, 10*k, 12*k, 15*k, c, 2*k)
    circ(p, 12*k, 18*k, 1.1*k, c, true)
end
D["alert"] = D["warning"]

D["eye"] = function(p, s, c)
    local k = s / 24
    ln(p, 3*k, 12*k, 8*k, 6*k, c, 1.8*k)
    ln(p, 8*k, 6*k, 16*k, 6*k, c, 1.8*k)
    ln(p, 16*k, 6*k, 21*k, 12*k, c, 1.8*k)
    ln(p, 21*k, 12*k, 16*k, 18*k, c, 1.8*k)
    ln(p, 16*k, 18*k, 8*k, 18*k, c, 1.8*k)
    ln(p, 8*k, 18*k, 3*k, 12*k, c, 1.8*k)
    circ(p, 12*k, 12*k, 3*k, c, false)
end
D["view"] = D["eye"]

D["code"] = function(p, s, c)
    local k = s / 24
    ln(p, 8*k, 6*k, 3*k, 12*k, c, 2*k)
    ln(p, 3*k, 12*k, 8*k, 18*k, c, 2*k)
    ln(p, 16*k, 6*k, 21*k, 12*k, c, 2*k)
    ln(p, 21*k, 12*k, 16*k, 18*k, c, 2*k)
end
D["dev"] = D["code"]; D["script"] = D["code"]

D["bolt"] = function(p, s, c)
    local k = s / 24
    ln(p, 14*k, 3*k, 6*k, 13*k, c, 2*k)
    ln(p, 6*k, 13*k, 12*k, 13*k, c, 2*k)
    ln(p, 12*k, 13*k, 10*k, 21*k, c, 2*k)
    ln(p, 10*k, 21*k, 18*k, 11*k, c, 2*k)
    ln(p, 18*k, 11*k, 12*k, 11*k, c, 2*k)
    ln(p, 12*k, 11*k, 14*k, 3*k, c, 2*k)
end
D["power"] = D["bolt"]; D["zap"] = D["bolt"]; D["lightning"] = D["bolt"]

D["sun"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 5*k, c, false)
    for i = 0, 7 do
        local a = math.rad(i * 45)
        local x1 = 12 + math.cos(a) * 8
        local y1 = 12 + math.sin(a) * 8
        local x2 = 12 + math.cos(a) * 10
        local y2 = 12 + math.sin(a) * 10
        ln(p, x1*k, y1*k, x2*k, y2*k, c, 1.8*k)
    end
end

D["moon"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 8*k, c, false)
    local cut = mk("Frame", {
        Position = UDim2.new(0, 14*k, 0, 10*k),
        Size = UDim2.new(0, 12*k, 0, 12*k),
        BackgroundColor3 = Theme.Bg,
        BorderSizePixel = 0,
        Parent = p,
    })
    cr(cut, 100)
end

D["key"] = function(p, s, c)
    local k = s / 24
    circ(p, 8*k, 12*k, 4*k, c, false)
    ln(p, 12*k, 12*k, 20*k, 12*k, c, 2*k)
    ln(p, 18*k, 12*k, 18*k, 15*k, c, 2*k)
end

D["link"] = function(p, s, c)
    local k = s / 24
    circ(p, 9*k, 9*k, 3*k, c, false)
    circ(p, 15*k, 15*k, 3*k, c, false)
    ln(p, 11*k, 11*k, 13*k, 13*k, c, 2*k)
end

D["folder"] = function(p, s, c)
    local k = s / 24
    ln(p, 4*k, 19*k, 4*k, 6*k, c, 2*k)
    ln(p, 4*k, 6*k, 10*k, 6*k, c, 2*k)
    ln(p, 10*k, 6*k, 11*k, 9*k, c, 2*k)
    ln(p, 11*k, 9*k, 20*k, 9*k, c, 2*k)
    ln(p, 20*k, 9*k, 20*k, 19*k, c, 2*k)
    ln(p, 20*k, 19*k, 4*k, 19*k, c, 2*k)
end

D["file"] = function(p, s, c)
    local k = s / 24
    ln(p, 6*k, 20*k, 6*k, 4*k, c, 2*k)
    ln(p, 6*k, 4*k, 14*k, 4*k, c, 2*k)
    ln(p, 14*k, 4*k, 20*k, 10*k, c, 2*k)
    ln(p, 20*k, 10*k, 20*k, 20*k, c, 2*k)
    ln(p, 20*k, 20*k, 6*k, 20*k, c, 2*k)
end

D["copy"] = function(p, s, c)
    local k = s / 24
    rect(p, 8*k, 8*k, 12*k, 12*k, 1.5*k, c)
    rect(p, 4*k, 4*k, 12*k, 12*k, 1.5*k, c)
end

D["trash"] = function(p, s, c)
    local k = s / 24
    ln(p, 4*k, 7*k, 20*k, 7*k, c, 2*k)
    ln(p, 9*k, 7*k, 9*k, 4*k, c, 2*k)
    ln(p, 9*k, 4*k, 15*k, 4*k, c, 2*k)
    ln(p, 15*k, 4*k, 15*k, 7*k, c, 2*k)
    ln(p, 6*k, 7*k, 7*k, 20*k, c, 2*k)
    ln(p, 7*k, 20*k, 17*k, 20*k, c, 2*k)
    ln(p, 17*k, 20*k, 18*k, 7*k, c, 2*k)
end
D["delete"] = D["trash"]

D["edit"] = function(p, s, c)
    local k = s / 24
    ln(p, 4*k, 20*k, 7*k, 17*k, c, 2*k)
    ln(p, 7*k, 17*k, 17*k, 7*k, c, 2*k)
    ln(p, 17*k, 7*k, 20*k, 10*k, c, 2*k)
    ln(p, 20*k, 10*k, 10*k, 20*k, c, 2*k)
    ln(p, 10*k, 20*k, 4*k, 20*k, c, 2*k)
end

D["download"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 4*k, 12*k, 15*k, c, 2*k)
    ln(p, 7*k, 10*k, 12*k, 15*k, c, 2*k)
    ln(p, 17*k, 10*k, 12*k, 15*k, c, 2*k)
    ln(p, 4*k, 20*k, 20*k, 20*k, c, 2*k)
end

D["upload"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 20*k, 12*k, 9*k, c, 2*k)
    ln(p, 7*k, 14*k, 12*k, 9*k, c, 2*k)
    ln(p, 17*k, 14*k, 12*k, 9*k, c, 2*k)
    ln(p, 4*k, 4*k, 20*k, 4*k, c, 2*k)
end

D["filter"] = function(p, s, c)
    local k = s / 24
    ln(p, 4*k, 5*k, 20*k, 5*k, c, 2*k)
    ln(p, 7*k, 11*k, 17*k, 11*k, c, 2*k)
    ln(p, 10*k, 17*k, 14*k, 17*k, c, 2*k)
end

D["crown"] = function(p, s, c)
    local k = s / 24
    ln(p, 5*k, 19*k, 5*k, 9*k, c, 2*k)
    ln(p, 5*k, 9*k, 9*k, 14*k, c, 2*k)
    ln(p, 9*k, 14*k, 12*k, 6*k, c, 2*k)
    ln(p, 12*k, 6*k, 15*k, 14*k, c, 2*k)
    ln(p, 15*k, 14*k, 19*k, 9*k, c, 2*k)
    ln(p, 19*k, 9*k, 19*k, 19*k, c, 2*k)
    ln(p, 5*k, 19*k, 19*k, 19*k, c, 2*k)
end
D["vip"] = D["crown"]

D["diamond"] = function(p, s, c)
    local k = s / 24
    ln(p, 6*k, 4*k, 18*k, 4*k, c, 2*k)
    ln(p, 18*k, 4*k, 22*k, 11*k, c, 2*k)
    ln(p, 22*k, 11*k, 12*k, 21*k, c, 2*k)
    ln(p, 12*k, 21*k, 2*k, 11*k, c, 2*k)
    ln(p, 2*k, 11*k, 6*k, 4*k, c, 2*k)
end
D["gem"] = D["diamond"]

D["fire"] = function(p, s, c)
    local k = s / 24
    ln(p, 12*k, 21*k, 6*k, 15*k, c, 2*k)
    ln(p, 6*k, 15*k, 5*k, 11*k, c, 2*k)
    ln(p, 5*k, 11*k, 8*k, 5*k, c, 2*k)
    ln(p, 8*k, 5*k, 11*k, 3*k, c, 2*k)
    ln(p, 11*k, 3*k, 13*k, 8*k, c, 2*k)
    ln(p, 13*k, 8*k, 16*k, 5*k, c, 2*k)
    ln(p, 16*k, 5*k, 19*k, 11*k, c, 2*k)
    ln(p, 19*k, 11*k, 18*k, 15*k, c, 2*k)
    ln(p, 18*k, 15*k, 12*k, 21*k, c, 2*k)
end
D["flame"] = D["fire"]

D["globe"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 9*k, c, false)
    ln(p, 3*k, 12*k, 21*k, 12*k, c, 1.8*k)
    ln(p, 12*k, 3*k, 12*k, 21*k, c, 1.8*k)
end

D["play"] = function(p, s, c)
    local k = s / 24
    ln(p, 8*k, 5*k, 19*k, 12*k, c, 2*k)
    ln(p, 19*k, 12*k, 8*k, 19*k, c, 2*k)
    ln(p, 8*k, 19*k, 8*k, 5*k, c, 2*k)
end

D["pause"] = function(p, s, c)
    local k = s / 24
    ln(p, 8*k, 5*k, 8*k, 19*k, c, 2.5*k)
    ln(p, 16*k, 5*k, 16*k, 19*k, c, 2.5*k)
end

D["crosshair"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 12*k, 8*k, c, false)
    ln(p, 12*k, 3*k, 12*k, 8*k, c, 2*k)
    ln(p, 12*k, 16*k, 12*k, 21*k, c, 2*k)
    ln(p, 3*k, 12*k, 8*k, 12*k, c, 2*k)
    ln(p, 16*k, 12*k, 21*k, 12*k, c, 2*k)
    circ(p, 12*k, 12*k, 1.2*k, c, true)
end
D["target"] = D["crosshair"]; D["aim"] = D["crosshair"]

D["pin"] = function(p, s, c)
    local k = s / 24
    circ(p, 12*k, 9*k, 6*k, c, false)
    ln(p, 9*k, 14*k, 12*k, 21*k, c, 2*k)
    ln(p, 15*k, 14*k, 12*k, 21*k, c, 2*k)
    circ(p, 12*k, 9*k, 2*k, c, true)
end
D["location"] = D["pin"]; D["map"] = D["pin"]

D["discord"] = function(p, s, c)
    local k = s / 24
    rect(p, 4*k, 6*k, 16*k, 12*k, 6*k, c, false)
    circ(p, 9*k, 12*k, 1.4*k, c, true)
    circ(p, 15*k, 12*k, 1.4*k, c, true)
end

D["sword"] = function(p, s, c)
    local k = s / 24
    ln(p, 5*k, 19*k, 10*k, 14*k, c, 2*k)
    ln(p, 10*k, 14*k, 19*k, 5*k, c, 2*k)
    ln(p, 19*k, 5*k, 19*k, 9*k, c, 2*k)
    ln(p, 19*k, 9*k, 15*k, 13*k, c, 2*k)
    ln(p, 15*k, 13*k, 10*k, 14*k, c, 2*k)
    ln(p, 6*k, 15*k, 9*k, 18*k, c, 2*k)
end
D["combat"] = D["sword"]

D["cpu"] = function(p, s, c)
    local k = s / 24
    rect(p, 6*k, 6*k, 12*k, 12*k, 1.5*k, c)
    rect(p, 9*k, 9*k, 6*k, 6*k, 1*k, c, true)
    ln(p, 9*k, 3*k, 9*k, 6*k, c, 1.8*k)
    ln(p, 15*k, 3*k, 15*k, 6*k, c, 1.8*k)
    ln(p, 9*k, 18*k, 9*k, 21*k, c, 1.8*k)
    ln(p, 15*k, 18*k, 15*k, 21*k, c, 1.8*k)
    ln(p, 3*k, 9*k, 6*k, 9*k, c, 1.8*k)
    ln(p, 3*k, 15*k, 6*k, 15*k, c, 1.8*k)
    ln(p, 18*k, 9*k, 21*k, 9*k, c, 1.8*k)
    ln(p, 18*k, 15*k, 21*k, 15*k, c, 1.8*k)
end
D["chip"] = D["cpu"]

D["terminal"] = function(p, s, c)
    local k = s / 24
    rect(p, 3*k, 4*k, 18*k, 16*k, 1.5*k, c)
    ln(p, 7*k, 10*k, 11*k, 13*k, c, 2*k)
    ln(p, 11*k, 13*k, 7*k, 16*k, c, 2*k)
    ln(p, 13*k, 16*k, 18*k, 16*k, c, 2*k)
end

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
        pcall(D[n], box, size, color)
        return box
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

-- ═══ NOTIFICATION ═══
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
        Position = UDim2.new(1, -340, 0, 20),
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
    cr(n, 10)
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
        Position = UDim2.new(0, 16, 0, 16),
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

    n.Position = UDim2.new(1, 40, n.Position.Y.Scale, n.Position.Y.Offset)
    tw(n, 0.3, { Position = UDim2.new(0, 0, n.Position.Y.Scale, n.Position.Y.Offset) })
    tw(progFill, dur, { Size = UDim2.new(0, 0, 1, 0) }, Enum.EasingStyle.Linear)

    task.delay(dur, function()
        if n and n.Parent then
            tw(n, 0.28, { BackgroundTransparency = 1, Position = UDim2.new(1, 40, n.Position.Y.Scale, n.Position.Y.Offset) })
            tw(stk, 0.28, { Transparency = 1 })
            for _, c in ipairs(n:GetDescendants()) do
                if c:IsA("TextLabel") then tw(c, 0.28, { TextTransparency = 1 })
                elseif c:IsA("Frame") then tw(c, 0.28, { BackgroundTransparency = 1 })
                elseif c:IsA("UIStroke") then tw(c, 0.28, { Transparency = 1 })
                end
            end
            task.wait(0.3)
            n:Destroy()
        end
    end)
end

-- ═══ WINDOW ═══
function AvenUI:CreateWindow(o)
    o = o or {}
    local title     = o.Name or "AvenUI"
    local subtitle  = o.Subtitle or ""
    local width     = o.Width or 580
    local height    = o.Height or 420
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

    -- Topbar
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
        BackgroundColor3 = Theme.BorderSoft,
        BorderSizePixel = 0,
        Parent = top,
    })

    if ic then
        local glow = mk("Frame", {
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, 18, 0.5, -20),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
            Parent = top,
        })
        cr(glow, 11)
        local iconWrap = mk("Frame", {
            Size = UDim2.new(0, 30, 0, 30),
            Position = UDim2.new(0, 23, 0.5, -15),
            BackgroundColor3 = Theme.Accent,
            BackgroundTransparency = 0.85,
            BorderSizePixel = 0,
            Parent = top,
        })
        cr(iconWrap, 8)
        local iStk = st(iconWrap, Theme.Accent, 1)
        iStk.Transparency = 0.5
        local icon = Icon.Create(iconWrap, ic, 16, Theme.Accent)
        icon.AnchorPoint = Vector2.new(0.5, 0.5)
        icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    end

    local titleX = ic and 68 or 22
    local titleLbl = mk("TextLabel", {
        Size = UDim2.new(1, -200, 0, 22),
        Position = UDim2.new(0, titleX, 0, 13),
        BackgroundTransparency = 1,
        Font = Theme.FontBlack,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = top,
    })

    local subLbl
    if subtitle ~= "" then
        subLbl = mk("TextLabel", {
            Size = UDim2.new(1, -200, 0, 14),
            Position = UDim2.new(0, titleX, 0, 35),
            BackgroundTransparency = 1,
            Font = Theme.FontMed,
            Text = subtitle,
            TextColor3 = Theme.Accent,
            TextSize = 10.5,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = top,
        })
    end

    local minBtn = mk("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -74, 0.5, -15),
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
    local ci = Icon.Create(closeHolder, "close", 12, Theme.SubText)
    ci.AnchorPoint = Vector2.new(0.5, 0.5); ci.Position = UDim2.new(0.5, 0, 0.5, 0)

    closeBtn.MouseEnter:Connect(function()
        tw(closeBtn, 0.15, { BackgroundColor3 = Theme.Danger })
    end)
    closeBtn.MouseLeave:Connect(function()
        tw(closeBtn, 0.15, { BackgroundColor3 = Theme.Item })
    end)
    minBtn.MouseEnter:Connect(function() tw(minBtn, 0.15, { BackgroundColor3 = Theme.ItemHover }) end)
    minBtn.MouseLeave:Connect(function() tw(minBtn, 0.15, { BackgroundColor3 = Theme.Item }) end)

    -- Sidebar
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
    local searchStroke = st(searchWrap, Theme.BorderSoft, 1)
    local si = Icon.Create(searchWrap, "search", 13, Theme.Muted)
    si.Position = UDim2.new(0, 10, 0.5, -6.5)
    local searchBox = mk("TextBox", {
        Size = UDim2.new(1, -36, 1, 0),
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
    searchBox.Focused:Connect(function() tw(searchStroke, 0.2, { Color = Theme.BorderFocus }) end)
    searchBox.FocusLost:Connect(function() tw(searchStroke, 0.2, { Color = Theme.BorderSoft }) end)

    local tabHolder = mk("ScrollingFrame", {
        Size = UDim2.new(1, 0, 1, -48),
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
        Padding = UDim.new(0, 2),
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

    self.SaveConfig = function()
        if not hasFileAPI() then return false end
        local data = { flags = {}, theme = {} }
        for k, v in pairs(self.Flags) do
            if v.type == "toggle" or v.type == "slider" then
                data.flags[k] = v.value
            end
        end
        data.theme.Accent = { Theme.Accent.R, Theme.Accent.G, Theme.Accent.B }
        return pcall(function()
            writefile(FOLDER .. "/config.json", HttpService:JSONEncode(data))
        end)
    end

    self.LoadConfig = function()
        if not hasFileAPI() then return false end
        local path = FOLDER .. "/config.json"
        if type(isfile) == "function" and not isfile(path) then return false end
        local ok, content = pcall(function() return readfile(path) end)
        if not ok or not content then return false end
        local ok2, data = pcall(function() return HttpService:JSONDecode(content) end)
        if not ok2 or not data then return false end
        if data.flags then
            for k, v in pairs(data.flags) do
                local f = self.Flags[k]
                if f and type(f.set) == "function" then
                    pcall(f.set, v)
                end
            end
        end
        return true
    end

    searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = searchBox.Text:lower()
        for _, t in ipairs(self.Tabs) do
            t.Button.Visible = q == "" or t.Name:lower():find(q, 1, true) ~= nil
        end
    end)

    -- ═══ TAB CREATION (with error isolation) ═══
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

        local accentBar = mk("Frame", {
            Size = UDim2.new(0, 3, 0, 18),
            Position = UDim2.new(0, 0, 0.5, -9),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Parent = btn,
        })
        cr(accentBar, 3)
        accentBar.BackgroundTransparency = 1

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
        tab.AccentBar = accentBar
        tab.IconHolder = iHolder
        tab.IconName = ic or "star"

        local function select()
            for _, t in ipairs(self.Tabs) do
                tw(t.Button, 0.18, { BackgroundTransparency = 1 })
                tw(t.AccentBar, 0.18, { BackgroundTransparency = 1 })
                tw(t.Label, 0.18, { TextColor3 = Theme.SubText })
                t.Container.Visible = false
                for _, c in ipairs(t.IconHolder:GetChildren()) do c:Destroy() end
                Icon.Create(t.IconHolder, t.IconName, 16, Theme.SubText)
            end
            tw(btn, 0.18, { BackgroundTransparency = 0.9, BackgroundColor3 = Theme.Accent })
            tw(accentBar, 0.18, { BackgroundTransparency = 0 })
            tw(label, 0.18, { TextColor3 = Theme.Accent })
            for _, c in ipairs(iHolder:GetChildren()) do c:Destroy() end
            Icon.Create(iHolder, ic or "star", 16, Theme.Accent)
            container.Visible = true
            self.ActiveTab = tab
        end

        btn.MouseButton1Click:Connect(select)
        table.insert(self.Tabs, tab)
        if #self.Tabs == 1 then task.defer(select) end

        -- Section
        function tab:Section(txt, sic)
            local wrap = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 24),
                BackgroundTransparency = 1,
                Parent = container,
            })
            local startX = 0
            if sic then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new(0, 2, 0.5, -7),
                    BackgroundTransparency = 1,
                    Parent = wrap,
                })
                Icon.Create(h, sic, 14, Theme.Accent)
                startX = 22
            else
                mk("Frame", {
                    Size = UDim2.new(0, 3, 0, 14),
                    Position = UDim2.new(0, 2, 0.5, -7),
                    BackgroundColor3 = Theme.Accent,
                    BorderSizePixel = 0,
                    Parent = wrap,
                })
                startX = 12
            end
            mk("TextLabel", {
                Size = UDim2.new(1, -startX, 1, 0),
                Position = UDim2.new(0, startX, 0, 0),
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
        function tab:Toggle(opt)
            opt = opt or {}
            local state = opt.CurrentValue or false
            local flag = opt.Flag

            local row = mk("TextButton", {
                Size = UDim2.new(1, -8, 0, 40),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            local rowStroke = st(row, Theme.BorderSoft, 1)

            local tx = 14
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, Theme.SubText)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 60, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = opt.Name or "Toggle",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local sw = mk("Frame", {
                Size = UDim2.new(0, 36, 0, 20),
                Position = UDim2.new(1, -50, 0.5, -10),
                BackgroundColor3 = Theme.Track,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(sw, 100)

            local knob = mk("Frame", {
                Size = UDim2.new(0, 14, 0, 14),
                Position = UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Theme.SubText,
                BorderSizePixel = 0,
                Parent = sw,
            })
            cr(knob, 100)

            local function render()
                if state then
                    tw(knob, 0.25, { Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = Color3.new(1, 1, 1) }, Enum.EasingStyle.Back)
                    tw(sw, 0.22, { BackgroundColor3 = Theme.Accent })
                    tw(rowStroke, 0.2, { Color = Theme.Accent, Transparency = 0.5 })
                else
                    tw(knob, 0.25, { Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = Theme.SubText }, Enum.EasingStyle.Back)
                    tw(sw, 0.22, { BackgroundColor3 = Theme.Track })
                    tw(rowStroke, 0.2, { Color = Theme.BorderSoft, Transparency = 0 })
                end
            end

            local api = {
                Set = function(v)
                    state = v; render()
                    task.spawn(opt.Callback or function() end, v)
                end,
                Get = function() return state end,
            }

            -- Register flag FIRST
            if flag then
                self.Flags[flag] = self.Flags[flag] or {}
                self.Flags[flag].type = "toggle"
                self.Flags[flag].value = state
                self.Flags[flag].set = api.Set
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
                if flag and self.Flags[flag] then self.Flags[flag].value = state end
                task.spawn(opt.Callback or function() end, state)
            end)
            render()

            return api
        end

        -- Slider
        function tab:Slider(opt)
            opt = opt or {}
            local mn = (opt.Range and opt.Range[1]) or 0
            local mx = (opt.Range and opt.Range[2]) or 100
            local inc = opt.Increment or 1
            local val = opt.CurrentValue or mn
            local sfx = opt.Suffix or ""
            local flag = opt.Flag

            local row = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 54),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0, 11),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, Theme.SubText)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 90, 0, 18),
                Position = UDim2.new(0, tx, 0, 8),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = opt.Name or "Slider",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local valBubble = mk("Frame", {
                Size = UDim2.new(0, 62, 0, 22),
                Position = UDim2.new(1, -76, 0, 7),
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
                TextColor3 = Theme.AccentText,
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

            local api = {
                Set = function(v)
                    v = math.clamp(tonumber(v) or mn, mn, mx)
                    val = v
                    local rel = (val - mn) / (mx - mn)
                    fill.Size = UDim2.new(rel, 0, 1, 0)
                    knob.Position = UDim2.new(rel, -7, 0.5, -7)
                    valLbl.Text = tostring(val) .. sfx
                    task.spawn(opt.Callback or function() end, val)
                end,
                Get = function() return val end,
            }

            -- Register flag FIRST
            if flag then
                self.Flags[flag] = self.Flags[flag] or {}
                self.Flags[flag].type = "slider"
                self.Flags[flag].value = val
                self.Flags[flag].set = api.Set
            end

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
                if flag and self.Flags[flag] then self.Flags[flag].value = val end
                task.spawn(opt.Callback or function() end, val)
            end)

            return api
        end

        -- Button
        function tab:Button(opt)
            opt = opt or {}
            local danger = opt.Danger or false
            local bg = danger and Theme.Danger or Theme.Accent
            local txtCol = danger and Color3.new(1, 1, 1) or Theme.AccentText

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
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, txtCol)
                tx = 38
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = opt.Name or "Button",
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
                task.spawn(opt.Callback or function() end)
            end)
        end

        -- Input
        function tab:Input(opt)
            opt = opt or {}
            local row = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 56),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0, 11),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, Theme.SubText)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 20, 0, 16),
                Position = UDim2.new(0, tx, 0, 8),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = opt.Name or "Input",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local boxWrap = mk("Frame", {
                Size = UDim2.new(1, -24, 0, 24),
                Position = UDim2.new(0, 12, 0, 28),
                BackgroundColor3 = Theme.Input,
                BorderSizePixel = 0,
                Parent = row,
            })
            cr(boxWrap, 6)
            local bStroke = st(boxWrap, Theme.BorderSoft, 1)

            local box = mk("TextBox", {
                Size = UDim2.new(1, -20, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.Font,
                Text = opt.CurrentValue or "",
                PlaceholderText = opt.Placeholder or "Type here...",
                TextColor3 = Theme.Text,
                PlaceholderColor3 = Theme.Muted,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                ClearTextOnFocus = false,
                Parent = boxWrap,
            })

            box.FocusLost:Connect(function()
                tw(bStroke, 0.2, { Color = Theme.BorderSoft })
                task.spawn(opt.Callback or function() end, box.Text)
            end)
            box.Focused:Connect(function()
                tw(bStroke, 0.2, { Color = Theme.BorderFocus })
            end)

            return {
                Set = function(v) box.Text = v end,
                Get = function() return box.Text end,
            }
        end

        -- Dropdown
        function tab:Dropdown(opt)
            opt = opt or {}
            local opts = opt.Options or {}
            local cur = opt.CurrentOption or (opts[1] or "")

            local wrap = mk("Frame", {
                Size = UDim2.new(1, -8, 0, 38),
                BackgroundTransparency = 1,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = container,
            })

            local row = mk("TextButton", {
                Size = UDim2.new(1, 0, 0, 38),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = wrap,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, Theme.SubText)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 105, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = opt.Name or "Dropdown",
                TextColor3 = Theme.Text,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = row,
            })

            local valLbl = mk("TextLabel", {
                Size = UDim2.new(0, 84, 1, 0),
                Position = UDim2.new(1, -110, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontBold,
                Text = tostring(cur),
                TextColor3 = Theme.Accent,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = row,
            })

            local chev = mk("Frame", {
                Size = UDim2.new(0, 11, 0, 11),
                Position = UDim2.new(1, -24, 0.5, -5.5),
                BackgroundTransparency = 1,
                Parent = row,
            })
            Icon.Create(chev, "chevron-down", 11, Theme.SubText)

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

            for _, o in ipairs(opts) do
                local ob = mk("TextButton", {
                    Size = UDim2.new(1, -8, 0, 28),
                    BackgroundColor3 = Theme.Item,
                    BorderSizePixel = 0,
                    Font = Theme.Font,
                    Text = tostring(o),
                    TextColor3 = Theme.Text,
                    TextSize = 11,
                    AutoButtonColor = false,
                    Parent = list,
                })
                cr(ob, 6)
                ob.MouseEnter:Connect(function() tw(ob, 0.1, { BackgroundColor3 = Theme.ItemHover }) end)
                ob.MouseLeave:Connect(function() tw(ob, 0.1, { BackgroundColor3 = Theme.Item }) end)
                ob.MouseButton1Click:Connect(function()
                    cur = o
                    valLbl.Text = tostring(o)
                    list.Visible = false
                    list.Size = UDim2.new(1, 0, 0, 0)
                    for _, c in ipairs(chev:GetChildren()) do c:Destroy() end
                    local d = Icon.Create(chev, "chevron-down", 11, Theme.SubText)
                    d.AnchorPoint = Vector2.new(0.5, 0.5); d.Position = UDim2.new(0.5, 0, 0.5, 0)
                    task.spawn(opt.Callback or function() end, o)
                end)
            end

            local exp = false
            row.MouseButton1Click:Connect(function()
                exp = not exp
                list.Visible = exp
                local th = (#opts * 30) + 8
                tw(list, 0.22, { Size = UDim2.new(1, 0, 0, exp and th or 0) })
                for _, c in ipairs(chev:GetChildren()) do c:Destroy() end
                local d = Icon.Create(chev, exp and "chevron-up" or "chevron-down", 11, Theme.SubText)
                d.AnchorPoint = Vector2.new(0.5, 0.5); d.Position = UDim2.new(0.5, 0, 0.5, 0)
            end)

            return {
                Set = function(v) cur = v; valLbl.Text = tostring(v) end,
                Get = function() return cur end,
            }
        end

        -- Keybind
        function tab:Keybind(opt)
            opt = opt or {}
            local cur = opt.CurrentKeybind or Enum.KeyCode.E
            local listening = false

            local row = mk("TextButton", {
                Size = UDim2.new(1, -8, 0, 38),
                BackgroundColor3 = Theme.Item,
                BorderSizePixel = 0,
                Text = "",
                AutoButtonColor = false,
                Parent = container,
            })
            cr(row, Theme.RadiusSm)
            st(row, Theme.BorderSoft, 1)

            local tx = 14
            if opt.Icon then
                local h = mk("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = UDim2.new(0, 14, 0.5, -8),
                    BackgroundTransparency = 1,
                    Parent = row,
                })
                Icon.Create(h, opt.Icon, 16, Theme.SubText)
                tx = 40
            end

            mk("TextLabel", {
                Size = UDim2.new(1, -tx - 95, 1, 0),
                Position = UDim2.new(0, tx, 0, 0),
                BackgroundTransparency = 1,
                Font = Theme.FontMed,
                Text = opt.Name or "Keybind",
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
            local kStroke = st(keyBox, Theme.BorderSoft, 1)

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
                tw(kStroke, 0.2, { Color = Theme.BorderFocus })
            end)

            UserInput.InputBegan:Connect(function(i, p)
                if not listening then return end
                if p then return end
                if i.UserInputType == Enum.UserInputType.Keyboard then
                    cur = i.KeyCode
                    keyLbl.Text = cur.Name
                    keyLbl.TextColor3 = Theme.Accent
                    listening = false
                    tw(kStroke, 0.2, { Color = Theme.BorderSoft })
                    task.spawn(opt.Callback or function() end, cur)
                end
            end)

            return { Get = function() return cur end }
        end

        -- Label
        function tab:Label(opt)
            opt = opt or {}
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
                Text = opt.Text or "",
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
