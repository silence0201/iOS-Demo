//
//  ViewController.swift
//  NewsDemo
//
//  Created by 杨晴贺 on 2017/4/8.
//  Copyright © 2017年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: UIScreen.main.bounds)
        webView.delegate = self 
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        let url = URL(string: "http://c.3g.163.com/nc/article/CHCL05CH0008856R/full.html")
        
        guard let ul = url else {
            print("url错误")
            return
        }
        
        let request = URLRequest(url: ul)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if(error == nil) {
                let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                print(jsonObj ?? "")
                if let dic = jsonObj {
                    self.dealNewsDetail(jsonObj: dic)
                }
            }
        }
        dataTask.resume()
    }
    
    private func dealNewsDetail(jsonObj: NSDictionary) -> Void {
        let allData = jsonObj["CHCL05CH0008856R"]
        
        guard let info = allData as? NSDictionary else {
            return
        }
        
        if  var bodyHtml = info["body"] as? String,
            let title = info["title"] as? String,
            let ptime = info["ptime"] as? String,
            let source = info["source"] as? String,
            let img = info["img"] as? [[String: AnyObject]] {
            
            // 创建标题的HTML标签
            let titleHtml = "<div id=\"mainTitle\">\(title)</div>"
            // 创建子标题的HTML标签
            let subTitleHtml = "<div id=\"subTitle\"><span class=\"time\">\(ptime)</span><span>\(source)</span></div>"
            
            for imgItem in img {
                if  let ref = imgItem["ref"] as? String,
                    let imgTitle = imgItem["alt"] as? String,
                    let src = imgItem["src"] as? String{
                    let imgHtml = "<div class=\"all-img\"><img src=\"\(src)\"><div>\(imgTitle)</div></div>"
                    // 替换body中的占位符
                    bodyHtml = bodyHtml.replacingOccurrences(of: ref, with: imgHtml)
                }
            }
            
            // 加载css
            let css = Bundle.main.url(forResource: "newsDetail", withExtension: "css")
            let cssHtml = "<link href=\"\(css!)\" rel=\"stylesheet\">"
            
            // 加载url
            let js = Bundle.main.url(forResource: "newsDetail", withExtension: "js")
            let jsHtml = "<script src=\"\(js!)\"></script>"
            
            // 拼接
            let html = "<html><head>\(cssHtml)</head><body>\(titleHtml)\(subTitleHtml)\(bodyHtml)\(jsHtml)</body></html>"
            
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
}

extension ViewController: UIWebViewDelegate {
    // 决定是否加载请求
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlHeader = "silence:///"
        
        if let requestStr: NSString = request.url?.absoluteString as NSString?{
            let range = requestStr.range(of: urlHeader)
            let location = range.location
            if(location != NSNotFound) {
                let method = requestStr.substring(from: range.length)
                let sel = Selector(method)
                self.perform(sel)
            }
        }
        
        return true
    }
    
    func testFunc() {
        print(#function)
    }
}

