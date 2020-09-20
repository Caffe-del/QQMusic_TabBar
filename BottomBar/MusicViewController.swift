//
//  MusicViewController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.delegate = self
        
        let switchBtn = UISwitch.init(frame: CGRect.init(origin: self.view.center, size: CGSize.init(width: 60, height: 50)))
        switchBtn.isOn = true
        switchBtn.addTarget(self, action: #selector(self.handleSwitchValueChange(_:)), for: .valueChanged)
        self.view.addSubview(switchBtn)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = MusicDetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateBottomStyle(.all)
        }
    }
    
    @objc func handleSwitchValueChange(_ switchBtn:UISwitch) {
        sharedGloble.isSkinStyle = switchBtn.isOn
        
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateItemsInfo()
            tabBarController.updateBottomStyle(.all)
        }
    }
}

extension MusicViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
}
