//
//  AddCardsView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/17.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit
import iCarousel
import Spring
import SnapKit

let mStarbucksCardAnimationTop = 20
let mCardsViewTopAnimationOffset = 20

final class AddCardsView: PageView {
    
    var carouselDidSelectItemAtIndex: ((index: Int) -> Void)?
    
    private var combinedImageView: UIImageView!
    var starbucksCardImageView: UIImageView!
    private var orLabel: UILabel!
    var cardsView: iCarousel!
    private var agreementLabel: UILabel!
    
    var starbucksTopConstraint: ConstraintDescriptionEditable?
    var cardsViewTopConstraint: ConstraintDescriptionEditable?
    
    private var isUserCardScaleAnimation = false
    
    private var cardsContainerImageView: [SpringImageView] {
//        func createCardImageView(image: UIImage?) -> SpringImageView {
//            let imageView = SpringImageView(image: image)
//            imageView.frame = CGRectMake(0, 0, 285, 178)
//            return imageView
//        }
        
        let imageViews = [
//            createCardImageView(UIImage(named: "visa_card")),
//            createCardImageView(UIImage(named: "master_card")),
//            createCardImageView(UIImage(named: "apple_pay"))
            SpringImageView(image: UIImage(named: "visa_card")),
            SpringImageView(image: UIImage(named: "master_card")),
            SpringImageView(image: UIImage(named: "apple_pay"))
        ]
        return imageViews
    }
    
    override func constructView() {
        super.constructView()
        
        // combined
        self.combinedImageView = UIImageView(image: UIImage(named: "combined"))
        // Starbucks Card
        self.starbucksCardImageView = UIImageView(image: UIImage(named: "starbucks_card"))
        // OR
        self.orLabel = self.createLabel("OR", font: UIFont.systemFontOfSize(16))
        // Cards
        self.cardsView = iCarousel()
        self.cardsView.type = .Rotary
        self.cardsView.bounces = true
        self.cardsView.pagingEnabled = true
        self.cardsView.currentItemIndex = 1
        self.cardsView.dataSource = self
        self.cardsView.delegate = self
        // Agree
        self.agreementLabel = self.createLabel("I agree to Starbucks Card Terms and \n Conditions")
        
        self.addSubview(self.combinedImageView)
        self.addSubview(self.starbucksCardImageView)
        self.addSubview(self.orLabel)
        self.addSubview(self.cardsView)
        self.addSubview(self.agreementLabel)
    }
    
    private func createLabel(text: String, font: UIFont = UIFont.systemFontOfSize(12)) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = UIColor(hexString: "888A8C").flatten()
        label.numberOfLines = 0
        label.textAlignment = .Center
        
        return label
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
        // Starbucks Card
        let starbucksCardImage = self.starbucksCardImageView.image!
        let starbucksCardImageRadio = starbucksCardImage.size.height / starbucksCardImage.size.width
        self.starbucksCardImageView.snp_makeConstraints { (make) in
            self.starbucksTopConstraint = make.top.equalTo(self.combinedImageView.snp_bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(self.starbucksCardImageView.snp_width).multipliedBy(starbucksCardImageRadio)
        }
        // OR
        self.orLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.starbucksCardImageView.snp_bottom).offset(20)
            make.left.right.equalTo(self.starbucksCardImageView)
            make.height.equalTo(16)
        }
        // Cards
        self.cardsView.snp_makeConstraints { (make) in
            self.cardsViewTopConstraint = make.top.equalTo(self.orLabel.snp_bottom).offset(20)
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.agreementLabel.snp_top).offset(-10)
        }
        // Agree
        self.agreementLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(self).offset(-50)
        }
    }
    
    override func prepareForAnimation() {
        self.starbucksCardImageView.alpha = 0
        self.orLabel.alpha = 0;
        self.cardsView.alpha = 0;
        self.agreementLabel.alpha = 0;
    }
    
    override func commitAnimation() {
        self.layoutIfNeeded()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 0.5)), dispatch_get_main_queue()) {
            self.starbucksCardImageView.addCardFlyRoateAnimationFromPositionY(self.orLabel.frame.maxY, angel: CGFloat(M_PI_4 / 2))
            self.orLabel.addAppearAnimationWithVelocity()
            self.cardsView.addCardFlyAppearAnimationFromPositionY(self.cardsView.frame.maxY)
            self.agreementLabel.addAppearAnimationWithVelocity()
        }
    }

}

extension AddCardsView: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return self.cardsContainerImageView.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var reusingView = view
        if reusingView == nil {
            reusingView = self.cardsContainerImageView[index]
            reusingView!.frame = CGRectInset(carousel.bounds, 20, 0)
            reusingView?.contentMode = .ScaleAspectFit
        }
        return reusingView!
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .Wrap:
            return 1
        case .Spacing:
            return value * 1.15
        case .Arc:
            return CGFloat(M_PI / 2)
        default:
            break
        }
        
        return value
    }
    
    func carouselDidEndScrollingAnimation(carousel: iCarousel) {
        // Ignore for first
        guard self.isUserCardScaleAnimation else {
            self.isUserCardScaleAnimation = true
            return
        }
        let itemView = carousel.currentItemView as! SpringImageView
        itemView.addJerryAnimation()
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        self.commitDidSelectedAnimation(carousel, didSelectItemAtIndex: index)
    }
    
    private func commitDidSelectedAnimation(carousel: iCarousel, didSelectItemAtIndex index: Int) {
        carousel.currentItemView?.pop_removeAllAnimations()
        
        //add left and right cards remove animation
        let leftIndex = carousel.currentItemIndex == 0 ? carousel.numberOfItems - 1 : carousel.currentItemIndex - 1
        let rightIndex = carousel.currentItemIndex >= carousel.numberOfItems - 1 ? 0 : carousel.currentItemIndex + 1
        let leftView = carousel.visibleItemViews[leftIndex] as? UIView
        let rightView = carousel.visibleItemViews[rightIndex] as? UIView
        leftView?.addCardFlyDisappearAnimationToPositionX(-100)
        rightView?.addCardFlyDisappearAnimationToPositionX(UIScreen.mainScreen().bounds.width + 100)
        
        //add starbucks image  remove animation
        self.starbucksCardImageView.addFlyAnimationToPositionY(-self.starbucksCardImageView.bounds.height, springSpeed: 0)
        
        //add label dispaear animation
        self.orLabel.addDisappearAnimationWithVelocity()
        self.agreementLabel.addDisappearAnimationWithVelocity()
        
        //add card move to top animation
        let largeCardAnimation = carousel.currentItemView?.addCardFlyLargeAnimationToPositionY(self.starbucksCardImageView.center.y - carousel.frame.minY - self.combinedImageView.bounds.height)
        largeCardAnimation?.completionBlock = { _ in
            dispatch_async(dispatch_get_main_queue(), { 
                self.carouselDidSelectItemAtIndex?(index: index)
            })
        }
    }
    
}
