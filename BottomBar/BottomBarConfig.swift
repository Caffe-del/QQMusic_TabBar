//
//  BottomBarConfig.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/27.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

let BarConfig = BottomBarConfig()

class BottomBarConfig: NSObject {
    private let NoneBottomBarList: [AnyClass] = [MusicDetailVC.self]
    private let AllBottomBarList: [AnyClass] = [MusicViewController.self, VideoViewController.self, BBSViewController.self, AccountViewController.self]
    
    func bottomBarStyleForViewControllerClass(_ className:AnyClass) -> BottomBarStyle {
        if NoneBottomBarList.contains(where: { $0 == className }) {
            return .none
        }
        if AllBottomBarList.contains(where: { $0 == className }) {
            return .all
        }
        return .miniPlayViewOnly
    }
    
}
