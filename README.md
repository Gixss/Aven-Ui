AvenUI

«A premium, dependency-free Roblox UI library with hand-drawn vector icons.»

AvenUI is a lightweight and customizable Roblox UI library designed with a simple philosophy:

No emoji. No Unicode icons. No external assets. No hidden network calls. Just clean UI.

""Version" (https://img.shields.io/github/v/release/YourUser/AvenUI?style=flat-square)" (https://github.com/YourUser/AvenUI/releases)
""License" (https://img.shields.io/github/license/YourUser/AvenUI?style=flat-square)" (LICENSE)
""Lua" (https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)" (https://www.lua.org/)
""Roblox" (https://img.shields.io/badge/Roblox-000000?style=flat-square&logo=roblox&logoColor=white)" (https://www.roblox.com/)
""Stars" (https://img.shields.io/github/stars/YourUser/AvenUI?style=flat-square)" (https://github.com/YourUser/AvenUI/stargazers)

---

Why AvenUI?

Many Roblox UI libraries rely on external assets, Unicode characters, or large third-party icon packs. This can lead to slower loading, broken icons, unnecessary dependencies, and harder-to-maintain code.

AvenUI takes a different approach.

- Hand-drawn icons — Icons are rendered using Roblox GUI primitives instead of external icon packs.
- Zero dependencies — AvenUI is designed to work as a single Lua file.
- No HTTP requests — The library itself does not make network calls.
- Runtime theming — Change colors and UI properties without rebuilding the interface.
- Touch-friendly — Designed for both PC and mobile.
- Readable source — Small, modular elements that are easy to understand and modify.

«AvenUI is built to be simple enough to use, but flexible enough to make your own.»

---

Features

Feature| Details
Icons| 60+ hand-drawn vector-style icons
Dependencies| Zero
Distribution| Single Lua file
Theme| Fully runtime-swappable
Mobile| Touch-friendly
Network| No HTTP calls from the library
Animation| Smooth UI animations
Window| Draggable and minimizable
Search| Built-in sidebar filtering
Elements| 11 UI element types

---

Installation

Option 1 — Loadstring

The quickest way to load AvenUI:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"
))()

Option 2 — Local / Inline

Download "AvenUI.lua" and include it directly in your project.

This approach is recommended when you want to keep the library locally and avoid fetching it at runtime.

---

Quick Start

A minimal working example:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"
))()

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by YourName",
    Icon = "sparkle",
})

local Tab = Window:CreateTab("Main", "home")

Tab:Toggle({
    Name = "Enable",
    Icon = "power",
    Callback = function(state)
        print("Enabled:", state)
    end,
})

After running the script:

- Drag the window using the top bar.
- Minimize it using the "-" button.
- Toggle the UI using "RightControl".

---

Full Example

The following example demonstrates the main AvenUI components:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"
))()

local Window = AvenUI:CreateWindow({
    Name = "Aven Hub",
    Subtitle = "by Gixss",
    Icon = "sparkle",
    Width = 560,
    Height = 420,
    ToggleKey = Enum.KeyCode.RightControl,
})

-- Main
local MainTab = Window:CreateTab("Main", "home")

MainTab:Section("Character", "user")

MainTab:Slider({
    Name = "Walk Speed",
    Icon = "power",
    Range = { 16, 200 },
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 16,

    Callback = function(value)
        print("Speed:", value)
    end,
})

MainTab:Slider({
    Name = "Jump Power",
    Icon = "bolt",
    Range = { 50, 200 },
    Increment = 5,
    Suffix = " jp",
    CurrentValue = 50,
})

MainTab:Toggle({
    Name = "Infinite Jump",
    Icon = "arrow-up",
    CurrentValue = false,

    Callback = function(state)
        print("Infinite Jump:", state)
    end,
})

MainTab:Toggle({
    Name = "No Clip",
    Icon = "shield",
    CurrentValue = false,
})

-- Visual
local VisualTab = Window:CreateTab("Visual", "eye")

VisualTab:Section("Rendering", "sparkle")

VisualTab:Dropdown({
    Name = "Quality",
    Icon = "grid",
    Options = {
        "Low",
        "Medium",
        "High",
        "Ultra",
    },
    CurrentOption = "Medium",

    Callback = function(option)
        print("Quality:", option)
    end,
})

VisualTab:Button({
    Name = "Apply Settings",
    Icon = "check",

    Callback = function()
        AvenUI:Notify({
            Title = "Applied",
            Content = "Settings saved successfully",
            Icon = "check",
            Accent = Color3.fromRGB(34, 197, 94),
            Duration = 3,
        })
    end,
})

-- Misc
local MiscTab = Window:CreateTab("Misc", "settings")

MiscTab:Section("Input", "key")

MiscTab:Input({
    Name = "Webhook URL",
    Icon = "link",
    Placeholder = "https://discord.com/api/webhooks/...",
    
    Callback = function(text)
        print("Webhook:", text)
    end,
})

MiscTab:Keybind({
    Name = "Panic Key",
    Icon = "key",
    CurrentKeybind = Enum.KeyCode.P,

    Callback = function(key)
        print("Panic:", key.Name)
    end,
})

MiscTab:Divider("Danger Zone")

MiscTab:Button({
    Name = "Reset All",
    Icon = "trash",
    Danger = true,

    Callback = function()
        AvenUI:Notify({
            Title = "Reset",
            Content = "All settings cleared",
            Icon = "warning",
            Accent = Color3.fromRGB(239, 68, 68),
            Duration = 3,
        })
    end,
})

---

Elements

AvenUI currently provides 11 element types.

