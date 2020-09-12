//
//  ChildViewController.swift
//  AITabbarDemo
//
//  Created by maliang on 2020/9/12.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit

class ChildViewController: UIViewController {
    
    var pageTitle: String = ""
    var bgColor: UIColor? = nil
    
    convenience init(title: String, bgColor: UIColor) {
        self.init()
        pageTitle = title
        self.bgColor = bgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
    }
}
