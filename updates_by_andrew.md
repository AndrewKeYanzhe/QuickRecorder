## Updates by Andrew


### Change 1: Improve encoding quality 

Improve image quality by targeting ~ 110 mbps for 3.5K30 recording. Image quality increase is significant when recording HDR videos. 

Comparison: Both at Resolution: High, Quality: High

Previous setting 

<img width="412" alt="image" src="https://github.com/user-attachments/assets/08df03f7-3ce8-4a90-b591-13c502c0fd8d" />

New setting

<img width="404" alt="image" src="https://github.com/user-attachments/assets/4370f46d-5aee-47a1-90f3-984266e3a49f" />





### Frame rate

ScreenCaptureKit only delivers a new frame when something changes. Does not allow setting a fixed frame rate. Only allows throttling frame rate. https://developer.apple.com/documentation/screencapturekit/scstreamconfiguration/minimumframeinterval

Frame rate setting in app changes 2 things
1. ScreenCaptureKit source frame rate throttling
2. Video encoder expected frame rate

Tests on MBP 16 120Hz display
- 120 Hz content (120Hz FPS video in quicktime)
  - SCP no cap. Video encoder expect 60. Encoded 87

- 60 Hz content (Peru HDR on Chrome)
  - SCP no cap. Video encoder expect 120. Encoded 67. Little to no drops. Very good
  - SCP no cap. Video encoder expect 60. Encoded 67. Little to no drops. Very good
  - SCP cap 60. Video encoder expect 60. Encoded 57. More stutter


- 30 Hz content(RDR2 Youtube on Chrome https://youtu.be/Dnzuh6I8gnM?si=qbnhhImPl6Glawxx&t=319)
  - SCP no cap. Video encoder expect 30. Encoded 60. Almost no stutter, quite smooth
  - SCP cap 30. Video encoder expect 30. Encoded 29.4. Very significant stutter

### Change 2:

Remove SCP frame rate throttling for >= 60 FPS (labelled as 60+, 120+)
- Reduces chance of stutter. 
- VideoEncoder expected frame rate is set by the FPS setting

Tips for usage: Use 30 FPS if recording desktop, static items.

Use 60+ when recording anything moving, e.g. videos or games.
Don't use 30fps setting for 30fps games/videos


### HDR Screenshot

- macOS does not support writing AVIF or JXL
- current approach is to write 10 bit HEIF PQ BT2020, but this is limited to 420 chroma sampling

### Notes for building

Grant screen recording permissions to all new builds when building in xcode:
- in settings > privacy and security , delete previous permissions for QuickRecorder
- add QuickRecorder in Xcode build folder





### HDR support in alternative APIs
Screencapturekit seems to be the only API that has HDR support.
AVCaptureScreenInput and CGDisplayStream dont seem to support HDR (search for dynamic in Apple docs)

