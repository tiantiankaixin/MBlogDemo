//
//  ViewController.swift
//  AILogManagerDemo
//
//  Created by mal on 2020/5/21.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var phoneTF: UITextField = {
        let tf = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(textChanged(sender:)), for: .editingChanged)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AIDefaultLogger.log("测试1111")
        AIDownloadLogger.log("测试2222")
        AIDefaultLogger.log("测试1112")
        AIDownloadLogger.log("测试2223")
        view.addSubview(phoneTF)
    }
    
    @objc func textChanged(sender: UITextField) {
        let phoneNum = sender.text
        if let numStr = phoneNum, numStr.isEmpty == false {
            if numStr.contains(" ") {
                let mobile = numStr.replacingOccurrences(of: " ", with: "")
                self.phoneTF.text = mobile
                self.phoneTF.aisetSelectedRange(range: NSMakeRange(mobile.count, 1))
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.navigationController?.pushViewController(ViewController1(), animated: true)
    }
}

