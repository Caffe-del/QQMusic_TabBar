//
//  BBSViewController.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/8/23.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class BBSViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(red: 144/255, green: 190/255, blue: 222/255, alpha: 1)
        
        let descLabel = UILabel.init()
        descLabel.numberOfLines = 0
        let labelW:CGFloat = 260
        descLabel.frame = CGRect.init(x: (screenWidth-labelW)/2.0, y: screenHeight/2.0, width: labelW, height: 150)
        descLabel.text = "点击空白处跳转,使用系统的Present"
        self.view.addSubview(descLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = BBSDetailVC.init()
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
