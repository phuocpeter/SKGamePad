//
//  SKColorButton.swift
//  SKGamePad
//
//  Created by Phuoc Tran on 2018-06-10.
//  Copyright © 2018 Phuoc Tran. All rights reserved.
//

import SpriteKit

/**
 A retangular color sprite that register touch events.
 */
public class SKColorButton: SKSpriteNode {
    /** The touch listener of the sprite. */
    public var listener: SKColorButtonTouchesListener?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: nil, color: color, size: size)
        self.isUserInteractionEnabled = true
    }
    
    /**
     Initializes a color sprite button.
     - parameters:
        - name: the name of the button used for detecting event caller.
        - color: the color of the button.
        - size: the size of the button.
     */
    convenience public init(name: String, color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
        self.name = name
    }
    
}

// Touch events handling.
extension SKColorButton {
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            listener?.buttonTouched(button: self, withState: .begun)
        }
        super.touchesBegan(touches, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            listener?.buttonTouched(button: self, withState: .ended)
        }
        super.touchesEnded(touches, with: event)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            listener?.buttonTouched(button: self, withState: .moved)
        }
        super.touchesMoved(touches, with: event)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            listener?.buttonTouched(button: self, withState: .cancelled)
        }
        super.touchesCancelled(touches, with: event)
    }
}

/** Touch event states of the button. */
public enum SKColorButtonTouchEvent {
    /** The button is touched. */
    case begun
    /** The button is released. */
    case ended
    /** The button is moving. */
    case moved
    /** The button is cancelled. */
    case cancelled
}

/** Listener for button's touch event notifications. */
public protocol SKColorButtonTouchesListener {
    /**
     Notifies that the button is touched.
     - parameters:
        - button: the button that triggered this event.
        - withState: the state of the event.
     */
    func buttonTouched(button: SKColorButton, withState state: SKColorButtonTouchEvent)
}

