//
//  ViewController.swift
//  CAReplicatorLayerD
//
//  Created by 杨晴贺 on 2017/5/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: 414, height: 200)
        replicatorLayer.instanceCount = 20
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0, 0)
        replicatorLayer.instanceDelay = 0.2
        replicatorLayer.masksToBounds = true
        replicatorLayer.backgroundColor = UIColor.black.cgColor
        
        let layer = CALayer()
        layer.frame = CGRect(x: 14, y: 200, width: 10, height: 100)
        layer.backgroundColor = UIColor.red.cgColor
        
        replicatorLayer.addSublayer(layer)
        view.layer.addSublayer(replicatorLayer)
        
        let animation = CABasicAnimation()
        animation.keyPath = "position.y"
        animation.duration = 0.5
        animation.fromValue = 200
        animation.toValue = 180
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: nil)
    }



}

