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
        
        let switchBtn = UISwitch.init(frame: CGRect.init(origin: CGPoint.init(x: screenWidth/2, y: 200), size: CGSize.init(width: 60, height: 50)))
        switchBtn.isOn = true
        switchBtn.addTarget(self, action: #selector(self.handleSwitchValueChange(_:)), for: .valueChanged)
        self.view.addSubview(switchBtn)
        
        let skinLabel = UILabel.init()
        var labelFrame = switchBtn.frame
        labelFrame.origin.x = labelFrame.origin.x - 85
        labelFrame.size.width = 100
        skinLabel.frame = labelFrame
        skinLabel.text = "主题切换："
        self.view.addSubview(skinLabel)
        
        let descLabel = UILabel.init()
        descLabel.numberOfLines = 0
        let labelW:CGFloat = 260
        descLabel.frame = CGRect.init(x: (screenWidth-labelW)/2.0, y: screenHeight/2.0, width: labelW, height: 150)
        descLabel.text = "点击空白处跳转,用push方式实现present"
        self.view.addSubview(descLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = MusicDetailVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.RTPushViewController(vc, operation: .bottomUp, animated: true)
    }
    
    @objc func handleSwitchValueChange(_ switchBtn:UISwitch) {
        sharedGloble.isSkinStyle = switchBtn.isOn
        
        if let tabBarController = self.tabBarController as? RootTabBarController {
            tabBarController.updateRootTabBarInfos()
            tabBarController.updateBottomStyle(BarConfig.bottomBarStyleForViewControllerClass(Self.self))
        }
    }
}
