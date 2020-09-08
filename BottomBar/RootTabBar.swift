//
//  RootTabBar.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/3.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

protocol MainTabBarDelegate: NSObjectProtocol {
    func tabBar(_ tabBar:RootTabBar, didSelectedIndex:Int)
}

class RootTabBar: UITabBar {
    
    var RTDelegate: MainTabBarDelegate?
    var tabBarItems = [RootTabBarItem]()
    
    private var itemsContainer: UIView?
    private var bgImgView: UIImageView?
    private var miniPlayerView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for tempView in self.subviews {
            if (tempView.isKind(of: NSClassFromString("UITabBarButton")!)) {
                tempView.removeFromSuperview()
            }
        }
        
        self.layoutBackgroundView()
        self.layoutMiniPlayerView()
        self.layoutCustomTabBatItems()
    }
    
    private func layoutBackgroundView() {
        if bgImgView == nil {
            bgImgView = UIImageView.init(image: UIImage.init(named: "skin_minibar_bg"))
            bgImgView!.frame = self.bounds
            self.addSubview(bgImgView!)
            self.sendSubviewToBack(bgImgView!)
        }
    }
    
    private func layoutMiniPlayerView() {
        if miniPlayerView == nil {
            let viewW = screenWidth - 40
            let viewX = (screenWidth - viewW) / 2
            miniPlayerView = UIView.init(frame: CGRect.init(x: viewX, y: 0, width: viewW, height: 50))
            miniPlayerView!.backgroundColor = .systemTeal
            self.addSubview(miniPlayerView!)
        }
    }
    
    private func layoutCustomTabBatItems() {
        #warning("写法")
        if itemsContainer == nil {
            itemsContainer = UIView.init(frame: CGRect.init(x: 0, y: layout.miniPlayViewHeight, width: screenWidth, height: layout.tabBarHeight))
            self.addSubview(itemsContainer!)
            
            let itemW = screenWidth / CGFloat(tabBarItems.count)
            for (index,barItem) in tabBarItems.enumerated() {
                barItem.frame = CGRect.init(x: itemW*CGFloat(index), y: 0, width: itemW, height: layout.tabBarHeight)
                itemsContainer!.addSubview(barItem)
                barItem.RTDelegate = self
            }
            
        }
    }
}

extension RootTabBar: RootTabBarItemDelegate {
    func tabBarItem(_ tabBarItem: RootTabBarItem, didSelectedIndex: Int) {
        if self.RTDelegate != nil {
            self.RTDelegate!.tabBar(self, didSelectedIndex: didSelectedIndex)
        }
    }
}
