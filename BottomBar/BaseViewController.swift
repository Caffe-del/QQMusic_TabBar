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
        self.automaticallyAdjustsScrollViewInsets = true;
    }

}
