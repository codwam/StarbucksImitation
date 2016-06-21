//
//  PayCardsSuccessView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/19.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayCardsSuccessView: PageView {

    private var combinedImageView: UIImageView!
    private var backCupView: UIView!
    private var cupImageView: UIImageView!
    private var hurryLabel: UILabel!
    var finishedButton: UIButton!
    
    override func constructView() {
        super.constructView()
        
        // combined
        self.combinedImageView = UIImageView(image: UIImage(named: "combined"))
        // Cup
        self.backCupView = UIView()
        self.backCupView.backgroundColor = UIColor(hexString: "6C5247").flatten()
        self.cupImageView = UIImageView(image: UIImage(named: "cup"))
        // hurry
        self.hurryLabel = UILabel()
        self.hurryLabel.text = "HURRY!"
        self.hurryLabel.textColor = UIColor(hexString: "CC9966").flatten()
        self.hurryLabel.font = UIFont.systemFontOfSize(32)
        // Finished
        self.finishedButton = UIButton(type: .Custom)
        self.finishedButton.setTitle("Finished", forState: .Normal)
        self.finishedButton.setTitleColor(UIColor.flatWhiteColor(), forState: .Normal)
        self.finishedButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        self.finishedButton.backgroundColor = UIColor(hexString: "6C5247").flatten()
        
        self.addSubview(self.combinedImageView)
        self.addSubview(self.backCupView)
        self.backCupView.addSubview(self.cupImageView)
        self.addSubview(self.hurryLabel)
        self.addSubview(self.finishedButton)
    }
    
    override func constructLayout() {
        // combined
        let combinedImage = self.combinedImageView.image!
        self.combinedImageView.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self)
            make.width.equalTo(combinedImage.size.width / 2)
            make.height.equalTo(combinedImage.size.height / 2)
        }
        // Cup
        self.backCupView.snp_makeConstraints { (make) in
            make.center.equalTo(self).offset(CGPointMake(0, -60))
            make.width.equalTo(180)
            make.height.equalTo(180)
        }
        self.cupImageView.snp_makeConstraints { (make) in
            make.center.equalTo(self.backCupView)
            make.width.equalTo(67)
            make.height.equalTo(107)
        }
        // hurry
        self.hurryLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.backCupView.snp_bottom).offset(20)
            make.centerX.equalTo(self)
        }
        // Done
        self.finishedButton.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(68)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.backCupView.layer.cornerRadius == 0 {
            self.backCupView.layer.cornerRadius = self.backCupView.bounds.width / 2
        }
    }
    
    override func prepareForAnimation() {
        self.backCupView.alpha = 0
        self.cupImageView.alpha = 0
        self.hurryLabel.alpha = 0
        self.finishedButton.alpha = 0
    }
    
    override func commitAnimation() {
        self.layoutIfNeeded()
        
        let scaleAnimation = self.backCupView.addCardScaleAnimation()
        scaleAnimation.completionBlock = { (_, isFinish) in
            if isFinish {
                self.cupImageView.addCardFlyAppearAnimationFromPositionY(self.cupImageView.center.y + self.cupImageView.bounds.height)
                self.hurryLabel.addAppearAnimationWithVelocity()
                self.finishedButton.addAppearAnimationWithVelocity()
            }
        }
    }

}
