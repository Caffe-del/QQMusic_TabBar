//
//  PushAnimatedTransitionAsFromBottomToTop.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/20.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class PushAnimatedTransitionAsFromBottomToTop: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toVC = transitionContext.viewController(forKey: .to)        
        let toView: UIView!
        
        if transitionContext.responds(to: #selector(transitionContext.view(forKey:))) {
            toView = transitionContext.view(forKey: .to)
        } else {
            toView = toVC?.view
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        
        toView.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight)
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}
