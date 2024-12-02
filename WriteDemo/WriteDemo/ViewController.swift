//
//  ViewController.swift
//  WriteDemo
//
//  Created by maliang on 2024/11/30.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tabIM: UIImageView!
    
    var typeView: TypingView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        
        print("开始了....1")
        let typingView = TypingView(
            frame: CGRect(x: 20, y: CGRectGetHeight(self.view.frame) - 100, width: view.frame.width - 150, height: 0),
            speed: 0.05, // 每个字的打印间隔（秒）
            lineBreakPause: 0.3 // 遇到换行符的额外停顿时间（秒）
        )
        typingView.backgroundColor = .white
        view.addSubview(typingView)
        typingView.startTyping()
        print("开始了....2")
        if let image = UIImage(named: "tab") {
            let newImage = image.resizeableImage()
            tabIM.image = newImage
        }
        
        self.typeView = typingView
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //present(Test1(), animated: true)
        let str1 = "司法解释两地分居塑料袋飞机上拉法基手打拉法基说法了三大理发收垃圾代发垃圾1"
        let str2 = "烦死了党风建设咯inn你那拿不拿不拿，不能不吃，吃吧，女，你，ff保持，女粗暴你，，你，你，你，你，胜多负少防守打法"
        let str3 = "比较轻😁理解法律手段就分手了电极法就发了解决29734923749273942739492479274274932472749234"
        let str4 = "fsdfsfsfsfsfsfsdfsfsdfsdfsfsdfsdfsfsfsfsfsfsfsfsdf00000000"
        let textArray = [str1, str2, str3, str4]
        let text = textArray.joined(separator: "\n")
        
        self.typeView?.appendText(text)
    }
    
}

extension UIImage {
    /// 图片拉伸处理
    func resizeableImage() -> UIImage {
        let w = self.size.width * 0.5
        let h = self.size.height * 0.5
        return self.resizableImage(withCapInsets: UIEdgeInsets(top: h - 1, left: w - 1, bottom: h - 1, right: w - 1), resizingMode: .stretch)
    }
}

