

//
//  BaseNavigationController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/20.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // 非手势交互转场
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return PushAnimatedTransitionAsFromBottomToTop.init()
        } else if (operation == .pop) {
            return PopAnimatedTransitioningAsFromTopToBottom.init()
        }
        return nil
    }
    
    // 手势交互转场
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
