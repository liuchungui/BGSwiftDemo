//
//  ViewController.swift
//  2、CAKeyframeAnimation
//
//  Created by user on 15/9/13.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var _layer: CALayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayer()
        //添加动画
//        self.addKeyframeAnimation()
        @IBOutlet weak var myView: UIView!
        @IBOutlet weak var jkfjd: UIView!
        addBezierPathKeyFrameAnimation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //TODO: setup layer
    func setupLayer(){
        _layer.bounds = CGRectMake(0, 0, 100, 100)
        _layer.backgroundColor = UIColor.blueColor().CGColor
        _layer.position = CGPointMake(100, 60)
        self.view.layer.addSublayer(_layer)
    }
    
    //TODO: create animation
    func addKeyframeAnimation(){
        //1、创建动画
        let animation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath:"position")
        
        //2、设置关键帧
        let key1: NSValue = NSValue(CGPoint:_layer.position)
        let key2 = NSValue(CGPoint:CGPointMake(60, 100))
        let key3 = NSValue(CGPoint:CGPointMake(300, 200))
        let key4 = NSValue(CGPoint:CGPointMake(100, 450))
        let array = [key1, key2, key3, key4]
        
        //设置路径
        animation.values = array
        
        //设置其他属性
        animation.duration = 8.0
        //延迟1秒执行
        animation.beginTime = CACurrentMediaTime() + 1
        
        //3、添加动画到图层
        _layer.addAnimation(animation, forKey: "keyframeAnimation")
        
    }
    
    //添加贝塞尔曲线动画
    func addBezierPathKeyFrameAnimation(){
        //1、 创建动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        //2、设置路径
        //绘制贝塞尔曲线
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, _layer.position.x, _layer.position.y)
        CGPathAddCurveToPoint(path, nil, 60, 100, 300, 200, 100, 450)
        
        //设置路径
        animation.path = path
        
        //设置其它属性
        animation.duration = 8.0
        animation.beginTime = CACurrentMediaTime() + 1.0
        
        //设置时间
        animation.keyTimes = [0.0, 0.5, 0.75, 1.0]
        
        //设置动画计算模式
        //kCAAnimationPaced 匀速，设置keyTimes不起作用
        //kCAAnimationCubic 平滑执行，对于位置变动帧动画运行轨迹更平滑
        
        animation.calculationMode = kCAAnimationLinear
        
        //3、添加动画
        _layer.addAnimation(animation, forKey: "kBezierPathKeyFrameAnimation")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

