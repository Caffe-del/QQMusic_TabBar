//
//  MusicViewController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class MusicViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 229/255, green: 225/255, blue: 238/255, alpha: 1)
        
        let switchBtn = UISwitch.init(frame: CGRect.init(origin: self.view.center, size: CGSize.init(width: 60, height: 50)))
        switchBtn.isOn = true
        switchBtn.addTarget(self, action: #selector(self.handleSwitchValueChange(_:)), for: .valueChanged)
        self.view.addSubview(switchBtn)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = MusicDetailVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.all)
        }
    }
    
    @objc func handleSwitchValueChange(_ switchBtn:UISwitch) {
        sharedGloble.isSkinStyle = switchBtn.isOn
        
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateRootTabBarInfos()
            tabBarController.updateBottomStyle(.all)
        }
    }
}
