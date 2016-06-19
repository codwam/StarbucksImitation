//
//  BaseVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/18.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.construct()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
