//
//  ViewController.swift
//  3、CAAniamtionGroup
//
//  Created by user on 15/9/13.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var _layer: CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayer()
        addGroupAnimation()
        @IBOutlet weak var myView: UIView!
        @IBOutlet weak var 的: UIView!
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //TODO: setup layer
    func setupLayer(){
        _layer.bounds = CGRectMake(0, 0, 100, 100)
        _layer.backgroundColor = UIColor.blueColor().CGColor
        _layer.position = CGPointMake(100, 60)
        self.view.layer.addSublayer(_layer)
    }
    
    //添加贝塞尔帧动画
    func bezierPathKeyFrameAnimation() -> CAKeyframeAnimation{
        //1、 创建动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        //2、设置路径
        //绘制贝塞尔曲线
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, _layer.position.x, _layer.position.y)
        let endPoint = CGPointMake(100, 450)
        CGPathAddCurveToPoint(path, nil, 60, 100, 300, 200, endPoint.x, endPoint.y)
        
        //设置路径
        animation.path = path
        
        //设置其它属性
//        animation.duration = 2.0
//        animation.beginTime = CACurrentMediaTime() + 1.0
        
        //设置动画计算模式
        //kCAAnimationPaced 匀速，设置keyTimes不起作用
        //kCAAnimationCubic 平滑执行，对于位置变动帧动画运行轨迹更平滑
        animation.calculationMode = kCAAnimationLinear
        
        animation.setValue(NSValue(CGPoint:endPoint), forKey: "keyFrameAnimationEndPoint")
        
        return animation
    }
    
    //添加旋转动画
    func rotationAnimation() -> CABasicAnimation{
        let toValue = NSNumber(double: M_PI*2)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.removedOnCompletion = false
        rotationAnimation.duration = 2.0
        rotationAnimation.toValue = toValue
        rotationAnimation.repeatCount = 100
        //旋转后旋转到原来位置
        rotationAnimation.autoreverses = false
        
        //储存值
        rotationAnimation.setValue(toValue, forKey: "ratationToValue")
        
        return rotationAnimation
    }
    
    //添加动画组
    func addGroupAnimation() {
        //1、创建动画组
        let animationGroup = CAAnimationGroup()
        
        //2、设置动画组中的动画和其他属性
        let basicAnimation = rotationAnimation()
        let keyframeAnimation = bezierPathKeyFrameAnimation()
        animationGroup.animations = [basicAnimation, keyframeAnimation]
        
        animationGroup.delegate = self
        //设置动画时间，如果动画组中的时间已经设置过，则不起作用
        animationGroup.duration = 10.0
        animationGroup.beginTime = CACurrentMediaTime() + 0.5
        
        //3、添加动画
        _layer.addAnimation(animationGroup, forKey: "kAnimationGroup")
    }
    
    //TODO: Animation delegate
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        let groupAnimation = anim as! CAAnimationGroup
        let basicAnimation = groupAnimation.animations?[0] as! CABasicAnimation
        let frameKeyAnimation = groupAnimation.animations?[1] as! CAKeyframeAnimation
        //获取值
        let toValue = basicAnimation.valueForKey("ratationToValue")!.floatValue
        let endPoint = frameKeyAnimation.valueForKey("keyFrameAnimationEndPoint")!.CGPointValue
        
        //设置动画最终状态
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        _layer.position = endPoint
        _layer.transform = CATransform3DMakeRotation(CGFloat(toValue), 0, 0, 1)
        
        CATransaction.commit()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

