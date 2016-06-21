//
//  PageVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/21.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

class PageVC: BaseVC {
    
    var hasHandlePageAnimate = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        guard self.shouldHandlePageAnimation() else {
            return
        }
        self.instanceOfPageView()?.prepareForAnimation()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        guard self.shouldHandlePageAnimation(true) else {
            return
        }
        self.instanceOfPageView()?.commitAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        debugPrint("\(self) deinit")
    }
    
    func instanceOfPageView() -> PageView? {
        return nil
    }
    
    private func shouldHandlePageAnimation(reset: Bool = false) -> Bool {
        let hasHandlePageAnimate = self.hasHandlePageAnimate
        if reset {
            defer {
                self.hasHandlePageAnimate = true
            }
        }
        return !hasHandlePageAnimate
    }

}
