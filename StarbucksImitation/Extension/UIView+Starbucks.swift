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
    
    func addRoateAniamationFromAngel(fromAngel: CGFloat, toAngel: CGFloat) {
        let rotateAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotation)
        rotateAnimation.fromValue = fromAngel
        rotateAnimation.toValue = toAngel
        rotateAnimation.dynamicsTension = 100
        self.layer.pop_addAnimation(rotateAnimation, forKey: nil)
    }
    
    func addFlyAnimationFromPositionY(positionY: CGFloat, springSpeed: CGFloat) {
        let flyAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        flyAnimation.fromValue = positionY
        if springSpeed > 0 {
            flyAnimation.springSpeed = springSpeed
        }
        flyAnimation.dynamicsTension = 100
        self.layer.pop_addAnimation(flyAnimation, forKey: nil)
    }
    
    func addFlyAnimationToPositionY(positionY: CGFloat, springSpeed: CGFloat) {
        let flyAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)
        flyAnimation.toValue = positionY
        if springSpeed > 0 {
            flyAnimation.springSpeed = springSpeed
        }
        flyAnimation.dynamicsTension = 100
        flyAnimation.autoreverses = true
        self.layer.pop_addAnimation(flyAnimation, forKey: nil)
    }
    
    func addFlyAnimationToPositionX(positionX: CGFloat, springSpeed: CGFloat) {
        let flyAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        flyAnimation.toValue = positionX
        if springSpeed > 0 {
            flyAnimation.springSpeed = springSpeed
        }
        flyAnimation.dynamicsTension = 100
        flyAnimation.autoreverses = true
        self.layer.pop_addAnimation(flyAnimation, forKey: nil)
    }
    
    func addAppearAnimationWithVelocity(velocity: CGFloat = 4.0) {
        let appearAnimation = POPDecayAnimation(propertyNamed: kPOPLayerOpacity)
        appearAnimation.fromValue = 0
        appearAnimation.velocity = fabs(velocity)
        appearAnimation.deceleration = 0.998
        self.layer.pop_addAnimation(appearAnimation, forKey: nil)
    }
    
    func addDisappearAnimationWithVelocity(velocity: CGFloat = 4.0) {
        let disAppearAnimation = POPDecayAnimation(propertyNamed: kPOPLayerOpacity)
        disAppearAnimation.fromValue = 1.0
        disAppearAnimation.velocity = fabs(velocity)
        disAppearAnimation.deceleration = 0.998
        self.layer.pop_addAnimation(disAppearAnimation, forKey: nil)
    }
    
}

extension UIView {
    
    func addCardFlyAppearAnimationFromPositionY(positionY: CGFloat) {
        self.addAppearAnimationWithVelocity()
        self.addFlyAnimationFromPositionY(positionY, springSpeed: 0)
    }
    
    func addCardFlyDisappearAnimationToPositionX(positionX: CGFloat) {
        self.addDisappearAnimationWithVelocity()
        self.addFlyAnimationToPositionX(positionX, springSpeed: 0)
    }
    
    func addCardFlyRoateAnimationFromPositionY(positionY: CGFloat, angel: CGFloat) {
        self.addRoateAniamationFromAngel(angel, toAngel: 0)
        self.addCardFlyAppearAnimationFromPositionY(positionY)
    }
    
    func addCardFlyLargeAnimationToPositionY(positionY: CGFloat) -> POPSpringAnimation {
        let cardLargeAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        cardLargeAnimation.toValue = NSValue(CGPoint: CGPointMake(1.2, 1.2))
        self.layer.pop_addAnimation(cardLargeAnimation, forKey: nil)
        self.addFlyAnimationToPositionY(positionY, springSpeed: 2)
        
        return cardLargeAnimation
    }
    
    func addCardScaleAnimation() -> POPBasicAnimation {
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.fromValue = NSValue(CGPoint: CGPointMake(3.0, 3.0))
        scaleAnimation.toValue = NSValue(CGPoint: CGPointMake(1.0, 1.0))
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.layer.pop_addAnimation(scaleAnimation, forKey: nil)
        self.addAppearAnimationWithVelocity()
        
        return scaleAnimation
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
