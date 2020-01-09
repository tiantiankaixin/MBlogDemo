//
//  WebViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/7.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, AIRouterProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - AIRouterProtocol
    static func targetWith(pa: [String : Any]) -> AIRouterProtocol? {
        let web = WebViewController()
        if let url = pa["url"] as? String {
            AILog("打开链接：\(url.ai.urlDecoding())")
        }
        return web
    }
    
    func needLogin() -> Bool {
        return false
    }
    
    func isPush() -> Bool {
        return true
    }
}
