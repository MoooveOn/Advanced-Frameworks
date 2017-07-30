//
//  MovieTransitioner.swift
//  MovieSelector
//
//  Created by Pavel Selivanov on 17.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class MovieAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresentation = false

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval { return 0.5 }
    

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let fromView = fromVC!.view
        
        let toVC = transitionContext.viewController(forKey: .to)
        let toView = toVC!.view
        
        let containerView = transitionContext.containerView
        
        if isPresentation {
            containerView.addSubview(toView!)
        }
        
        let animatingVC   = isPresentation ? toVC : fromVC
        let animatingView = animatingVC?.view
        
        let appearedFrame = transitionContext.finalFrame(for: animatingVC!)
        var dismissedFrame = appearedFrame
        
        dismissedFrame.origin.y += dismissedFrame.size.height
        
        let initialFrame = isPresentation ? dismissedFrame : appearedFrame
        let finalFrame   = isPresentation ? appearedFrame  : appearedFrame
        
        animatingView?.frame = initialFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 300, initialSpringVelocity: 5, options: [.allowUserInteraction, .beginFromCurrentState], animations: {
            
            animatingView?.frame = finalFrame
            
            if self.isPresentation == false {
                animatingView?.alpha = 0
            }
            
        }) { (success: Bool) in
            if self.isPresentation == false {
                fromView?.removeFromSuperview()
            }
            
            transitionContext.completeTransition(true)
        }
    }
}




























