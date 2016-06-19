//
//  StoresView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class StoresView: PageView {

    private var label: UILabel!
    
    override func constructView() {
        super.constructView()
        
        // Test label
        self.label = UILabel()
        self.label.text = "It is no STORES \n Wait for you Pull Request...."
        self.label.font = UIFont.systemFontOfSize(17)
        self.label.textColor = UIColor(hexString: "888A8C").flatten()
        self.label.numberOfLines = 0
        self.label.textAlignment = .Center
        
        self.addSubview(self.label)
    }
    
    override func constructLayout() {
        // Test label
        self.label.snp_makeConstraints { (make) in
            make.edges.equalTo(self).inset(10)
        }
    }

}
