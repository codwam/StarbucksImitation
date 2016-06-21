//
//  PayVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayVC: PageVC {
    
    private let addCardsView = AddCardsView()

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
            let vc = PayCardsInfoVC()
            vc.bannerCurrentIndex = index
//            vc.modalPresentationStyle = .OverCurrentContext
//            self.navigationController?.presentViewController(vc, animated: false, completion: nil)
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        self.view.addSubview(self.addCardsView)
    }
    
    override func constructLayout() {
        // Cards
        self.addCardsView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    override func instanceOfPageView() -> PageView? {
        return self.addCardsView
    }

}
