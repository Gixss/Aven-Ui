<div align="center">

<h1>AvenUI</h1>
<p><strong>A premium, dependency-free Roblox UI library — icons drawn from zero.</strong><br>
<em>Library UI Roblox premium tanpa dependensi — ikon digambar dari nol.</em></p>

![Version](https://img.shields.io/badge/version-1.0.0-5865F2?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-22c55e?style=flat-square)
![Icons](https://img.shields.io/badge/icons-60%2B-f59e0b?style=flat-square)
![Zero Dependencies](https://img.shields.io/badge/dependencies-none-ef4444?style=flat-square)

<br>

[Why](#why-avenui) · [Features](#features) · [Installation](#installation) · [Quick Start](#quick-start) · [Elements](#elements) · [Icons](#icons) · [Theme](#theme) · [API](#api-reference)

</div>

---

## Why AvenUI?

Most UI libraries lean on Roblox's asset marketplace, unicode characters, or bloated third-party icon packs — slow loads, broken icons after moderation, hidden network calls.

> *Sebagian besar library UI bergantung pada marketplace aset Roblox, karakter unicode, atau pak ikon pihak ketiga yang besar — loading lambat, ikon rusak setelah moderasi, panggilan network tersembunyi.*

AvenUI does none of that. Every icon is drawn pixel-by-pixel using `Frame` primitives and `UIStroke`. Every color comes from a runtime-swappable theme. Every element stays under 40 lines — readable, hackable, yours.

> *AvenUI tidak seperti itu. Setiap ikon digambar pixel-by-pixel menggunakan primitif `Frame` dan `UIStroke`. Setiap warna berasal dari tema yang bisa diganti saat runtime. Setiap elemen di bawah 40 baris — mudah dibaca, mudah dimodifikasi, milikmu.*

---

## Features

| Feature | English | Indonesia |
|---|---|---|
| **Icons** | 60+ hand-drawn vector icons | 60+ ikon vektor yang digambar manual |
| **Size** | Single file, zero dependencies | Satu file, tanpa dependensi |
| **Theme** | Runtime-swappable color system | Sistem warna yang bisa diganti saat runtime |
| **Mobile** | Fully touch-compatible | Sepenuhnya kompatibel sentuhan |
| **Network** | Zero HTTP calls | Tanpa network call sama sekali |
| **Performance** | Smooth 60+ FPS animations | Animasi mulus 60+ FPS |
| **Window** | Draggable & minimizable | Bisa digeser & di-minimize |
| **Search** | Built-in sidebar filter | Filter pencarian di sidebar |
| **Elements** | 11 element types | 11 tipe elemen |

---

## Installation

**Option 1 — One-liner (recommended) / Opsi 1 — Satu baris (direkomendasikan):**

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"))()
```

**Option 2 — Local / Opsi 2 — Lokal:**
Download `AvenUI.lua` and drop it into your project.
*Unduh `AvenUI.lua` lalu masukkan ke dalam project kamu.*

---

## Quick Start

The shortest working example. / *Contoh terpendek yang langsung jalan.*

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"))()

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

> Run it — a window appears center-screen. Drag by the topbar, minimize with **`−`**, toggle visibility with **Right Ctrl**.
> *Jalankan — window muncul di tengah layar. Geser dengan menahan topbar, minimize dengan tombol **`−`**, sembunyikan dengan **Ctrl Kanan**.*

---

## Full Example

Complete showcase with every element type. / *Contoh lengkap dengan semua tipe elemen.*

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gixss/Aven-Ui/main/AvenUI.lua"))()

local Window = AvenUI:CreateWindow({
    Name      = "Aven Hub",
    Subtitle  = "by Gixss",
    Icon      = "sparkle",
    Width     = 560,
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
    Callback     = function(v) print("Speed:", v) end,
})

MainTab:Slider({
    Name         = "Jump Power",
    Icon         = "bolt",
    Range        = { 50, 200 },
    Increment    = 5,
    Suffix       = " jp",
    CurrentValue = 50,
})

MainTab:Toggle({
    Name         = "Infinite Jump",
    Icon         = "arrow-up",
    CurrentValue = false,
    Callback     = function(state) print("Inf Jump:", state) end,
})

MainTab:Toggle({
    Name         = "No Clip",
    Icon         = "shield",
    CurrentValue = false,
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

MiscTab:Divider("danger zone")

MiscTab:Button({
    Name     = "Reset All",
    Icon     = "trash",
    Danger   = true,
    Callback = function()
        AvenUI:Notify({
            Title    = "Reset",
            Content  = "All settings cleared",
            Icon     = "warning",
            Accent   = Color3.fromRGB(239, 68, 68),
            Duration = 3,
        })
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

AvenUI ships with 60+ hand-drawn vector icons. Every icon is built from `Frame` primitives — no unicode, no emoji, no external assets.

*AvenUI hadir dengan 60+ ikon vektor yang digambar manual. Setiap ikon dibuat dari primitif `Frame` — tanpa unicode, tanpa emoji, tanpa aset eksternal.*

Three ways to pass an icon: / *Tiga cara memasukkan ikon:*

```lua
Tab:Toggle({ Name = "Named",     Icon = "gear" })
Tab:Toggle({ Name = "Asset ID",  Icon = 1234567890 })
Tab:Toggle({ Name = "Asset URL", Icon = "rbxassetid://1234567890" })
```

### Available Icon Names

```
activity     aim          alert        arrow-down   arrow-left
arrow-right  arrow-up     bell         bolt         cart
check        chevron-down chevron-left chevron-right chevron-up
chip         close        code         cog          combat
copy         cpu          crosshair    crown        delete
dev          diamond      discord      document     download
edit         exit         eye          favorite     file
filter       find         fire         flame        folder
gear         gem          globe        grid         heart
home         house        info         key          like
lightning    link         list         location     lock
map          menu         minus        moon         notif
pause        pencil       pin          play         plus
power        profile      protect      refresh      reload
remove       script       search       secure       settings
shield       shop         sparkle      star         stop
sun          sword        sync         tag          target
terminal     tick         trash        upload       user
view         vip          volume       warning      wifi
x            zap
```

Get the full list at runtime: / *Ambil daftar lengkap saat runtime:*

```lua
print(AvenUI.IconNames)
```

---

## Theme

**Override Theme / Ganti Tema:**

```lua
AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg     = Color3.fromRGB(15, 15, 20),
})
```

**Set Accent Only / Ganti Accent Saja:**

```lua
AvenUI:SetAccent(Color3.fromRGB(239, 68, 68))
```

**Read Current Theme / Baca Tema Saat Ini:**

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
| `Warn` | Warning state | Untuk peringatan |
| `Info` | Info state | Untuk informasi |
| `Success` | Success state | Untuk keberhasilan |
| `Radius` | Default corner radius | Radius sudut default |
| `RadiusSm` | Small radius | Radius kecil |
| `RadiusLg` | Large radius | Radius besar |
| `HeaderH` | Topbar height | Tinggi top bar |
| `SidebarW` | Sidebar width | Lebar sidebar |

---

## API Reference

### `AvenUI:CreateWindow(opts)`

Creates the main window. Returns a `Window` object.
*Membuat window utama. Mengembalikan objek `Window`.*

### `Window:CreateTab(name, icon)`

Creates a tab inside the window. Returns a `Tab` object.
*Membuat tab di dalam window. Mengembalikan objek `Tab`.*

### `Window:SetTitle(text)`

Updates the window title at runtime.
*Mengubah judul window saat runtime.*

### `Window:SetSubtitle(text)`

Updates the window subtitle at runtime.
*Mengubah subtitle window saat runtime.*

### `Window:Destroy()`

Destroys the entire UI.
*Menghapus seluruh UI.*

### `AvenUI:Notify(opts)`

Shows a notification toast.
*Menampilkan notifikasi toast.*

| Option | Type | Description |
|---|---|---|
| `Title` | string | Notification title |
| `Content` | string | Body text |
| `Icon` | string | Icon name |
| `Accent` | Color3 | Accent color |
| `Duration` | number | Seconds before auto-dismiss |

### `AvenUI:SetTheme(table)`

Merges a table into the active theme.
*Menggabungkan tabel ke dalam tema aktif.*

### `AvenUI:SetAccent(color)`

Sets the primary accent color and recalculates derived colors.
*Mengatur warna aksen utama dan menghitung ulang warna turunannya.*

### `AvenUI:GetTheme()`

Returns the current theme table.
*Mengembalikan tabel tema saat ini.*

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

Works on PC and mobile. Fully touch-compatible.
*Berjalan di PC dan mobile. Sepenuhnya kompatibel dengan sentuhan.*

---

## Contributing

Pull requests are welcome. For major changes, open an issue first so we can discuss what you'd like to change.

*Pull request sangat diterima. Untuk perubahan besar, buka issue terlebih dahulu agar kita bisa diskusi dulu.*

---

## License

MIT — see [LICENSE](LICENSE).

---

<div align="center">
Made by Gixss · <a href="#">Discord</a>
</div>
