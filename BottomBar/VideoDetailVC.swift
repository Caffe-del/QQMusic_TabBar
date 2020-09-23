//
//  VideoDetailVC.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/8.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class VideoDetailVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 255/255, green: 228/255, blue: 181/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.miniPlayViewOnly)
        }
    }
}
