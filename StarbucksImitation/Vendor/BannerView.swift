//
//  BannerView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import iCarousel

final class BannerView: BaseView {
    
    var localImageNames = [String]() {
        didSet {
            self.imageCarousel.reloadData()
            self.pageControl.numberOfPages = self.localImageNames.count
            

        }
    }
    var currentIndex = 0

    private var imageCarousel: iCarousel!
    private var tipLabel: UILabel!
    private var pageControl: UIPageControl!
    
    override func constructView() {
        // Image
        self.imageCarousel = iCarousel()
//        self.imageCarousel.type = .Rotary
        self.imageCarousel.pagingEnabled = true
        self.imageCarousel.dataSource = self
        self.imageCarousel.delegate = self
        // Tip
        self.tipLabel = UILabel()
        self.tipLabel.text = "Swipe to change the card"
        self.tipLabel.textColor = UIColor(hex: "BBBBBB").flatten()
        self.tipLabel.font = UIFont.systemFontOfSize(14)
        self.tipLabel.textAlignment = .Center
        // PageControl
        self.pageControl = UIPageControl()
        self.pageControl.hidesForSinglePage = true
        self.pageControl.currentPageIndicatorTintColor = UIColor(hexString: "BEBEBE").flatten()
        self.pageControl.pageIndicatorTintColor = UIColor(hexString: "E3E3E3").flatten()
        
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
            make.left.right.equalTo(self.pageControl)
            make.bottom.equalTo(self.pageControl.snp_top)
            make.height.equalTo(12)
        }
        // PageControl
        self.pageControl.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self).offset(-8)
            make.height.equalTo(30)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.imageCarousel.currentItemIndex != self.currentIndex {
            self.imageCarousel.scrollToItemAtIndex(self.currentIndex, animated: false)
            self.pageControl.currentPage = self.currentIndex
        }
    }

}

extension BannerView: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return self.localImageNames.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var reusingView = view
        if reusingView == nil {
            let image = UIImage(named: self.localImageNames[index])
            reusingView = UIImageView(image: image)
            reusingView?.frame = self.bounds
        }
        return reusingView!
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .Wrap:
            return 1
        default:
            return value
        }
    }
    
    func carouselCurrentItemIndexDidChange(carousel: iCarousel) {
        self.pageControl.currentPage = carousel.currentItemIndex
    }
    
}
