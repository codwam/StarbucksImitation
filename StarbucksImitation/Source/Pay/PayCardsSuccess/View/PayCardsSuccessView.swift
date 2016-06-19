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
    private var cupView: UIView!
    private var cupImageView: UIImageView!
    private var hurryLabel: UILabel!
    var finishedButton: UIButton!
    
    override func constructView() {
        super.constructView()
        
        // combined
        self.combinedImageView = UIImageView(image: UIImage(named: "combined"))
        // Cup
        self.cupView = UIView()
        self.cupView.backgroundColor = UIColor(hexString: "6C5247").flatten()
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
        self.addSubview(self.cupView)
        self.cupView.addSubview(self.cupImageView)
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
        self.cupView.snp_makeConstraints { (make) in
            make.center.equalTo(self).offset(CGPointMake(0, -60))
            make.width.equalTo(180)
            make.height.equalTo(180)
        }
        self.cupImageView.snp_makeConstraints { (make) in
            make.center.equalTo(self.cupView)
            make.width.equalTo(67)
            make.height.equalTo(107)
        }
        // hurry
        self.hurryLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.cupView.snp_bottom).offset(20)
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
        
        if self.cupView.layer.cornerRadius == 0 {
            self.cupView.layer.cornerRadius = self.cupView.bounds.width / 2
        }
    }

}
