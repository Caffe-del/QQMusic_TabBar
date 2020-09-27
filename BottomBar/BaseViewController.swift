//
//  BaseViewController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        if let tabBarController = self.tabBarController as? RootTabBarController,  !self.isDelayShowBottomBar {
            tabBarController.updateBottomStyle(BarConfig.bottomBarStyleForViewControllerClass(Self.self))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 此处处理从使用自定义push方式实现present的页面 dismiss的情况
        if let tabBarController = self.tabBarController as? RootTabBarController,  self.isDelayShowBottomBar {
            tabBarController.updateBottomStyle(BarConfig.bottomBarStyleForViewControllerClass(Self.self))
        }
    }
    

}
