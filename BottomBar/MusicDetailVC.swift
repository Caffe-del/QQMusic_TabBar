
//
//  MusicDetailVC.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/25.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class MusicDetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        let switchBtn = UISwitch.init(frame: CGRect.init(origin: self.view.center, size: CGSize.init(width: 60, height: 50)))
        switchBtn.isOn = true
        self.view.addSubview(switchBtn)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.miniPlayViewOnly)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.navigationController?.popViewController(animated: true)
//    }
}
