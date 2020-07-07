//
//  ViewController.swift
//  AIInPutView
//
//  Created by mal on 2020/7/6.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var inputTextView: AIInputTextView = {
        let view = AIInputTextView.viewWith()
        view.maxLines = 5
        view.placeHolder = "我是占位的文本"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onShowInputViewBtnClick(_ sender: UIButton) {
        inputTextView.show(inView: self.view)
    }
}

