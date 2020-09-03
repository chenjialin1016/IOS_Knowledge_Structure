//
//  TTTabbarView.swift
//  CustomTabBar
//
//  Created by 陈嘉琳 on 2020/8/26.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit
import Lottie

typealias ItemButtonBlock = ((Int)->Void)

class TTTabbarView: UIView {

    var block: ItemButtonBlock!
    
    fileprivate var currentItem: Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        currentItem = 1000
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemButton(_ num: Int, _ itemBlock: @escaping ItemButtonBlock){
        let itemW = UIScreen.main.bounds.size.width / CGFloat(num);
        let w: CGFloat = itemW / 4.0 ;
        let nameArray: [String] = ["homeData", "callListData", "contactData", "msgListData"]
        for i in 0..<num {
            let item: TTItemButton = TTItemButton(frame: CGRect(x: w+itemW*CGFloat(i), y: 0, width: 44, height: 44))
            item.imageView?.contentMode = .scaleAspectFit
            item.tag = 100+i
            let lotView = AnimationView(name: nameArray[i])
            lotView.tag = item.tag+100
            lotView.contentMode = .scaleAspectFill
            var lotFrame = item.frame
            lotFrame.origin.y = 16
            lotView.frame = lotFrame
            
            self.addSubview(lotView)
            item.addTarget(self, action: #selector(selectedButtonItem(_:)), for: .touchUpInside)
            self.addSubview(item)
            
        }
        self.setBeginAnimationLotView()
        self.block = itemBlock
        
    }

}

//MARK:--- Action
extension TTTabbarView{
    @objc fileprivate func selectedButtonItem(_ sender: UIButton){
        if currentItem != sender.tag {
            self.currentItem = sender.tag
            let lotView: AnimationView = self.viewWithTag(sender.tag + 100) as! AnimationView
            for view in self.subviews {
                if view.isKind(of: AnimationView.self) {
                    (view as! AnimationView).stop()
                }
            }
            if lotView.realtimeAnimationProgress == 0 {
                lotView.play(toProgress: 0.5)
            }
            self.block(sender.tag)
        }
    }
    
}

//MARK:--- Private
extension TTTabbarView{
    fileprivate func setBeginAnimationLotView(){
        let lotView: AnimationView = self.viewWithTag(200) as! AnimationView
        if lotView.realtimeAnimationProgress == 0 {
            lotView.play(toProgress: 0.5)
        }
    }
}
