//
//  ViewController.swift
//  6、颜色改变的动画
//
//  Created by user on 15/9/14.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var displayView: UIView!
    var slider: UISlider!
    var animation: CABasicAnimation!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.displayView = UIView(frame: CGRectMake(20, 50, 250, 50))
        self.displayView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(self.displayView)
        
        self.slider = UISlider(frame: CGRectMake(20, 150, 250, 30))
        self.slider.addTarget(self, action: Selector("slideAction:"), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(self.slider)
        
        //添加动画
        self.animation = CABasicAnimation(keyPath: "backgroundColor")
        self.animation.fromValue = self.displayView.backgroundColor?.CGColor
        self.animation.toValue = UIColor.blueColor().CGColor
        self.animation.duration = 1.0
        self.displayView.layer.addAnimation(self.animation, forKey: "animation")
        
        //设置displayView的layer的speed的速度位0，而不是self.animation
        self.displayView.layer.speed = 0
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func slideAction(slider:UISlider){
//        self.animation.timeOffset = CFTimeInterval(slider.value)
        self.displayView.layer.timeOffset = CFTimeInterval(slider.value)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

