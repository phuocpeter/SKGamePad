//
//  SKDirectionalPad.swift
//  SKGamePad
//
//  Created by Phuoc Tran on 2018-06-10.
//  Copyright © 2018 Phuoc Tran. All rights reserved.
//

import SpriteKit

/** Delegate for notification of directional button touch events. */
protocol SKDirectionalPadDelegate {
    /**
     Notifies the event from the up button.
     - parameters:
        - eventState: the state of the touch button.
     */
    func upPadEventTriggered(eventState state: SKColorButtonTouchEvent)
    /** Notifies the event from the down button.
     - parameters:
        - eventState: the state of the touch button.
     */
    func downPadEventTriggered(eventState state: SKColorButtonTouchEvent)
    /** Notifies the event from the left button.
     - parameters:
        - eventState: the state of the touch button.
     */
    func leftPadEventTriggered(eventState state: SKColorButtonTouchEvent)
    /** Notifies the event from the right button.
     - parameters:
        - eventState: the state of the touch button.
     */
    func rightPadEventTriggered(eventState state: SKColorButtonTouchEvent)
}

/**
 A node containing the directional pad.
 */
class SKDirectionalPad: SKNode {
    /** Delegate for notification of button touch events. */
    var delegate: SKDirectionalPadDelegate?
    
    var padColor: UIColor
    var padSize: CGSize
    
    var upPad: SKColorButton!
    var downPad: SKColorButton!
    var leftPad: SKColorButton!
    var rightPad: SKColorButton!
    
    /** Initiliazes from NSCoder. */
    required init?(coder aDecoder: NSCoder) {
        padColor = UIColor.lightGray
        padSize = CGSize(width: 50, height: 50)
        super.init(coder: aDecoder)
        setupDpad()
    }
    
    /**
     Initializes with the specified color and size.
     - parameters:
        - color: the color of the button.
        - size: the size of the individual button.
     */
    init(padColor color: UIColor, padSize size: CGSize) {
        self.padColor = color
        self.padSize = size
        super.init()
        self.isUserInteractionEnabled = true
        setupDpad()
    }
    
    /** Setups up the directional buttons in this node. */
    private func setupDpad() {
        upPad = SKColorButton(name: SKDirectionalPadButtons.upButton.rawValue, color: padColor, size: padSize)
        upPad.position = CGPoint(x: 0, y: padSize.height)
        upPad.listener = self
        self.addChild(upPad)
        
        downPad = SKColorButton(name: SKDirectionalPadButtons.downButton.rawValue, color: padColor, size: padSize)
        downPad.position = CGPoint(x: 0, y: -padSize.height)
        downPad.listener = self
        self.addChild(downPad)
        
        leftPad = SKColorButton(name: SKDirectionalPadButtons.leftButton.rawValue, color: padColor, size: padSize)
        leftPad.position = CGPoint(x: -padSize.width, y: 0)
        leftPad.listener = self
        self.addChild(leftPad)
        
        rightPad = SKColorButton(name: SKDirectionalPadButtons.rightButton.rawValue, color: padColor, size: padSize)
        rightPad.position = CGPoint(x: padSize.width, y: 0)
        rightPad.listener = self
        self.addChild(rightPad)
    }
    
    /**
     Convenience method to sets the position of the D-Pad to the bottom left of the screen.
     - parameters:
     - visibleSize: the CGSize object of the visible size of the device screen.
     */
    func setPositionToBottomLeft(view: SKView) {
        let visibleSize = view.bounds.size
        /** Insets specifically for new iPhone. */
        var insets: UIEdgeInsets {
            if #available(iOS 11.0, *) {
                return view.safeAreaInsets
            } else {
                return .zero
            }
        }
        // Position the pad to the bottom left of the screen.
        let x = -visibleSize.width + (padSize.width * 2.5) + insets.left
        let y = -visibleSize.height / 2 + insets.bottom
        self.position = CGPoint(x: x, y: y)
    }
}

// Redirects button events to delegate
extension SKDirectionalPad: SKColorButtonTouchesListener {
    func buttonTouched(button: SKColorButton, withState state: SKColorButtonTouchEvent) {
        // Identifies the button by name.
        guard let name = button.name else { return }
        // Compares the button name with the enumeration.
        switch name {
        case SKDirectionalPadButtons.upButton.rawValue:
            delegate?.upPadEventTriggered(eventState: state)
        case SKDirectionalPadButtons.downButton.rawValue:
            delegate?.downPadEventTriggered(eventState: state)
        case SKDirectionalPadButtons.leftButton.rawValue:
            delegate?.leftPadEventTriggered(eventState: state)
        case SKDirectionalPadButtons.rightButton.rawValue:
            delegate?.rightPadEventTriggered(eventState: state)
        default:
            break
        }
    }
    
}

/** Convenience enumeration of conventional directional buttons. */
enum SKDirectionalPadButtons: String {
    /** Pointing upward button. */
    case upButton
    /** Pointing downward button. */
    case downButton
    /** Pointing leftward button. */
    case leftButton
    /** Pointing rightward button. */
    case rightButton
}
