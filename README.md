<div align="center">AvenUI

A clean, lightweight, dependency-free Roblox UI library.

Hand-drawn icons. Runtime themes. Simple API.

""Lua" (https://img.shields.io/badge/Lua-Roblox-2C2D72?style=flat-square)" (https://www.lua.org/)
""License" (https://img.shields.io/badge/License-MIT-green?style=flat-square)" (LICENSE)
""Dependencies" (https://img.shields.io/badge/Dependencies-None-blue?style=flat-square)" (#features)

</div>---

About

AvenUI is a lightweight Roblox UI library built around a simple idea:

«Clean UI. Simple API. Full control.»

It is designed to give developers a modern interface without requiring large UI frameworks, external icon packs, or complicated dependencies.

AvenUI includes:

- 60+ built-in hand-drawn icons
- A centralized runtime theme system
- Draggable and minimizable windows
- Sidebar search
- Touch-friendly controls
- Lightweight UI elements
- Animated notifications
- A simple, readable API
- Zero required dependencies

---

Features

Feature| Description
Icons| 60+ built-in hand-drawn vector-style icons
Dependencies| None
Theme| Fully customizable at runtime
Window| Draggable and minimizable
Sidebar| Built-in search and filtering
Mobile| Touch-friendly controls
Notifications| Animated notification toasts
Elements| Toggle, Slider, Button, Input, Dropdown, Keybind and more
Distribution| Single Lua file
Runtime| No library-side HTTP requests

---

Why AvenUI?

Lightweight

AvenUI is designed to stay simple.

There are no required third-party frameworks or large dependency chains.

Built-in Icons

Icons are included directly inside the library.

No external icon pack is required for the built-in icon set.

Tab:Button({
    Name = "Settings",
    Icon = "settings",
})

Runtime Themes

Change the appearance of your interface while it is running.

AvenUI:SetTheme({
    Bg = Color3.fromRGB(15, 15, 20),
    Accent = Color3.fromRGB(88, 101, 242),
})

Or change only the accent:

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Developer Friendly

The API is intentionally small and easy to understand.

Tab:Toggle({...})
Tab:Slider({...})
Tab:Button({...})
Tab:Dropdown({...})
Tab:Input({...})
Tab:Keybind({...})

---

Installation

«Important: Make sure the raw URL points to the actual Lua file in the repository. The example below uses the expected "AvenUI.lua" path; update it if your file is located elsewhere.»

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"
))()

Local Installation

You can also download the library source and include it directly in your own project.

---

Quick Start

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"
))()

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by YourName",
    Icon = "sparkle",
})

local Main = Window:CreateTab("Main", "home")

Main:Toggle({
    Name = "Enable",
    Icon = "power",

    Callback = function(state)
        print("Enabled:", state)
    end,
})

Once created, the window can be dragged from the top bar.

Default Controls

Action| Control
Move window| Drag the top bar
Minimize| "-" button
Toggle UI| "RightControl"

---

Full Example

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"
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
local Main = Window:CreateTab("Main", "home")

Main:Section("Character", "user")

Main:Slider({
    Name = "Walk Speed",
    Icon = "power",
    Range = {16, 200},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 16,

    Callback = function(value)
        print("Walk Speed:", value)
    end,
})

Main:Slider({
    Name = "Jump Power",
    Icon = "bolt",
    Range = {50, 200},
    Increment = 5,
    Suffix = " jp",
    CurrentValue = 50,
})

Main:Toggle({
    Name = "Infinite Jump",
    Icon = "arrow-up",
    CurrentValue = false,

    Callback = function(state)
        print("Infinite Jump:", state)
    end,
})

Main:Toggle({
    Name = "No Clip",
    Icon = "shield",
    CurrentValue = false,
})

-- Visual
local Visual = Window:CreateTab("Visual", "eye")

Visual:Section("Rendering", "sparkle")

