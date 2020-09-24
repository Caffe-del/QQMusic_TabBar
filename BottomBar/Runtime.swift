//
//  Runtime.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/24.
//  Copyright © 2020 全达晖. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // 嵌套结构体
    private struct AssociatedKeys {
        static var isDelayShowBottomBarKey = "isDelayShowBottomBarKey"
        static var pushOperationKey = "pushOperationKey"
    }
    
    // 当前vc是否需要延迟做动画
    var isDelayShowBottomBar: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.isDelayShowBottomBarKey) as! Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.isDelayShowBottomBarKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var currentPushOperation: pushOperation {
        get {
            if let operation = objc_getAssociatedObject(self, &AssociatedKeys.pushOperationKey) as? pushOperation {
                return operation
            }
            return .normal
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pushOperationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
