//
//  ALNdecibelView.swift
//  ALNDecibelView
//
//  Created by AlienLi on 15/3/12.
//  Copyright (c) 2015年 ALN. All rights reserved.
//

import UIKit

class ALNdecibelView: UIView {
    
    let margin: CGFloat = 10
    let triangleMargin: CGFloat = 10
    
    var outerRadius: CGFloat {
        
        get{
            assert(self.bounds.width > self.bounds.height, "width should longer than height")
            
            assert(self.bounds.width < 2 * self.bounds.height, "height should longer than  0.5 * width")
            
            return self.bounds.width / 2 - triangleMargin
            
            
        }
    }
    
    var innerRadius: CGFloat {
        
        get {
            return self.outerRadius - margin
        }
    }
    
    var circleCenter: CGPoint {
        
        get {
            return CGPointMake(self.bounds.width / 2 , self.bounds.height - margin - triangleMargin)
        }
    }
    
    var image:UIImage {
        
        get {
            return UIImage(named: "flower")!
        }
        
        set {
            self.image = newValue
        }
    }
    var baseView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //        configureCurrentDecibelItem()
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    
    
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath()
        path.lineWidth = 2.0
        UIColor.whiteColor().setStroke()
        
        println("outerRadius:\(outerRadius)")
        for index in  0 ... 45 {
            
            var angle = (M_PI / 90) * Double(index * 2)
            
            var inner_x = cos(CGFloat(angle)) * innerRadius
            var inner_y = sin(CGFloat(angle)) * innerRadius
            
            var innerPoint = CGPointMake(self.circleCenter.x - inner_x, self.circleCenter.y - inner_y)
            
            var outer_x = cos(CGFloat(angle)) * outerRadius
            var outer_y = sin(CGFloat(angle)) * outerRadius
            
            var outerPoint = CGPointMake(self.circleCenter.x - outer_x, self.circleCenter.y - outer_y)
            
            path.moveToPoint(innerPoint)
            path.addLineToPoint(outerPoint)
        }
        path.fill()
        path.stroke()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCurrentDecibelItem()
        
    }
    
    func configureCurrentDecibelItem() {
        
        if let view = baseView {
            
        } else {
            
            baseView = UIView(frame: CGRectMake(0, self.bounds.height - 2.5 * triangleMargin, self.bounds.width , triangleMargin))
            
            let triangle = UIImageView(frame: CGRectMake(0, 0, triangleMargin, triangleMargin))
            triangle.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * -0.5)
            triangle.image = self.image
            baseView?.addSubview(triangle)
            baseView?.backgroundColor = UIColor.clearColor()
        }
        
        self.addSubview(baseView!)
    }
    
    
    // Mark: animate current decibel item
    
    func setCurrentDecibel (var currentDb: CGFloat) {
        if currentDb < 0 {
            currentDb = 0
        } else if currentDb > 100 {
            currentDb = 90
        }
        
        let angle = CGFloat(M_PI) * currentDb / 90
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.baseView!.transform = CGAffineTransformMakeRotation(angle)
            }, completion: nil)
    }
    
    
}
