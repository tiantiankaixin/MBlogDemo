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
        view.maxLines = 4
        view.placeHolder = "我是占位的文本"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.sendTextBlock = {(text) in
            print("发送的文本是\(text)")
        }
    }
    
    @IBAction func onShowInputViewBtnClick(_ sender: UIButton) {
        inputTextView.show(inView: self.view)
    }
}

