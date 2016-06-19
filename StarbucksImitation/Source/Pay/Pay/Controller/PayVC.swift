//
//  PayVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayVC: BaseVC {
    
    private let addCardsView = AddCardsView()
    private lazy var payCardsInfoView: PayCardsInfoView = PayCardsInfoView()
    private lazy var payCardsSuccessView: PayCardsSuccessView = PayCardsSuccessView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {
        self.addCardsView.carouselDidSelectItemAtIndex = {[unowned self] index in
//            let vc = UIViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
            
            self.payCardsInfoView.bannerView.currentIndex = index
            self.addPayCardsInfoView()
        }
        
        self.view.addSubview(self.addCardsView)
    }
    
    override func constructLayout() {
        // Cards
        self.addCardsView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

}

extension PayVC {
    
    private func addPayCardsInfoView() {
        self.payCardsInfoView.doneButton.addTarget(self, action: #selector(cardsInfoDoneClicked), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.payCardsInfoView)
        
        // Cards info
        self.payCardsInfoView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc private func cardsInfoDoneClicked(sender: UIButton) {
        self.addPayCardsSuccessView()
    }
    
}

extension PayVC {
    
    private func addPayCardsSuccessView() {
        self.payCardsSuccessView.finishedButton.addTarget(self, action: #selector(cardsSuccessFinishedClicked), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.payCardsSuccessView)
        
        // Cards info
        self.payCardsSuccessView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc private func cardsSuccessFinishedClicked(sender: UIButton) {
        self.payCardsInfoView.removeFromSuperview()
        self.payCardsSuccessView.removeFromSuperview()
    }
    
}
