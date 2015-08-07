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
            updateProperties()
        }
    }

    @IBInspectable public var progressColor: UIColor = UIColor(white: 1.0, alpha: 1.0) {
        didSet {
            updateProperties()
        }
    }

    @IBInspectable public var lineWidth: CGFloat = 10.0 {
        didSet {
            updateProperties()
        }
    }

    @IBInspectable public var progress: CGFloat = 0.6 {
        didSet {
            updateProperties()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override public func awakeFromNib() {
        commonInit()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        let d = CGFloat(lineWidth / 2.0)

        if backgroundRingLayer == nil {

            let rect = CGRectInset(bounds, d, d)
            let path = UIBezierPath(ovalInRect: rect)
            backgroundRingLayer = CAShapeLayer()
            backgroundRingLayer.path = path.CGPath
            backgroundRingLayer.fillColor = nil
            backgroundRingLayer.lineWidth = lineWidth
            backgroundRingLayer.strokeColor = progressBackgroundColor.CGColor
            layer.addSublayer(backgroundRingLayer)
        }

        backgroundRingLayer.frame = layer.bounds

        if ringLayer == nil {
            ringLayer = CAShapeLayer()

            let rect = CGRectInset(bounds, d, d)
            let path = UIBezierPath(ovalInRect: rect)

            ringLayer.path = path.CGPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = lineWidth
            ringLayer.strokeColor = progressColor.CGColor
            ringLayer.strokeEnd = 0.0
            ringLayer.anchorPoint = CGPointMake(0.5, 0.5)
            ringLayer.transform = CATransform3DRotate(ringLayer.transform, CGFloat(-M_PI/2), 0, 0, 1)
            layer.addSublayer(ringLayer)
        }

        ringLayer.frame = layer.bounds
        updateProperties()
    }

    public func updateProgress(value: CGFloat) {
        progress = value
    }

    private func updateProperties() {

        if ringLayer != nil {

            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = ringLayer.strokeEnd
            animation.toValue = progress
            animation.duration = 0.4
            ringLayer.addAnimation(animation, forKey: "strokeEnd")
            ringLayer.strokeEnd = progress

            if progress >= 1.0 {
                hidden = true
            }
        }
    }

    private func commonInit() {
        backgroundColor = UIColor.clearColor()
        progress = 0.0
    }
}
