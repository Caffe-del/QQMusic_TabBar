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
    
    var bottomBarStyle = BottomBarStyle.miniPlayViewOnly
    var RTDelegate: MainTabBarDelegate?
    var tabBarItems = [RootTabBarItem]() {
        didSet {
            for barItem in tabBarItems {
                itemsContainer!.addSubview(barItem)
                barItem.RTDelegate = self
            }
        }
    }
    
    private lazy var itemsContainer: UIView! = {
        let itemsContainer = UIView.init()
        self.addSubview(itemsContainer)
        return itemsContainer
    }()
    
    private lazy var bgImgView: UIImageView! = {
        let bgImgView = UIImageView.init(image: UIImage.init(named: "skin_minibar_bg"))
        self.addSubview(bgImgView)
        self.sendSubviewToBack(bgImgView)
        return bgImgView
    }()
    
    private lazy var miniPlayerView: UIView! = {
        let miniPlayerView = UIView.init()
        miniPlayerView.backgroundColor = .systemTeal
        miniPlayerView.layer.cornerRadius = miniPlayViewHeight * 0.5
        miniPlayerView.layer.masksToBounds = true
        self.addSubview(miniPlayerView)
        return miniPlayerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear;
        self.backgroundImage = UIImage.init()
        self.shadowImage = UIImage.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for tempView in self.subviews {
            if (tempView.isKind(of: NSClassFromString("UITabBarButton")!)) {
                tempView.removeFromSuperview()
            }
        }
        
        // backgroundView
        let exHeight = CGFloat(25)
        var frame = self.bounds
        frame.origin.y = exHeight
        frame.size.height = self.bounds.size.height - exHeight
        bgImgView?.frame = frame
        
        // MiniPlayerView
        let viewW = screenWidth - 40
        let viewX = (screenWidth - viewW) / 2
        miniPlayerView.frame = CGRect.init(x: viewX, y: 0, width: viewW, height: miniPlayViewHeight)
         
        // TabBatItems
        itemsContainer.frame = CGRect.init(x: 0, y: miniPlayViewHeight, width: screenWidth, height: tabBarHeight)
        let itemW = screenWidth / CGFloat(tabBarItems.count)
        for (index,barItem) in tabBarItems.enumerated() {
            let layoutY = bottomBarStyle == .miniPlayViewOnly ? safeAreaBottomHeight : 0
            barItem.frame = CGRect.init(x: itemW*CGFloat(index), y: layoutY, width: itemW, height: tabBarHeight)
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
