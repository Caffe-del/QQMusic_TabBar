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
    var itemsInfo: [itemInfoTuple]!
    var bgImg: UIImage!
    var RTDelegate: MainTabBarDelegate?
    
    private var tabBarItems = [RootTabBarItem]()
    private var bgImgView: UIImageView! // 背景图
    private var miniPlayerView: UIView! // mini播放条
    private var itemsContainer: UIView! // 装载items的容器
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear;
        self.backgroundImage = UIImage.init()
        self.shadowImage = UIImage.init()
        
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubviews() {
        bgImgView = UIImageView.init(image: UIImage.init(named: "skin_minibar_bg"))
        self.addSubview(bgImgView)
        self.sendSubviewToBack(bgImgView)
        
        miniPlayerView = UIView.init()
        miniPlayerView.backgroundColor = .systemTeal
        miniPlayerView.layer.cornerRadius = miniPlayViewHeight * 0.5
        miniPlayerView.layer.masksToBounds = true
        self.addSubview(miniPlayerView)
        
        itemsContainer = UIView.init()
        self.addSubview(itemsContainer)
    }
    
    func createTabBarItems() {
        for (index, _) in itemsInfo.enumerated() {
            let tabBarItem = RootTabBarItem()
            tabBarItem.tag = index
            itemsContainer!.addSubview(tabBarItem)
            tabBarItems.append(tabBarItem)
            tabBarItem.RTDelegate = self
        }
    }
    
    // 刷新数据
    func reloadData(_ selectedIdx:Int) {
        bgImgView.image = bgImg
        for (index, item) in tabBarItems.enumerated() {
            let info = itemsInfo[index]
            item.iconName = info.name
            item.iconSelectedName = info.selectName

            item.titleColor = info.color
            item.titleSelectedColor = info.selectColor

            item.title = info.title
        }
        
        self.updateBarItems(selectedIdx: selectedIdx)
    }
    
    /// 更新items 的状态
    /// - Parameter selected: 当前选中的索引
    func updateBarItems(selectedIdx:Int) {
        for (idx,item) in tabBarItems.enumerated() {
            let state:itemState = selectedIdx==idx ? .selected : .normal
            item.reloadData(state: state)
        }
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
         
        // TabBarItems
        let layoutY = bottomBarStyle == .miniPlayViewOnly ? miniPlayViewHeight + safeAreaBottomHeight : miniPlayViewHeight
        itemsContainer.frame = CGRect.init(x: 0, y: layoutY, width: screenWidth, height: tabBarHeight)
        let itemW = screenWidth / CGFloat(tabBarItems.count)
        for (index,barItem) in tabBarItems.enumerated() {
            barItem.frame = CGRect.init(x: itemW*CGFloat(index), y: 0, width: itemW, height: tabBarHeight)
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
