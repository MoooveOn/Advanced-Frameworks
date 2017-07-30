//
//  Shakeable.swift
//  ShakingTextField
//
//  Created by Pavel Selivanov on 19.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

protocol Shakeable {}

extension Shakeable where Self: UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
