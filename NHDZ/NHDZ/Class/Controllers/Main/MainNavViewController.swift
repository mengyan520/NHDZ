//
//  MainNavViewController.swift
//  起点阅读
//
//  Created by Youcai on 16/9/22.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class MainNavViewController: UINavigationController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        let target = interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer.init(target: target, action:  Selector(("handleNavigationTransition:")))
       
         pan.delegate = self
        view.addGestureRecognizer(pan)
        interactivePopGestureRecognizer?.isEnabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//
//        super.pushViewController(viewController, animated: animated)
//    }

    func pop()  {
      popViewController(animated: true)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if childViewControllers.count == 1 {
            return false
        }
        return true
    }
}
