# Simulator

@Metadata {
    @PageColor(purple)
}

## Overview
visionOS proposes an interaction paradigm that works under the umbrella of spatial computing. This results in many fresh ideas and re-elaboration of the terms we're familiar with. It's important to learn how to control the simulator well and get familiar with all the new concepts because developing will rely a lot on it.

### Basic simulator gestures 

| **Gesture**                      | **To simulate**                    |
| -------------------------------- | ---------------------------------- |
| Tap                              | Click.                             |
| Double-tap                       | Double-click.                      |
| Touch and hold                   | Click and hold.                    |
| Drag (left, right, up, and down) | Drag left, right, up, and down.    |
| Drag (forward and back)          | Shift-drag up and down.            |
| Two-handed gestures              | Press and hold the Option key to display touch points. Move the pointer while pressing the Option key to change the distance between the touch points. Move the pointer and hold the Shift and Option keys to reposition the touch points.           |

#### Bonus
`Fn-VO-Up Arrow (fn⌃⌥↑)` -> Notification center

`Fn-VO-Down Arrow (fn⌃⌥↓)` -> Reality control center

> Tip: **Shift-command-H** lets you go home from any place in the simulator, which is helpful when you're stuck in a flow.

### Accessibility

When dealing with visionOS development, [Improving accessibility support in your visionOS app](https://developer.apple.com/documentation/visionos/improving-accessibility-support-in-your-app) helps to keep in mind the essentials. Simulator will help us conduct manual audits, as it contains several of the same accessibility features that Vision Pro has.

> Digital Crown, which in the real device lowers the barrier for controlling accessibility options, is not provided in the simulator. [Xcode 15 beta 6 Release Notes](https://developer.apple.com/documentation/Xcode-Release-Notes/xcode-15-release-notes#visionOS-Simulator) mentions a workaround for emulating it that utilizes the XCTest's `XCUIDevice.rotateDigitalCrown(delta:)` method, but since XCTest can't be imported on non-test targets and [UI testing is not available to visionOS](https://developer.apple.com/documentation/xctest/user_interface_tests), it appears that there is currently no convenient way to trigger Accessibility Shortcut.


### Simulating accessibility features

@Links(visualStyle: detailedGrid) {
  - <doc:VoiceOver>
  - <doc:PointerControl>
  - <doc:GuidedAccess>
}


### References
- [Accessibility - Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [Accessibility updates](https://developer.apple.com/documentation/updates/accessibility)
- [Building accessible apps](https://developer.apple.com/accessibility/)
- [Interacting with your app in the visionOS simulator](https://developer.apple.com/documentation/visionos/interacting-with-your-app-in-the-visionos-simulator)
- [VoiceOver Command Charts](https://help.apple.com/voiceover/command-charts/)
