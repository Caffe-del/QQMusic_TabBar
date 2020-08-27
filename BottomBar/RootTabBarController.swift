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
        
    }
    
    func updateBottomStyle(_ style:BottomBarStyle) {
        self.view.layoutIfNeeded()
        bottomBarStyle = style
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.24, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

}
