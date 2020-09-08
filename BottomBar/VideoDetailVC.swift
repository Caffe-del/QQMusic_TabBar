//
//  VideoDetailVC.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/8.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class VideoDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.miniPlayViewOnly)
        }
    }
}