Element| Method| Returns
Section| "Tab:Section(text, icon?)"| —
Toggle| "Tab:Toggle(opts)"| "{ Set, Get }"
Slider| "Tab:Slider(opts)"| "{ Set, Get }"
Button| "Tab:Button(opts)"| —
Input| "Tab:Input(opts)"| "{ Set, Get }"
Dropdown| "Tab:Dropdown(opts)"| "{ Set, Get }"
Keybind| "Tab:Keybind(opts)"| "{ Get }"
Label| "Tab:Label(opts)"| —
Divider| "Tab:Divider(text?)"| —
Notification| "AvenUI:Notify(opts)"| —

---

Icons

AvenUI includes 60+ hand-drawn vector-style icons.

Icons are constructed using Roblox GUI primitives, so the library does not require an external icon pack or Unicode characters.

Using a Named Icon

Tab:Toggle({
    Name = "Enabled",
    Icon = "gear",
})

Using an Asset ID

Tab:Toggle({
    Name = "Custom Icon",
    Icon = 1234567890,
})

Using an Asset URL

Tab:Toggle({
    Name = "Custom Icon",
    Icon = "rbxassetid://1234567890",
})

Available Icon Names

activity
aim
alert
arrow-down
arrow-left
arrow-right
arrow-up
bell
bolt
cart
check
chevron-down
chevron-left
chevron-right
chevron-up
chip
close
code
cog
combat
copy
cpu
crosshair
crown
delete
dev
diamond
discord
document
download
edit
exit
eye
favorite
file
filter
find
fire
flame
folder
gear
gem
globe
grid
heart
home
house
info
key
like
lightning
link
list
location
lock
map
menu
minus
moon
notif
pause
pencil
pin
play
plus
power
profile
protect
refresh
reload
remove
script
search
secure
settings
shield
shop
sparkle
star
stop
sun
sword
sync
tag
target
terminal
tick
trash
upload
user
view
vip
volume
warning
wifi
x
zap

You can also retrieve the complete list at runtime:

print(AvenUI.IconNames)

---

Theme

AvenUI uses a centralized theme system that can be changed at runtime.

Override Theme

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg = Color3.fromRGB(15, 15, 20),
})

Only the properties you provide are changed; the remaining theme values are preserved.

Change Accent

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Read Current Theme

local theme = AvenUI:GetTheme()

print(theme.Accent)

Theme Properties

Property| Description
"Bg"| Main window background
"BgTop"| Top bar background
"BgSide"| Sidebar background
"Item"| Default element background
"ItemHover"| Hover state background
"Input"| TextBox background
"Track"| Slider and toggle track
"Border"| Primary border color
"BorderSoft"| Secondary border color
"Text"| Primary text color
"SubText"| Secondary text color
"Muted"| Muted text color
"Accent"| Primary accent color
"AccentDim"| Dimmed accent color
"Danger"| Destructive action color
"Warn"| Warning color
"Info"| Information color
"Success"| Success color
"Radius"| Default corner radius
"RadiusSm"| Small corner radius
"RadiusLg"| Large corner radius
"HeaderH"| Top bar height
"SidebarW"| Sidebar width

---

API Reference

"AvenUI:CreateWindow(opts)"

Creates the main AvenUI window.

Returns a "Window" object.

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by YourName",
    Icon = "sparkle",
})

---

"Window:CreateTab(name, icon)"

Creates a new tab inside the window.

Returns a "Tab" object.

local Tab = Window:CreateTab("Main", "home")

---

"Window:SetTitle(text)"

Updates the window title at runtime.

Window:SetTitle("New Title")

---

"Window:SetSubtitle(text)"

Updates the window subtitle.

Window:SetSubtitle("Updated subtitle")

---

"Window:Destroy()"

Destroys the entire AvenUI interface.

Window:Destroy()

---

"AvenUI:Notify(opts)"

Displays a notification toast.

AvenUI:Notify({
    Title = "Success",
    Content = "Settings saved.",
    Icon = "check",
    Duration = 3,
})

---

"AvenUI:SetTheme(table)"

Merges the supplied values into the active theme.

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
})

---

"AvenUI:SetAccent(color)"

Changes the primary accent color and recalculates derived accent colors.

AvenUI:SetAccent(
    Color3.fromRGB(88, 101, 242)
)

---

"AvenUI:GetTheme()"

Returns the current theme table.

local Theme = AvenUI:GetTheme()

print(Theme.Bg)
print(Theme.Accent)

---

Compatibility

AvenUI has been tested with the following environments:

Executor| Status
Delta| Supported
Wave| Supported
Xeno| Supported
Fluxus| Supported
Arceus X| Supported
Hydrogen| Supported
Codex| Supported
Krnl| Supported
Synapse| Supported
Vega X| Supported

AvenUI is designed for both PC and mobile and supports touch interaction.

«Compatibility can change as Roblox and third-party environments are updated. If something stops working, please open an issue with the relevant details.»

---

Performance

AvenUI is designed with lightweight UI primitives and minimal dependencies.

The library aims to provide:

- Lightweight initialization
- Smooth UI transitions
- Minimal external overhead
- No built-in HTTP/network requests
- Touch-friendly interaction
- Runtime theme updates

Performance may vary depending on the executor, device, Roblox client version, and the complexity of the UI using AvenUI.

---

Contributing

Contributions are welcome.

For small fixes and improvements, feel free to open a pull request.

For larger changes:

1. Open an issue first.
2. Explain the proposed change.
3. Discuss the implementation.
4. Submit a pull request once the approach is agreed upon.

---

License

AvenUI is released under the MIT License.

See ""LICENSE"" (LICENSE) for the complete license text.

---

Credits

Made by Gixss

- Discord: https://discord.gg/q7PZBsbpD
- Repository: "YourUser/AvenUI"

If you like AvenUI, consider giving the repository a star on GitHub.
