#
<p align="center">
<img src="./QuickRecorder/Assets.xcassets/AppIcon.appiconset/icon_128x128@2x.png" width="200" height="200" />
<h1 align="center">QuickRecorder</h1>
<h3 align="center">A lightweight and high-performance HDR screen recorder for macOS
</p>



## Installation and Usage
### System Requirements:
- macOS 12.3 and later
- macOS 15.0+ needed for HDR screen recording

### Install:
Download the latest installation file [under the releases page](../../releases/latest).




## HDR screen recording instructions (updated as of 4 July 2025)

macOS applications typically display HDR content using this scaling
- PQ HDR **images** are typically displayed using PQ 203 nits (media) = SDR 1.0 (hardware brightness). This is true for Chrome and Lightroom
- PQ HDR **videos** are typically displayed using PQ 100 nits (media) = SDR 1.0 (hardware brightness)

Currently QuickRecorder uses `captureHDRStreamLocalDisplay` which saves the screen recording in a PQ BT2020 container, with SDR 1.0 encoded based on the physical display's brightness. For example, if the display is set at SDR = 300 nits, then the screen recording's SDR or EDR 1.0 value is encoded as 300 nits PQ. This behaviour is verified on macOS Sequoia. However, macOS 26 seems to have altered the API behaviour.

Therefore, the recommended usage is:
- When recording HDR screenshots, set display brightness to 203 nits.
  - For Macbook Pros with XDR displays: create a reference mode in system settings and set the SDR brightness to 203
  - For other Macbooks: use the `brightness` homebrew package to set SDR brightness:
    - brightness is set using a value from 0 - 1. Check using the macOS Console to verify that SDR brightness in nits is set to the desired value
    - disable auto brightness
- When recording HDR videos, set display brightness to 100 nits.

This ensures that if an HDR photo or video is displayed in an application, and recorded using QuickRecorder, the final exposure in the recorded file is the same as the original media.

HDR screenshots can be recorded using the following steps:
1. Go to QuickRecorder preferences > Hotkey > set `Save Current Frame` to the preferred shortcut
2. Start a screen recording, and press the shortcut for `Save Current Frame`
3. This saves a 16 bit PNG with 4:4:4 chroma sampling in the PQ BT2020 container.


