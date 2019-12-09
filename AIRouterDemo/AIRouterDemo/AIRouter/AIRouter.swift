//
//  AIRouter.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/7.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

let kAppScheme = "ArtAIClass"
private let kHttp = "http,https"

//ArtAIClass://xxxx/xxx?pa=xxx
//http://xxxx/xxx?pa=xxx

protocol AIRouterProtocol {
    static func targetWith(pa: [String: Any]) -> AIRouterProtocol?
    func needLogin() -> Bool
    func isPush() -> Bool
}

class AIRouter {
    
    var targetDict = [String: AIRouterProtocol.Type]()
    
    static let share: AIRouter = {
        let router = AIRouter()
        return router
    }()
    
    func registerRouter(target: AIRouterProtocol.Type, key: String) {
        targetDict.updateValue(target, forKey: key)
    }
    
    func targetWith(urlStr: String) -> AIRouterProtocol? {
        let encodeUrlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let urlComponents = URLComponents(string: encodeUrlStr) {
            let scheme = urlComponents.scheme ?? ""
            let host = urlComponents.host ?? ""
            let path = urlComponents.path
            //AILog("scheme:\(scheme) host:\(host) path:\(path)")
            var parameter = [String: String]()
            if let queryItems = urlComponents.queryItems {
                for query in queryItems {
                    parameter.updateValue(query.value ?? "", forKey: query.name)
                }
            }
            if scheme == kAppScheme {
                return targetWith(key: host + path, parameter: parameter)
            } else if kHttp.contains(scheme) {
                if let target = targetWith(key: host + path, parameter: parameter) {
                    return target
                } else {
                    //TODO: 创建个webcontroller
                }
            }
        }
        return nil
    }
    
    func targetWith(key: String, parameter: [String: String]) -> AIRouterProtocol? {
        if let router = targetDict[key] {
            return router.targetWith(pa: parameter)
        }
        return nil
    }
}
