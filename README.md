<div align="center">

# AvenUI

**A dependency-free Roblox UI library with hand-drawn vector icons.**

**Library UI Roblox tanpa dependensi, dengan ikon vektor yang digambar dari nol.**

<br>

[![Version](https://img.shields.io/badge/version-2.0.0-84cc16?style=for-the-badge&labelColor=0a0b0d)](https://github.com/Gixss/Aven-Ui/releases)
[![License](https://img.shields.io/badge/license-MIT-84cc16?style=for-the-badge&labelColor=0a0b0d)](LICENSE)
[![Lua](https://img.shields.io/badge/lua-5.1-2C2D72?style=for-the-badge&labelColor=0a0b0d&logo=lua&logoColor=white)](https://www.lua.org)
[![Roblox](https://img.shields.io/badge/roblox-compatible-84cc16?style=for-the-badge&labelColor=0a0b0d)](https://www.roblox.com)
[![Stars](https://img.shields.io/github/stars/Gixss/Aven-Ui?style=for-the-badge&color=84cc16&labelColor=0a0b0d)](https://github.com/Gixss/Aven-Ui/stargazers)

<br>

[Why](#why-avenui) · [Features](#features) · [Installation](#installation) · [Quick Start](#quick-start) · [Full Example](#full-example) · [Elements](#elements) · [Icons](#icons) · [Config Storage](#config-storage) · [Theme](#theme) · [API](#api-reference)

</div>

---

## Why AvenUI

### English

Most UI libraries depend on Roblox's asset marketplace, unicode characters, or third-party icon packs. That means slow load times, broken icons after moderation, and hidden network calls.

AvenUI does none of that.

Every icon is drawn pixel-by-pixel using `Frame` primitives and `UIStroke`. Every color comes from a runtime-swappable theme. Every element is under 40 lines — readable, hackable, yours.

### Indonesia

Sebagian besar library UI bergantung pada marketplace aset Roblox, karakter unicode, atau pak ikon pihak ketiga. Akibatnya loading lambat, ikon rusak setelah moderasi, dan panggilan network tersembunyi.

AvenUI tidak seperti itu.

Setiap ikon digambar pixel-by-pixel menggunakan primitif `Frame` dan `UIStroke`. Setiap warna berasal dari tema yang bisa diganti saat runtime. Setiap elemen di bawah 40 baris — mudah dibaca, mudah dimodifikasi, milikmu.

---

## Features

| Feature | English | Indonesia |
|---|---|---|
| Icons | 45+ hand-drawn Lucide-style icons | 45+ ikon Lucide-style digambar manual |
| Size | Single file, zero dependencies | Satu file, tanpa dependensi |
| Theme | Runtime swappable | Bisa diganti saat runtime |
| Mobile | Touch-friendly | Ramah sentuhan |
| Network | No HTTP calls at all | Tanpa network call sama sekali |
| Performance | Smooth 60+ FPS animations | Animasi UI mulus 60+ FPS |
| Window | Draggable, minimizable | Bisa digeser, bisa di-minimize |
| Search | Built-in sidebar filter | Filter pencarian di sidebar |
| Elements | 11 element types | 11 tipe elemen |
| Storage | Auto-create `Aven UI` folder | Auto-bikin folder `Aven UI` |
| Config | Save/load flags to disk | Simpan/muat flag ke disk |

---

## Installation

### English

**One-liner (recommended):**

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"))()
```

**Inline:** Download `AvenUi.lua` and drop it into your project.

### Indonesia

**Satu baris (direkomendasikan):**

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"))()
```

**Inline:** Unduh `AvenUi.lua` lalu masukkan ke dalam project kamu.

---

## Quick Start

**English:** The shortest working example — 8 lines.

**Indonesia:** Contoh terpendek yang langsung jalan — 8 baris.

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"))()

local Window = AvenUI:CreateWindow({
    Name     = "My Hub",
    Subtitle = "by YourName",
    Icon     = "sparkle",
})

local Tab = Window:CreateTab("Main", "home")

Tab:Toggle({
    Name     = "Enable",
    Icon     = "power",
    Callback = function(state) print(state) end,
})
```

> **English:** Run it — a window appears in the center of your screen. Drag by the top bar, minimize with the `-` button, hide with `Right Ctrl`. A folder named `Aven UI` is automatically created in your executor workspace.
>
> **Indonesia:** Jalankan — window muncul di tengah layar. Geser dengan menahan top bar, minimize dengan tombol `-`, sembunyikan dengan `Ctrl Kanan`. Folder bernama `Aven UI` otomatis dibuat di workspace executor.

---

## Full Example

**English:** Complete showcase with every element type.

**Indonesia:** Contoh lengkap dengan semua tipe elemen.

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/refs/heads/main/AvenUi.lua"))()

local Window = AvenUI:CreateWindow({
    Name      = "Aven Hub",
    Subtitle  = "by Gixss",
    Icon      = "sparkle",
    Width     = 580,
    Height    = 420,
    ToggleKey = Enum.KeyCode.RightControl,
})

-- Tab 1: Main
local MainTab = Window:CreateTab("Main", "home")

MainTab:Section("Character", "user")

MainTab:Slider({
    Name         = "Walk Speed",
    Icon         = "power",
    Range        = { 16, 200 },
    Increment    = 1,
    Suffix       = " studs",
    CurrentValue = 16,
    Flag         = "speed",
    Callback     = function(v) print("Speed:", v) end,
})

MainTab:Slider({
    Name         = "Jump Power",
    Icon         = "bolt",
    Range        = { 50, 200 },
    Increment    = 5,
    Suffix       = " jp",
    CurrentValue = 50,
    Flag         = "jump",
})

MainTab:Toggle({
    Name         = "Infinite Jump",
    Icon         = "arrow-up",
    CurrentValue = false,
    Flag         = "infJump",
    Callback     = function(state) print("Inf Jump:", state) end,
})

MainTab:Toggle({
    Name         = "No Clip",
    Icon         = "shield",
    CurrentValue = false,
    Flag         = "noClip",
})

-- Tab 2: Visual
local VisualTab = Window:CreateTab("Visual", "eye")

VisualTab:Section("Rendering", "sparkle")

VisualTab:Dropdown({
    Name          = "Quality",
    Icon          = "grid",
    Options       = { "Low", "Medium", "High", "Ultra" },
    CurrentOption = "Medium",
    Callback      = function(opt) print("Quality:", opt) end,
})

VisualTab:Button({
    Name     = "Apply Settings",
    Icon     = "check",
    Callback = function()
        AvenUI:Notify({
            Title    = "Applied",
            Content  = "Settings saved successfully",
            Icon     = "check",
            Accent   = Color3.fromRGB(34, 197, 94),
            Duration = 3,
        })
    end,
})

-- Tab 3: Misc
local MiscTab = Window:CreateTab("Misc", "settings")

MiscTab:Section("Input", "key")

MiscTab:Input({
    Name        = "Webhook URL",
    Icon        = "link",
    Placeholder = "https://discord.com/api/webhooks/...",
    Callback    = function(text) print("Webhook:", text) end,
})

MiscTab:Keybind({
    Name           = "Panic Key",
    Icon           = "key",
    CurrentKeybind = Enum.KeyCode.P,
    Callback       = function(key) print("Panic:", key.Name) end,
})

MiscTab:Divider("config")

MiscTab:Button({
    Name     = "Save Config",
    Icon     = "download",
    Callback = function()
        if Window:SaveConfig() then
            AvenUI:Notify({
                Title   = "Saved",
                Content = "Config stored to Aven UI folder",
                Icon    = "check",
            })
        end
    end,
})

MiscTab:Button({
    Name     = "Load Config",
    Icon     = "upload",
    Callback = function()
        Window:LoadConfig()
    end,
})
```

---

## Elements

| Element | Method | Returns |
|---|---|---|
| Section | `Tab:Section(text, icon?)` | — |
| Toggle | `Tab:Toggle(opts)` | `{ Set, Get }` |
| Slider | `Tab:Slider(opts)` | `{ Set, Get }` |
| Button | `Tab:Button(opts)` | — |
| Input | `Tab:Input(opts)` | `{ Set, Get }` |
| Dropdown | `Tab:Dropdown(opts)` | `{ Set, Get }` |
| Keybind | `Tab:Keybind(opts)` | `{ Get }` |
| Label | `Tab:Label(opts)` | — |
| Divider | `Tab:Divider(text?)` | — |
| Notification | `AvenUI:Notify(opts)` | — |

---

## Icons

### English

AvenUI ships with 45+ hand-drawn Lucide-style icons. Thin strokes, rounded joints, clean look. Three ways to add an icon:

### Indonesia

AvenUI hadir dengan 45+ ikon Lucide-style yang digambar manual. Garis tipis, ujung membulat, tampilan bersih. Tiga cara menambahkan ikon:

```lua
Tab:Toggle({ Name = "Named",     Icon = "gear" })
Tab:Toggle({ Name = "Asset ID",  Icon = 1234567890 })
Tab:Toggle({ Name = "Asset URL", Icon = "rbxassetid://1234567890" })
```

### Available Icon Names

```
activity     alert        arrow-down   arrow-left   arrow-right
arrow-up     bell         bolt         check        chevron-down
chevron-left chevron-right chevron-up  chip         close
code         cog          combat       copy         cpu
crosshair    crown        delete       dev          diamond
discord      download     edit         exit         eye
file         filter       fire         flame        folder
gear         gem          globe        grid         heart
home         house        info         key          like
lightning    link         list         location     lock
map          menu         minus        moon         notif
pause        pin          play         plus         power
profile      protect      refresh      reload       remove
script       search       settings     shield         sparkle
star         stop         sun          sword        target
terminal     tick         trash        upload       user
view         vip          warning      x            zap
```

Get the full list at runtime / Ambil daftar lengkap saat runtime:

```lua
print(AvenUI.IconNames)
```

---

## Config Storage

### English

AvenUI automatically creates a folder named `Aven UI` in the executor workspace the moment the library loads. You can save and load flags (toggle/slider values) as JSON without worrying about file paths.

```lua
-- Save all flags to Aven UI/config.json
Window:SaveConfig()

-- Load flags from Aven UI/config.json
Window:LoadConfig()

-- Manual file operations
AvenUI:SaveFile("notes.txt", "hello world")
local content = AvenUI:LoadFile("notes.txt")
local files = AvenUI:ListFiles()
```

To make flags savable, add a `Flag` field to any Toggle or Slider:

```lua
Tab:Toggle({ Name = "Auto Farm", Flag = "autoFarm" })
Tab:Slider({ Name = "Speed", Flag = "speed" })
```

### Indonesia

AvenUI otomatis membuat folder bernama `Aven UI` di workspace executor begitu library dijalankan. Kamu bisa simpan dan muat flag (nilai toggle/slider) sebagai JSON tanpa memikirkan path file.

```lua
-- Simpan semua flag ke Aven UI/config.json
Window:SaveConfig()

-- Muat flag dari Aven UI/config.json
Window:LoadConfig()

-- Operasi file manual
AvenUI:SaveFile("notes.txt", "hello world")
local content = AvenUI:LoadFile("notes.txt")
local files = AvenUI:ListFiles()
```

Supaya flag bisa disimpan, tambahkan field `Flag` ke Toggle atau Slider:

```lua
Tab:Toggle({ Name = "Auto Farm", Flag = "autoFarm" })
Tab:Slider({ Name = "Speed", Flag = "speed" })
```

---

## Theme

### Override Theme / Ganti Tema

```lua
AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg     = Color3.fromRGB(15, 15, 20),
})
```

### Set Accent Only / Ganti Accent Saja

```lua
AvenUI:SetAccent(Color3.fromRGB(239, 68, 68))
```

### Read Current Theme / Baca Tema Saat Ini

```lua
local theme = AvenUI:GetTheme()
print(theme.Accent)
```

### Theme Properties / Properti Tema

| Key | English | Indonesia |
|---|---|---|
| `Bg` | Main window background | Background window utama |
| `BgTop` | Topbar background | Background top bar |
| `BgSide` | Sidebar background | Background sidebar |
| `Item` | Default element background | Background elemen default |
| `ItemHover` | Hover state | Warna saat hover |
| `Input` | TextBox background | Background TextBox |
| `Track` | Slider and toggle track | Track slider dan toggle |
| `Border` | Primary stroke color | Warna stroke utama |
| `BorderSoft` | Secondary stroke color | Warna stroke sekunder |
| `Text` | Primary text | Teks utama |
| `SubText` | Secondary text | Teks sekunder |
| `Muted` | Muted text | Teks redup |
| `Accent` | Brand accent | Warna aksen brand |
| `AccentDim` | Dimmed accent | Aksen diredupkan |
| `Danger` | Destructive action | Untuk aksi berbahaya |
| `Radius` | Default corner radius | Radius sudut default |
| `RadiusSm` | Small radius | Radius kecil |
| `RadiusLg` | Large radius | Radius besar |
| `HeaderH` | Topbar height | Tinggi top bar |
| `SidebarW` | Sidebar width | Lebar sidebar |

---

## API Reference

### `AvenUI:CreateWindow(opts)`

**English:** Creates the main window. Returns a `Window` object.

**Indonesia:** Membuat window utama. Mengembalikan objek `Window`.

### `Window:CreateTab(name, icon)`

**English:** Creates a tab inside the window. Returns a `Tab` object.

**Indonesia:** Membuat tab di dalam window. Mengembalikan objek `Tab`.

### `Window:SetTitle(text)` / `Window:SetSubtitle(text)`

**English:** Updates the title or subtitle at runtime.

**Indonesia:** Mengubah judul atau subtitle saat runtime.

### `Window:SaveConfig()` / `Window:LoadConfig()`

**English:** Save/load all flagged values to/from `Aven UI/config.json`.

**Indonesia:** Simpan/muat semua nilai flag ke/dari `Aven UI/config.json`.

### `Window:Destroy()`

**English:** Destroys the entire UI.

**Indonesia:** Menghapus seluruh UI.

### `AvenUI:Notify(opts)`

**English:** Shows a notification toast.

**Indonesia:** Menampilkan notifikasi toast.

### `AvenUI:SaveFile(name, content)`

**English:** Writes a file into the `Aven UI` folder.

**Indonesia:** Menulis file ke dalam folder `Aven UI`.

### `AvenUI:LoadFile(name)`

**English:** Reads a file from the `Aven UI` folder.

**Indonesia:** Membaca file dari folder `Aven UI`.

### `AvenUI:ListFiles()`

**English:** Returns all file paths inside the `Aven UI` folder.

**Indonesia:** Mengembalikan semua path file di dalam folder `Aven UI`.

### `AvenUI:SetTheme(table)` / `AvenUI:SetAccent(color)` / `AvenUI:GetTheme()`

**English:** Manage the global theme at runtime.

**Indonesia:** Mengatur tema global saat runtime.

---

## Compatibility

| Executor | Status |
|---|---|
| Delta | ✅ |
| Wave | ✅ |
| Xeno | ✅ |
| Fluxus | ✅ |
| Arceus X | ✅ |
| Hydrogen | ✅ |
| Codex | ✅ |
| Krnl | ✅ |
| Synapse | ✅ |
| Vega X | ✅ |

**English:** Works on PC and mobile. Config storage requires the executor to support `writefile` / `readfile`.

**Indonesia:** Berjalan di PC dan mobile. Penyimpanan config butuh executor yang mendukung `writefile` / `readfile`.

---

## Contributing

**English:** Pull requests are welcome. For major changes, please open an issue first.

**Indonesia:** Pull request sangat diterima. Untuk perubahan besar, buka issue terlebih dahulu.

---

## License

**English:** MIT — see [LICENSE](LICENSE).

**Indonesia:** MIT — lihat [LICENSE](LICENSE).

---

<div align="center">

Made by **Gixss**

[Discord](https://discord.gg/q7PZBsbpD)

</div>
