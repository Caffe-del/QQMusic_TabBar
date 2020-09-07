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

class RootTabBarItem: UIView {
    // 对外暴露
    var icon: String! {
        didSet{
            swappableImageView.image = UIImage.init(named: icon)
        }
    }
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    var titleColor: UIColor! {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    var RTDelegate: RootTabBarItemDelegate?
    
    // 私有属性
    fileprivate
    var swappableImageView: UIImageView!
    var titleLabel: UILabel!
    
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
    
    func initSubviews() {
        swappableImageView = UIImageView()
        self.addSubview(swappableImageView)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 10)
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = .systemGray
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 图片和文字 模式
        if icon.count > 0 && title.count > 0 {
            let imgW: CGFloat = 22
            let imgH: CGFloat = imgW
            let imgX: CGFloat = (self.frame.width - imgW) / 2
            let imgY: CGFloat = 0
            swappableImageView.frame = CGRect.init(x: imgX, y: imgY, width: imgW, height: imgH)
            
            let titleX: CGFloat = 0
            let titleY: CGFloat = swappableImageView.frame.maxY + 5
            let titleW: CGFloat = self.frame.width;
            let titleH: CGFloat = 18
            titleLabel.frame = CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        // 只有图片 模式 主题
        else {
            swappableImageView.bounds = self.bounds
        }
    }
    
    @objc func handleClickItem() {
        if self.RTDelegate != nil {
            self.RTDelegate!.tabBarItem(self, didSelectedIndex: self.tag)
        }
    }
    
    

}
