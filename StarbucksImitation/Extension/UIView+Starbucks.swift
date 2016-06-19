//
//  UIView+Starbucks.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import pop
import Spring
import UIKit

extension UIView {
    
    func addJerryAnimation() {
        let smallAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        smallAnimation.toValue = NSValue(CGPoint: CGPointMake(0.98, 0.98))
        smallAnimation.springSpeed = 20
        
        let normalAnimation = smallAnimation.copy() as! POPSpringAnimation
        normalAnimation.toValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
        
        let largeAnimation = smallAnimation.copy() as! POPSpringAnimation
        largeAnimation.toValue = NSValue(CGPoint: CGPointMake(1.02, 1.02))
        
        smallAnimation.completionBlock = { (animation, isFinish) in
            if isFinish {
                self.layer.pop_addAnimation(normalAnimation, forKey: nil)
            }
        }
        
        largeAnimation.completionBlock = { (animation, isFinish) in
            if isFinish {
                self.layer.pop_addAnimation(smallAnimation, forKey: nil)
            }
        }
        
        self.layer.pop_addAnimation(largeAnimation, forKey: nil)
    }
    
}

extension SpringImageView {
    
    func addSpringJerryAnimation() {
        self.animation = Spring.AnimationPreset.Pop.rawValue
        self.damping = 1
        self.scaleX = 1.2
        self.scaleY = 1.2
        self.animateTo()

        self.scaleX = 0.98
        self.scaleY = 0.98
        self.animateTo()

        self.scaleX = 1.0
        self.scaleY = 1.0
        self.animate()
    }
    
}
