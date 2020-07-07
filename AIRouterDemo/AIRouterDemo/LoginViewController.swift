//
//  LoginViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var loginComplete: (() -> ())?
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.backgroundColor = UIColor.systemOrange
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        return btn
    }()
    
    convenience init(complete: @escaping ()-> ()) {
        self.init()
        self.loginComplete = complete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loginBtn)
        self.loginBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func loginBtnClick() {
        UserManager.share.login()
        AILog("已登录")
        self.navigationController?.popViewController(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let block = self.loginComplete {
                block()
            }
        }
    }
}

class UserManager {
    
    static let share = UserManager()
    
    /// 用户是否登录
    var UserIsLogin: Bool {
        if let _ = user {
            return true
        }
        return false
    }
    
    /// 模拟用户
    var user: String?
    
    func login() {
        self.user = "user"
    }
    
    func loginOut() {
        self.user = nil
    }
}
