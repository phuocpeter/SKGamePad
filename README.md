SKGamePad
==========

> SKGamePad is a simple-to-use SpriteKit framework that provides an on-screen gamepad.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/phuocpeter19/SKGamePad/blob/master/LICENSE)
[![Platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS-red.svg)](http://www.apple.com)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

**SKGamePad** is built from ground up with Swift and extends **SKNode** and **SKSpriteNode**. This framework adds convenience class to initializ and listen to gamepad touch event.

- Compatible with *Xcode 9 and Swift 4*

## Features
- [x] Fully documented.
- [x] Convenience class ```SKColorButton: SKSpriteNode``` creates retangular button that listens for touch events.
- [ ] Convenience class for creating button from textures or images.
- [x] Convenience class ```SKDirectionalPad: SKNode``` creates a node that contains 4 conventional direction button.
- [ ] Convenience class for creating utilities button such as ```A, B, X, Y``` on conventional gamepad.

## Requirements
- iOS 9.0+
- Xcode 9.0 / Swift 4.0

## Installation

### For Carthage installation
- Create a Cartfile in the root of your project and add:
    ```github "phuocpeter19/SKGamePad"```
- Then run ```carthage update``` on *Terminal*.

### For manual installation
- Download the latest release of this repo and add it to your *Xcode* project.

## Usage

### Create a color button
```swift
class Scene: SKScene {
    ...
    override func didMove(to view: SKView) {
        let button = SKColorButton(name: SKDirectionalPadButtons.upButton.rawValue, color: padColor, size: padSize)
        button.listener = self
        self.addChild(button)
    }
}
extension Scene: SKColorButtonTouchesListener {
    func buttonTouched(button: SKColorButton, withState state: SKColorButtonTouchEvent) {
        // Do something when the button is touched.
    }
}
```
> ```SKDirectionalPadButtons``` is a convenience enumeration for conventional d-pad button. It is recommended to use ```rawValues``` from the *enum* to define d-pad button.

- Implement protocol ```SKColorButtonTouchesListener``` method to receive notification of the button's touch events.
> Remember to set the listener of the button!

### Create an on-screen d-pad
```swift
class Scene: SKScene {
    ...
    override func didMove(to view:SKView) {
        let dpad = SKDirectionalPad(padColor: UIColor.blue, padSize: CGSize(width: 100, height: 100))
        // This will position the dpad at the bottom left of the screen while taking care of the safe area insets of new iPhone X.
        dpad.setPositionToBottomLeft(view)
        dpad.delegate = self
        self.addChild(dpad)
    }
}
extension Scene: SKDirectionalPadDelegate {
    func upPadEventTriggered(eventState state: SKColorButtonTouchEvent) {
        // Do something when up button is touched.
        // repeated this for other buttons.
    }
}
```

