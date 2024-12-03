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
        typingView.backgroundColor = .red
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
        let text = "左目: 扇形二重まぶた\n右目: 扇形二重まぶた\n目の下のたるみ検出結果: 目の下にたるみがない\n黒眼袋検出結果: 黒眼袋なし\nおでこのしわ検出結果: おでこのしわなし\n目尻のしわ検出結果: 目尻のしわなし\n目元の細かいしわ検出結果: 目元の細かいしわなし\n眉間のしわ検出結果: 眉間のしわなし\nほうれい線検出結果: ほうれい線なし\n肌質検出結果: 普通肌\n額の毛穴検出結果: 毛穴が目立たない\n左頬の毛穴検出結果: 毛穴が目立たない\n右頬の毛穴検出結果: 毛穴が目立たない\n顎の毛穴検出結果: 毛穴が目立たない\n黒ずみ検出結果: 黒ずみなし\nニキビ検出結果: ニキビなし\nほくろ検出結果: ほくろなし\nシミ検出結果: シミなし\n • 三庭の比率：0.34:0.32:0.34\n • 上庭の長さ（单位：mm）：67.37\n • 上庭の割合：0.34\n • 上庭の判定結果：上庭标准\n • 中庭の長さ（单位：mm）：63.68\n • 中庭の割合：0.32\n • 中庭の判定結果：中庭標準\n • 下庭の長さ（单位：mm）：67.37\n • 下庭の割合：0.34\n • 下庭の判定結果"
        
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

