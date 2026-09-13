<div align="center">AvenUI

A lightweight Roblox UI library built from scratch.

Single file · Zero dependencies · Built-in icons · Runtime themes

AvenUI is a minimal and customizable UI library for Roblox,
built with native Roblox GUI objects and designed to stay simple, fast, and easy to modify.

<br>"Features" (#features) · "Installation" (#installation) · "Quick Start" (#quick-start) · "Elements" (#elements) · "Icons" (#icons) · "Themes" (#themes) · "API" (#api)

</div>---

Why AvenUI?

Most Roblox UI libraries become difficult to maintain because they rely on large frameworks, external packages, or complicated abstractions.

AvenUI takes a different approach.

The entire library is contained in a single Lua file, with its UI built directly from Roblox's native GUI objects.

That means:

- No UI framework required
- No third-party dependencies
- No hidden HTTP requests
- Built-in icon system
- Centralized theme system
- Mouse and touch support
- Easy-to-read source
- Easy to customize

«Small enough to understand. Powerful enough to build with.»

---

Features

<table>
<tr>
<td width="50%">UI

- Draggable window
- Minimize support
- Keyboard toggle
- Sidebar navigation
- Tab search
- Notifications
- Sections & dividers
- Touch-friendly controls

</td>
<td width="50%">Customization

- Runtime themes
- Custom accent colors
- Built-in icon system
- Configurable window size
- Custom fonts
- Danger-state buttons
- Custom callbacks
- Simple API

</td>
</tr>
</table>---

Installation

Loadstring

The easiest way to use AvenUI:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"
))()

That's it.

No additional libraries are required.

Manual

You can also download "AvenUi.lua" and include it directly in your project.

---

Quick Start

Create a window and add your first element:

local AvenUI = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"
))()

local Window = AvenUI:CreateWindow({
    Name = "My Hub",
    Subtitle = "by Gixss",
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

Default controls

Action| Input
Drag window| Mouse / Touch
Minimize| Top bar "-" button
Toggle UI| "RightControl"
Close| Top bar close button

The toggle key can be changed through "ToggleKey".

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
        print("Speed:", value)
    end,
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
            Content = "Settings saved successfully",
            Icon = "check",
            Accent = Color3.fromRGB(34, 197, 94),
            Duration = 3,
        })
    end,
})

-- Misc
local Misc = Window:CreateTab("Misc", "settings")

Misc:Section("Input", "key")

Misc:Input({
    Name = "Username",
    Icon = "user",
    Placeholder = "Enter username...",

    Callback = function(text)
        print("Username:", text)
    end,
})

Misc:Keybind({
    Name = "Panic Key",
    Icon = "key",
    CurrentKeybind = Enum.KeyCode.P,

    Callback = function(key)
        print("Key:", key.Name)
    end,
})

Misc:Divider("Danger Zone")

