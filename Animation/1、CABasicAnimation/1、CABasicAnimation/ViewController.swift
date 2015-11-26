//
//  ViewController.swift
//  1、CABasicAnimation
//
//  Created by user on 15/9/13.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

let kTranslateAnimation: String = "kTranslateAnimation"
let kRotationAnimation: String = "kRotationAnimation"
let kBasicAnimationLocation: String = "kBasicAnimationLocation"

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var displayView: UIView!
    @IBAction func slid(sender: UISlider) {
    }
    var _layer: CALayer = CALayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayer()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //TODO: Create Layer -
    func setupLayer(){
        _layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        _layer.backgroundColor = UIColor.redColor().CGColor
        self.view.layer.addSublayer(_layer)
    }
    //TODO: Create Animation -
    //添加平移动画
    func addTranslateAnimation(point: CGPoint){
        let translateAnimation = CABasicAnimation(keyPath: "position")
        //完成后不删除
        translateAnimation.removedOnCompletion = false
        //设置动画执行时间
        translateAnimation.duration = 10.0
        //设置值
        translateAnimation.fromValue = NSValue(CGPoint:_layer.position)
        translateAnimation.toValue = NSValue(CGPoint: point)
        //设置代理
        translateAnimation.delegate = self
//        translateAnimation.speed = 10.0
        translateAnimation.setValue(NSValue(CGPoint:point), forKey: kBasicAnimationLocation)
        //添加动画
        _layer.addAnimation(translateAnimation, forKey: kTranslateAnimation)
        
    }
    //添加旋转动画
    func addRotationAnimation(){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.duration = 2.0
        rotationAnimation.toValue = NSNumber(double: M_PI*2)
        rotationAnimation.repeatCount = 100
        //旋转后旋转到原来位置
        rotationAnimation.autoreverses = false
        _layer.addAnimation(rotationAnimation, forKey: kRotationAnimation)
    }
    
    //TODO: Pause and Resume Animation
    func pauseAnimation(){
        //获取时间偏移量
        let timeOffset = _layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        print("mediaTime:\(CACurrentMediaTime()), timeoffset:\(timeOffset)")
        //保证暂停时，旋转位置暂停在当前位置
        _layer.timeOffset = timeOffset
        //设置速度
        _layer.speed = 0
    }
    
    func resumeAnimation(){
        //暂停时的时间偏移量
        let pauseTimeOffset = _layer.timeOffset
        _layer.timeOffset = 0
        //设置开始时间，设置为相对于父layer的相对偏移位置，因为speed为0，所以状态看起来没变化
        _layer.beginTime = CACurrentMediaTime() - pauseTimeOffset
        //设置速度
        _layer.speed = 1
        print(_layer.duration)
    }
    
    //TODO: Touch method -
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if _layer.animationForKey(kTranslateAnimation) != nil {
            if _layer.speed == 0 {
                self.resumeAnimation()
            }
            else{
                self.pauseAnimation()
            }
        }
        else{
            let touch = touches.first
            if let point =  touch?.locationInView(self.view) {
                self.addTranslateAnimation(point)
                self.addRotationAnimation()
            }
        }
    }
    
    //TODO: animation delegate
    override func animationDidStart(anim: CAAnimation) {
        print("animationDidStart")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        print("animationDidStop")
        //开启事务
        CATransaction.begin()
        //禁用隐式动画
        CATransaction.setDisableActions(true)
        //设置位置
        _layer.position = anim.valueForKey(kBasicAnimationLocation)!.CGPointValue
        //提交事务
        CATransaction.commit()
        //暂停动画
        self.pauseAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

