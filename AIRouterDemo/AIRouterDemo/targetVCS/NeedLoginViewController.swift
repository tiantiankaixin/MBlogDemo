//
//  NeedLoginViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class NeedLoginViewController: UIViewController, AIRouterProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - AIRouterProtocol
    static func targetWith(pa: [String : Any]) -> AIRouterProtocol? {
        let vc = NeedLoginViewController()
        AILog("参数:\(pa)")
        return vc
    }

    func needLogin() -> Bool {
        return true
    }
    
    func isPush() -> Bool {
        return true
    }
}
