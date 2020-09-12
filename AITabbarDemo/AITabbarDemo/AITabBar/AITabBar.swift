//
//  AITabBar.swift
//  AITabbarDemo
//
//  Created by maliang on 2020/9/12.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit
import SnapKit

private let kTabBarHeight: CGFloat = 50

class AITabBar: UITabBar {
    
    var tabbarItems: [AITabbarItemBase] = [AITabbarItemBase]()
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    class func makeWith(items: [AITabbarItemBase]) -> AITabBar {
        let tabbar = AITabBar()
        tabbar.tabbarItems.append(contentsOf: items)
        tabbar.setUp()
        return tabbar
    }
}

extension AITabBar: UITabBarDelegate {
    func setUp() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let itemCount = tabbarItems.count
        var leftView = contentView
        for (idx, item) in tabbarItems.enumerated() {
            contentView.addSubview(item)
            if idx == 0 {
                item.snp.makeConstraints { (make) in
                    make.left.top.equalToSuperview()
                    make.height.equalTo(kTabBarHeight)
                    make.width.equalToSuperview().dividedBy(itemCount)
                }
                leftView = contentView
            } else {
                item.snp.makeConstraints { (make) in
                    make.left.equalTo(leftView.snp.right)
                    make.top.width.height.equalTo(leftView)
                }
            }
        }
    }
}
