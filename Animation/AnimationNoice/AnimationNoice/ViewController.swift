//
//  ViewController.swift
//  AnimationNoice
//
//  Created by 杨晴贺 on 2017/5/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var audioBarNum: Int = 0
    var gradientLayer = CAGradientLayer()
    var layerArray = NSMutableArray()
    var colorArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setcolorArray()
        view.backgroundColor = UIColor.black
        audioBarNum = 15
        for i in 0...audioBarNum {
            let h:CGFloat = 150
            let w:CGFloat = (self.view.frame.size.width-10)/CGFloat(audioBarNum)
            let x:CGFloat = 20
            let y:CGFloat = 50
            let v = UIView(frame: CGRect(x: w*CGFloat(i)+x, y: y, width: w-x, height: h))
            view.addSubview(v)
            
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = v.bounds
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            v.layer.addSublayer(gradientLayer)
            layerArray.add(gradientLayer)
        }
        Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(colorChange), userInfo: nil, repeats: true)
    }
    
    func colorChange() {
        for layer in layerArray {
            let index = Int(arc4random_uniform(11))
            let color = colorArray.object(at: index) as! UIColor
            let colors = [UIColor.clear.cgColor,color.cgColor]
            let layer = layer as! CAGradientLayer
            layer.colors = colors
            layer.locations = [0.0,1.0]
            let gradientAnimation = CABasicAnimation()
            gradientAnimation.keyPath = "locations"
            let beginValue = Float(arc4random_uniform(11))/10.0
            gradientAnimation.fromValue = [beginValue,beginValue]
            gradientAnimation.toValue = [1.0,1.0]
            gradientAnimation.duration = 0.4
            layer.add(gradientAnimation, forKey: nil)
        }
    }
    
    func setcolorArray(){
        let  color1:UIColor = UIColor(red: 255.0 / 255.0, green: 127.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
        let  color2:UIColor = UIColor(red: 138.0 / 255.0, green: 206.0 / 255.0, blue: 245.0 / 255.0, alpha: 1.0)
        let  color3:UIColor = UIColor(red: 216.0 / 255.0, green: 114.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
        let  color4:UIColor = UIColor(red: 51.0 / 255.0, green: 207.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
        let  color5:UIColor = UIColor(red: 102.0 / 255.0, green: 150.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0)
        let  color6:UIColor = UIColor(red: 255.0 / 255.0, green: 105.0 / 255.0, blue: 177.0 / 255.0, alpha: 1.0)
        let  color7:UIColor = UIColor(red: 187.0 / 255.0, green: 56.0 / 255.0, blue: 201.0 / 255.0, alpha: 1.0)
        let  color8:UIColor = UIColor(red: 255.0 / 255.0, green: 163.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        let  color9:UIColor = UIColor(red: 203.0 / 255.0, green: 93.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0)
        let  color10:UIColor = UIColor(red: 61.0 / 255.0, green: 226.0 / 255.0, blue: 210.0 / 255.0, alpha: 1.0)
        let  color11:UIColor = UIColor(red: 25.0 / 255.0, green: 146.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        colorArray.add(color1)
        colorArray.add(color2)
        colorArray.add(color3)
        colorArray.add(color4)
        colorArray.add(color5)
        colorArray.add(color6)
        colorArray.add(color7)
        colorArray.add(color8)
        colorArray.add(color9)
        colorArray.add(color10)
        colorArray.add(color11)
    }



}

