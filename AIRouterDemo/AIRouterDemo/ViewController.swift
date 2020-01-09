//
//  ViewController.swift
//  AIRouterDemo
//
//  Created by mal on 2019/12/7.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var routerTarget: AIRouterProtocol.Type?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AIRouterManager.appLoadFinish = true
    }
        
    //MARK: present
    @IBAction func presentBtnClick(_ sender: UIButton) {
        let openUrl = "http://present/?roomId=1"
        AIRouterManager.openUrl(urlStr: openUrl)
    }
    
    //MARK: push
    @IBAction func pushBtnClick(_ sender: UIButton) {
        let openUrl = "http://home/?roomId=1"
        AIRouterManager.openUrl(urlStr: openUrl)
    }
    
    //MARK: 需要先登录
    @IBAction func needLoginBtnClick(_ sender: Any) {
        let openUrl = "http://needlogin/"
        AIRouterManager.openUrl(urlStr: openUrl)
    }
    
    //MARK: 弹窗 -> 点确定后跳转页面
    @IBAction func alertBtnClick(_ sender: Any) {
        //直接传递链接对参数解析有影响 encoding一下
        let pageUrl = "http://home/?roomId=1".ai.urlEncoding()
        let alertUrl = "https://alert/?url=\(pageUrl)&title=提示&message=是否要打开目标页&ok=确定&cancel=取消"
        AIRouterManager.openUrl(urlStr: alertUrl)
    }
    
    @IBAction func openWebPage(_ sender: UIButton) {
        let webUrl = "www.baidu.com?pa1=1&pa2=2".ai.urlEncoding()
        let openUrl = "http://web/?url=\(webUrl)"
        AIRouterManager.openUrl(urlStr: openUrl)
    }
}

