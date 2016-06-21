//
//  PayCardsInfoVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/19.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayCardsInfoVC: PageVC {
    
    var bannerCurrentIndex = 0
    
    private let payCardsInfoView = PayCardsInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {
        self.payCardsInfoView.bannerView.currentIndex = self.bannerCurrentIndex
        self.payCardsInfoView.doneButton.addTarget(self, action: #selector(cardsInfoDoneClicked), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.payCardsInfoView)
    }
    
    override func constructLayout() {
        // Cards info
        self.payCardsInfoView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc private func cardsInfoDoneClicked(sender: UIButton) {
        let vc = PayCardsSuccessVC()
//        vc.modalPresentationStyle = .CurrentContext
//        self.presentViewController(vc, animated: false, completion: nil)
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func instanceOfPageView() -> PageView? {
        return self.payCardsInfoView
    }

}
