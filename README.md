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

On macOS, PQ HDR **images** are typically displayed using 
````diff
- PQ 203 nits (media) = SDR 1.0 (Chrome, Lightroom). Recommended screen brightness: SDR = 203 nits.
````
PQ HDR **videos** are typically displayed using
````diff
+ PQ 100 nits (media) ≈ SDR 1.0 (Macbook Pro 16 XDR).  Recommended screen brightness: SDR = 100 nits
- PQ 100 nits (media) = SDR 0.47 (400 nit HDR screen).  Recommended screen brightness: SDR ≈ 203 nits
````
DaVinci Resolve always displays as
````diff
+ PQ 100 nits (media) = SDR 1.0. Recommended screen brightness: SDR = 100 nits
+ This is true for the Macbook Pro 16 and the 400 nit HDR screen
````


Detailed tests performed to verify PQ EOTF tracking for videos in QuickTime:
  - `Apple XDR Display (P3-1600 nits) profile`
    - set to SDR=100 nits physical, displaying `100 nits PQ pattern`, viewed using QuickTime:
    - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at 112 nits (stops clipping at 1.13% linear PQ), so `test pattern is shown at 112 nits`.
      - (for reference, with SDR white, darktable clips at 1% linear PQ, stops clipping at 1.01% linear PQ)
  - `HDR Video (P3-ST 2084) profile`
    - displaying `100 nits PQ pattern`, viewed using QuickTime:
    - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at exactly 100 nits (1% linear PQ), at exactly the same point as SDR white. `Test pattern is shown at 100 nits`.
  - External monitor with `no HDR support`
    - 100 nits PQ pattern shown using QuickTime:
      - Digital Colour Meter: `100 nits pattern` is displayed with value of 141 (sRGB 8 bit) ≈ `27 nits`
    - 203 nits PQ pattern shown using QuickTime:
      - Digital Colour Meter: pattern is displayed with value of 174 (sRGB 8 bit) ≈ 42 nits
  - External monitor with `HDR peak of 417.71 nits, set to SDR = 100 nits` (verified using Console).
    - 100 nits PQ pattern shown using QuickTime:
      - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at 0.47% linear PQ. `Hence 100 nits test pattern is shown at 47 nits`
  - External monitor with `HDR peak of 417.71 nits, set to SDR = 203 nits` (verified using Console).
    - 100 nits PQ pattern shown using QuickTime:
      - Darktable using HDR screenshot (captureHDRStreamLocalDisplay): clipping occurs at 0.96% linear PQ. `Hence 100 nits test pattern is shown at 96 nits`


On the Macbook Pro 16 with XDR display, the Photos app appears to show images using PQ 203 nits (media) = SDR 2.03.


````diff
- Overall, PQ EOTF tracking on macOS can be unpredictable, and depends on the monitor used and the application.
! On some HDR monitors, QuickTime shows the HDR video as half as bright as Davinci Resolve
````
      

Currently QuickRecorder uses `captureHDRStreamLocalDisplay` which saves the screen recording in a PQ BT2020 container, with SDR 1.0 encoded based on the physical display's brightness. For example, if the display is set at SDR = 300 nits, then the screen recording's SDR or EDR 1.0 value is encoded as 300 nits PQ. This behaviour is verified on macOS Sequoia. However, macOS 26 seems to have altered the API behaviour.

Therefore, the recommended usage is:
- When recording HDR screenshots, set display brightness to 203 nits.
  - For Macbook Pros with XDR displays: create a reference mode in system settings and set the SDR brightness to 203
  - For other Macbooks: use the `brightness` homebrew package to set SDR brightness:
    - brightness is set using a value from 0 - 1. Check using the macOS Console to verify that SDR brightness in nits is set to the desired value
    - disable auto brightness
- When recording HDR videos, set display brightness to 100 nits.

This ensures that if an HDR photo or video is displayed in an application, and recorded using QuickRecorder, the final exposure in the recorded file is the same as the original media.



