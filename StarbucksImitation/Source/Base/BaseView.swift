//
//  BaseView.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.construct()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.construct()
    }
    
    func construct() {
        self.constructView()
        self.constructLayout()
    }
    
    func constructView() {
        
    }
    
    func constructLayout() {
        
    }

}
