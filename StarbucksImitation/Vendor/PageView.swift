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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !self.isSetTopCorner {
            self.addTopCorners()
            
            self.isSetTopCorner = false
        }
    }
    
    override func constructView() {
        self.backgroundColor = UIColor(hexString: "F1F1F1").flatten()
    }

}

// MARK: - PageProtocol

protocol PageProtocol {
    func addTopCorners()
}

extension PageProtocol where Self: UIView {
    
    func addTopCorners() {
        let cornerPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.TopLeft, .TopRight], cornerRadii: CGSizeMake(10.0, 10.0))
        let cornerMaskLayer = CAShapeLayer()
        cornerMaskLayer.frame = self.bounds
        cornerMaskLayer.path = cornerPath.CGPath
        self.layer.mask = cornerMaskLayer
    }
    
}
