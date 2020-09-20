//
//  PopAnimatedTransitioningAsFromTopToBottom.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/20.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class PopAnimatedTransitioningAsFromTopToBottom: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)
        let fromVC = transitionContext.viewController(forKey: .from)
        
        let toView: UIView!
        let fromView: UIView!
        
        if transitionContext.responds(to: #selector(transitionContext.view(forKey:))) {
            toView = transitionContext.view(forKey: .to)
            fromView = transitionContext.view(forKey: .from)
        } else {
            fromView = fromVC?.view
            toView = toVC?.view
        }
        transitionContext.containerView.insertSubview(toView, belowSubview: fromView)
        
        fromView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            fromView.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}
