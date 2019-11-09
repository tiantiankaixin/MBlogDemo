//
//  ViewController.swift
//  MMoyaDemo
//
//  Created by mal on 2019/11/8.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        alamofire_test()
        // Do any additional setup after loading the view.
    }

    func alamofire_test() {
        let parmeters = [
            "device":"iPhone",
            "appid":0,
            "name":"find_native",
            "network":"WIFI",
            "operator":3,
            "scale":3,
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970)
            ] as [String : Any]
        Alamofire.request("http://adse.ximalaya.com/ting/feed/ts-1532656780625", method: .get, parameters: parmeters).responseData(queue: DispatchQueue.main) { (response) in
            print(response)
        }
    }
}

