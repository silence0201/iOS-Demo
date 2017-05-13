//
//  ViewController.swift
//  LineChartAnimation
//
//  Created by 杨晴贺 on 2017/5/13.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lineChartView1:LineChartView?
    var barChartView1:BarChartView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView1 = LineChartView(frame: self.view.bounds)
        self.view.addSubview(lineChartView1!)
        
        barChartView1 = BarChartView(frame: CGRect(x: 0, y: self.view.bounds.height/2.0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(barChartView1!)
        
        self.addDrawChartButton()
        self.addAxes()
    }
    
    func addAxes(){
        // LineChart
        for i in 1...5{
            let xAxesTitle:String = "SEP"+"\(i)"
            let xAxesLabel:UILabel = UILabel(frame: CGRect(x: 50+(CGFloat(i)-1)*70,y: 300, width: 50, height: 20))
            xAxesLabel.text = xAxesTitle
            self.view.addSubview(xAxesLabel)
        }
        for i in 0...5{
            let yAxesTitle:String = "\(10-i*2)"
            let yAxesLabel:UILabel = UILabel(frame: CGRect(x: 20,y: 120+(CGFloat(i)-1)*35, width: 20, height: 20))
            yAxesLabel.text = yAxesTitle
            self.view.addSubview(yAxesLabel)
        }
        // BarChart
        for i in 1...5{
            let xAxesTitle:String = "SEP"+"\(i)"
            let xAxesLabel:UILabel = UILabel(frame: CGRect(x: 40+(CGFloat(i)-1)*70,y: 600, width: 50, height: 20))
            xAxesLabel.text = xAxesTitle
            self.view.addSubview(xAxesLabel)
        }
    }
    func addDrawChartButton(){
        let bt_line:UIButton = UIButton()
        bt_line.frame = CGRect(x: (self.view.frame.size.width-100)/2, y: 20, width: 100, height: 50)
        bt_line.setTitle("Line Chart", for: UIControlState())
        bt_line.setTitleColor(PNGreen, for: UIControlState())
        bt_line.addTarget(self, action: #selector(ViewController.drawChart), for: UIControlEvents.touchUpInside)
        self.view.addSubview(bt_line)
        
    }
    
    
    func drawChart(){
        lineChartView1!.drawLineChart()
        barChartView1!.drawLineChart()
    }



}

