//
//  RootHeaderView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/17.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit
import ChameleonFramework
import SnapKit

let mRootHeaderViewHeight = 60

/// PAY, STORES, GIFT View
final class RootHeaderView: BaseView {
    
    var didClickedButton: ((index: Int) -> Void)?
    
    private var buttons = [UIButton]()
    private let buttonNormalColor = UIColor(hexString: "#888A8C").flatten()
    private let buttonSelectedColor = UIColor.flatWhiteColor()
    
    override func constructView() {
        let titles = ["PAY", "STORES", "GIFT"]
        
        for (index, title) in titles.enumerate() {
            let button = self.createButton(title)
            button.tag = index
            self.addSubview(button)
            
            // First selected
            if index == 0 {
                button.selected = true
                self.lastSelectedButton = button
            }
            
            self.buttons.append(button)
        }
    }
    
    private func createButton(title: String) -> UIButton {
        let button = UIButton(type: .Custom)
        button.setTitle(title, forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(buttonNormalColor, forState: .Normal)
        button.setTitleColor(buttonSelectedColor, forState: .Selected)
        button.setTitleColor(UIColor(hexString: "#49C1FC").flatten(), forState: .Highlighted)
        button.addTarget(self, action: #selector(buttonClicked), forControlEvents: .TouchUpInside)
        
        return button
    }
    
    override func constructLayout() {
        let buttonHeight = 15
        
        for (index, button) in self.buttons.enumerate() {
            button.snp_makeConstraints { (make) in
                if index == 0 {// Pay
                    make.centerX.equalTo(self).dividedBy(2)
                } else if index == 1 {// Stores
                    make.centerX.equalTo(self)
                } else {// Gift
                    make.centerX.equalTo(self).multipliedBy(1.5)
                }
                make.centerY.equalTo(self)
                make.height.equalTo(buttonHeight)
            }
        }
    }
    
    func willTransitToIndex(index: CGFloat) {
        let minIndex = CGFloat(0)
        let maxIndex = CGFloat(self.buttons.count)
        
        let lastIndex = CGFloat(self.lastSelectedButton.tag)
        let currentIndex: Int!
        if index > 0 {// Forward
            currentIndex = Int(ceil(lastIndex + index))
        } else {// Reverse
            currentIndex = Int(floor(lastIndex + index))
        }
        
        guard currentIndex >= Int(minIndex) && currentIndex < Int(maxIndex) else {
            return
        }
        
        // last button
        let lastSelectedButton = self.lastSelectedButton
        // current button
        let currentSelectedButton = self.buttons[currentIndex]
        
        let nonNagativeIndex = fabs(index)
        let isHalfPass = nonNagativeIndex - floor(nonNagativeIndex) > 0.5
//        debugPrint("index = \(nonNagativeIndex), floor(index) = \(floor(nonNagativeIndex)) isHalfPass = \(isHalfPass)")
        lastSelectedButton.selected = !isHalfPass
        currentSelectedButton.selected = isHalfPass
    }
    
    func didTransitToIndex(index: Int) {
        // last selected
        self.lastSelectedButton.selected = false
        // current selected
        let currentButton = self.buttons[index]
        currentButton.selected = true
        
        self.lastSelectedButton = currentButton
    }

}

extension RootHeaderView {
    
    private struct AsscociatedType {
        static var lastSelectedButton: UIButton?
    }
    
    var lastSelectedButton: UIButton {
        get {
            let button = objc_getAssociatedObject(self, &AsscociatedType.lastSelectedButton) as! UIButton
            return button
        }
        set {
            objc_setAssociatedObject(self, &AsscociatedType.lastSelectedButton, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func buttonClicked(sender: UIButton) {
        guard !sender.selected else {
            return
        }
        // unselected before
        self.lastSelectedButton.selected = false
        // selected current
        sender.selected = true
        
        self.lastSelectedButton = sender
        
        self.didClickedButton?(index:  sender.tag)
    }
    
}
