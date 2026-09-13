Nah, kalau maunya lebih bagus dan lebih “niat”, kita bisa bikin README-nya seperti dokumentasi library Roblox yang benar-benar profesional — bukan sekadar daftar API.

Aku sarankan strukturnya seperti ini:

Hero/header AvenUI

Badges

Short description

Navigation / Table of Contents

Showcase / Preview

Why AvenUI?

Highlights

Features lengkap

Design philosophy

Installation

Quick Start

Full Example

Window configuration

Tabs

Semua Elements

Icon system

Daftar 80+ icon

Theme system

Theme presets

Notifications

API Reference

Methods & properties

Mobile support

Keyboard controls

Performance

Compatibility

FAQ

Troubleshooting

Contributing

Roadmap

License

Credits


Dan semua Markdown-nya dibuat benar, jadi saat dipaste ke GitHub tidak berubah menjadi teks/kode berantakan.

Contoh bagian awalnya bisa dibuat jauh lebih keren seperti ini:


---

AvenUI

A premium, dependency-free Roblox UI library built for clean, modern, and customizable interfaces.

AvenUI focuses on a simple idea:

> Clean UI. Zero dependencies. Hand-drawn icons. Full control.



    


---

Navigation

About

Features

Why AvenUI?

Installation

Quick Start

Full Example

Windows

Tabs

Elements

Icons

Themes

Notifications

API Reference

Mobile Support

Compatibility

FAQ

Troubleshooting

Roadmap

Contributing

License



---

About

AvenUI is a lightweight Roblox UI library designed for developers who want a polished interface without relying on large third-party frameworks.

Unlike many UI libraries, AvenUI is designed around:

No external icon packs

No Unicode-based icons

No emoji

No library dependencies

No built-in HTTP requests

Runtime theme customization

PC and mobile support

Simple and readable APIs


The result is a UI system that is easy to integrate, customize, and extend.


---

Why AvenUI?

Lightweight

AvenUI is distributed as a single Lua file with no required dependencies.

Custom Icons

The library includes 60+ hand-drawn vector-style icons built specifically for AvenUI.

No external icon package is required.

Runtime Themes

Change colors and visual properties while the interface is running.

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg = Color3.fromRGB(15, 15, 20),
})

Mobile Ready

Controls are designed with touch interaction in mind, making AvenUI suitable for both desktop and mobile Roblox clients.

Developer Friendly

AvenUI's API is intentionally simple:

Tab:Toggle({...})
Tab:Slider({...})
Tab:Button({...})
Tab:Dropdown({...})
Tab:Input({...})
Tab:Keybind({...})


---

Features

Category	Included

UI	Modern dark interface
Window	Draggable, minimizable
Sidebar	Search and filtering
Tabs	Multiple configurable tabs
Icons	60+ custom icons
Themes	Runtime theme switching
Notifications	Animated toast notifications
Input	Text input and keybinds
Controls	Toggle, slider, dropdown, button
Mobile	Touch-friendly
Dependencies	None
Network	No built-in HTTP requests
Distribution	Single Lua file



---

Installation

Loadstring

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"
))()

Local Installation

Download AvenUI.lua and place it directly into your project.

Then require/load it from your own environment.


---

Quick Start

Creating your first AvenUI window only takes a few lines:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"
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

Default Controls

Action	Control

Move window	Drag top bar
Minimize	- button
Toggle UI	RightControl



---

Full Example

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

-- Main Tab
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
})

Main:Toggle({
    Name = "No Clip",
    Icon = "shield",
    CurrentValue = false,
})

-- Visual Tab
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
            Content = "Settings saved successfully",
            Icon = "check",
            Accent = Color3.fromRGB(34, 197, 94),
            Duration = 3,
        })
    end,
})


---

Elements

AvenUI provides a collection of lightweight UI elements.

Toggle

local Toggle = Tab:Toggle({
    Name = "Enable Feature",
    Icon = "power",

    CurrentValue = false,

    Callback = function(state)
        print(state)
    end,
})

Returns:

Toggle:Set(true)
Toggle:Get()


---

Slider

local Slider = Tab:Slider({
    Name = "Walk Speed",
    Icon = "power",

    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Suffix = " studs",

    Callback = function(value)
        print(value)
    end,
})


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
        print(option)
    end,
})


---

Input

local Input = Tab:Input({
    Name = "Username",
    Icon = "user",

    Placeholder = "Enter username...",

    Callback = function(text)
        print(text)
    end,
})


---

Keybind

local Keybind = Tab:Keybind({
    Name = "Toggle Menu",
    Icon = "key",

    CurrentKeybind = Enum.KeyCode.RightControl,

    Callback = function(key)
        print(key.Name)
    end,
})


---

Icons

AvenUI includes a large collection of built-in icons.

Tab:Button({
    Name = "Settings",
    Icon = "settings",
})

Icon Sources

AvenUI supports:

Named icons

Icon = "settings"

Asset IDs

Icon = 1234567890

Roblox asset URLs

