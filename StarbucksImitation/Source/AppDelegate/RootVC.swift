//
//  RootVC.swift
//  StarbucksImitation
//
//  Created by lh on 16/6/17.
//  Copyright © 2016年 codwam. All rights reserved.
//

import UIKit

/// Root
final class RootVC: BaseVC {
    
    private let headerView = RootHeaderView()
    private var pageVC: UIPageViewController!
    private let pageContainerVCS: [UIViewController] = {
        let vcs = [PayVC(), StoresVC(), GiftVC()]
        
        var navs = [UINavigationController]()
        for vc in vcs {
            let nav = BaseNav(rootViewController: vc)
            nav.navigationBar.hidden = true
            navs.append(nav)
        }

        return navs
    }()
    private var presentationPageIndex = 0
    private var isHeaderScroll = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func constructView() {
        self.view.backgroundColor = UIColor.flatBlackColor()
        
        // Header
        self.headerView.didClickedButton = {[unowned self] index in
            self.isHeaderScroll = true
            
            let direction: UIPageViewControllerNavigationDirection = index > self.presentationPageIndex ? .Forward : .Reverse
            self.showVisiblePageViewController(index, direction: direction, animated: true, completion: { isFinish in
                if isFinish {
                    self.isHeaderScroll = false
                }
            })
        }
        self.view.addSubview(self.headerView)
        
        // pageVC
        let options = [
            UIPageViewControllerOptionInterPageSpacingKey: 20
        ]
        self.pageVC = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: options)
        self.pageVC.dataSource = self
        self.pageVC.delegate = self
        self.showVisiblePageViewController(0)
        
        self.view.addSubview(self.pageVC.view)
        self.addChildViewController(self.pageVC)
        self.pageVC.didMoveToParentViewController(self)
        // _UIQueuingScrollView
        for view in self.pageVC.view.subviews {
            if view.isKindOfClass(NSClassFromString("_UIQueuingScrollView")!) {
                (view as! UIScrollView).delegate = self
            }
        }
    }
    
    override func constructLayout() {
        // Header
        self.headerView.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            make.height.equalTo(mRootHeaderViewHeight)
        }
        // PageVC
        self.pageVC.view.snp_makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp_bottom)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.bottom.equalTo(self.snp_bottomLayoutGuideTop)
        }
    }

}

extension RootVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func showVisiblePageViewController(index: Int, direction: UIPageViewControllerNavigationDirection = .Forward, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        self.presentationPageIndex = index
        
        let visibleVC = self.pageContainerVCS[index]
        self.pageVC.setViewControllers([visibleVC], direction: direction, animated: animated, completion: completion)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let currentViewController = self.pageCurrentViewController(viewController, isBefore: true)
        
        return currentViewController
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let currentViewController = self.pageCurrentViewController(viewController, isBefore: false)
        
        return currentViewController
    }
    
    private func pageCurrentViewController(viewController: UIViewController, isBefore: Bool) -> UIViewController? {
        let index = self.pageContainerVCS.indexOf(viewController)
        if let index = index {
            if isBefore {
                let preIndex = index.predecessor()
                if preIndex >= 0 {
                    let preVC = self.pageContainerVCS[preIndex]
                    return preVC
                }
            } else {
                let nextIndex = index.successor()
                if nextIndex < self.pageContainerVCS.count {
                    let nextVC = self.pageContainerVCS[nextIndex]
                    return nextVC
                }
            }
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else {
            return
        }
        // current vc
        let currentVC = pageViewController.viewControllers!.first!
        let index = self.pageContainerVCS.indexOf(currentVC)!
        self.headerView.didTransitToIndex(index)
        
        self.presentationPageIndex = index
    }
    
}

extension RootVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        guard !self.isHeaderScroll else {
            return
        }
        
        let offset = scrollView.contentOffset.x
        let index = offset / scrollView.bounds.width
        // 最后还会设置一次新的VC，contentOffset会再次刷新
        guard index != 1 else {
            return
        }
        let correctIndex = index - 1// + CGFloat(self.presentationPageIndex)
//        debugPrint("offset = \(offset), correctIndex = \(correctIndex)")
        self.headerView.willTransitToIndex(correctIndex)
    }

}
