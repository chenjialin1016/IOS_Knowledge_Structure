//
//  TTCustomTabBar.swift
//  CustomTabBar
//
//  Created by 陈嘉琳 on 2020/8/26.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit

class TTCustomTabBar: UITabBar {

    var itemClouse: ((Int)->Void) = {item in}
    
    var tabbarView: TTTabbarView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTabbarView()
        self.addSubview(tabbarView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置tabBarView的frame
        self.tabbarView.frame = self.bounds
        // 把tabBarView带到最前面，覆盖tabBar的内容
        self.bringSubviewToFront(self.tabbarView)
    }
    
}


extension TTCustomTabBar{
    fileprivate func setupTabbarView(){
        self.tabbarView = TTTabbarView(frame: self.bounds)
        tabbarView.itemButton(4) { (item) in
            self.itemClouse(item)
        }
    }
}
