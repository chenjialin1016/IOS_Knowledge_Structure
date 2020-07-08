//
//  ViewController.swift
//  CornerRadiusPlan
//
//  Created by 陈嘉琳 on 2020/7/7.
//  Copyright © 2020 CJL. All rights reserved.
//

import UIKit
import YYWebImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        MARK: --- imageView的layer设置圆角
        let btn0 = UIButton(type: .custom)
        btn0.frame = CGRect(x: 100, y: 60, width: 100, height: 100)
        //设置圆角
        btn0.imageView?.layer.cornerRadius = 50
        self.view.addSubview(btn0)
        //设置背景图片
        btn0.setImage(UIImage(named: "mouse"), for: .normal)
        //裁剪
        btn0.imageView?.layer.masksToBounds = true
        
//        MARK: --- 利用贝塞尔曲线设置圆角
        let btn1 = UIButton(type: .custom)
        btn1.frame = CGRect(x: 100, y: 200, width: 100, height: 100)
        //设置圆角
        var cornerRadius: CGFloat = btn1.frame.size.width
        self.view.addSubview(btn1)
        //设置背景图片
        let image = UIImage(named: "mouse")?.roundedCornerImageWithCornerRadius(&cornerRadius)
        btn1.setImage(image, for: .normal)
        //裁剪
        btn1.layer.masksToBounds = true
        
        
//        MARK: --- 利用蒙版设置圆角
        let btn2 = UIButton(type: .custom)
        btn2.frame = CGRect(x: 100, y: 320, width: 100, height: 100)
        self.view.addSubview(btn2)
        //设置背景图片
        let image2 = addMaskToBounds(btn2.frame)
        btn2.setImage(image2, for: .normal)
        //裁剪
        btn2.layer.masksToBounds = true
        
//        MARK: --- 使用YYImage处理（也可以自定义，参考YYImage中的处理逻辑）
        let btn3 = UIButton(type: .custom)
        btn3.frame = CGRect(x: 100, y: 480, width: 100, height: 100)
        //设置圆角
        self.view.addSubview(btn3)
        //设置背景图片
        //设置圆角
        var cornerRadius3: CGFloat = btn1.frame.size.width
        let image3 = UIImage(named: "mouse")?.yy_image(byRoundCornerRadius: cornerRadius3)
        btn3.setImage(image3, for: .normal)
        
        
    }


}

extension ViewController{
    func addMaskToBounds(_ maskBounds: CGRect) -> UIImage{
        let w = maskBounds.size.width
        let h = maskBounds.size.height
        let size = maskBounds.size
        let scale = UIScreen.main.scale
        let imageRect = CGRect(x: 0, y: 8, width: w, height: h)
        var cornerRadius = min(w, h) / 2
        
        
        if cornerRadius < 0{
            cornerRadius = 0
        }else if cornerRadius >  min(w, h){
            cornerRadius = min(w, h) / 2
        }
        
        let image = UIImage.init(named: "mouse")
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        UIBezierPath.init(roundedRect: imageRect, cornerRadius: cornerRadius).addClip()
        
        image?.draw(in: imageRect)
        let roundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundImage!
        
    }
}

extension UIImage{
//    2、贝塞尔曲线
    func roundedCornerImageWithCornerRadius(_ cornerRadius: inout CGFloat) -> UIImage{
        let  w = self.size.width
        let  h = self.size.height
        let scale = UIScreen.main.scale
        
        //防止圆角半径小于0，或者大于宽/高中较小的值
        if cornerRadius < 0 {
            cornerRadius = 0
        }else if cornerRadius >  min(w, h){
            cornerRadius = min(w, h) / 2
        }
        
        var image: UIImage?
        let imageFrame = CGRect(x: 0, y: 0, width: w, height: h)
        UIGraphicsBeginImageContextWithOptions(self.size, false, scale)
        UIBezierPath.init(roundedRect: imageFrame, cornerRadius: cornerRadius).addClip()
        
        self.draw(in: imageFrame)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
