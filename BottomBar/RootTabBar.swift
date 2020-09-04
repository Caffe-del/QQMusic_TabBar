//
//  RootTabBar.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/3.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class RootTabBar: UITabBar {

    var itemsContainer: UIView?
    var tabBarItems = [RootTabBarItem]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for tempView in self.subviews {
            if (tempView.isKind(of: NSClassFromString("UITabBarButton")!)) {
                tempView.removeFromSuperview()
            }
        }
        
        self.layoutCustomTabBatItems()
    }
    
    func layoutCustomTabBatItems() {
        #warning("写法")
        if itemsContainer == nil {
            itemsContainer = UIView.init(frame: CGRect.init(x: 0, y: layout.miniPlayViewHeight, width: screenWidth, height: layout.tabBarHeight))
            self.addSubview(itemsContainer!)
            
            let itemW = screenWidth / CGFloat(tabBarItems.count)
            for (index,barItem) in tabBarItems.enumerated() {
                barItem.frame = CGRect.init(x: itemW*CGFloat(index), y: 0, width: itemW, height: layout.tabBarHeight)
                itemsContainer!.addSubview(barItem)
            }
            
        }
    }
}
