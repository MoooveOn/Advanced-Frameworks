//
//  ViewController.swift
//  StartWithDynamics
//
//  Created by Pavel Selivanov on 17.06.17.
//  Copyright © 2017 Pavel Selivanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var groundView: UIView!
    
    private var animator: UIDynamicAnimator!
    private var ball: UIView!
    private var elasticity: CGFloat = 0.5 {
        didSet {
            elasticityLabel.text = "\(round(elasticity * 100) / 100)"
        }
    }
    @IBOutlet weak var elasticityLabel: UILabel!
    
    func addGravity() {
        
        let gravity = UIGravityBehavior(items: [ball])
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: [ball])
        collision.addBoundary(withIdentifier: 777 as NSCopying, from: groundView.frame.origin, to:
            CGPoint(x: groundView.frame.origin.x + groundView.frame.width, y: groundView.frame.origin.y))
        
        animator.addBehavior(collision)
        
        //Ball should bounce:
        let ballBehavior = UIDynamicItemBehavior(items: [ball])
        ballBehavior.elasticity = elasticity
        animator.addBehavior(ballBehavior)
        
        
        //Now we want to observer when ball touches the ground:
        
        //We add UICollisionBehaviorDelegate protocol
        collision.collisionDelegate = self
        
        
    }
    
    //We want to track collision of ball with ground
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if NSNumber(integerLiteral: 777).isEqual(identifier) {
            ball.backgroundColor = UIColor.blue
        }
    }
    
    @IBAction func changeElasticity(_ sender: UIStepper) {
        
        elasticity = CGFloat(sender.value)
        
    }
    
    @IBAction func newBall(_ sender: UIButton) { createNewBall() }
    
    func createNewBall() {
        if ball != nil {
            ball.removeFromSuperview()
        }
        ball = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        ball.layer.cornerRadius = 25
        ball.backgroundColor = UIColor.red
        
        self.view.addSubview(ball)
        
        //Now add animation
        
        animator = UIDynamicAnimator(referenceView: self.view)
    }
    
    @IBAction func throwBall(_ sender: UIButton) { addGravity() }
    
    override func viewDidLoad() {
        createNewBall()
    }
    
}