Misc:Button({
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

AvenUI keeps its element API intentionally simple.

Element| Method| Returns
Section| "Tab:Section(text, icon?)"| —
Toggle| "Tab:Toggle(options)"| "Set", "Get"
Slider| "Tab:Slider(options)"| "Set", "Get"
Button| "Tab:Button(options)"| —
Input| "Tab:Input(options)"| "Set", "Get"
Dropdown| "Tab:Dropdown(options)"| "Set", "Get"
Keybind| "Tab:Keybind(options)"| "Get"
Label| "Tab:Label(options)"| —
Divider| "Tab:Divider(text?)"| —
Notification| "AvenUI:Notify(options)"| —

---

Toggle

local Toggle = Tab:Toggle({
    Name = "Auto Farm",
    Icon = "bolt",
    CurrentValue = false,

    Callback = function(state)
        print(state)
    end,
})

Toggle:Set(true)

print(Toggle:Get())

---

Slider

local Slider = Tab:Slider({
    Name = "Walk Speed",
    Icon = "activity",

    Range = {16, 200},
    Increment = 1,
    Suffix = " studs",
    CurrentValue = 16,

    Callback = function(value)
        print(value)
    end,
})

Slider:Set(50)

print(Slider:Get())

---

Button

Tab:Button({
    Name = "Apply",
    Icon = "check",

    Callback = function()
        print("Applied")
    end,
})

Danger buttons are supported:

Tab:Button({
    Name = "Delete",
    Icon = "trash",
    Danger = true,

    Callback = function()
        print("Deleted")
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

Input:Set("Player")

print(Input:Get())

---

Dropdown

local Dropdown = Tab:Dropdown({
    Name = "Mode",
    Icon = "grid",

    Options = {
        "Default",
        "Fast",
        "Safe",
    },

    CurrentOption = "Default",

    Callback = function(option)
        print(option)
    end,
})

Dropdown:Set("Fast")

print(Dropdown:Get())

---

Keybind

local Keybind = Tab:Keybind({
    Name = "Open Menu",
    Icon = "key",
    CurrentKeybind = Enum.KeyCode.P,

    Callback = function(key)
        print(key.Name)
    end,
})

print(Keybind:Get())

---

Labels & Dividers

Tab:Label({
    Text = "A simple information label."
})

Tab:Divider("Advanced")

---

Icons

AvenUI includes a built-in icon system with 60+ icon names and aliases.

Icons are created from Roblox GUI primitives rather than requiring a third-party icon package.

Tab:Toggle({
    Name = "Settings",
    Icon = "settings",
})

Available icons

activity    aim         alert        arrow-down
arrow-left  arrow-right arrow-up     bell
bolt        cart        check        chevron-down
chevron-left chevron-right chevron-up chip
close       code        cog          combat
copy        cpu         crosshair    crown
delete      dev         diamond      discord
document    download    edit         exit
eye         favorite    file         filter
find        fire        flame        folder
gear        gem         globe        grid
heart       home        house        info
key         like        lightning    link
list        location    lock         map
menu        minus       moon         notif
pause       pencil      pin          play
plus        power       profile      protect
refresh     reload      remove       script
search      secure      settings     shield
shop        sparkle     star         stop
sun         sword       sync         tag
target      terminal    tick         trash
upload      user        view         vip
volume      warning     wifi         x
zap

You can also inspect the available names at runtime:

print(AvenUI.IconNames)

Custom asset icons

If needed, an icon can also reference a Roblox asset:

Icon = 1234567890

or:

Icon = "rbxassetid://1234567890"

---

Themes

AvenUI uses a centralized theme system so the entire UI can follow your preferred style.

Change multiple properties

AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg = Color3.fromRGB(15, 15, 20),
})

Change only the accent

AvenUI:SetAccent(
    Color3.fromRGB(239, 68, 68)
)

Read the current theme

local Theme = AvenUI:GetTheme()

print(Theme.Accent)

Theme properties

Property| Description
"Bg"| Main background
"BgTop"| Top bar background
"BgSide"| Sidebar background
"Item"| Element background
"ItemHover"| Hover background
"Input"| Input background
"Track"| Slider / toggle track
"Border"| Primary border
"BorderSoft"| Secondary border
"Text"| Primary text
"SubText"| Secondary text
"Muted"| Muted text
"Accent"| Primary accent
"AccentDim"| Dimmed accent
"Danger"| Destructive actions
"Warn"| Warning state
"Info"| Information state
"Success"| Success state
"Radius"| Default radius
"RadiusSm"| Small radius
"RadiusLg"| Large radius
"HeaderH"| Header height
"SidebarW"| Sidebar width

---

Notifications

AvenUI includes a lightweight notification system.

AvenUI:Notify({
    Title = "Success",
    Content = "Settings saved successfully.",
    Icon = "check",
    Accent = Color3.fromRGB(34, 197, 94),
    Duration = 3,
})

Notifications support custom:

- Title
- Content
- Icon
- Accent
- Duration

---

API

AvenUI

AvenUI:CreateWindow(options)

AvenUI:Notify(options)

AvenUI:SetTheme(theme)

AvenUI:SetAccent(color)

AvenUI:GetTheme()

Useful properties:

AvenUI.Icon
AvenUI.IconNames
AvenUI.Theme
AvenUI.Version

---

Window

Window:CreateTab(name, icon)

Window:Destroy()

Window.SetTitle(text)

Window.SetSubtitle(text)

---

Tab

Tab:Section(text, icon?)

Tab:Toggle(options)

Tab:Slider(options)

Tab:Button(options)

Tab:Input(options)

Tab:Dropdown(options)

Tab:Keybind(options)

Tab:Label(options)

Tab:Divider(text?)

---

Compatibility

AvenUI is designed for both desktop and mobile Roblox clients.

Input

- Mouse
- Touch
- Keyboard

Platforms

- PC
- Mobile

The UI uses Roblox's standard GUI and input services, making it suitable for projects where you want the same interface to work across different input methods.

---

Performance

AvenUI is intentionally lightweight.

The library:

- Uses a single source file
- Avoids external UI dependencies
- Uses Roblox's native GUI objects
- Uses "TweenService" for animations
- Uses "UserInputService" for input
- Does not perform HTTP requests internally

The goal is not to create the biggest UI framework possible.

The goal is to make a UI library that is small, understandable, and actually pleasant to use.

---

Philosophy

AvenUI follows four principles:

Simple

One file. Small API. No unnecessary framework.

Clean

Minimal visual design without relying on huge asset packs.

Customizable

Themes, colors, icons, dimensions, and callbacks are exposed to the developer.

Yours

The source is there to be read, modified, and extended.

---

Contributing

Contributions are welcome.

If you want to make a major change, open an issue first so the direction can be discussed.

For pull requests:

1. Keep the implementation readable.
2. Avoid unnecessary dependencies.
3. Keep the API consistent.
4. Test changes on both desktop and mobile where possible.

---

License

AvenUI is released under the MIT License.

See ""LICENSE"" (LICENSE) for the full license.

---

<div align="center">AvenUI

Built from scratch by Gixss.

Clean UI. Simple API. No unnecessary baggage.

<br>"GitHub" (https://github.com/Gixss/Aven-Ui)

</div>
