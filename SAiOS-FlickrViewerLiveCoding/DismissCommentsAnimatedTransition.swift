//
//  DismissCommentsAnimatedTransition.swift
//  SAiOS-FlickrViewerLiveCoding
//
//  Created by Key Hoffman on 1/2/17.
//  Copyright © 2017 Key Hoffman. All rights reserved.
//

import UIKit

// MARK: - DismissCommentsAnimatedTransition

final class DismissCommentsAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: - UIViewControllerAnimatedTransitioning Conformance
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from), let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.layoutIfNeeded()
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
            animations: {
                toViewController.view          .alpha = Percentage.oneHundred.cgFloat
                transitionContext.containerView.alpha = Percentage.zero.cgFloat
                fromViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: transitionContext.containerView.frame.height), size: fromViewController.view.bounds.size)
                transitionContext.containerView.layoutIfNeeded()
            },
            completion: {
                transitionContext.completeTransition($0)
            }
        )
    }
}
