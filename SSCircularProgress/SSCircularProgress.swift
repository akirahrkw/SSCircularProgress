//
//  SSCircularProgress.swift
//  SSCircularProgress
//
//  Created by Akira Hirakawa on 8/4/15.
//  Copyright (c) 2015 Simple Swift. All rights reserved.
//

import UIKit

@IBDesignable
public class SSCircularProgress: UIView {

    var backgroundRingLayer: CAShapeLayer!
    
    var ringLayer: CAShapeLayer!
    
    public var progressBackgroundColor: UIColor!
    
    public var progressColor: UIColor!
    
    @IBInspectable public var lineWidth: CGFloat! {
        didSet {
            updateProperties()
        }
    }
    
    @IBInspectable public var rating: CGFloat! {
        didSet {
            updateProperties()
        }
    }
    
    override init() {
        super.init()
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override public func awakeFromNib() {
        self.commonInit()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let d = CGFloat(self.lineWidth / 2.0)
        
        if self.backgroundRingLayer == nil {
            self.backgroundRingLayer = CAShapeLayer()
            
            let rect = CGRectInset(self.bounds, d, d)
            let path = UIBezierPath(ovalInRect: rect)
            
            self.backgroundRingLayer.path = path.CGPath
            self.backgroundRingLayer.fillColor = nil
            self.backgroundRingLayer.lineWidth = self.lineWidth
            self.backgroundRingLayer.strokeColor = self.progressBackgroundColor.CGColor
            
            self.layer.addSublayer(self.backgroundRingLayer)
        }
        
        self.backgroundRingLayer.frame = layer.bounds
        
        if self.ringLayer == nil {
            self.ringLayer = CAShapeLayer()
            
            let rect = CGRectInset(self.bounds, d, d)
            let path = UIBezierPath(ovalInRect: rect)
            
            self.ringLayer.path = path.CGPath
            self.ringLayer.fillColor = nil
            self.ringLayer.lineWidth = self.lineWidth
            self.ringLayer.strokeColor = self.progressColor.CGColor
            self.ringLayer.strokeEnd = 0.0
            self.ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            self.ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI/2), 0, 0, 1)
            
            self.layer.addSublayer(self.ringLayer)
        }
        
        self.ringLayer.frame = layer.bounds
        
        self.updateProperties()
    }
    
    public func updateProgress(value: CGFloat) {
        self.rating = value
    }
    
    private func updateProperties() {
        
        if self.ringLayer != nil {
            
            var animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = self.ringLayer.strokeEnd
            animation.toValue = self.rating
            animation.duration = 0.4
            self.ringLayer.addAnimation(animation, forKey: "strokeEnd")
            self.ringLayer.strokeEnd = self.rating
            
            if self.rating >= 1.0 {
                self.hidden = true
            }
        }
    }
    
    private func commonInit() {
        self.rating = 0.0
        self.lineWidth = 10.0
        self.backgroundColor = UIColor.clearColor()
        self.progressBackgroundColor = UIColor(white: 0.5, alpha: 0.3)
        self.progressColor = UIColor(white: 1.0, alpha: 1.0)
    }
}
