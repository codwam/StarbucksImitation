//
//  BannerView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import iCarousel

final class BannerView: BaseView {

    private var imageCarousel: iCarousel!
    private var tipLabel: UILabel!
    private var pageControl: UIPageControl!
    
    override func constructView() {
        // Image
        self.imageCarousel = iCarousel()
        // Tip
        self.tipLabel = UILabel()
        self.tipLabel.text = "Swipe to change the card"
        self.tipLabel.textColor = UIColor(hex: "BBBBBB").flatten()
        self.tipLabel.font = UIFont.systemFontOfSize(12)
        // PageControl
        self.pageControl = UIPageControl()
        
        self.addSubview(self.imageCarousel)
        self.addSubview(self.tipLabel)
        self.addSubview(self.pageControl)
    }
    
    override func constructLayout() {
        // Image
        self.imageCarousel.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        // Tip
        self.tipLabel.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.pageControl)
            make.height.equalTo(12)
        }
        // PageControl
        self.pageControl.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-8)
            make.height.equalTo(30)
        }
    }

}
