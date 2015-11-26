//
//  ViewController.swift
//  5、弹性动画
//
//  Created by user on 15/9/14.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myview: UIView!
    var _imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加图片视图
        _imageView.frame = CGRectMake(0, 0, 100, 100)
        _imageView.image = UIImage(named: "ball.jpg")
        self.view.addSubview(_imageView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first!
        let location = touch.locationInView(self.view)
        //usingSpringWithDamping：阻尼，减速参数
        //initialSpringVelocity: 初始化速度
        UIView.animateWithDuration(5.0, delay: 0.0, usingSpringWithDamping: CGFloat(0.1), initialSpringVelocity: CGFloat(10.0), options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self._imageView.center = location
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

