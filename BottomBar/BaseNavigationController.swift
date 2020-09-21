

//
//  BaseNavigationController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/20.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {

    var popInteractiveTransition: UIPercentDrivenInteractiveTransition?
    
    // 从上往下拉手势
    lazy var panGesture: UIPanGestureRecognizer = {
        let panGes = UIPanGestureRecognizer.init(target: self, action: #selector(handleGesture(_:)))
        panGes.maximumNumberOfTouches = 1
        panGes.delegate = self
        return panGes
    }()
    
    // 屏幕边缘手势
    lazy var screenEdgesPanGesture: UIScreenEdgePanGestureRecognizer = {
        let gesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleGesture(_:)))
        gesture.edges = .left
        gesture.delegate = self
        return gesture
    }()
    
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
        return popInteractiveTransition
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: MusicDetailVC.self) {
            screenEdgesPanGesture.isEnabled = true
            viewController.view.addGestureRecognizer(screenEdgesPanGesture)
            
            panGesture.isEnabled = true
            viewController.view.addGestureRecognizer(panGesture)
        }
        
    }
    
    
    @objc func handleGesture(_ gesture:UIPanGestureRecognizer) {
        var process:CGFloat = 0.0
        var velocity:CGFloat = 0.0
        var isScreenEdge = false
        
        // 测滑处理
        if screenEdgesPanGesture == gesture {
            velocity = screenEdgesPanGesture.velocity(in: screenEdgesPanGesture.view).x
            process = screenEdgesPanGesture.translation(in: screenEdgesPanGesture.view).x / screenWidth
            isScreenEdge = true
        } else {
            velocity = panGesture.velocity(in: panGesture.view).y
            process = panGesture.translation(in: panGesture.view).y /  CGFloat(screenHeight - 190)

        }
                
        if gesture.state == .began {
            popInteractiveTransition = UIPercentDrivenInteractiveTransition.init()
            self.popViewController(animated: true)
        } else if gesture.state == .changed {
            popInteractiveTransition?.update(process)
        } else if gesture.state == .ended || gesture.state == .cancelled{
            if isScreenEdge {
                if velocity > 1000 || process > 0.2 {
                    popInteractiveTransition?.finish()
                } else {
                    popInteractiveTransition?.cancel()
                }
            } else {
                if velocity > 1500 || process > 0.2 {
                    popInteractiveTransition?.finish()
                } else {
                    popInteractiveTransition?.cancel()
                }
            }
            popInteractiveTransition = nil
        }
    }

}

extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.viewControllers.count <= 1 {
            return false
        }
        
        // 处理符合边缘的手势
        if screenEdgesPanGesture == gestureRecognizer {
            let beginPoint = gestureRecognizer.location(in: gestureRecognizer.view)
            let maxAllowDistance: CGFloat = 20.0
            if beginPoint.x > maxAllowDistance  {
                return false
            }
        }

        // 正在转场，不再重新开始一个新的转场
        if let isTransition = self.value(forKey: "_isTransitioning") as? Bool, isTransition == true {
            return false
        }
        
        return true
    }
}

