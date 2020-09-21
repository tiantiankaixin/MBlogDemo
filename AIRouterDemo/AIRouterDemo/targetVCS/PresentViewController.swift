//
//  PresentViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class PresentViewController: UIViewController, AIRouterProtocol {

    lazy var lb: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.black
        lb.text = "PresentViewController点击返回"
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - AIRouterProtocol
    static func targetWith(pa: [String : Any]) -> AIRouterProtocol? {
        let home = PresentViewController()
        AILog("参数:\(pa)")
        return home
    }
    
    func isPush() -> Bool {
        return false
    }
}
