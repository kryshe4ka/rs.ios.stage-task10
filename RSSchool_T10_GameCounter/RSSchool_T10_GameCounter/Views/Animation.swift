//
//  Animation.swift
//  RSSchool_T10_GameCounter
//
//  Created by Liza Kryshkovskaya on 26.08.21.
//

import UIKit

class Animation {
    
    static func shakeAnimation(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 10, y: onView.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 10, y: onView.center.y))
        onView.layer.add(animation, forKey: "position")
    }
}
