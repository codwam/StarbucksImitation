//
//  GiftVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class GiftVC: BaseVC {
    
    let giftView = GiftView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {        
        self.view.addSubview(self.giftView)
    }
    
    override func constructLayout() {
        // Gift view
        self.giftView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

}
