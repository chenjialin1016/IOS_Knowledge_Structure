//
//  HomeTabBarController.swift
//  CustomTabBar
//
//  Created by 陈嘉琳 on 2020/9/2.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit
import Lottie

class HomeTabBarController: UITabBarController {
    
    var animationView: AnimationView?
    
    var lottieNameArr: [String] = ["homeData", "callListData", "contactData", "msgListData"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
        self.tabBar.backgroundColor = UIColor.lightGray
        self.tabBar.tintColor = UIColor(red: 255/255, green: 78/255, blue: 80/255, alpha: 1)
        
        setupChildVC()
    }
    

}
//MARK:--- set up
extension HomeTabBarController{
    fileprivate func setupChildVC(){
        
        let first = UIViewController()
        first.view.backgroundColor = UIColor.yellow
        
        let second = UIViewController()
        second.view.backgroundColor = UIColor.green
        
        let third = UIViewController()
        third.view.backgroundColor = UIColor.purple
        
        let fourth = UIViewController()
        fourth.view.backgroundColor = UIColor.white
        
        setTabbarChild(first, title: "首页", img: "tabBar_home_normal", selectImg: "tabBar_home_selected")
        setTabbarChild(second, title: "通话", img: "tabBar_call_normal", selectImg: "tabBar_call_selected")
        setTabbarChild(third, title: "联系人", img: "tabBar_link_normal", selectImg: "tabBar_link_selected")
        setTabbarChild(fourth, title: "消息", img: "tabBar_message_normal", selectImg: "tabBar_message_selected")
    }
    
    private func setTabbarChild(_ vc: UIViewController,title: String, img: String, selectImg: String){
        let vc = vc
//        vc.view.backgroundColor = UIColor.white
        let nvc = UINavigationController(rootViewController: vc)
        nvc.tabBarItem.title = title
        
        var image = UIImage(named: img)
        image = image?.withRenderingMode(.alwaysOriginal)
        nvc.tabBarItem.image = image
        
        var selectImage = UIImage(named: img)
        selectImage = selectImage?.withRenderingMode(.automatic)
        nvc.tabBarItem.selectedImage = selectImage
        
        nvc.tabBarItem.imageInsets = UIEdgeInsets(top: -1.5, left: 0, bottom: 1.5, right: 0)
        self.addChild(nvc)
    }
    
    
}

//MARK:--- UITabBarControllerDelegate
extension HomeTabBarController: UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setupAnimation(tabBarController, viewController)
    }
    
    private func getAnimationViewAtTabBarIndex(_ index: Int, _ frame: CGRect)-> AnimationView{
            
        // tabbar1 。。。 tabbar3
        let view = AnimationView(name: lottieNameArr[index])
        view.frame = frame
        view.contentMode = .scaleAspectFill
        view.animationSpeed = 1
        return view
    }

    private func setupAnimation(_ tabBarVC: UITabBarController, _ viewController: UIViewController){
        
        if animationView != nil {
            animationView!.stop()
        }
        
    //        1. 获取当前点击的是第几个
        let index = tabBarVC.viewControllers?.index(of: viewController)
        var tabBarSwappableImageViews = [UIImageView]()
        
    //        2.遍历取出所有的 tabBarButton
        for tempView in tabBarVC.tabBar.subviews {
            if tempView.isKind(of: NSClassFromString("UITabBarButton")!) {
                //2.1 继续遍历tabBarButton 找到 UITabBarSwappableImageView 并保存
    //                print("tempView : \(tempView.subviews)" )
                    //从subviews中查找
                    for tempImgV in tempView.subviews {
                        //第一种层级关系 UITabBarButton --> UITabBarSwappableImageView
                        if tempImgV.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                            tabBarSwappableImageViews.append(tempImgV as! UIImageView)
                        }else{
                            //第二种：UITabBarButton --> UIVisualEffectView --> _UIVisualEffectContentView--> UITabBarSwappableImageView
                             let array = tempView.subviews[0].subviews[0].subviews
                            for tempImg in array {
                                if tempImg.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                                    tabBarSwappableImageViews.append(tempImg as! UIImageView)
                                }
                            }
                        }
                    }
                
                
            }
        }
        
        
    //        3. 找到当前的UITabBarButton
        let currentTabBarSwappableImageView = tabBarSwappableImageViews[index!]
        
    //        4. 获取UITabBarButton中的 UITabBarSwappableImageView 并隐藏
        var frame = currentTabBarSwappableImageView.frame
        frame.origin.x = 0
        frame.origin.y = 0
        var animation: AnimationView? = getAnimationViewAtTabBarIndex(index!, frame)
        self.animationView = animation
         self.animationView!.center = currentTabBarSwappableImageView.center
        
        
    //        5. 创建动画 view 加载到 当前的 UITabBarButton 并隐藏 UITabBarSwappableImageView
        currentTabBarSwappableImageView.superview?.addSubview( animation!)
        currentTabBarSwappableImageView.isHidden = true
        
    //        6. 执行动画，动画结束后 显示 UITabBarSwappableImageView 移除 动画 view 并置空
        animation!.play(fromProgress: 0, toProgress: 1) { (finished) in
            currentTabBarSwappableImageView.isHidden = false
            animation!.removeFromSuperview()
             animation = nil
        }
    }
}
