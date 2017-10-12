//
//  HomeViewController.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/27.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var pageView:PageScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WHITE_COLOR
        automaticallyAdjustsScrollViewInsets = false
        title = "首页"
        let arrs = ["-105","-104", "-103", "-102"]
        for i in 0..<4 {
            let vc = HomeTableViewController.init(content_type: arrs[i])
            addChildViewController(vc)
        }
        pageView = PageScrollView.init(childControllers: childViewControllers, titles: ["推荐","视频", "图片", "段子"])
        view.addSubview(pageView!)
        pageView?.frame = CGRect.init(x: 0, y: 64, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-64-49)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.refreshHome), name: NSNotification.Name(rawValue: RefreshHome), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func refreshHome() {
        let vc = self.childViewControllers[(pageView?.selectedIndex)!] as! HomeTableViewController
         vc.tableView.mj_header.beginRefreshing()
    }
}
