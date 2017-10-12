//
//  MainTabBarViewController.swift
//  仿漫漫
//
//  Created by Youcai on 16/5/18.
//  Copyright © 2016年 mm. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController,UITabBarControllerDelegate {
    var tag  = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
         delegate = self
        view.backgroundColor = WHITE_COLOR
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        switch item.tag {
        case 0:
            if tag == 0 {
                POSTNOTIFICATION(name: RefreshHome, data: nil)
            } else {
                tag = 0
            }
            
            break
        case 1:

            tag = 1

            break
        case 3:
            tag = 2
            
//            let conr = LoginTableViewController()
//            let nav = UINavigationController.init(rootViewController: conr)
//            
//            self.selectedViewController?.present(nav, animated: true, completion: nil)
            break
        default:
            tag = 2
            
            break
            
        }
        
        
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == tabBarController.viewControllers?[2] {
            return false
        }
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- 添加Tab子控制器
    func addChildVc(arrVC:[UIViewController])  {
        var arr = [UIViewController]()
        for vc in arrVC {
            let nav = MainNavViewController(rootViewController: vc)
            arr.append(nav)
        }
        viewControllers = arr
    }
    func BaseTabBarItem(titles:[String]?,Font:UIFont?,titleColor:UIColor?,selectedTitleColor:UIColor?,images:[String]?,selectedImages:[String]?,barBackgroundImage:UIImage?) {
        if (barBackgroundImage != nil) {
            tabBar.backgroundImage = barBackgroundImage
            // tabBar.shadowImage = UIImage(imageLiteral: "bg_t.png")
        }
        if titleColor != nil && (titles?.count)! > 0 {
            
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:titleColor!,NSFontAttributeName:Font!], for: .disabled)
        }
        if selectedTitleColor != nil && (titles?.count)! > 0  {
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:selectedTitleColor!,NSFontAttributeName:Font!], for: .selected)
        }
        var i:NSInteger = 0
        for item in tabBar.items! {
            if (titles?.count)! > 0 {
                item.title = titles![i]
            }
            item.tag = i
            if (images?.count)! > 0 {
                
                item.image = UIImage.init(named:  images![i])?.withRenderingMode(.alwaysOriginal)
                
            }
            if (selectedImages?.count)! > 0 {
                
                item.selectedImage = UIImage.init(named: selectedImages![i])?.withRenderingMode(.alwaysOriginal)
            }
            i += 1
        }
    }
}
