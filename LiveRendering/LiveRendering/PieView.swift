//
//  PieView.swift
//  LiveRendering
//
//  Created by Pavel Selivanov on 14.06.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

@IBDesignable
class PieView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    //override func draw(_ rect: CGRect) {
        // Drawing code
    //}
    
    var bgLayer: CAShapeLayer!
    @IBInspectable var bgLayerColor: UIColor = UIColor.darkGray {
        didSet { updateLayerProperties() }
    }
    
    var bgImageLayer: CALayer!
    @IBInspectable var bgImage: UIImage? {
        didSet { updateLayerProperties() }
    }
    
    var ringLayer: CAShapeLayer!
    @IBInspectable var ringThickness: CGFloat = 2.0
    @IBInspectable var ringColor: UIColor = UIColor.green
    @IBInspectable var ringProgress: CGFloat = 0.75 {
        didSet { updateLayerProperties() }
    }
    
    var percentageLayer: CATextLayer!
    @IBInspectable var showPercentage: Bool = true {
        didSet { updateLayerProperties() }
    }
    @IBInspectable var percentagePosition: CGFloat = 100 {
        didSet { updateLayerProperties() }
    }
    @IBInspectable var percentageColor: UIColor = .white {
        didSet { updateLayerProperties() }
    }
    
    var lineWidth: CGFloat = 2
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createChart()
    }
    
    func createChart() {
        layoutBackgroundLayer()
        layoutBackgroundImageLayer()
        createPie()
        updateLayerProperties()
    }
    
    func layoutBackgroundLayer() {
        if bgLayer == nil {
            bgLayer = CAShapeLayer()
            layer.addSublayer(bgLayer)
            
            let rectangle = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let path = UIBezierPath(ovalIn: rectangle)
            
            //See explanation in documentation why we use cgPath
            bgLayer.path = path.cgPath
            bgLayer.fillColor = bgLayerColor.cgColor
            
            //Our bgLayer fills the whole view
            bgLayerColor.accessibilityFrame = layer.bounds
        }
    }
    
    func layoutBackgroundImageLayer() {
        if bgImageLayer == nil {
            
            //Out image has rectangular shape, but we want to have circle shape of image. Let's create mask fot it:
            let imageMask = CAShapeLayer()
            let inset = lineWidth + 3
            let insetBounds = self.bounds.insetBy(dx: inset, dy: inset)
            let maskPath = UIBezierPath(ovalIn: insetBounds)
            imageMask.path = maskPath.cgPath
            imageMask.fillColor = UIColor.black.cgColor
            imageMask.frame = self.bounds
            
            bgImageLayer = CAShapeLayer()
            bgImageLayer.mask = imageMask
            bgImageLayer.frame = self.bounds
            bgImageLayer.contentsGravity = kCAGravityResizeAspectFill
            layer.addSublayer(bgImageLayer)
            
        }
    }
    
    
    func createPie() {
        if ringProgress == 0 {
            if ringLayer != nil {
                ringLayer.strokeEnd = 0
            }
        }
        
        if ringLayer == nil {
            ringLayer = CAShapeLayer()
            layer.addSublayer(ringLayer)
            let inset = ringThickness / 2
            let rectangle = bounds.insetBy(dx: inset, dy: inset)
            let path = UIBezierPath(ovalIn: rectangle)
            ringLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.path = path.cgPath
            ringLayer.fillColor = nil
            ringLayer.lineWidth = ringThickness
            ringLayer.strokeStart = 0
        }
        
        ringLayer.strokeEnd = ringProgress / 100
        ringLayer.frame = layer.bounds
        
        if percentageLayer == nil {
            percentageLayer = CATextLayer()
            layer.addSublayer(percentageLayer)
            
            percentageLayer.font = UIFont(name: "HelveticaNeue-Light", size: 80)
            percentageLayer.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: percentageLayer.fontSize + 10)
            percentageLayer.position = CGPoint(x: bounds.midX, y: percentagePosition)
            
            percentageLayer.string = "\(Int(ringProgress))%"
            percentageLayer.alignmentMode = kCAAlignmentCenter
            percentageLayer.foregroundColor = percentageColor.cgColor
            percentageLayer.contentsScale = UIScreen.main.scale
            
        }
    }
    
    
    
    
    
    
    func updateLayerProperties() {
        
        if bgLayer != nil {
            bgLayer.fillColor = bgLayerColor.cgColor
            
        }
        
        if bgImageLayer != nil {
            if let image = bgImage {
                bgImageLayer.contents = image.cgImage
            }
        }
        
        if ringLayer != nil {
            ringLayer.strokeEnd = ringProgress / 100
            ringLayer.strokeColor = ringColor.cgColor
            ringLayer.lineWidth = ringThickness
        }
        
        if percentageLayer != nil {
            if showPercentage == true {
                percentageLayer.opacity = 1
                percentageLayer.string = "\(Int(ringProgress))%"
                percentageLayer.position = CGPoint(x: bounds.midX, y: percentagePosition)
                percentageLayer.foregroundColor = percentageColor.cgColor
            } else {
                percentageLayer.opacity = 0
            }
        }
    }
 

}

































