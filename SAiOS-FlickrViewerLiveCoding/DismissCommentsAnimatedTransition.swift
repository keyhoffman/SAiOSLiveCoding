//
//  DismissCommentsAnimatedTransition.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

final class DismissCommentsAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        containerView.layoutIfNeeded()
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha   = Percentage.oneHundred.cgFloat
            containerView.alpha           = Percentage.zero.cgFloat
            fromViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: containerView.frame.height), size: fromViewController.view.bounds.size)
            containerView.layoutIfNeeded()
        }) { transitionContext.completeTransition($0) }
    }
}
