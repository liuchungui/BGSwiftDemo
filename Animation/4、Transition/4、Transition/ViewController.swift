//
//  ViewController.swift
//  4、Transition
//
//  Created by user on 15/9/14.
//  Copyright © 2015年 lcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UISlider!
    
    @IBOutlet weak var sfsdf: UIView!
    var _imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加图片视图
        _imageView.frame = UIScreen.mainScreen().bounds
        _imageView.contentMode = UIViewContentMode.ScaleAspectFit
        _imageView.image = self.imageWithIndex(0)
        self.view.addSubview(_imageView)
        
        let leftSwip = UISwipeGestureRecognizer(target: self, action: Selector("leftSwipe:"))
        leftSwip.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(leftSwip)
        
        let rightSwip = UISwipeGestureRecognizer(target: self, action: Selector("rightSwipe:"))
        rightSwip.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(rightSwip)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //TODO: swip action method
    func leftSwipe(swip: UISwipeGestureRecognizer){
        self.transitionAnimation(true)
    }
    
    func rightSwipe(swip: UISwipeGestureRecognizer) {
        self.transitionAnimation(false)
    }
    
    //TODO: 转场动画
    func transitionAnimation(isNext: Bool){
        let transition = CATransition()
        transition.type = "cube"
        
        var index = 0
        if isNext {
            index = 1
            transition.subtype = kCATransitionFromRight
        }
        else {
            index = 0
            transition.subtype = kCATransitionFromLeft
        }
        
        _imageView.image = self.imageWithIndex(index)
        _imageView.layer.addAnimation(transition, forKey: "kTransitionAnimation")
    }
    
    //TODO: private method
    func imageWithIndex(index: Int) -> UIImage?{
        return UIImage(named: "mm\(index+1).jpg")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

