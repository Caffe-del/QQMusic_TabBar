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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = RootTabBar()
        
        let musicTabBatItem = RootTabBarItem()
        musicTabBatItem.icon = "tabbar_icon_account"
        musicTabBatItem.title = "音乐"
        
        let videoTabBatItem = RootTabBarItem()
        videoTabBatItem.icon = "tabbar_icon_account"
        videoTabBatItem.title = "视频"
        
        let BBSTabBatItem = RootTabBarItem()
        BBSTabBatItem.icon = "tabbar_icon_account"
        BBSTabBatItem.title = "扑通"
        
        let accountTabBatItem = RootTabBarItem()
        accountTabBatItem.icon = "tabbar_icon_account"
        accountTabBatItem.title = "我的"
        
        tabBar.tabBarItems = [musicTabBatItem, videoTabBatItem, BBSTabBatItem, accountTabBatItem]
        
        self.setValue(tabBar, forKey: "tabBar")
        
        let musicVC = MusicViewController()
        let image = UIImage.init(named: "tabbar_icon_account")
        musicVC.tabBarItem = UITabBarItem.init(title: "音乐", image: image, tag: 0)
        let musicNav = UINavigationController.init(rootViewController: musicVC)
        
        let videoVC = VideoViewController()
        videoVC.tabBarItem = UITabBarItem.init(title: "视频", image: image, tag: 1)
        let videoNav = UINavigationController.init(rootViewController: videoVC)
        
        let BBSVC = BBSViewController()
        BBSVC.tabBarItem = UITabBarItem.init(title: "扑通", image: image, tag: 2)
        let BBSNav = UINavigationController.init(rootViewController: BBSVC)
        
        let accountVC = AccountViewController()
        accountVC.tabBarItem = UITabBarItem.init(title: "我的", image: image, tag: 3)
        let accountNav = UINavigationController.init(rootViewController: accountVC)
        
        self.viewControllers = [musicNav, videoNav, BBSNav, accountNav];
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        if (self.botttomBarStyle == BPBottomBarStyleNone) {
//            tabBarStartingY = SCREEN_HEIGHT;
//            playBarHeight = PLAY_BAR_HEIGHT;
//        } else if (self.botttomBarStyle == BPBottomBarStylePlayBarOnly) {
//            tabBarStartingY = SCREEN_HEIGHT - PLAY_BAR_HEIGHT - SAFE_BOTTOM_MARGIN;
//            // 因buzz栏目有添加自定义的icon（此icon会超过UITabBarButton顶部4个像素）,所以在只展示playbar时候要处理这个情况
//            playBarHeight = PLAY_BAR_HEIGHT + SAFE_BOTTOM_MARGIN + 4;
//        } else if (self.botttomBarStyle == BPBottomBarStyleAll) {
//            tabBarStartingY = SCREEN_HEIGHT - TAB_BAR_HEIGHT - PLAY_BAR_HEIGHT - SAFE_BOTTOM_MARGIN;
//            playBarHeight = PLAY_BAR_HEIGHT;
//        }
//
//        [self.tabBar setFrame: CGRectMake(0, tabBarStartingY, SCREEN_WIDTH, PLAY_BAR_HEIGHT + TAB_BAR_HEIGHT + SAFE_BOTTOM_MARGIN)];
//        self.playBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, playBarHeight);
        
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
