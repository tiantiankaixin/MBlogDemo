//
//  AITabBarViewController.swift
//  AITabbarDemo
//
//  Created by maliang on 2020/9/12.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit

class AITabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    
    func setUpTabbar() {
        let page1 = ChildViewController(title: "page1", bgColor: .red)
        let page2 = ChildViewController(title: "page2", bgColor: .green)
        let page3 = ChildViewController(title: "page3", bgColor: .blue)
        let page4 = ChildViewController(title: "page4", bgColor: .orange)
        viewControllers = [page1, page2, page3, page4]
        
        let tabbar = AITabBar.makeWith(items: [])
        self.setValue(tabbar, forKey: "tab" + "Bar")
    }
}
