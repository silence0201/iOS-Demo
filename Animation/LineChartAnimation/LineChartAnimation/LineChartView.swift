//
//  LineChartView.swift
//  LineChartAnimation
//
//  Created by 杨晴贺 on 2017/5/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

let PNGreen:UIColor = UIColor(red: 77.0/255.0, green: 186.0/255.0, blue: 122.0/255.0, alpha: 1.0)
class LineChartView: UIView {

    var chartLine:CAShapeLayer = CAShapeLayer()
    var pathAnimation:CABasicAnimation = CABasicAnimation()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        chartLine.lineCap = kCALineCapRound
        chartLine.lineJoin = kCALineJoinRound
        chartLine.fillColor = UIColor.white.cgColor
        chartLine.lineWidth = 10.0
        chartLine.strokeEnd = 0.0
        self.layer.addSublayer(chartLine)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let line = UIBezierPath()
        line.lineWidth = 10.0
        line.lineCapStyle = CGLineCap.round
        line.lineJoinStyle = CGLineJoin.round
        line.move(to: CGPoint(x: 70, y: 260))
        line.addLine(to: CGPoint(x: 140, y: 100))
        line.addLine(to: CGPoint(x: 210, y: 240))
        line.addLine(to: CGPoint(x: 280, y: 170))
        line.addLine(to: CGPoint(x: 350, y: 220))
        chartLine.path = line.cgPath
        chartLine.strokeColor = PNGreen.cgColor
        
        pathAnimation.keyPath = "strokeEnd"
        
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.autoreverses = false
        pathAnimation.duration = 2.0
    }
    
    func drawLineChart(){
        chartLine.strokeEnd = 1.0
        chartLine.add(pathAnimation, forKey: nil)
    }
    
}
