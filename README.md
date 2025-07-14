#
<p align="center">
<img src="./QuickRecorder/Assets.xcassets/AppIcon.appiconset/icon_128x128@2x.png" width="200" height="200" />
<h1 align="center">QuickRecorder</h1>
<h3 align="center">A lightweight and high-performance screen recorder for macOS<br><a href="./README_zh.md">[中文版本]</a><br><a href="https://lihaoyun6.github.io/quickrecorder/">[Landing Page]</a>
</p>


## Screenshot
<p align="center">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="./img/preview_en_dark.png">
  <source media="(prefers-color-scheme: light)" srcset="./img/preview_en.png">
  <img alt="QuickRecorder Screenshots" src="./img/preview_en.png" width="840"/>
</picture>
</p>

## Installation and Usage
### System Requirements:
- macOS 12.3 and Later

### Install:
Download the latest installation file [under the releases page](../../releases/latest).


### Features/Usage:
- You can use QuickRecorder to record your screens / windows / applications / mobile devices... etc.

- QuickRecorder supports driver-free audio loopback recording, mouse highlighting, screen magnifier and many more useful features.  
- The new **"[Presenter Overlay](https://support.apple.com/guide/facetime/presenter-overlay-video-conferencing-fctm6333f4bd/mac)"** in macOS 14 was fully supported by QuickRecorder, which can overlay the camera in real time on your recording *(macOS 12/13 can only use camera floating window)*  
- QuickRecorder is able to record `HEVC with Alpha` video format, that can contain alpha channel in the output file *(currently only iMovie and FCPX support this feature)*

## HDR screen recording instructions (updated as of 4 July 2025)

macOS applications typically display HDR content using this scaling
- PQ HDR **images** are typically displayed using PQ 203 nits (media) = SDR 1.0 (hardware brightness). This is true for Chrome and Lightroom
- PQ HDR **videos** are typically displayed using PQ 100 nits (media) = SDR 1.0 (hardware brightness)

Currently QuickRecorder uses `captureHDRStreamLocalDisplay` which saves the screen recording in a PQ BT2020 container, with SDR 1.0 encoded based on the physical display's brightness. For example, if the display is set at SDR = 300 nits, then the screen recording's SDR or EDR 1.0 value is encoded as 300 nits PQ. This behaviour is verified on macOS Sequoia. However, macOS 26 seems to have altered the API behaviour.

Therefore, the recommended usage is:
- When recording HDR screenshots, set display brightness to 203 nits.
  - For Macbook Pros with XDR displays: create a reference mode in system settings and set the SDR brightness to 203
  - For other Macbooks: use the `brightness` homebrew package to set SDR brightness, and also disable auto brightness
- When recording HDR videos, set display brightness to 100 nits.

This ensures that if an HDR photo or video is displayed in an application, and recorded using QuickRecorder, the final exposure in the recorded file is the same as the original media.

HDR screenshots can be recorded using the following steps:
1. Go to QuickRecorder preferences > Hotkey > set `Save Current Frame` to the preferred shortcut
2. Start a screen recording, and press the shortcut for `Save Current Frame`
3. This saves a 16 bit PNG with 4:4:4 chroma sampling in the PQ BT2020 container.

## Q&A
**1. Where can I reopen the main panel after closing it?**
> Click the Dock tile or Menubar icon of QuickRecorder to reopen the main panel at any time.

**2. Why does QuickRecorder not a sandbox app?**
> QuickRecorder has no plans to be uploaded to the App Store, so it does not need to be designed as a sandbox app.  

**3. How to independently control the volume of system sound and sound from microphone in other video editor?**
> QuickRecorder will merge the audio input from the microphone to the main audio track after recording by default. If you need to edit the video, you can turn off the `Record Microphone to Main Track` option in the settings panel. After turning off, the system sound and sound from microphone will be recorded into two audio tracks and can be edited independently.  

## Donate
<img src="./img/donate.png" width="350"/>

## Thanks
[Azayaka](https://github.com/Mnpn/Azayaka) @Mnpn
> The source of inspiration and part of the code of the screen recording engine comes from the Azayaka project, and I am also one of the code contributors to this project

[KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) @sindresorhus  
> QuickRecorder uses this swift library to handle shortcut key events  

[SwiftLAME](https://github.com/hidden-spectrum/SwiftLAME) @Hidden Spectrum
> QuickRecorder uses this swift library to handle MP3 output

[ChatGPT](https://chat.openai.com) @OpenAI
> Note: Part of the code in this project was generated or refactored using ChatGPT.
