//
//  ViewController1.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginOut(_ sender: UIButton) {
        UserManager.share.loginOut()
        AILog("已退出登录")
    }
}
