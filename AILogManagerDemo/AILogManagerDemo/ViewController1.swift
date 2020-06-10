//
//  ViewController1.swift
//  AILogManagerDemo
//
//  Created by mal on 2020/5/26.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        
        if let navi = self.navigationController {
            let controllers = navi.viewControllers
            var newControllers = [UIViewController]()
            newControllers.append(ViewController2())
            for vc in controllers {
                if vc.isKind(of: ViewController.self) == false {
                    newControllers.append(vc)
                }
            }
            navi.viewControllers = newControllers
        }
    }
}
