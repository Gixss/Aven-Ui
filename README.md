# Aven-Ui
<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=84cc16&height=220&section=header&text=AvenUI&fontSize=90&fontAlignY=35&desc=Premium%20Roblox%20UI%20Library&descAlignY=55&descSize=18&fontColor=ffffff" width="100%"/>

**A premium, dependency-free Roblox UI library with hand-drawn vector icons.**

**Library UI Roblox premium tanpa dependensi, dengan ikon vektor yang digambar dari nol.**

No emoji · No unicode · No external assets · Just clean UI
Tanpa emoji · Tanpa unicode · Tanpa aset eksternal · Hanya UI bersih

<br/>

[![Version](https://img.shields.io/badge/version-1.0.0-84cc16?style=for-the-badge&labelColor=0a0b0d)](https://github.com/YourUser/AvenUI/releases)
[![License](https://img.shields.io/badge/license-MIT-84cc16?style=for-the-badge&labelColor=0a0b0d)](LICENSE)
[![Lua](https://img.shields.io/badge/lua-5.1-2C2D72?style=for-the-badge&labelColor=0a0b0d&logo=lua&logoColor=white)](https://www.lua.org)
[![Roblox](https://img.shields.io/badge/roblox-compatible-84cc16?style=for-the-badge&labelColor=0a0b0d)](https://www.roblox.com)
[![Stars](https://img.shields.io/github/stars/YourUser/AvenUI?style=for-the-badge&color=84cc16&labelColor=0a0b0d)](https://github.com/YourUser/AvenUI/stargazers)

<br/>

<a href="#-installation">Installation</a> ·
<a href="#-quick-start">Quick Start</a> ·
<a href="#-elements">Elements</a> ·
<a href="#-icons">Icons</a> ·
<a href="#-theme">Theme</a> ·
<a href="#-api">API</a>

</div>

---

## ⚡ Why AvenUI? / Kenapa AvenUI?

<table>
<tr>
<th width="50%">🇬🇧 English</th>
<th width="50%">🇮🇩 Indonesia</th>
</tr>
<tr>
<td>

Most UI libraries depend on Roblox's asset marketplace, unicode characters, or massive third-party icon packs. That means slow load times, broken icons after moderation, and hidden network calls.

**AvenUI does none of that.**

Every icon is **drawn pixel-by-pixel** using `Frame` primitives and `UIStroke`. Every color comes from a **runtime-swappable theme**. Every element is **under 40 lines** — readable, hackable, yours.

</td>
<td>

Sebagian besar library UI bergantung pada marketplace aset Roblox, karakter unicode, atau pak icon pihak ketiga yang besar. Akibatnya: loading lambat, ikon rusak setelah moderasi, dan panggilan network tersembunyi.

**AvenUI tidak seperti itu.**

Setiap ikon **digambar pixel-by-pixel** menggunakan primitif `Frame` dan `UIStroke`. Setiap warna berasal dari **tema yang bisa diganti saat runtime**. Setiap elemen **di bawah 40 baris** — mudah dibaca, mudah dimodifikasi, milikmu.

</td>
</tr>
</table>

<br/>

<table>
<tr>
<td width="50%" valign="top">

### ✅ AvenUI

- 🎨 **60+ vector icons** drawn from scratch
- 🚀 **Single-file**, zero dependencies
- 🌈 Runtime **theme swappable**
- 📱 **Touch-friendly** for mobile
- 🔒 No network calls, no HTTP requests
- 💎 Smooth 60+ FPS UI animations
- 📝 Fully documented

</td>
<td width="50%" valign="top">

### ✅ AvenUI

- 🎨 **60+ ikon vektor** digambar dari nol
- 🚀 **Satu file**, tanpa dependensi
- 🌈 **Tema bisa diganti** saat runtime
- 📱 **Ramah sentuhan** untuk mobile
- 🔒 Tanpa network call, tanpa HTTP
- 💎 Animasi UI mulus 60+ FPS
- 📝 Terdokumentasi lengkap

</td>
</tr>
</table>

---

## 📦 Installation / Instalasi

### One-liner (recommended) / Satu baris (direkomendasikan)

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"))()
```

### Inline

Download [`AvenUI.lua`](AvenUI.lua) and drop it into your project.
Unduh [`AvenUI.lua`](AvenUI.lua) lalu masukkan ke dalam project kamu.

---

## 🚀 Quick Start / Mulai Cepat

The shortest working example — **8 lines**.
Contoh terpendek yang langsung jalan — **8 baris**.

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"))()

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

Run it. You'll see a window appear in the middle of your screen. Drag it by the top bar. Minimize with the `–` button. Hide with <kbd>Right Ctrl</kbd>.

Jalankan. Kamu akan melihat window muncul di tengah layar. Geser dengan menahan top bar. Minimize dengan tombol `–`. Sembunyikan dengan <kbd>Ctrl Kanan</kbd>.

---

## 🖼 Full Example / Contoh Lengkap

Complete showcase with every element type.
Contoh lengkap dengan semua tipe elemen.

```lua
local AvenUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/YourUser/AvenUI/main/AvenUI.lua"))()

local Window = AvenUI:CreateWindow({
    Name      = "Aven Hub",
    Subtitle  = "by Gixss",
    Icon      = "sparkle",
    Width     = 560,
    Height    = 420,
    ToggleKey = Enum.KeyCode.RightControl,
})

-- ═══ Tab 1: Main ═══
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

-- ═══ Tab 2: Visual ═══
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

-- ═══ Tab 3: Misc ═══
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

## 🧩 Element Reference / Referensi Elemen

<table>
<tr>
<th align="left">Element</th>
<th align="left">Method</th>
<th align="left">Returns</th>
</tr>
<tr>
<td><b>Section</b></td>
<td><code>Tab:Section(text, icon?)</code></td>
<td>—</td>
</tr>
<tr>
<td><b>Toggle</b></td>
<td><code>Tab:Toggle(opts)</code></td>
<td><code>{ Set, Get }</code></td>
</tr>
<tr>
<td><b>Slider</b></td>
<td><code>Tab:Slider(opts)</code></td>
<td><code>{ Set, Get }</code></td>
</tr>
<tr>
<td><b>Button</b></td>
<td><code>Tab:Button(opts)</code></td>
<td>—</td>
</tr>
<tr>
<td><b>Input</b></td>
<td><code>Tab:Input(opts)</code></td>
<td><code>{ Set, Get }</code></td>
</tr>
<tr>
<td><b>Dropdown</b></td>
<td><code>Tab:Dropdown(opts)</code></td>
<td><code>{ Set, Get }</code></td>
</tr>
<tr>
<td><b>Keybind</b></td>
<td><code>Tab:Keybind(opts)</code></td>
<td><code>{ Get }</code></td>
</tr>
<tr>
<td><b>Label</b></td>
<td><code>Tab:Label(opts)</code></td>
<td>—</td>
</tr>
<tr>
<td><b>Divider</b></td>
<td><code>Tab:Divider(text?)</code></td>
<td>—</td>
</tr>
<tr>
<td><b>Notification</b></td>
<td><code>AvenUI:Notify(opts)</code></td>
<td>—</td>
</tr>
</table>

---

## 🎨 Icons / Ikon

### English

AvenUI ships with **60+ hand-drawn vector icons**. Every icon is built from `Frame` primitives — no unicode, no emoji, no external assets.

Three ways to add an icon:

```lua
Tab:Toggle({ Name = "Named",     Icon = "gear" })          -- by name
Tab:Toggle({ Name = "Asset ID",  Icon = 1234567890 })      -- numeric ID
Tab:Toggle({ Name = "Asset URL", Icon = "rbxassetid://1234567890" })
```

### Indonesia

AvenUI hadir dengan **60+ ikon vektor yang digambar manual**. Setiap ikon dibuat dari primitif `Frame` — tanpa unicode, tanpa emoji, tanpa aset eksternal.

Tiga cara menambahkan ikon:

```lua
Tab:Toggle({ Name = "Named",     Icon = "gear" })          -- berdasarkan nama
Tab:Toggle({ Name = "Asset ID",  Icon = 1234567890 })      -- ID numerik
Tab:Toggle({ Name = "Asset URL", Icon = "rbxassetid://1234567890" })
```

### Available icon names / Nama ikon tersedia

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

Get the full list at runtime / Ambil daftar lengkap saat runtime:

```lua
print(AvenUI.IconNames)
```

---

## 🎭 Theme / Tema

### Override theme / Ganti tema

```lua
AvenUI:SetTheme({
    Accent = Color3.fromRGB(88, 101, 242),
    Bg     = Color3.fromRGB(15, 15, 20),
})
```

### Set accent only / Ganti accent saja

```lua
AvenUI:SetAccent(Color3.fromRGB(239, 68, 68))
```

### Read current theme / Baca tema saat ini

```lua
local theme = AvenUI:GetTheme()
print(theme.Accent)
```

### Theme properties / Properti tema

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

## 📚 API Reference

### `AvenUI:CreateWindow(opts)`

**EN:** Creates the main window. Returns a `Window` object.
**ID:** Membuat window utama. Mengembalikan objek `Window`.

### `Window:CreateTab(name, icon)`

**EN:** Creates a tab inside the window. Returns a `Tab` object.
**ID:** Membuat tab di dalam window. Mengembalikan objek `Tab`.

### `Window:SetTitle(text)`

**EN:** Updates the window title at runtime.
**ID:** Mengubah judul window saat runtime.

### `Window:SetSubtitle(text)`

**EN:** Updates the window subtitle at runtime.
**ID:** Mengubah subtitle window saat runtime.

### `Window:Destroy()`

**EN:** Destroys the entire UI.
**ID:** Menghapus seluruh UI.

### `AvenUI:Notify(opts)`

**EN:** Shows a notification toast.
**ID:** Menampilkan notifikasi toast.

### `AvenUI:SetTheme(table)`

**EN:** Merges a table into the active theme.
**ID:** Menggabungkan tabel ke dalam tema aktif.

### `AvenUI:SetAccent(color)`

**EN:** Sets the primary accent color and recalculates derived colors.
**ID:** Mengatur warna aksen utama dan menghitung ulang warna turunannya.

### `AvenUI:GetTheme()`

**EN:** Returns the current theme table.
**ID:** Mengembalikan tabel tema saat ini.

---

## 🌐 Compatibility / Kompatibilitas

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

**EN:** Works on PC and mobile. Fully touch-compatible.
**ID:** Berjalan di PC dan mobile. Sepenuhnya kompatibel dengan sentuhan.

---

## 🛠 Contributing / Kontribusi

**EN:** Pull requests are welcome. For major changes, please open an issue first.
**ID:** Pull request sangat diterima. Untuk perubahan besar, buka issue terlebih dahulu.

---

## 📝 License / Lisensi

MIT — see [LICENSE](LICENSE).
MIT — lihat [LICENSE](LICENSE).

---

<div align="center">

**Made with ♥ by Gixss**

[Discord](https://discord.gg/q7PZBsbpD)

<img src="https://capsule-render.vercel.app/api?type=waving&color=84cc16&height=100&section=footer" width="100%"/>

</div>
