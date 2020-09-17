//
//  RootTabBarController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

enum BottomBarStyle {
    case miniPlayViewOnly
    case all
    case none
}

class RootTabBarController: UITabBarController {

    private var bottomBarStyle = BottomBarStyle.miniPlayViewOnly
    private var itemList = [RootTabBarItem]()
    private let itemsInfo: [(normal:String?, select:String?, title:String?)] =
        [("tabVC_music","tabVC_music_h","音乐"),
         ("tabVC_video","tabVC_video_h","视频"),
         ("tabVC_putoo","tabVC_putoo_h","扑通"),
         ("tabVC_mine","tabVC_mine_h","我的"),]
    
//    private let itemsInfo: [(normal:String?, select:String?, title:String?)] =
//    [("tabVC_music","tabVC_music_h",nil),
//     ("tabVC_video","tabVC_video_h",nil),
//     ("tabVC_putoo","tabVC_putoo_h",nil),
//     ("tabVC_mine","tabVC_mine_h",nil),]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabBar = RootTabBar()
        tabBar.RTDelegate = self
        
        for (index, info) in itemsInfo.enumerated() {
            let tabBatItem = RootTabBarItem()
            if let iconNormal = info.normal, let iconSelect = info.select {
                tabBatItem.iconNormal = iconNormal
                tabBatItem.iconSelected = iconSelect
            }
            
            if let title = info.title {
                tabBatItem.title = title
            }
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
        self.updateBarItems(selected: self.selectedIndex)
    }
    
    func updateBottomStyle(_ style: BottomBarStyle) {
        self.view.layoutIfNeeded()
        bottomBarStyle = style
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.24, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func updateBarItems(selected:Int) {
        for (idx,item) in itemList.enumerated() {
            let state:itemState = selected==idx ? .selected : .normal
            item.reloadData(state: state)
        }
    }

}

extension RootTabBarController: MainTabBarDelegate {
    func tabBar(_ tabBar: RootTabBar, didSelectedIndex: Int) {
        self.selectedIndex = didSelectedIndex;
        self.updateBarItems(selected: didSelectedIndex)
    }
    
}
