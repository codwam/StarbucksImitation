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
    private lazy var cardsInfoView: CardsInfoView = CardsInfoView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {
        self.addCardsView.carouselDidSelectItemAtIndex = { index in
            self.view.addSubview(self.cardsInfoView)
            
            // Cards info
            self.cardsInfoView.snp_makeConstraints { (make) in
                make.edges.equalTo(self.view)
            }
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
