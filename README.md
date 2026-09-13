<div align="center">

# AvenUI

**A clean, lightweight, dependency-free Roblox UI library.**

Hand-drawn icons · Runtime themes · Simple API · Mobile friendly

[![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)](LICENSE)
[![Dependencies](https://img.shields.io/badge/Dependencies-None-blue?style=flat-square)](#features)

</div>

---

## About

AvenUI is a lightweight Roblox UI library focused on clean visuals, a simple API, and easy customization.

It provides a modern interface without requiring large UI frameworks or third-party icon packs.

### Highlights

- 60+ built-in hand-drawn vector-style icons
- Zero required dependencies
- Runtime-swappable themes
- Draggable and minimizable windows
- Built-in sidebar search
- Touch-friendly controls
- Animated notifications
- Simple and readable API
- Single Lua file
- No library-side HTTP requests

---

## Installation

### One-liner

```lua
local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"
))()

Local

Download AvenUi.lua and include it directly in your project.


---

Quick Start

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"
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

The window appears in the center of the screen.

Drag the window from the top bar

Minimize using the - button

Toggle the UI with RightControl



---

Features

Feature	Description

Icons	60+ built-in hand-drawn icons
Dependencies	None
Theme	Fully customizable at runtime
Window	Draggable and minimizable
Search	Built-in sidebar filtering
Mobile	Touch-friendly controls
Notifications	Built-in notification toasts
Elements	Multiple UI element types
Distribution	Single Lua file
Network	No library-side HTTP requests



---

Full Example

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"
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

    Range = {16, 200},
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

    Range = {50, 200},
    Increment = 5,
    Suffix = " jp",
    CurrentValue = 50,

    Callback = function(value)
        print("Jump Power:", value)
    end,
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
            Content = "Settings saved successfully.",
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

Element	Method	Returns

Section	Tab:Section(text, icon?)	—
Toggle	Tab:Toggle(opts)	{ Set, Get }
Slider	Tab:Slider(opts)	{ Set, Get }
Button	Tab:Button(opts)	—
Input	Tab:Input(opts)	{ Set, Get }
Dropdown	Tab:Dropdown(opts)	{ Set, Get }
Keybind	Tab:Keybind(opts)	{ Get }
Label	Tab:Label(opts)	—
Divider	Tab:Divider(text?)	—
Notification	AvenUI:Notify(opts)	—



---

Toggle

local Toggle = Tab:Toggle({
    Name = "Enable Feature",
    Icon = "power",
    CurrentValue = false,

    Callback = function(state)
        print("Enabled:", state)
    end,
})

Toggle:Set(true)

local state = Toggle:Get()
print(state)


---

Slider

local Slider = Tab:Slider({
    Name = "Walk Speed",
    Icon = "power",

    Range = {16, 200},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 16,

    Callback = function(value)
        print("Value:", value)
    end,
})

Slider:Set(50)

local value = Slider:Get()
print(value)


---

Button

Tab:Button({
    Name = "Execute",
    Icon = "play",

    Callback = function()
        print("Executed")
    end,
})


---

Input

local Input = Tab:Input({
    Name = "Username",
    Icon = "user",

    Placeholder = "Enter username...",

    Callback = function(text)
        print("Input:", text)
    end,
})

Input:Set("Gixss")

local text = Input:Get()
print(text)


---

Dropdown

local Dropdown = Tab:Dropdown({
    Name = "Quality",
    Icon = "grid",

    Options = {
        "Low",
        "Medium",
        "High",
        "Ultra",
    },

    CurrentOption = "High",

    Callback = function(option)
        print("Selected:", option)
    end,
})


---

Keybind

local Keybind = Tab:Keybind({
    Name = "Toggle Menu",
    Icon = "key",

    CurrentKeybind = Enum.KeyCode.RightControl,

    Callback = function(key)
        print("Pressed:", key.Name)
    end,
})

local key = Keybind:Get()
print(key.Name)


---

Icons

AvenUI includes 60+ built-in hand-drawn vector-style icons.

The built-in icon system does not require Unicode characters, emoji, or external icon packs.

Named Icon

Tab:Button({
    Name = "Settings",
    Icon = "settings",
})

Asset ID

Tab:Button({
    Name = "Custom",
    Icon = 1234567890,
})

Roblox Asset URL

Tab:Button({
    Name = "Custom",
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

Get the current icon list at runtime:

print(AvenUI.IconNames)


---

Theme

AvenUI uses a centralized runtime theme system.

Set Theme

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg = Color3.fromRGB(15, 15, 20),
})

Set Accent

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Get Current Theme

local Theme = AvenUI:GetTheme()

print(Theme.Accent)

Theme Properties

Property	Description

Bg	Main window background
BgTop	Top bar background
BgSide	Sidebar background
Item	Default element background
ItemHover	Hover state
Input	TextBox background
Track	Slider and toggle track
Border	Primary stroke color
BorderSoft	Secondary stroke color
Text	Primary text
SubText	Secondary text
Muted	Muted text
Accent	Primary accent color
AccentDim	Dimmed accent color
Danger	Destructive action color
Warn	Warning color
Info	Information color
Success	Success color
Radius	Default corner radius
RadiusSm	Small corner radius
RadiusLg	Large corner radius
HeaderH	Top bar height
SidebarW	Sidebar width



---

Notifications

Create a notification toast with AvenUI:Notify():

AvenUI:Notify({
    Title = "Applied",
    Content = "Settings saved successfully.",
    Icon = "check",

    Accent = Color3.fromRGB(34, 197, 94),
    Duration = 3,
})


---

API Reference

AvenUI:CreateWindow(opts)

Creates the main AvenUI window.

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by Gixss",
    Icon = "sparkle",
})

Window:CreateTab(name, icon)

Creates a new tab.

local Tab = Window:CreateTab("Main", "home")

Window:SetTitle(text)

Updates the window title.

Window:SetTitle("New Title")

Window:SetSubtitle(text)

Updates the window subtitle.

Window:SetSubtitle("Updated subtitle")

Window:Destroy()

Destroys the entire UI.

Window:Destroy()

AvenUI:Notify(opts)

Displays a notification toast.

AvenUI:SetTheme(table)

Merges the supplied values into the active theme.

AvenUI:SetAccent(color)

Changes the primary accent color and updates derived colors.

AvenUI:GetTheme()

Returns the current theme table.

AvenUI.IconNames

Contains the available built-in icon names.


---

Mobile Support

AvenUI is designed for both desktop and mobile interfaces.

Touch-friendly controls

Draggable windows

Sidebar navigation

Comfortable interaction areas

Keyboard shortcuts where supported



---

Performance

AvenUI is designed to stay lightweight and easy to maintain.

The library avoids unnecessary dependencies and keeps its UI architecture simple.

Performance can vary depending on the device, Roblox client, and complexity of the UI created with the library.


---

Compatibility

AvenUI is intended for Roblox environments that support the APIs used by the library.

Compatibility with third-party environments may change after updates.

If you encounter an issue, please include:

Environment

Roblox version

Error message

Relevant code

Steps to reproduce the issue



---

Troubleshooting

The UI does not appear

Check that:

1. The raw GitHub URL is correct.


2. The library loads without an error.


3. Your environment supports the required Roblox APIs.


4. You are using the latest version.


5. The console does not contain an error.



An icon does not appear

Check the icon name:

print(AvenUI.IconNames)

Icon names are case-sensitive.

Theme changes are not visible

Make sure the property exists in the theme:

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
})


---

FAQ

Does AvenUI require dependencies?

No. AvenUI is designed as a standalone library.

Does AvenUI use external icon packs?

No. The built-in icon collection is included with the library.

Does AvenUI make HTTP requests?

The library itself does not make HTTP requests.

The loadstring(game:HttpGet(...)) installation method retrieves the library source from GitHub.

Does AvenUI support mobile?

Yes. The interface is designed with touch interaction in mind.

Can I customize the colors?

Yes. Use SetTheme() for multiple properties or SetAccent() for the primary accent.

Can I create multiple tabs?

Yes.

local Main = Window:CreateTab("Main", "home")
local Visual = Window:CreateTab("Visual", "eye")
local Settings = Window:CreateTab("Settings", "settings")


---

Contributing

Pull requests are welcome.

Before submitting a pull request:

1. Check existing issues and pull requests.


2. Keep changes focused.


3. Follow the existing coding style.


4. Test your changes.


5. Explain what was changed and why.



For major changes, open an issue first.


---

License

AvenUI is licensed under the MIT License.

See LICENSE for the complete license text.


---

<div align="center">AvenUI

Clean UI. Simple API. Full control.

Made by Gixss

GitHub

</div>
