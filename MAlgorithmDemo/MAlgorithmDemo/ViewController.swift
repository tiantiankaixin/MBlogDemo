//
//  ViewController.swift
//  MAlgorithmDemo
//
//  Created by mal on 2019/10/17.
//  Copyright © 2019 mal. All rights reserved.
//

import UIKit

class ViewController: MMenuViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mAddItem(item: MMenuItem.ItemWith(title: "矩阵", itemClass: MMatrixViewController.self))
        self.mAddItem(item: MMenuItem.ItemWith(title: "查找算法", itemClass: MFindViewController.self))
        self.mAddItem(item: MMenuItem.ItemWith(title: "递归", itemClass: MDiguiViewController.self))
    }
}

