//
//  ViewController.swift
//  AnimationCAGradientLayer
//
//  Created by 杨晴贺 on 2017/5/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置指纹扫描背景图片
        let image = UIImage(named: "unLock")
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = self.view.frame
        imageView.center = self.view.center
        self.view.backgroundColor = UIColor.black
        self.view.addSubview(imageView)
        // 设置layer图层属性
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 105, y: 330, width: 200,height: 200)
        imageView.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.white.cgColor,UIColor.clear.cgColor]
        gradientLayer.locations = [0.0,0.1,0.2]
        // 设置CABasicAnimayion
        let gradientAnimation = CABasicAnimation()
        gradientAnimation.keyPath = "locations"
        gradientAnimation.fromValue = [0.0,0.1,0.2]
        gradientAnimation.toValue = [0.8,0.9,1.0];
        gradientAnimation.duration = 3.0
        gradientAnimation.repeatCount = 100
        gradientLayer.add(gradientAnimation, forKey: nil)
    }


}

