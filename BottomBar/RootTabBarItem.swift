//
//  RootTabBarItem.swift
//  BottomBar
//
//  Created by 全达晖 on 2020/9/3.
//  Copyright © 2020 全达晖. All rights reserved.
//

import UIKit

protocol RootTabBarItemDelegate: NSObjectProtocol {
    func tabBarItem(_ tabBarItem:RootTabBarItem , didSelectedIndex:Int)
}

enum itemState {
    case normal
    case selected
}

class RootTabBarItem: UIView {
    // 对外暴露
    var iconName: String!
    var iconSelectedName: String!
    
    var titleColor:UIColor!
    var titleSelectedColor: UIColor!
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var RTDelegate: RootTabBarItemDelegate?
    
    // 私有属性
    private var swappableImageView: UIImageView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSubviews();
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(handleClickItem))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        swappableImageView = UIImageView()
        self.addSubview(swappableImageView)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.numberOfLines = 0;
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imgW: CGFloat = sharedGloble.isSkinStyle ? 60:30
        let imgH: CGFloat = sharedGloble.isSkinStyle ? 50:30
        let imgX: CGFloat = (self.frame.width - imgW) / 2
        let imgY: CGFloat = 0
        swappableImageView.frame = CGRect.init(x: imgX, y: imgY, width: imgW, height: imgH)
        
        let titleX: CGFloat = 0
        let titleY: CGFloat = swappableImageView.frame.maxY + 1
        let titleW: CGFloat = self.frame.width;
        let titleH: CGFloat = 18
        titleLabel.frame = CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH)
    }
    
    func reloadData(state:itemState) {
        if let normal = iconName, state == .normal {
            titleLabel.textColor = titleColor
            swappableImageView.image = UIImage.init(named: normal)
        }
        
        if let select = iconSelectedName, state == .selected {
            swappableImageView.image = UIImage.init(named: select)
            titleLabel.textColor = titleSelectedColor
        }
    }
    
    @objc private func handleClickItem() {
        if self.RTDelegate != nil {
            self.RTDelegate!.tabBarItem(self, didSelectedIndex: self.tag)
        }
    }
}
