//
//  ViewController.swift
//  7、CATextLayer
//
//  Created by user on 15/9/14.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let textLayer = CATextLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画字
        textLayer.bounds = CGRectMake(0, 0, 200, 200)
        textLayer.position = CGPointMake(100, 100)
//        textLayer.string = "hello, 宝贝"
        textLayer.foregroundColor = UIColor.blueColor().CGColor
        self.view.layer.addSublayer(textLayer)
        
        let animation = CABasicAnimation(keyPath: "string")
        animation.fromValue = "我"
        animation.toValue = "我爱你，宝贝"
        animation.duration = 10.0
        
        textLayer.addAnimation(animation, forKey: "changeTextColor")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

