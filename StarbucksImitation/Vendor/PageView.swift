//
//  PageView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

class PageView: BaseView, PageProtocol {

    private var isSetTopCorner = false
    
    override func constructView() {
        self.backgroundColor = UIColor(hexString: "F1F1F1").flatten()
        
        if self.shouldAddRestartAnimationButton() {
            self.addRestartAnimationButton()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isSetTopCorner {
            self.addTopCorners()
            
            self.isSetTopCorner = false
        }
    }
    
    func addTopCorners() {
        let cornerPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10.0, 10.0))
        let cornerMaskLayer = CAShapeLayer()
        cornerMaskLayer.frame = self.bounds
        cornerMaskLayer.path = cornerPath.CGPath
        self.layer.mask = cornerMaskLayer
    }
    
    func prepareForAnimation() {
        
    }
    
    func commitAnimation() {
//        self.layoutIfNeeded()
    }
    
    func shouldAddRestartAnimationButton() -> Bool {
        return true
    }
    
    @objc private func addRestartAnimationButton() {
        let repeatAnimationButton = UIButton()
        repeatAnimationButton.setTitle("Repeat Animation", forState: .Normal)
        repeatAnimationButton.setTitleColor(UIColor.flatBlueColorDark(), forState: .Normal)
        repeatAnimationButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        repeatAnimationButton.addTarget(self, action: #selector(PageView.repeatAnimationClicked(_:)), forControlEvents: .TouchUpInside)
        
        self.addSubview(repeatAnimationButton)
        
        repeatAnimationButton.snp_makeConstraints { (make) in
            make.top.equalTo(self)
            make.right.equalTo(self).offset(-8)
        }
    }
    
    @objc private func repeatAnimationClicked(sender: UIButton) {
        self.prepareForAnimation()
        
        self.commitAnimation()
    }

}

// MARK: - PageProtocol

protocol PageProtocol {
    
    func addTopCorners()
    
    func prepareForAnimation()
    
    func commitAnimation()
    // Just for test
    func shouldAddRestartAnimationButton() -> Bool
    
}
