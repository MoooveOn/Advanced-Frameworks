//
//  MovieTransitionDelegate.swift
//  MovieSelector
//
//  Created by Pavel Selivanov on 18.07.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class MovieTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
 
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentationController = MoviePresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationController = MovieAnimatedTransitioning()
        animationController.isPresentation = true
        return animationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animationControler = MovieAnimatedTransitioning()
        animationControler.isPresentation = false
        return animationControler
    }
}
