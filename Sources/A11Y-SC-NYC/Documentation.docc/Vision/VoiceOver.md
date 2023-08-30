# VoiceOver

## Overview

> VoiceOver is disabled by default on the visionOS simulator and currenlty cannot be activated without external help.

### Shortcuts

The visionOS version of VoiceOver is similar to the iPadOS version, allowing gestures and external keyboards.

> Important: To use the VoiceOver Keyboard Shortcuts, you have to make sure the keyboard is captured in the simulator. Press the Keyboard Capture button in the nav bar or choose *I/O > Input > Send Keyboard Input to Device* **(Option+Cmd+K)**. ![Screenshot of visionOS simulator nav bar, highlighting the keyboard capture button](KeyboardCapture)


#### Discover

The VoiceOver Help feature will describe the action for a given key combination when available, so you can find keyboard shortcuts interactively.

| **Action**              | **Shortcut**    |
| ----------------------- | --------------- |
| Turn on VoiceOver Help  | VO-K            |
| Turn off VoiceOver Help | Esc (Escape)    |

VO-Shift-D -> Describe App Location
VO-I -> Show Item Chooser
VO-M -> Move to status bar
VO-Shift-N -> Read Hint
VO-Shift-Q -> Toggle Quick Nav
VO-V -> Open Quick Settings
VO-F11 -> Curtain (cuac)
VO-F3 -> Read Item Summary
VO-F4 -> Read System-Focused Item Summary
VO-Command-Right/Left Arrow -> Rotor


> VO represents the VoiceOver modifier. The VoiceOver modifier is a key or set of keys you press with one or more other keys to enter VoiceOver commands. By default, visionOS simulator uses the Control-Option.

#### Simulating Gestures

On the real device, VoiceOver uses different finger pinches on different hands to perform different actions:

- By default, you can move focus to the next item by pinching your right index finger.
- To move focus to the previous item, pinch your right middle finger.
- To activate an item, pinch your right ring finger or your left index finger.

On the simulator, equivalents are:
 
- **VO-Right Arrow** to focus on the next item
- **VO-Left Arrow** to focus on the previous item
- **VO-Space bar** to activate an item

| **Action** | **Vision Pro**                               | **Simulator**     |
| ---------  | -------------------------------------------- |  ---------------- |
| Next       | pinch right index finger                     | VO-Right Arrow    |
| Previous   | pinch right middle finger                    | VO-Left Arrow     |
| Activate   | pinch right ring finger or left index finger | VO-Space bar |

### References
- [Supporting VoiceOver in your app](https://developer.apple.com/documentation/visionos/improving-accessibility-support-in-your-app)
- [Using digital crown on Vision Pro Simulator](https://developer.apple.com/forums/thread/732458)
- [Cómo utilizar VoiceOver en VisionOS](https://programaraciegas.net/?p=1102)