Icon = "rbxassetid://1234567890"

Built-in Icons

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

Get the icon list at runtime:

print(AvenUI.IconNames)


---

Themes

AvenUI uses a centralized theme system.

Set Theme

AvenUI:SetTheme({
    Bg = Color3.fromRGB(15, 15, 20),
    Accent = Color3.fromRGB(88, 101, 242),
})

Change Accent

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Read Theme

local Theme = AvenUI:GetTheme()

print(Theme.Bg)
print(Theme.Accent)

Theme Properties

Property	Description

Bg	Main background
BgTop	Top bar background
BgSide	Sidebar background
Item	Element background
ItemHover	Hover background
Input	Input background
Track	Slider/toggle track
Border	Primary border
BorderSoft	Secondary border
Text	Primary text
SubText	Secondary text
Muted	Muted text
Accent	Main accent
AccentDim	Dimmed accent
Danger	Destructive actions
Warn	Warning state
Info	Information state
Success	Success state
Radius	Default radius
RadiusSm	Small radius
RadiusLg	Large radius
HeaderH	Header height
SidebarW	Sidebar width



---

Notifications

Display lightweight notification toasts with:

AvenUI:Notify({
    Title = "Success",
    Content = "Settings saved successfully.",
    Icon = "check",

    Accent = Color3.fromRGB(34, 197, 94),
    Duration = 3,
})

Supported notification states can be represented using the theme's:

Success

Danger

Warn

Info



---

API Reference

Window

Method	Description

AvenUI:CreateWindow(opts)	Create a window
Window:CreateTab(name, icon)	Create a tab
Window:SetTitle(text)	Change title
Window:SetSubtitle(text)	Change subtitle
Window:Destroy()	Destroy UI


Global

Method	Description

AvenUI:Notify(opts)	Show notification
AvenUI:SetTheme(table)	Update theme
AvenUI:SetAccent(color)	Change accent
AvenUI:GetTheme()	Get active theme



---

Mobile Support

AvenUI is designed to work across different screen sizes.

The interface focuses on:

Touch-friendly controls

Comfortable button sizes

Responsive interaction

Draggable windows

Mobile-friendly sidebar navigation


PC keyboard controls remain available where supported.


---

Compatibility

AvenUI has been tested with several Roblox environments.

Environment	Status

Delta	Supported
Wave	Supported
Xeno	Supported
Fluxus	Supported
Arceus X	Supported
Hydrogen	Supported
Codex	Supported
Krnl	Supported
Synapse	Supported
Vega X	Supported


> Compatibility may change as Roblox and third-party environments receive updates.




---

Performance

AvenUI is designed to remain lightweight by avoiding unnecessary dependencies and external resources.

Performance principles

Minimal dependencies

No external icon packages

No built-in HTTP requests

Lightweight GUI primitives

Reusable theme system

Simple element architecture


Actual performance depends on the device, Roblox client, executor, and complexity of the interface being created.


---

FAQ

Does AvenUI require external assets?

No. Built-in icons are included as part of the library.

Does AvenUI require dependencies?

No. AvenUI is distributed as a single Lua file.

Does AvenUI make HTTP requests?

The library itself does not make network requests.

The loadstring example fetches the library source from GitHub; this is separate from the library's runtime behavior.

Does it work on mobile?

Yes. AvenUI is designed with touch interaction in mind.

Can I customize the colors?

Yes. Use SetTheme() or SetAccent().

Can I create multiple tabs?

Yes.

local Main = Window:CreateTab("Main", "home")
local Visual = Window:CreateTab("Visual", "eye")
local Settings = Window:CreateTab("Settings", "settings")


---

Troubleshooting

UI does not appear

Check that:

1. The AvenUI source is loading correctly.


2. Your environment supports the required Roblox APIs.


3. The script does not stop due to another error.


4. You are using a current version of AvenUI.



An icon does not appear

Make sure the icon name exists:

print(AvenUI.IconNames)

Theme changes are not visible

Make sure the property name matches one of the supported theme properties.

For example:

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
})


---

Roadmap

Planned improvements may include:

[ ] More built-in icons

[ ] Additional UI elements

[ ] More theme presets

[ ] Improved mobile layouts

[ ] More animation options

[ ] Extended API documentation

[ ] Additional customization options

[ ] Improved accessibility

[ ] More examples


> The roadmap may change as AvenUI evolves.




---

Contributing

Contributions are welcome.

Before submitting a pull request

1. Check existing issues and pull requests.


2. Keep changes focused.


3. Follow the existing coding style.


4. Test your changes.


5. Explain what changed and why.



For major changes, open an issue first so the approach can be discussed.


---

License

AvenUI is licensed under the MIT License.

See LICENSE for the complete license text.


---

Credits

AvenUI

Made by Gixss

If AvenUI is useful to you, consider giving the repository a star.

Community:
https://discord.gg/q7PZBsbpD


---

<p align="center">
  <b>AvenUI</b><br>
  Clean UI. Simple API. Full control.
</p>
