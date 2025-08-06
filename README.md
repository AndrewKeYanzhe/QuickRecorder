#
<p align="center">
<img src="./QuickRecorder/Assets.xcassets/AppIcon.appiconset/icon_128x128@2x.png" width="200" height="200" />
<h1 align="center">QuickRecorder</h1>
<h3 align="center">A lightweight and high-performance HDR screen recorder for macOS
</p>

## Features
QuickRecorder records 16 bit HDR PNG screenshots and 10 bit HDR HEVC screen recordings. Screenshots and screen recordings are both in the PQ BT2020 colorspace and utilise chroma 4:4:4 sampling.

## Installation and Usage
### System Requirements:
- macOS 12.3 and later
- macOS 15.0+ needed for HDR screen recording

### Install:
Download the latest installation file [under the releases page](../../releases/latest).

### Usage instructions:

Record HDR videos:
1. Follow the user interface.

Record HDR screenshorts
1. Go to QuickRecorder preferences > Hotkey > set `Save Current Frame` to the preferred shortcut
2. Press shortcut to take a HDR screenshot


## HDR screen recording documentation (updated as of 4 July 2025)

macOS applications typically display HDR content using this scaling
- PQ HDR **images** are typically displayed using PQ 203 nits (media) = SDR 1.0 (physical nits depends on macOS brightness setting). This is true for Chrome and Lightroom
- PQ HDR **videos** are typically displayed using roughly PQ 100 nits (media) ≈ SDR 1.0 (physical nits depends on macOS brightness setting)
  - `Apple XDR Display (P3-1600 nits) profile`
    - set to SDR=100 nits physical, displaying `100 nits PQ pattern`, viewed using QuickTime:
    - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at 112 nits (stops clipping at 1.13% linear PQ), so `test pattern is shown at 112 nits`.
      - (for reference, with SDR white, darktable clips at 1% linear PQ, stops clipping at 1.01% linear PQ)
  - `HDR Video (P3-ST 2084) profile`
    - displaying `100 nits PQ pattern`, viewed using QuickTime:
    - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at exactly 100 nits (1% linear PQ), at exactly the same point as SDR white. `Test pattern is shown at 100 nits`.
  - External monitor with no HDR support
    - 100 nits PQ pattern shown using QuickTime:
      - Digital Colour Meter: pattern is displayed with value of 141 (sRGB 8 bit) ≈ 27 nits
    - 203 nits PQ pattern shown using QuickTime:
      - Digital Colour Meter: pattern is displayed with value of 174 (sRGB 8 bit) ≈ 42 nits
      
However, this may not be true for every application. The macOS Photos app appears to show images using PQ 203 nits (media) = SDR 2.03.

Currently QuickRecorder uses `captureHDRStreamLocalDisplay` which saves the screen recording in a PQ BT2020 container, with SDR 1.0 encoded based on the physical display's brightness. For example, if the display is set at SDR = 300 nits, then the screen recording's SDR or EDR 1.0 value is encoded as 300 nits PQ. This behaviour is verified on macOS Sequoia. However, macOS 26 seems to have altered the API behaviour.

Therefore, the recommended usage is:
- When recording HDR screenshots, set display brightness to 203 nits.
  - For Macbook Pros with XDR displays: create a reference mode in system settings and set the SDR brightness to 203
  - For other Macbooks: use the `brightness` homebrew package to set SDR brightness:
    - brightness is set using a value from 0 - 1. Check using the macOS Console to verify that SDR brightness in nits is set to the desired value
    - disable auto brightness
- When recording HDR videos, set display brightness to 100 nits.

This ensures that if an HDR photo or video is displayed in an application, and recorded using QuickRecorder, the final exposure in the recorded file is the same as the original media.



