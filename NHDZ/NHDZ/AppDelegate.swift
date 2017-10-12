//
//  AppDelegate.swift
//  NHDZ
//
//  Created by Youcai on 2017/7/25.
//  Copyright © 2017年 mm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabbarController:MainTabBarViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        changeToMainPage()
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //MARK:- 控制器
    func changeToMainPage () {
        tabbarController = MainTabBarViewController()
        let backgroundImage = UIImage.init().ImageWithColor(color:WHITE_COLOR)
        tabbarController?.addChildVc(arrVC: [HomeViewController(),ShowViewController(),UIViewController(), DiscoverTableViewController(),UserTableViewController()])
        tabbarController?.BaseTabBarItem(titles: ["首页","段友秀","直播","发现","我的"], Font: Font(fontSize: 12), titleColor:BLACK_COLOR, selectedTitleColor:RGB(r: 110, g: 85, b: 72, a: 1.0), images:["icon_main","main_tab_qbfriends","main_tab_live","icon_chat","icon_me"], selectedImages: ["icon_main_active","main_tab_qbfriends_active","main_tab_live_active","icon_chat_active","icon_me_active"], barBackgroundImage: backgroundImage)
        window?.rootViewController = tabbarController
    }
}
