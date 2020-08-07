//
//  ViewController.swift
//  Swift_shaderLayerDemo
//
//  Created by — on 2020/8/7.
//  Copyright © 2020 —. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClick(_ sender: UIButton) {
        
        var offSet: (CGFloat, CGFloat)!
        
        switch sender.tag {
        case 0:
            offSet = (5.0, 5.0)
        case 1:
            offSet = (5.0, 0.0)
        case 2:
            offSet = (5.0, -5.0)
            
        case 3:
            offSet = (-5.0, 5.0)
        case 4:
            offSet = (-5.0, 0.0)
        case 5:
            offSet = (-5.0, -5.0)
        
        default:
            offSet = (0.0, 0.0)
        }
        
        setupShader(offSet.0, offSet.1, sender)
        
    }
    


}

extension ViewController{
    
//    当width 为正数时，向右偏移，为负数时，向左偏移
//    当height为正数时，向下偏移，为负数时，向上偏移
    fileprivate func setupShader(_ w: CGFloat, _ h: CGFloat, _ btn: UIButton){
        //设置阴影路径--避免离屏渲染
        let path = UIBezierPath(rect: btn.bounds)
        btn.layer.shadowPath = path.cgPath
        //设置阴影颜色
        btn.layer.shadowColor = UIColor.black.cgColor
        //设置透明度
        btn.layer.shadowOpacity = 0.5
        //设置阴影半径
        btn.layer.shadowRadius = 5.0
        //设置阴影偏移量
        btn.layer.shadowOffset = CGSize(width: w, height: h)
    }
}

