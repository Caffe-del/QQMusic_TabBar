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

typealias itemInfoTuple = (name:String, selectName:String,color:UIColor, selectColor:UIColor, title:String)

class RootTabBarController: UITabBarController {

    private var rootTabBar: RootTabBar!
    private var bottomBarStyle = BottomBarStyle.miniPlayViewOnly

    private var tabBarBgImg: UIImage {
        get {
            let imgStr = sharedGloble.isSkinStyle ? "skin_minibar_bg":"minibar_bg"
            let tabBarBgImg = UIImage.init(named: imgStr)!
            return tabBarBgImg
        }
    }
    
    private var itemsInfo: [itemInfoTuple] {
        get {
            var itemsInfo: [itemInfoTuple]
            if !sharedGloble.isSkinStyle {
                itemsInfo = [("tabVC_music","tabVC_music_h",UIColor.systemGray,UIColor.systemGreen,"音乐"),
                              ("tabVC_video","tabVC_video_h",UIColor.systemGray,UIColor.systemGreen,"视频"),
                              ("tabVC_putoo","tabVC_putoo_h",UIColor.systemGray,UIColor.systemGreen,"扑通"),
                              ("tabVC_mine","tabVC_mine_h",UIColor.systemGray,UIColor.systemGreen,"我的")]
            } else {
                itemsInfo = [("skin_tabVC_music","skin_tabVC_music_h",UIColor.black,UIColor.systemGreen,"音乐"),
                              ("skin_tabVC_video","skin_tabVC_video_h",UIColor.black,UIColor.systemGreen,"视频"),
                              ("skin_tabVC_putoo","skin_tabVC_putoo_h",UIColor.black,UIColor.systemGreen,"扑通"),
                              ("skin_tabVC_mine","skin_tabVC_mine_h",UIColor.black,UIColor.systemGreen,"我的")]
            }
            return itemsInfo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootTabBar = RootTabBar()
        rootTabBar.RTDelegate = self
        rootTabBar.itemsInfo = itemsInfo
        rootTabBar.bgImg = tabBarBgImg
        rootTabBar.createTabBarItems()
        self.setValue(rootTabBar, forKey: "tabBar")
        
        let musicVC = MusicViewController()
        let musicNav = UINavigationController.init(rootViewController: musicVC)
        
        let videoVC = VideoViewController()
        let videoNav = UINavigationController.init(rootViewController: videoVC)
        
        let BBSVC = BBSViewController()
        let BBSNav = UINavigationController.init(rootViewController: BBSVC)
        
        let accountVC = AccountViewController()
        let accountNav = UINavigationController.init(rootViewController: accountVC)
        
        self.viewControllers = [musicNav, videoNav, BBSNav, accountNav];
        
        self.updateRootTabBarInfos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarY: CGFloat
        
        switch bottomBarStyle {
        case .none:
            tabBarY = screenHeight
        case .all:
            tabBarY = screenHeight - tabBarHeight - miniPlayViewHeight - safeAreaBottomHeight
        case .miniPlayViewOnly:
            tabBarY = screenHeight - miniPlayViewHeight - safeAreaBottomHeight
        }
        
        self.tabBar.frame = CGRect.init(x: 0, y: tabBarY, width: screenWidth, height: tabBarHeight + miniPlayViewHeight + safeAreaBottomHeight)
    }
    
    /// 更新RotTabBar所需要的信息，并且刷新展示
    func updateRootTabBarInfos() {
        rootTabBar.itemsInfo = itemsInfo
        rootTabBar.bgImg = tabBarBgImg
        rootTabBar.reloadData(self.selectedIndex)
    }
    
    /// 更新底部的样式
    /// - Parameter style: 底部展示样式
    func updateBottomStyle(_ style: BottomBarStyle) {
        self.view.layoutIfNeeded()
        bottomBarStyle = style
        rootTabBar.bottomBarStyle = style
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.24, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension RootTabBarController: MainTabBarDelegate {
    func tabBar(_ tabBar: RootTabBar, didSelectedIndex: Int) {
        self.selectedIndex = didSelectedIndex;
        rootTabBar.reloadData(self.selectedIndex)
    }
    
}
