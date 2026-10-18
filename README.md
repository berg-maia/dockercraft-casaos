# dockercraft-casaos

An unofficial [CasaOS](https://casaos.zimaspace.com/) app store for the **ArtCraft** suite: open-source, clean-room reimplementations of well-known creative and office applications, rebuilt in pure Rust and served in your browser.

> **All credit for the applications goes to the [ArtCraft Team](https://getartcraft.com) and the contributors of each project.**
> This repository only packages their work for CasaOS. It is not an official ArtCraft repository.

- Website: <https://getartcraft.com>
- GitHub organization: <https://github.com/storytold>

## Install

1. Open the CasaOS dashboard and go to **App Store**.
2. Click **Add Source** and paste:

   ```
   https://github.com/berg-maia/dockercraft-casaos/archive/refs/heads/main.zip
   ```

3. Pick an app from the new source and install it. Open it at `http://<your-server-ip>:<port>` using the port from the table bellow.

Each app uses its own host port, so all of them can run side by side.

## Apps

| App | What it is | Release | Links | Port |
|:---:|---|:---:|---|---:|
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/PhotoCraft/icon.svg" width="40" height="40"><br><b>PhotoCraft</b></div> | Image editing; a reimplementation of Adobe Photoshop | ![version](https://img.shields.io/github/v/release/storytold/photocraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/photocraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/photocraft) · [Source](https://github.com/storytold/photocraft) | 8765 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/VectorCraft/icon.svg" width="40" height="40"><br><b>VectorCraft</b></div> | Vector illustration; a reimplementation of Adobe Illustrator | ![version](https://img.shields.io/github/v/release/storytold/vectorcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/vectorcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/vectorcraft) · [Source](https://github.com/storytold/vectorcraft) | 8766 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/FilmCraft/icon.svg" width="40" height="40"><br><b>FilmCraft</b></div> | Video editing, color and sound; a reimplementation of Adobe Premiere Pro | ![version](https://img.shields.io/github/v/release/storytold/filmcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/filmcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/filmcraft) · [Source](https://github.com/storytold/filmcraft) | 8767 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/LightCraft/icon.svg" width="40" height="40"><br><b>LightCraft</b></div> | Photo library and raw development; a reimplementation of Adobe Lightroom | ![version](https://img.shields.io/github/v/release/storytold/lightcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/lightcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/lightcraft) · [Source](https://github.com/storytold/lightcraft) | 8768 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/PdfCraft/icon.svg" width="40" height="40"><br><b>PdfCraft</b></div> | The PDF workbench; a reimplementation of Adobe Acrobat | ![version](https://img.shields.io/github/v/release/storytold/pdfcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/pdfcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/pdfcraft) · [Source](https://github.com/storytold/pdfcraft) | 8769 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/EffectCraft/icon.svg" width="40" height="40"><br><b>EffectCraft</b></div> | Motion graphics and visual effects; a reimplementation of Adobe After Effects | ![version](https://img.shields.io/github/v/release/storytold/effectcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/effectcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/effectcraft) · [Source](https://github.com/storytold/effectcraft) | 8770 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/DesignCraft/icon.svg" width="40" height="40"><br><b>DesignCraft</b></div> | Page layout and publishing; a reimplementation of Adobe InDesign | ![version](https://img.shields.io/github/v/release/storytold/designcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/designcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/designcraft) · [Source](https://github.com/storytold/designcraft) | 8771 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/FigCraft/icon.svg" width="40" height="40"><br><b>FigCraft</b></div> | Interface design; a reimplementation of Figma | ![version](https://img.shields.io/github/v/release/storytold/figcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/figcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/figcraft) · [Source](https://github.com/storytold/figcraft) | 8772 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/WordCraft/icon.svg" width="40" height="40"><br><b>WordCraft</b></div> | Writing and document design; a reimplementation of Microsoft Word | ![version](https://img.shields.io/github/v/release/storytold/wordcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/wordcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/wordcraft) · [Source](https://github.com/storytold/wordcraft) | 8773 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/SoundCraft/icon.svg" width="40" height="40"><br><b>SoundCraft</b></div> | Recording, editing and mixing audio; a reimplementation of Avid Pro Tools | ![version](https://img.shields.io/github/v/release/storytold/soundcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/soundcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/soundcraft) · [Source](https://github.com/storytold/soundcraft) | 8774 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/DeckCraft/icon.svg" width="40" height="40"><br><b>DeckCraft</b></div> | Presentations and slide shows; a reimplementation of Microsoft PowerPoint | ![version](https://img.shields.io/github/v/release/storytold/deckcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/deckcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/deckcraft) · [Source](https://github.com/storytold/deckcraft) | 8775 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/CADCraft/icon.png" width="40" height="40"><br><b>CADCraft</b></div> | Computer-aided design and drafting; a reimplementation of Autodesk AutoCAD | ![version](https://img.shields.io/github/v/release/storytold/cadcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/cadcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/cadcraft) · [Source](https://github.com/storytold/cadcraft) | 8776 |
| <div align="center"><img src="https://raw.githubusercontent.com/berg-maia/dockercraft-casaos/main/Apps/GridCraft/icon.svg" width="40" height="40"><br><b>GridCraft</b></div> | Spreadsheets and data; a reimplementation of Microsoft Excel | ![version](https://img.shields.io/github/v/release/storytold/gridcraft?label=&color=blue)<br>![date](https://img.shields.io/github/release-date/storytold/gridcraft?label=&color=lightgrey) | [Site](https://getartcraft.com/apps/gridcraft) · [Source](https://github.com/storytold/gridcraft) | 8777 |

App descriptions follow the official project descriptions. Open each app's website or repository for its full documentation.

## Credits and rights

- **Authors:** the applications are created by the **ArtCraft Team and the contributors of each project**. Please direct feature requests and application bugs to the project's own repository, linked in the table above.
- **License:** every ArtCraft project is open source under **MIT OR Apache-2.0**, with the copyright line "Copyright (c) 2026 ArtCraft Team and the *&lt;App&gt;* contributors". The license texts (`LICENSE-MIT`, `LICENSE-APACHE`) and the `NOTICE` file are in the root of each project's repository.
- **Names, icons and screenshots:** the app names, icons and screenshots belong to ArtCraft and its contributors. The icons are copied from each project's `assets/app-icon` folder, and the screenshots from its `docs/images` folder. Credits for the media shown inside the screenshots are kept by the projects in that same folder (for example `SOURCES.md` or `*.attribution` files).
- **What this repository contains:** only packaging for CasaOS (compose files, store metadata and GitHub Actions workflows). It does not contain or modify the source code of the applications. The Docker images are built from each project's official web release (`*-web-<version>.zip`) and served with nginx.
- **Third-party trademarks:** Adobe, Photoshop, Illustrator, Premiere Pro, Lightroom, Acrobat, After Effects and InDesign are trademarks of Adobe Inc.; Microsoft, Word, PowerPoint and Excel are trademarks of Microsoft Corporation; Figma is a trademark of Figma, Inc.; Avid and Pro Tools are trademarks of Avid Technology, Inc.; Autodesk and AutoCAD are trademarks of Autodesk, Inc. They are mentioned only to describe what each ArtCraft app reimplements, as in the projects' own descriptions. This store is not affiliated with or endorsed by any of these companies.

## Issues

Problems with installing an app from this store (ports, icons, versions, translations) belong in this repository's issues. Problems inside an application belong to the project's own repository.
