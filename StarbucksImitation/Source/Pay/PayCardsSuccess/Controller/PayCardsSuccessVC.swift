//
//  PayCardsSuccessVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/19.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

final class PayCardsSuccessVC: PageVC {
    
    private let payCardsSuccessView = PayCardsSuccessView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {
        self.payCardsSuccessView.finishedButton.addTarget(self, action: #selector(cardsSuccessFinishedClicked), forControlEvents: .TouchUpInside)
        self.view.addSubview(self.payCardsSuccessView)
    }
    
    override func constructLayout() {
        // Cards Success
        self.payCardsSuccessView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc private func cardsSuccessFinishedClicked(sender: UIButton) {
//        let presentingViewController = self.presentingViewController
//        self.dismissViewControllerAnimated(false, completion: {
//            // PayCardsInfoVC dismiss
//            presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
//        })
        if let vcs = self.navigationController?.viewControllers {
            if let vc = vcs.first as? PageVC {
                vc.hasHandlePageAnimate = false
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
    
    override func instanceOfPageView() -> PageView? {
        return self.payCardsSuccessView
    }

}
