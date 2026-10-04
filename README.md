<div align="center">

# NeutraTool

### Simple. Useful. Done.

A no-nonsense Windows toolkit for debloating, cleaning, optimizing, and developing.

**by littlleprince**

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078D4?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![License](https://img.shields.io/badge/License-Proprietary-red.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.3.0-orange.svg)]()

[Features](#features) · [Install](#install) · [Usage](#usage) · [Screenshots](#screenshots) · [License](#license) · [Contact](#contact)

</div>

---

## About

NeutraTool is a lightweight, single-launcher Windows utility that replaces a dozen scattered tweaking tools with one clean GUI. No installers, no telemetry, no bloat — just a `.bat` and a `.ps1`.

## Features

| Category | What it does |
|----------|-------------|
| **Debloat** | Removes ~40 preinstalled apps, provisioned packages, OneDrive, Teams; disables telemetry, Copilot, Recall, Widgets, web-search, ads |
| **Virus Scan** | Quick / Full / Offline (pre-boot) / Custom path scans, threat removal, driver heuristic, ASR, CFA, Network Protection, SMBv1 off |
| **Network** | Flush DNS, release/renew IP, Winsock / TCP-IP / ARP / NetBIOS / proxy / firewall resets, IP + adapter view, ping, DNS lookup, traceroute, TCP tuning, MTU |
| **Optimize** | Ultimate / High Performance power plan, service trimming, visual effects, Game Bar off, hibernation off, temp + recycle cleanup, O&O ShutUp10 preset, Windows Update control |
| **Dev Tools** | One-click winget install of Python, Node.js, Java, Go, Rust, PHP, Ruby, .NET, VS Code, Git, PowerShell 7, Windows Terminal, Neovim, CMake, LLVM, VS Build Tools, Docker, Postman, DBeaver |
| **Themes** | 10 color schemes — GitHub Dark, Midnight Blue, Dracula, Nord, Tokyo Night, Solarized, Crimson, Emerald, Purple Haze, Amber |

## Install

**Requirements**
- Windows 10 or 11 (64-bit)
- PowerShell 5.1 (built-in)
- Administrator rights

**Quick start**

1. Download `NeutraTool.bat` and `NeutraTool.ps1` from the [latest release](https://github.com/LillePrinsen/NeutraTool/releases/latest)
2. Put both files in the **same folder** — e.g. `C:\Users\YourName\Documents\NeutraTool\`
3. **Double-click `NeutraTool.bat`**
4. Click **Yes** on the UAC prompt
5. Done

**Clone via Git**

```powershell
git clone https://github.com/LillePrinsen/NeutraTool.git
cd NeutraTool
.\NeutraTool.bat
```

**Direct download (no Git)**

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/LillePrinsen/NeutraTool/main/NeutraTool.bat" -OutFile "NeutraTool.bat"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/LillePrinsen/NeutraTool/main/NeutraTool.ps1" -OutFile "NeutraTool.ps1"
.\NeutraTool.bat
```

## Usage

The window opens with a left sidebar. Pick a tab, tick the options you want, click the action button. Everything streams to the log at the bottom.

| Tab | Action button | Notes |
|-----|---------------|-------|
| Debloat | Run Debloat | Restart after |
| Virus Scan | Scan and Clean | Offline scan reboots the PC |
| Network | Run Network Tools | Winsock / TCP-IP resets want a reboot |
| Optimize | Apply Optimization | Restart after |
| Dev Tools | Install Selected | Requires winget (App Installer) |
| Settings | Show System Info | Theme picker lives here |

## Screenshots

> Add your own to `screenshots/` and reference them here.

```markdown
![Debloat tab](screenshots/main.png)
```

## Safety

- Every action is wrapped in error handling
- Fatal errors go to `%TEMP%\NeutraTool-error.log`
- Registry tweaks target policy keys (reversible via Group Policy Editor)
- No files deleted outside temp / cache / recycle
- Defender scans use built-in Windows APIs
- Nothing is uploaded anywhere — fully offline except winget / ShutUp10 downloads

## License

**Proprietary — commercial use requires a paid agreement.**

NeutraTool is free to evaluate for 14 days on a single personal device. Any business, professional, or commercial use — including internal IT, managed services, device provisioning, or bundling with a paid product — requires a signed agreement with the author.

See [LICENSE](LICENSE) for full terms. Licensing inquiries:

- Discord: `littlleprince`
- Email: `neutracocontact@gmail.com`

## Contact

**littlleprince**

- Discord: `littlleprince`
- Email: `neutracocontact@gmail.com`
- GitHub: [@LillePrinsen](https://github.com/LillePrinsen)

---

<div align="center">

**Simple. Useful. Done.**

If NeutraTool saved you time, drop a star.

</div>
