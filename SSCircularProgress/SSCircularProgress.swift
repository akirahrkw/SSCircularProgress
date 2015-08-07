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

    private var backgroundRingLayer: CAShapeLayer!

    private var ringLayer: CAShapeLayer!

    @IBInspectable public var progressBackgroundColor: UIColor! = UIColor(white: 0.5, alpha: 0.3) {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable public var progressColor: UIColor = UIColor(white: 1.0, alpha: 1.0) {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable public var lineWidth: CGFloat = 10.0 {
        didSet {
            self.updateProperties()
        }
    }

    @IBInspectable public var progress: CGFloat = 0.6 {
        didSet {
            self.updateProperties()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
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
        self.progress = value
    }

    private func updateProperties() {

        if self.ringLayer != nil {

            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = self.ringLayer.strokeEnd
            animation.toValue = self.progress
            animation.duration = 0.4
            self.ringLayer.addAnimation(animation, forKey: "strokeEnd")
            self.ringLayer.strokeEnd = self.progress

            if self.progress >= 1.0 {
                self.hidden = true
            }
        }
    }

    private func commonInit() {
        self.backgroundColor = UIColor.clearColor()
        self.progress = 0.0
    }
}
