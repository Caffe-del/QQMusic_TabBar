//
//  BBSDetailVC.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/27.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

class BBSDetailVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}
