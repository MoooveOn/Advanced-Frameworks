//
//  MoviePresentationController.swift
//  MovieSelector
//
//  Created by Pavel Selivanov on 17.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class MoviePresentationController: UIPresentationController, UIAdaptivePresentationControllerDelegate {

    var dimmimgView = UIView()
    
    override var shouldPresentInFullscreen: Bool { return true }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        dimmimgView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        dimmimgView.alpha = 0
    }
    
    override func presentationTransitionWillBegin() {
        dimmimgView.frame = (self.containerView?.bounds)!
        dimmimgView.alpha = 0
        
        containerView?.insertSubview(dimmimgView, at: 0)
        
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
                self.dimmimgView.alpha = 1
            }, completion: nil)
        } else {
            self.dimmimgView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { (context: UIViewControllerTransitionCoordinatorContext) in
                self.dimmimgView.alpha = 0
            }, completion: nil)
        } else {
            dimmimgView.alpha = 0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        if let containerCoordinates = containerView?.bounds {
            dimmimgView.frame    = containerCoordinates
            presentedView?.frame = containerCoordinates
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle { return .overFullScreen }
}
