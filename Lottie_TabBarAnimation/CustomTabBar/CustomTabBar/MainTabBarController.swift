//
//  MainTabBarController.swift
//  CustomTabBar
//
//  Created by 陈嘉琳 on 2020/9/2.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

       let customTabBar = TTCustomTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
        
        customTabBar.itemClouse = {[unowned self] item in
            self.selectedIndex = item - 100
        }
        
        addChildVC()
    }
    

    
}

extension MainTabBarController{
    fileprivate func addChildVC(){
        
        let home = UIViewController()
        home.view.backgroundColor = UIColor.red
        self.add(home, title: "首页", imageName: "tabBar_home_normal")
        
        let second = UIViewController()
        second.view.backgroundColor = UIColor.green
        self.add(second, title: "通话", imageName: "tabBar_call_normal")
        
        let third = UIViewController()
        third.view.backgroundColor = UIColor.black
        self.add(third, title: "联系人", imageName: "tabBar_link_normal")
        
        let fourth = UIViewController()
        fourth.view.backgroundColor = UIColor.white
        self.add(fourth, title: "信息", imageName: "tabBar_message_normal")
        
    }
    
    private func add(_ vc: UIViewController, title: String, imageName: String){
        let nav = UINavigationController(rootViewController: vc)
        self.addChild(nav)
    }
}
