//
//  AlertViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class AlertViewController: UIAlertController, AIRouterProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - AIRouterProtocol
    static func targetWith(pa: [String : Any]) -> AIRouterProtocol? {
        let title = pa["title"] as? String
        let message = pa["message"] as? String
        let okTitle = pa["ok"] as? String
        let cancelTitle = pa["cancel"] as? String
        let url = pa["url"] as? String
        let alert = AlertViewController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default) { (_) in
            if let urlStr = url {
                AIRouterManager.openUrl(urlStr: urlStr.ai.urlDecoding())
            }
        }
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        if let topVC = UIViewController.topViewController() {
            topVC.aiPresent(alert, animated: true, completion: nil)
        }
        return nil
    }
    
    func needLogin() -> Bool {
        return false
    }
    
    func isPush() -> Bool {
        return false
    }
}
