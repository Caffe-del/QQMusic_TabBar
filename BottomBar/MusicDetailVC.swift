
//
//  MusicDetailVC.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/25.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class MusicDetailVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        self.navigationController?.navigationBar.isHidden = true
        
        let backBtn = UIButton.init(frame: CGRect.init(x: 10, y: statusBarHeight, width: 60, height: 60))
        backBtn.addTarget(self, action: #selector(handleNaviBackClick), for: .touchUpInside)
        backBtn.setImage(UIImage.init(named: "Nav_dismiss"), for: .normal)
        self.view.addSubview(backBtn)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.none)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func handleNaviBackClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
