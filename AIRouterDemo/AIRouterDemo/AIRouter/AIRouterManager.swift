//
//  AIRouterManager.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/9.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class AIRouterManager {
    
    /// 存储需要延时打开的链接（app刚启动首页尚未加载/需要先显示广告页 这时候需要延时打开链接）
    static var delayOpenUrl: String?
    
    /// 标记app首页是否加载完毕了
    static var appLoadFinish = false {
        willSet {
            if let url = delayOpenUrl {
                openUrl(urlStr: url)
                delayOpenUrl = nil
            }
        }
    }
    
    static func registerRouters() {
        let router = AIRouter.share
        router.registerRouter(target: HomeViewController.self, key: "home/")
        router.registerRouter(target: WebViewController.self, key: "web/")
        router.registerRouter(target: AlertViewController.self, key: "alert/")
        router.registerRouter(target: PresentViewController.self, key: "present/")
        router.registerRouter(target: NeedLoginViewController.self, key: "needlogin/")
    }
    
    /// 处理链接（打开页面/其它处理）
    /// - Parameter urlStr: 链接
    /// - Parameter externParameter: 额外参数（一些参数无法放在链接中如block、UIImage等可以放在这里）
    static func openUrl(urlStr: String, externParameter: [String: Any]? = nil) {
        if let target = AIRouter.share.targetWith(urlStr: urlStr, externParameter: externParameter) {
            let needLogin = target.needLogin()
            let isPush = target.isPush()
            if let vc = target as? UIViewController {
                self.openVC(vc: vc, needLogin: needLogin, isPush: isPush)
            }
        }
    }
    
    static func openVC(vc: UIViewController, needLogin: Bool, isPush: Bool) {
        if let topVC = UIViewController.topViewController() {
            if needLogin && UserManager.share.UserIsLogin == false {//登录处理
                let loginVC = LoginViewController {
                    self.openVC(vc: vc, needLogin: needLogin, isPush: isPush)
                }
                self.openVC(vc: loginVC, needLogin: false, isPush: true)
            } else {
                if isPush {
                    if let _ = topVC.navigationController {
                        topVC.aiPushToVC(toVC: vc)
                    } else {
                        let navi = UINavigationController(rootViewController: vc)
                        topVC.aiPresent(navi, animated: true, completion: nil)
                    }
                } else {
                    topVC.aiPresent(vc, animated: true, completion: nil)
                }
            }
        }
    }
}

extension UIViewController {
    static func topViewController() -> UIViewController? {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        return self.topViewController(fromVC: rootVC)
    }
    
    static func topViewController(fromVC: UIViewController?) -> UIViewController? {
        if let navi = fromVC as? UINavigationController {
            return self.topViewController(fromVC: navi.topViewController)
        } else if let tab = fromVC as? UITabBarController {
            return self.topViewController(fromVC: tab.selectedViewController)
        } else if let presentedVC = fromVC?.presentedViewController {
            return self.topViewController(fromVC: presentedVC)
        } else {
            return fromVC
        }
    }
    
    func aiPresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        viewControllerToPresent.view.backgroundColor = UIColor.white
        self.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    func aiPushToVC(toVC: UIViewController, animated: Bool = true) {
        if let navi = self.navigationController {
            if navi.viewControllers.count == 1 {
                toVC.hidesBottomBarWhenPushed = true
            }
            toVC.view.backgroundColor = UIColor.white
            navi.pushViewController(toVC, animated: animated)
        }
    }
}

extension String {
    func aiBase64Encoding() -> String {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
    
    func aiBase64Decoding() -> String {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8) ?? ""
        }
        return ""
    }
}
