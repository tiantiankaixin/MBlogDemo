//
//  ViewController.swift
//  MMetalDemo
//
//  Created by maliang on 2020/8/15.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit
import Metal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        // Do any additional setup after loading the view.
    }

    func test() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            print("设备不支持")
            return
        }
        print(device)
    }
}

