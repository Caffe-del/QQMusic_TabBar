//
//  UIConstants.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/25.
//  Copyright © 2020 全达晖. All rights reserved.
//

import Foundation
import UIKit
import AdSupport

struct layout {
    static let tabBarHeight: CGFloat = 50
    static let miniPlayViewHeight: CGFloat = 44
}

// 设备参数
let screenFrame: CGRect = UIScreen.main.bounds
let screenWidth = screenFrame.size.width
let screenHeight = screenFrame.size.height
let safeAreaTopHeight: CGFloat = (screenHeight >= 812.0 && UIDevice.current.model == "iPhone" ? 88 : 64)
let safeAreaBottomHeight: CGFloat = (screenHeight >= 812.0 && UIDevice.current.model == "iPhone"  ? 30 : 0)

