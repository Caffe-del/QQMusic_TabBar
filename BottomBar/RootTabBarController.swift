//
//  RootTabBarController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

#warning("处理文件访问权限")

enum BottomBarStyle {
    case miniPlayViewOnly
    case all
    case none
}

class RootTabBarController: UITabBarController {

    private var bottomBarStyle = BottomBarStyle.miniPlayViewOnly
    private let iconList = ["tabbar_icon_account", "tabbar_icon_account", "tabbar_icon_account", "tabbar_icon_account"]
    private let titleList = ["音乐", "视频", "扑通", "我的"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = RootTabBar()
        tabBar.RTDelegate = self
        
        var itemList = [RootTabBarItem]()
        for (index, item) in iconList.enumerated() {
            let tabBatItem = RootTabBarItem()
            tabBatItem.icon = item
            tabBatItem.title = titleList[index]
            tabBatItem.tag = index
            itemList.append(tabBatItem)
        }
        
        tabBar.tabBarItems = itemList
        
        self.setValue(tabBar, forKey: "tabBar")
        
        let musicVC = MusicViewController()
        let musicNav = UINavigationController.init(rootViewController: musicVC)
        
        let videoVC = VideoViewController()
        let videoNav = UINavigationController.init(rootViewController: videoVC)
        
        let BBSVC = BBSViewController()
        let BBSNav = UINavigationController.init(rootViewController: BBSVC)
        
        let accountVC = AccountViewController()
        let accountNav = UINavigationController.init(rootViewController: accountVC)
        
        self.viewControllers = [musicNav, videoNav, BBSNav, accountNav];
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarY: CGFloat
        
        switch bottomBarStyle {
        case .none:
            tabBarY = screenHeight
        case .all:
            tabBarY = screenHeight - layout.tabBarHeight - layout.miniPlayViewHeight - safeAreaBottomHeight
        case .miniPlayViewOnly:
            tabBarY = screenHeight - layout.tabBarHeight
        }
        
        self.tabBar.frame = CGRect.init(x: 0, y: tabBarY, width: screenWidth, height: layout.tabBarHeight + layout.miniPlayViewHeight + safeAreaBottomHeight)
    }
    
    func updateBottomStyle(_ style: BottomBarStyle) {
        self.view.layoutIfNeeded()
        bottomBarStyle = style
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.24, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}

extension RootTabBarController: MainTabBarDelegate {
    func tabBar(_ tabBar: RootTabBar, didSelectedIndex: Int) {
        self.selectedIndex = didSelectedIndex;
    }
    
}
