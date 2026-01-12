# proving-grounds

**Experimental Projects & Example Code**

A collection of proof-of-concept projects, example implementations, and experimental code spanning embedded systems, distributed systems, database patterns, AI/ML infrastructure, and software architecture patterns.

**Owner:** [@mwwhited](https://github.com/mwwhited)
**Organization:** [Out-of-Band Development](https://github.com/OutOfBandDevelopment)

---

## Repository Structure

```
proving-grounds/
├── examples/          # 21 example projects (113+ C# projects)
│   ├── Hardware & Embedded
│   ├── Software Infrastructure
│   ├── Database & Messaging
│   ├── AI/ML & Search
│   ├── Tools & Utilities
│   └── Legacy/Archive
└── README.md         # This file
```

---

## Example Projects Index

### Hardware & Embedded Systems

#### **OoBDev.ScoreMachine** - Distributed Fencing Tournament Scoring System
**Production deployment (2018-2020) - Arnold Fencing Classic**

Complete distributed scoring system with real-time overlay, network-based A/V control, and multi-protocol support.

**Technologies:** C#/.NET Core 2.x, ASP.NET Core, SignalR, Arduino, FPGA (NeTV), Raspberry Pi
**Hardware:** Favero/Saint George scoring machines (RS-485), NeTV FPGA overlay, 4× E810-DTU converters, Arduino relay circuits, LANC cameras, HDMI switches, Zoom H4N audio
**Status:** Production (2018-2020) → Migrated to [FencingScoreBoard](https://github.com/mwwhited/FencingScoreBoard)

**Key Documentation:**
- [ZoomH4n.md](examples/OoBDev.ScoreMachine/ZoomH4n.md) - Extensive protocol reverse-engineering (RS-232 2400 baud)
- [SharedNodes.md](examples/OoBDev.ScoreMachine/SharedNodes.md) - Reference links (Tiny Core Linux, NeTV, .NET Core)
- [RaspberryPi.md](examples/OoBDev.ScoreMachine/RaspberryPi.md) - Raspberry Pi configuration
- Circuit designs: h4n2rs485, lanc2rs485, SG_Power (KiCad)

**Cross-References:**
- Production code: [FencingScoreBoard](https://github.com/mwwhited/FencingScoreBoard)
- Protocol decoders: [BinaryDataDecoders](https://github.com/mwwhited/BinaryDataDecoders)
- Arduino/circuits: [EmbeddedBakery](https://github.com/mwwhited/EmbeddedBakery)
- Project documentation: [shared/projects/scoremachine](../../shared/projects/scoremachine/)

---

#### **UsbMonitor** - USB Device Detection and Enumeration
USB device detection using WMI, WinRT API integration, GPS device support.

**Technologies:** C#/.NET, WMI, WinRT
**Projects:** UsbMonitor, UsbEnumerator, UsbGps, InfFinder, DesktopToWinRT
**Status:** Active

---

### Software Infrastructure

#### **OobDev.HomeSeer** - Home Automation Framework
Home automation infrastructure with form generation, image processing, identity management.

**Technologies:** C#/.NET, WPF, Web APIs
**Projects:** OobDev.Common, OobDev.FormEngine.Core, OobDev.ImageTools, OobDev.AspNet.Identity, OobDev.Adapter.HolidayApi.Client
**Status:** Framework/Library

---

#### **PostMessageProxy** - ASP.NET Proxy Pattern
Cross-window messaging proxy implementation for ASP.NET.

**Technologies:** ASP.NET, JavaScript (Bootstrap, Promises polyfill)
**Status:** Example

---

### Database & Messaging

#### **OoBDev.MessageBroker** - SQL Service Broker Examples
Message broker implementation using SQL Server Service Broker with Entity Framework 7 integration.

**Technologies:** C#/.NET, SQL Server Service Broker, Entity Framework 7
**Projects:** OoBDev.DependencyInjection.Cli, OoBDev.SqlServer.Sys.EntityFramework
**Documentation:** EF7.md, SessionContext.md, ssb.md
**Status:** Example/Experimental

---

#### **Ssb.Modeling** - SQL Service Broker WPF Designer
Visual designer for SQL Service Broker workflows with MVVM pattern.

**Technologies:** C#/.NET, WPF, MVVM
**Projects:** Ssb.Modeling.Wpf, Ssb.Modeling.Flow.Wpf, Ssb.Designer.Wpf
**Status:** Tool/Framework

---

#### **SQL** - SQL Examples and Utilities
T-SQL examples including Service Broker, stored procedures, binary conversion, Hamming sequences.

**Technologies:** T-SQL (SQL Server)
**Files:** ExampleFull.sql, RequestResponseExample.sql, functions-binary-conversion.sql, hamming sequence.sql
**Status:** Reference

---

### AI/ML & Search

#### **hybridsearch** - Hybrid Search Engine (AI/ML)
Document store with semantic + lexical search, LLM-based summarization, and PlantUML rendering.

**Technologies:** C#/.NET, Go, Docker, Qdrant (vector DB), OpenSearch, Ollama (LLM), Markdig
**Features:**
- **Semantic Search:** Sentence transformers (all-mpnet-base-v2), Qdrant vector DB
- **Lexical Search:** OpenSearch (inverted indexes)
- **Document Generation:** "Muse" - LLM summarization (Ollama + Mistral)
- **File Conversion:** Markdown-to-HTML (Markdig), PlantUML-to-PNG caching
- **Authorization:** Keycloak support (planned)

**Projects:**
- HybridSearchCSharp (OobDev.Search, OobDev.Documents, provider abstractions)
- HybridSearchGo (parallel Go implementation)

**Documentation:** [Design/Notes.md](examples/hybridsearch/HybridSearchCSharp/NotesAndScripts/Designs/Notes.md) - Comprehensive architecture documentation
**Status:** Active Development

---

### Tools & Utilities

#### **BuildFirstOnce** - MSBuild Orchestration Pattern
Demonstrates using Directory.Build.props for solution-wide MSBuild tasks with one-time execution.

**Technologies:** C# .NET 8.0, MSBuild
**Documentation:** [README.md](examples/BuildFirstOnce/README.md) - Detailed output examples
**Status:** Active (Example/Documentation)

---

#### **HandyClasses** - Utility Class Collection
MIT-licensed utility library with SMTP, barcode generation, CSV serialization, encoding/decoding.

**Technologies:** C# and VB.NET
**Classes:**
- SmtpClientService (ASP.NET Identity message service)
- Code39 (GDI+ barcode generator)
- ConsoleEx (interactive CLI prompts)
- XFragment (XML fragment handling)
- CsvWriter (RFC 4180 CSV serialization)
- IniFile (Win32 INI file wrapper)
- Convert (Base64/Base32/Base16/Base8 encoding - VB.NET)

**Documentation:** [README.md](examples/HandyClasses/README.md) - Comprehensive class descriptions
**Status:** Active Library

---

#### **markdownplantuml** - Markdown + PlantUML Integration
PlantUML extension for Markdig markdown processor with inline diagram rendering.

**Technologies:** C# .NET, Markdown (Markdig), PlantUML
**Projects:** PlantUmlBlock, PlantUmlBlockParser, custom renderers
**Documentation:** [Design.md](examples/markdownplantuml/Design.md)
**Status:** Active

---

#### **OobDev.Tools** - Development Tools
Development utilities including Unix domain socket support (AF_UNIX for .NET).

**Technologies:** C#/.NET
**Projects:** OobDev.Tools, OobDev.Tools.AfUnix, OobDev.Tools.Tests
**Status:** Active

---

#### **TotpExample** - Time-Based One-Time Password (2FA)
TOTP generation library with QR code support and web integration.

**Technologies:** C#/.NET (Windows, Windows Phone, Web)
**Projects:** WhitedUS.Totp, Samples.Test.TOTP (CLI + QR), Samples.Web, Samples.SignAndVerifyXml
**Status:** Example/Library

---

#### **UnmanagedExports** - P/Invoke and Unmanaged Code
Library for exporting .NET code as native DLL functions.

**Technologies:** C#/.NET (P/Invoke, DLL exports)
**Projects:** UnmanagedExports, UnmanagedExports.Common, test harnesses
**Status:** Example/Reference

---

### Network & Communication

#### **MulticastExample** - UDP Multicast Network Example
UDP multicast group subscription with Base64-encoded message display.

**Technologies:** C# .NET (Console)
**Config:** Listens on 224.0.0.21:3956
**Status:** Example

---

#### **WindowsUnixSocket** - Unix Domain Socket Support
AF_UNIX socket family support in .NET Core with WSL compatibility.

**Technologies:** C#/.NET Core (Unix domain sockets)
**Projects:** UnixSocketHost (server), UnixSocketClient (client)
**Status:** Example

---

### Legacy/Archive

#### **AccountingEngine** - Financial Accounting System
Simulates complex accounting workflows: tax engine, billing, dunning, clearing, termination, amortization.

**Technologies:** C# .NET (CLI)
**Status:** Example/Experimental

---

#### **BASIC** - Legacy BASIC Programming Examples
QBasic/BASIC language examples including Apple II compatibility, calendar generators, TTY simulation.

**Technologies:** QBasic, BASIC
**Files:** APPLE.BAS, MODIFY.BAS, cal.bas, tty.bas, Star Trek assets
**Status:** Archive/Historical

---

#### **CSharp** - C# Code Examples
Miscellaneous C# utilities: profiling, SQL logging, SiteMinder monitoring, XML manipulation.

**Technologies:** C#
**Files:** ProfilerEx.cs, SqlLogger.cs, StopwatchEx.cs, SecurityManagement notes
**Status:** Reference

---

#### **NCursersTest** - .NET Curses Binding
Tests for NaCurses library (ncurses wrapper for .NET) - terminal UI development.

**Technologies:** C# .NET, NaCurses (ncurses binding)
**Status:** Example/Experimental

---

#### **NeedsReviewed** - Miscellaneous Examples (Archive)
Mixed archive of games (XNA), encryption (PlayFair, FakeSSL), serial communication, network/proxy utilities.

**Technologies:** C#, VB.NET, XNA (Xbox game framework)
**Content:**
- XNA games (Pong, 3D models, OpenGL tests)
- Cryptography (PlayFair cipher, UnixCrypt)
- Serial communication examples
- Network utilities (proxy, Telnet)
- Star Trek ship assets (40+ GIFs)

**Status:** Archive/Historical

---

## Technology Stack Summary

### Languages & Frameworks
- **C# .NET** (dominant - ~80% of projects)
- **VB.NET** (legacy examples)
- **Go** (hybridsearch option)
- **T-SQL** (database)
- **QBasic/BASIC** (historical)
- **XNA** (game development)

### Key Libraries & Tools
- ASP.NET Core, WPF, WinForms
- SignalR (real-time communication)
- Entity Framework 7
- SQL Server Service Broker
- Markdig (Markdown processing)
- PlantUML (diagrams)
- Qdrant (vector DB)
- OpenSearch (full-text search)
- Ollama (LLM inference)

### Protocols & Hardware
- **RS-485** (multi-drop serial)
- **RS-232** (serial communication)
- **LANC** (Sony/Canon camera control)
- **USB** (device enumeration, HID)
- **Multicast UDP**
- **Unix domain sockets**
- **HDMI** (switch control via IR)
- **IR** (infrared remote control)

### Platforms
- Windows/.NET Framework
- Linux (Raspberry Pi, Tiny Core Linux)
- FPGA (NeTV hardware overlay)
- Arduino (relay circuits)
- Windows Phone, UWP

---

## Documentation Quality

### Excellent Documentation
- **BuildFirstOnce** - Detailed examples with output
- **HandyClasses** - Comprehensive class descriptions
- **hybridsearch** - Excellent design document with architecture diagrams
- **OoBDev.ScoreMachine** - ZoomH4n.md is exceptional protocol reverse-engineering
- **Ssb.Modeling** - Detailed notes on features and patterns

### Moderate Documentation
- **OoBDev.MessageBroker** - Good technical notes (EF7, SSB)
- **markdownplantuml** - Design notes
- **UsbMonitor** - README files for sub-projects

### Minimal/None
- Most other examples have code comments only or minimal README files

---

## Project Status Categories

### Production (Historical Reference)
- **OoBDev.ScoreMachine** - Deployed 2018-2020, migrated to separate repos

### Active Development
- **hybridsearch** - AI/ML search infrastructure
- **BuildFirstOnce** - MSBuild pattern documentation
- **HandyClasses** - Utility library
- **markdownplantuml** - Markdown extension
- **OobDev.Tools** - Development utilities

### Framework/Library
- **OobDev.HomeSeer** - Home automation framework
- **Ssb.Modeling** - SQL Service Broker designer
- **TotpExample** - 2FA library
- **UnmanagedExports** - P/Invoke library

### Example/Experimental
- **OoBDev.MessageBroker**, **PostMessageProxy**, **MulticastExample**, **WindowsUnixSocket**, **UsbMonitor**, **NCursersTest**

### Archive/Historical
- **BASIC**, **CSharp**, **SQL**, **NeedsReviewed**, **AccountingEngine**

---

## Related Repositories

### Production Code (Extracted from proving-grounds)
- **[FencingScoreBoard](https://github.com/mwwhited/FencingScoreBoard)** - Production scoring system (Phase 2: OBS)
- **[BinaryDataDecoders](https://github.com/mwwhited/BinaryDataDecoders)** - Protocol decoders (796K+ NuGet downloads)
- **[EmbeddedBakery](https://github.com/mwwhited/EmbeddedBakery)** - Arduino/FPGA projects
- **[dotex](https://github.com/OutOfBandDevelopment/dotex)** - .NET extensions framework
- **[BuildFirstOnce](https://github.com/OutOfBandDevelopment/BuildFirstOnce)** - MSBuild orchestration

### Documentation
- **[shared/projects/scoremachine](../../shared/projects/scoremachine/)** - Complete ScoreMachine documentation (README, Phase 1, Phase 2)

---

## Statistics

- **Total Example Projects:** 21 directories
- **Total C# Projects:** 113+ .csproj files
- **Languages:** C#, VB.NET, Go, T-SQL, QBasic/BASIC
- **Frameworks:** .NET Framework, .NET Core, .NET 5+, .NET 8.0
- **Hardware Projects:** 2 (OoBDev.ScoreMachine, UsbMonitor)
- **AI/ML Projects:** 1 (hybridsearch)
- **Database Projects:** 3 (OoBDev.MessageBroker, Ssb.Modeling, SQL)
- **Utility Libraries:** 4 (HandyClasses, OobDev.Tools, UnmanagedExports, TotpExample)

---

## Contributing

This repository serves as a personal proving ground for experimental code and examples. Most production-ready code has been extracted to dedicated repositories under [OutOfBandDevelopment](https://github.com/OutOfBandDevelopment).

---

## License

Individual projects may have their own licenses. Check each project directory for LICENSE files.

**Known Licenses:**
- **HandyClasses** - MIT License
- Most projects default to personal/experimental use

---

*Last updated: 2026-01-12*
*Repository owner: [@mwwhited](https://github.com/mwwhited)*
