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

    private typealias itemInfoTuple = (name:String, selectName:String,color:UIColor, selectColor:UIColor, title:String)

    private var rootTabBar: RootTabBar!
    private var bottomBarStyle = BottomBarStyle.miniPlayViewOnly
    private var itemList = [RootTabBarItem]()

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

        for (index, _) in itemsInfo.enumerated() {
            let tabBatItem = RootTabBarItem()
            tabBatItem.tag = index
            itemList.append(tabBatItem)
        }
        
        rootTabBar.tabBarItems = itemList
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
        
        self.updateItemsInfo()
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
            tabBarY = screenHeight - tabBarHeight - safeAreaBottomHeight
        }
        
        self.tabBar.frame = CGRect.init(x: 0, y: tabBarY, width: screenWidth, height: tabBarHeight + miniPlayViewHeight + safeAreaBottomHeight)
    }
    
    /// 更新items 所需要的信息，并且刷新展示
    func updateItemsInfo() {
        for (index, item) in itemList.enumerated() {
            let info = itemsInfo[index]
            item.iconName = info.name
            item.iconSelectedName = info.selectName
            
            item.titleColor = info.color
            item.titleSelectedColor = info.selectColor
            
            item.title = info.title
        }
        self.updateBarItems(selected: self.selectedIndex)
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
    
    /// 更新items 的状态
    /// - Parameter selected: 当前选中的索引
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
