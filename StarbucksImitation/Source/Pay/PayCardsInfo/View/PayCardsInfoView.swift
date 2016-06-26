//
//  PayCardsInfoView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayCardsInfoView: PageView {

    private var combinedImageView: UIImageView!
    var bannerView: BannerView!
    
    private var cardInfoView: UIView!
    private var cardHolderView: UIView!
    private var cardHolderLabel: UILabel!
    private var cardHolderTextField: UITextField!
    
    private var cardNumberView: UIView!
    private var cardNumberLabel: UILabel!
    private var cardNumberTextField: CardTextField!
    
    private var extView: UIView!
    private var expireDateLabel: UILabel!
    private var expireDateTextField: DateTextField!
    private var cvvLabel: UILabel!
    private var cvvTextField: UITextField!
    
    var doneButton: UIButton!
    
    override func constructView() {
        super.constructView()
        
        // combined
        self.combinedImageView = UIImageView(image: UIImage(named: "combined"))
        // Banner
        self.bannerView = BannerView()
        self.bannerView.localImageNames = ["visa_card_large", "master_card_large", "apple_pay_large"]
        // Card info
        self.cardInfoView = UIView()
        // Card holder
        self.cardHolderView = UIView()
        self.cardHolderView.backgroundColor = UIColor.whiteColor()
        self.cardHolderLabel = self.createLabel("Card holder", textColor: UIColor(hexString: "A9AFB6"))
        self.cardHolderTextField = self.createTextField(nil, placeholder: "Enter your card holder", textColor: UIColor(hexString: "A9AFB6"))
        // Card number
        self.cardNumberView = UIView()
        self.cardNumberLabel = self.createLabel("Card number")
        self.cardNumberTextField = self.createTextField(CardTextField(), placeholder: "Enter your card number")
        // Expire date & CVV
        self.extView = UIView()
        self.expireDateLabel = self.createLabel("Expire date")
        self.expireDateTextField = self.createTextField(DateTextField(), placeholder: "Select your expire date")
        self.cvvLabel = self.createLabel("CVV")
        self.cvvTextField = self.createTextField(nil, placeholder: "Enter your CVV")
        self.cvvTextField.keyboardType = .NumberPad
        // Done
        self.doneButton = UIButton(type: .Custom)
        self.doneButton.setTitle("Done", forState: .Normal)
        self.doneButton.setTitleColor(UIColor.flatWhiteColor(), forState: .Normal)
        self.doneButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        self.doneButton.backgroundColor = UIColor(hexString: "6C5247").flatten()
        
        self.addSubview(self.combinedImageView)
        self.addSubview(self.bannerView)
        
        self.addSubview(self.cardInfoView)
        self.cardInfoView.addSubview(self.cardHolderView)
        self.cardHolderView.addSubview(self.cardHolderLabel)
        self.cardHolderView.addSubview(self.cardHolderTextField)
        
        self.cardInfoView.addSubview(self.cardNumberView)
        self.cardNumberView.addSubview(self.cardNumberLabel)
        self.cardNumberView.addSubview(self.cardNumberTextField)
        
        self.cardInfoView.addSubview(self.extView)
        self.extView.addSubview(self.expireDateLabel)
        self.extView.addSubview(self.expireDateTextField)
        self.extView.addSubview(self.cvvLabel)
        self.extView.addSubview(self.cvvTextField)
        
        self.addSubview(self.doneButton)
    }
    
    private func createLabel(text: String, textColor: UIColor = UIColor(hexString: "9498A2")) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFontOfSize(14)
        
        return label
    }
    
    private func createTextField<T: UITextField>(theClass: T? = nil,placeholder: String, textColor: UIColor = UIColor(hexString: "9498A2")) -> T {
        let textField = theClass ?? T()
        textField.placeholder = placeholder
        textField.textColor = textColor.flatten()
        textField.font = UIFont.systemFontOfSize(14)
        
        return textField
    }
    
    override func constructLayout() {
        let padding = 8
        let containerViewHeight = 62
        let containerViewSpacing = 24
        let containerLabelPadding = 30
        
        // combined
        let combinedImage = self.combinedImageView.image!
        self.combinedImageView.snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self)
            make.width.equalTo(combinedImage.size.width / 2)
            make.height.equalTo(combinedImage.size.height / 2)
        }
        // Banner
        self.bannerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.combinedImageView.snp_bottom).offset(10)
            make.left.right.equalTo(self)
        }
        // Card info
        self.cardInfoView.snp_makeConstraints { (make) in
            make.top.equalTo(self.bannerView.snp_bottom).offset(20)
            make.left.right.equalTo(self.bannerView)
            make.bottom.equalTo(self.doneButton.snp_top).offset(-containerViewSpacing * 2)
        }
        // Card holder
        self.cardHolderView.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardInfoView)
            make.left.right.equalTo(self.bannerView)
            make.height.equalTo(containerViewHeight)
        }
        self.cardHolderLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardHolderView).offset(padding)
            make.left.equalTo(self.cardHolderView).offset(containerLabelPadding)
            make.right.equalTo(self.cardHolderView).offset(-containerLabelPadding)
        }
        self.cardHolderTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardHolderLabel.snp_bottom).offset(padding)
            make.left.right.equalTo(self.cardHolderLabel)
            make.bottom.equalTo(self.cardHolderView).offset(-padding)
        }
        // Card number
        self.cardNumberView.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardHolderView.snp_bottom).offset(containerViewSpacing)
            make.left.right.equalTo(self.cardHolderView)
            make.height.equalTo(containerViewHeight)
        }
        self.cardNumberLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardNumberView).offset(padding)
            make.left.equalTo(self.cardNumberView).offset(containerLabelPadding)
            make.right.equalTo(self.cardNumberView).offset(-containerLabelPadding)
        }
        self.cardNumberTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardNumberLabel.snp_bottom).offset(padding)
            make.left.right.equalTo(self.cardNumberLabel)
            make.bottom.equalTo(self.cardNumberView).offset(-padding)
        }
        // Expire date & CVV
        self.extView.snp_makeConstraints { (make) in
            make.top.equalTo(self.cardNumberView.snp_bottom).offset(containerViewSpacing)
            make.left.right.equalTo(self.cardNumberView)
            make.height.equalTo(containerViewHeight)
            make.bottom.equalTo(self.cardInfoView)
        }
        self.expireDateLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.extView).offset(padding)
            make.left.equalTo(self.extView).offset(containerLabelPadding)
            make.right.equalTo(self.extView.snp_centerY)
        }
        self.expireDateTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.expireDateLabel.snp_bottom).offset(padding)
            make.left.right.equalTo(self.expireDateLabel)
            make.bottom.equalTo(self.extView).offset(-padding)
        }
        self.cvvLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.extView).offset(padding)
            make.left.equalTo(self.extView.snp_centerX)
            make.right.equalTo(self.cardNumberView).offset(-containerLabelPadding)
        }
        self.cvvTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.cvvLabel.snp_bottom).offset(padding)
            make.left.right.equalTo(self.cvvLabel)
            make.bottom.equalTo(self.extView).offset(-padding)
        }
        // Done
        self.doneButton.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(68)
        }
    }
    
    override func prepareForAnimation() {
        self.cardInfoView.alpha = 0
        self.doneButton.alpha = 0
    }
    
    override func commitAnimation() {
        self.layoutIfNeeded()
        
        self.cardInfoView.addAppearAnimationWithVelocity()
        self.doneButton.addAppearAnimationWithVelocity()
    }

}