Visual:Dropdown({
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

Visual:Button({
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

-- Settings
local Settings = Window:CreateTab("Settings", "settings")

Settings:Section("Input", "key")

Settings:Input({
    Name = "Username",
    Icon = "user",
    Placeholder = "Enter username...",

    Callback = function(text)
        print("Username:", text)
    end,
})

Settings:Keybind({
    Name = "Panic Key",
    Icon = "key",
    CurrentKeybind = Enum.KeyCode.P,

    Callback = function(key)
        print("Key:", key.Name)
    end,
})

---

Elements

AvenUI currently provides the following UI elements:

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

Toggle

local Toggle = Tab:Toggle({
    Name = "Enable Feature",
    Icon = "power",

    CurrentValue = false,

    Callback = function(state)
        print("Enabled:", state)
    end,
})

Returned object:

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

Returned object:

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

Input

local Input = Tab:Input({
    Name = "Username",
    Icon = "user",

    Placeholder = "Enter username...",

    Callback = function(text)
        print("Input:", text)
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

---

Icons

AvenUI includes a built-in collection of hand-drawn vector-style icons.

No Unicode characters or emoji are required for the built-in icon system.

Named Icons

Tab:Button({
    Name = "Settings",
    Icon = "settings",
})

Asset IDs

Tab:Button({
    Name = "Custom",
    Icon = 1234567890,
})

Roblox Asset URLs

Tab:Button({
    Name = "Custom",
    Icon = "rbxassetid://1234567890",
})

Available Icons

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

Get the current list at runtime:

print(AvenUI.IconNames)

---

Themes

AvenUI uses a centralized theme system.

Set Theme

AvenUI:SetTheme({
    Bg = Color3.fromRGB(15, 15, 20),
    Accent = Color3.fromRGB(88, 101, 242),
})

Only the supplied properties are changed.

Set Accent

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Get Current Theme

local Theme = AvenUI:GetTheme()

print(Theme.Bg)
print(Theme.Accent)

Theme Properties

Property| Description
"Bg"| Main window background
"BgTop"| Top bar background
"BgSide"| Sidebar background
"Item"| Default element background
"ItemHover"| Hover state background
"Input"| Input background
"Track"| Slider and toggle track
"Border"| Primary border color
"BorderSoft"| Secondary border color
"Text"| Primary text
"SubText"| Secondary text
"Muted"| Muted text
"Accent"| Main accent color
"AccentDim"| Dimmed accent color
"Danger"| Destructive actions
"Warn"| Warning state
"Info"| Information state
"Success"| Success state
"Radius"| Default corner radius
"RadiusSm"| Small corner radius
"RadiusLg"| Large corner radius
"HeaderH"| Header height
"SidebarW"| Sidebar width

---

Notifications

Display a notification toast with "AvenUI:Notify()":

AvenUI:Notify({
    Title = "Success",
    Content = "Settings saved successfully.",
    Icon = "check",

    Accent = Color3.fromRGB(34, 197, 94),
    Duration = 3,
})

The notification system can use the theme colors for different states:

- "Success"
- "Danger"
- "Warn"
- "Info"

---

API Reference

Window

"AvenUI:CreateWindow(opts)"

Creates the main AvenUI window.

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by Gixss",
    Icon = "sparkle",
})

"Window:CreateTab(name, icon)"

Creates a new tab.

local Tab = Window:CreateTab("Main", "home")

"Window:SetTitle(text)"

Changes the window title at runtime.

Window:SetTitle("New Title")

"Window:SetSubtitle(text)"

Changes the window subtitle.

Window:SetSubtitle("Updated subtitle")

"Window:Destroy()"

Destroys the AvenUI window.

Window:Destroy()

---

Global API

"AvenUI:Notify(opts)"

Displays a notification toast.

"AvenUI:SetTheme(table)"

Merges the supplied values into the current theme.

"AvenUI:SetAccent(color)"

Changes the primary accent color.

"AvenUI:GetTheme()"

Returns the active theme table.

"AvenUI.IconNames"

Contains the available built-in icon names.

print(AvenUI.IconNames)

---

Mobile Support

AvenUI is designed with both desktop and touch interaction in mind.

The interface uses:

- Touch-friendly controls
- Comfortable interaction areas
- Draggable windows
- Sidebar navigation
- Responsive UI interaction

Keyboard shortcuts remain available on platforms where keyboard input is supported.

---

Performance

AvenUI is designed to remain lightweight by keeping the architecture simple.

Design goals

- No required dependencies
- No external icon packages
- No library-side HTTP requests
- Lightweight Roblox GUI primitives
- Centralized theme management
- Simple element architecture

Actual performance depends on the device, Roblox client, and complexity of the UI being created.

---

Compatibility

AvenUI is intended for Roblox environments that support the APIs required by the library.

Compatibility can change when Roblox or third-party environments receive updates.

«If you encounter an issue, please open an issue with your environment, Roblox version, and the error message.»

---

Troubleshooting

The UI does not appear

Check the following:

1. Make sure the library source is loading correctly.
2. Make sure the raw GitHub URL points to the correct Lua file.
3. Check the console for errors.
4. Make sure your environment supports the APIs used by AvenUI.
5. Make sure you are using the latest version.

An icon does not appear

Check the icon name:

print(AvenUI.IconNames)

Make sure the name exactly matches one of the available icons.

Theme changes are not visible

Make sure the property exists in the theme:

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
})

---

FAQ

Does AvenUI require dependencies?

No.

AvenUI is designed as a standalone library.

Does AvenUI use external icon packs?

No. Built-in icons are included with the library.

Does the library make HTTP requests?

The library itself does not make HTTP requests.

The "loadstring(game:HttpGet(...))" installation method only retrieves the library source from GitHub.

Does AvenUI support mobile?

Yes. The interface is designed with touch interaction in mind.

Can I customize the colors?

Yes.

Use "SetTheme()" for multiple properties or "SetAccent()" for the primary accent.

Can I create multiple tabs?

Yes.

local Main = Window:CreateTab("Main", "home")
local Visual = Window:CreateTab("Visual", "eye")
local Settings = Window:CreateTab("Settings", "settings")

---

Contributing

Contributions are welcome.

Before submitting a pull request:

1. Check existing issues and pull requests.
2. Keep changes focused.
3. Follow the existing coding style.
4. Test your changes.
5. Explain what was changed and why.

For major changes, open an issue first so the approach can be discussed.

---

License

AvenUI is licensed under the MIT License.

See ""LICENSE"" (LICENSE) for the complete license text.

---

<div align="center">AvenUI

Clean UI. Simple API. Full control.

Made by Gixss

"GitHub" (https://github.com/Gixss/Aven-Ui) · "Discord" (https://discord.gg/q7PZBsbpD)

</div>
