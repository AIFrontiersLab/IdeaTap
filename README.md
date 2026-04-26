# TrendCanvas ✨

> Turn LinkedIn ideas into polished, export-ready visuals — instantly.

[![Build](https://img.shields.io/badge/build-passing-brightgreen)](./)
[![Platform](https://img.shields.io/badge/platform-iOS%20%7C%20macOS-lightgrey)](./)
[![Swift](https://img.shields.io/badge/Swift-5.0%2B-orange)](./)
[![License](https://img.shields.io/badge/license-TBD-blue)](./)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen)](./CONTRIBUTING.md)

TrendCanvas (formerly **IdeaTap**) helps creators, founders, recruiters, and professionals transform a single copied LinkedIn link into **high-quality visual assets**—posters, carousels, and clean export-ready graphics—tuned to the original content’s intent and enhanced with **timely AI news + trends**.

---

## Why TrendCanvas exists (problem)

LinkedIn is full of strong ideas—great posts, profiles, frameworks, and insights. But turning those ideas into **polished visuals** usually means:

- 🕒 Spending 30–120 minutes in design tools
- 🧠 Translating a post’s “intent” into a visual concept
- 📰 Manually adding timely context (news, trends, recent releases)
- 🧩 Iterating formats (single image vs carousel) and export specs

Most people give up—or post low-effort assets that don’t match the quality of the idea.

---

## What TrendCanvas does (solution)

TrendCanvas makes “visualizing” a LinkedIn idea as easy as:

1. 🔗 Copy a LinkedIn post or profile link
2. 🧠 Let the AI agent infer intent + audience + tone
3. 🎨 Generate a tuned visual set (poster, carousel, cover images)
4. 📦 Export clean, social-ready assets in one click

---

## Core product vision

**TrendCanvas is the fastest path from “idea” → “shareable visual.”**  
It’s built for a modern creator workflow: minimal friction, high taste, consistent branding, and relevance that updates with the world.

---

## Key features (highlights)

- 📋 **Automatic LinkedIn URL detection** from the system clipboard
- 🧾 **Context capture** (post/profile content + inferred themes)
- 🧠 **AI intent analysis** (audience, tone, goal, CTA, format)
- 🖼️ **Tuned visual generation** (posters, carousels, clean layouts)
- 📰 **Trend enrichment** using the latest AI news, insights, and zeitgeist
- ⚡ **One-click asset generation** built for speed
- ✅ **Export-ready outputs** (clean typography, spacing, and contrast)
- 🧼 **Premium minimal aesthetic** suitable for demos + investor decks

---

## Screenshots (placeholders)

> Replace these with real images when available.

### App

- **Home / Clipboard detection**
  - `docs/screenshots/home.png`
- **Link preview + intent**
  - `docs/screenshots/intent.png`
- **Generated carousel preview**
  - `docs/screenshots/carousel.png`
- **Export options**
  - `docs/screenshots/export.png`

### Sample outputs

- `docs/samples/poster_01.png`
- `docs/samples/carousel_01.png`

---

## Example user journey (from copy → export)

| Step | What you do | What TrendCanvas does |
|---:|---|---|
| 1 | Copy a LinkedIn post/profile link | Detects clipboard change + validates URL 🔎 |
| 2 | Click **Generate** | Fetches/derives context, infers intent, picks best format 🧠 |
| 3 | Pick a style preset | Applies a consistent visual system (type, grid, colors) 🎛️ |
| 4 | Review assets | Shows poster + carousel variants with tuned captions 👀 |
| 5 | Export | Exports social-ready images (and future: templates) 📦 |

---

## Real-world use cases

- **Creators**: turn a saved post into a carousel with your voice + better structure
- **Founders**: convert an announcement into a clean launch visual set
- **Recruiters**: transform a profile or hiring post into brand-consistent hiring graphics
- **Professionals**: turn a thread into a “framework poster” for easy sharing
- **Communities/teams**: generate weekly trend recaps with up-to-date AI news

---

## AI workflow & agent architecture

TrendCanvas uses an agentic pipeline that separates **capture → understanding → enrichment → design → export**.

### High-level flow (diagram)

```text
User copies LinkedIn URL
        │
        ▼
Clipboard Listener (on-device)
        │
        ▼
URL Validator + Link Router
        │
        ├── Post URL ───────────────┐
        └── Profile URL ────────────┤
                                    ▼
                         Context Capture Layer
                     (metadata + extracted text)
                                    │
                                    ▼
                           Intent Analyzer Agent
               (audience, tone, goal, key points, CTA)
                                    │
                                    ▼
                          Trend Enrichment Agent
        (latest AI news, releases, trends, insights; optional)
                                    │
                                    ▼
                           Visual Composer Agent
          (layout system, typography, hierarchy, variants)
                                    │
                                    ▼
                        Renderer + Export Packager
                (poster, carousel, sizes, filenames)
                                    │
                                    ▼
                               Share / Save
```

### Agents (roles)

| Agent | Responsibility | Output |
|---|---|---|
| **Intent Analyzer** | Understand “what this wants to achieve” | structured brief (tone, audience, bullets, CTA) |
| **Trend Enricher** | Add timely relevance (AI news + insights) | enrichment notes + citations/links (optional) |
| **Visual Composer** | Convert brief into design-ready content blocks | layout spec + copy blocks + variant plan |
| **Renderer** | Produce exportable assets | PNG/JPG (and future: editable templates) |

---

## Tech stack (placeholder)

> Update this section once finalized.

- **Client**: Swift / SwiftUI (iOS, macOS)
- **Clipboard capture**: native clipboard APIs
- **AI orchestration**: TBD (agent framework, prompts, tools)
- **Visual rendering**: TBD (CoreGraphics / SwiftUI rendering / server-side)
- **News/trend sources**: TBD (curated feeds / APIs)

---

## Installation

### Prerequisites

- macOS with **Xcode** installed
- Swift toolchain (via Xcode)

### Build & run

1. Clone the repo
2. Open `IdeaTap.xcodeproj` in Xcode
3. Select a target device/simulator
4. Run the app (`⌘R`)

---

## Environment variables (placeholder)

> Add your keys using your preferred secrets workflow (e.g., Xcode build settings, `.xcconfig`, Keychain, or secure on-device storage).

| Variable | Description | Required |
|---|---|---:|
| `TRENDCANVAS_AI_API_KEY` | AI provider key | ✅/⬜ |
| `TRENDCANVAS_NEWS_API_KEY` | Trend/news provider key | ✅/⬜ |
| `TRENDCANVAS_ENV` | `dev` / `prod` | ⬜ |

---

## Usage

1. Open TrendCanvas
2. Copy a LinkedIn post URL or profile URL
3. Confirm the detected link inside the app
4. Choose a preset (tone/style)
5. Generate visuals
6. Export and share

---

## Project structure

> Current structure (may evolve as agents/rendering expand).

```text
IdeaTap/
  IdeaTap.xcodeproj/          # Xcode project
  IdeaTap/                    # App source
    ContentView.swift
    IdeaTapApp.swift
    LinkSheetService.swift
    Assets.xcassets/
  IdeaTapTests/
  IdeaTapUITests/
docs/                         # (recommended) screenshots, samples, diagrams
```

---

## Roadmap

### Near-term

- [ ] Add robust LinkedIn context extraction (post text, author info, themes)
- [ ] Style presets + brand kits (type scale, colors, logo placement)
- [ ] Carousel generation with consistent grid + pacing
- [ ] Better export controls (sizes, safe areas, filenames)

### Mid-term

- [ ] Trend enrichment with citations + “why it matters”
- [ ] Templates library (frameworks, announcements, hiring, recaps)
- [ ] Multi-platform export presets (LinkedIn, X, Instagram)

### Long-term

- [ ] Team workspaces + shared brand guidelines
- [ ] Editable template exports (e.g., Figma/Canva-compatible) *(TBD)*
- [ ] Scheduled “weekly trend recap” auto-generation *(opt-in)*

---

## Privacy & security

TrendCanvas is designed to be privacy-forward:

- 🔐 **Clipboard access** is used to detect copied LinkedIn URLs and should be **minimized and transparent**.
- 🧭 **Scope-limited capture**: only process content needed to generate the requested assets.
- 🗑️ **Data retention**: default to ephemeral processing where possible; avoid storing raw content unless the user saves a project.
- 🧩 **Secrets handling**: API keys should never be committed; store securely via platform mechanisms.

> This project is early-stage. Please treat privacy/security as a first-class requirement when contributing.

---

## Contributing

Contributions are welcome. If you’d like to help:

1. Fork the repo
2. Create a feature branch (`feature/your-change`)
3. Make changes with clear commits
4. Open a PR with:
   - what you changed
   - how to test it
   - screenshots (if UI)

If you’re adding AI behaviors:

- Keep prompts/tooling **deterministic** where possible
- Prefer structured outputs (JSON-like schemas) for agent handoffs
- Include safety checks for URLs and user-provided content

---

## License

**TBD** — add your preferred license (e.g., MIT, Apache-2.0) and update the badge at the top.

