//
//  HomeViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/7.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, AIRouterProtocol {

    lazy var lb: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.text = "HomeViewController"
        return lb
    }()
    
    var home: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(lb)
        self.lb.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    //MARK: - AIRouterProtocol
    static func targetWith(pa: [String : Any]) -> AIRouterProtocol? {
        let home = HomeViewController()
        AILog("参数:\(pa)")
        return home
    }
}
