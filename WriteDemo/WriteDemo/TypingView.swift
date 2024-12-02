//
//  TypingView.swift
//  WriteDemo
//
//  Created by maliang on 2024/11/30.
//

import UIKit

class TypingView: UIView {
    private let textView = TypeTextView()
    private var displayLink: CADisplayLink?
    private var fullText: String = ""
    private var currentIndex: Int = 0
    private var typingSpeed: Double = 0.1 // 每个字的间隔时间，单位秒
    private var lineBreakPause: Double = 0.5 // 换行符停顿时间，单位秒
    private var lastUpdateTime: CFTimeInterval = 0
    private var lineSpacing: CGFloat = 4.0 // 行间距
    private var isTyping: Bool = false // 是否正在打印
    private var currentHeight: CGFloat = 0 // 当前高度
    private var isScrollEnabled: Bool = false // 是否启用滚动

    var maxHeight: CGFloat = 200 // 设置最大高度

    init(frame: CGRect, speed: Double = 0.1, lineBreakPause: Double = 0.5, lineSpacing: CGFloat = 4.0) {
        super.init(frame: frame)
        self.typingSpeed = speed
        self.lineBreakPause = lineBreakPause
        self.lineSpacing = lineSpacing
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextView() {
        textView.frame = bounds
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.isEditable = false
        textView.isScrollEnabled = false // 初始禁止滚动
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        addSubview(textView)
        
        textView.contentSizeChangeBlock = { [weak self] in
            self?.scrollToCurrentLine()
        }
    }
    
    /// 开始打印文本
    func startTyping() {
        guard !isTyping else { return }
        currentIndex = 0
        lastUpdateTime = CACurrentMediaTime()
        displayLink = CADisplayLink(target: self, selector: #selector(updateText))
        displayLink?.add(to: .main, forMode: .default)
        isTyping = true
    }
    
    /// 停止打印
    func stopTyping() {
        displayLink?.invalidate()
        displayLink = nil
        isTyping = false
    }
    
    /// 追加文本并开始打印
    func appendText(_ newText: String) {
        fullText += newText
        if !isTyping {
            startTyping()
        }
    }
    
    @objc private func updateText() {
        guard currentIndex < fullText.count else {
            stopTyping()
            return
        }
        
        let currentTime = CACurrentMediaTime()
        let elapsedTime = currentTime - lastUpdateTime
        
        if elapsedTime < typingSpeed {
            return // 等待下一个时间间隔
        }
        
        let currentChar = fullText[fullText.index(fullText.startIndex, offsetBy: currentIndex)]
        
        if currentChar == "\n", elapsedTime < typingSpeed + lineBreakPause {
            return // 换行符时多等待一段时间
        }
        
        currentIndex += 1
        lastUpdateTime = currentTime
        
        // 更新富文本
        let currentText = String(fullText.prefix(currentIndex))
        updateAttributedText(with: currentText)
        
        // 根据内容动态调整高度
        if !isScrollEnabled {
            adjustHeightUsingAttributedText()
        }
    }
    
    private func updateAttributedText(with text: String) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        textView.attributedText = attributedString
    }
    
    /// 根据富文本内容动态调整高度
    private func adjustHeightUsingAttributedText() {
        guard let attributedText = textView.attributedText else { return }
        let renderTextHeight = attributedText.ml_height(for: CGRectGetWidth(textView.frame))
        
        let targetHeight = min(renderTextHeight, maxHeight)
        if targetHeight > currentHeight {
            // 高度更新动画
            displayLink?.isPaused = true // 暂停动画
            let changeHeight = targetHeight - currentHeight
            UIView.animate(withDuration: 0.3) {
                self.currentHeight = targetHeight
                var frame = self.frame
                frame.origin.y = frame.origin.y - changeHeight
                frame.size.height = self.currentHeight
                self.frame = frame
                
                self.textView.frame = self.bounds
            } completion: { result in
                self.displayLink?.isPaused = false // 暂停动画
            }
        }
        
        if currentHeight == maxHeight {
            // 达到最大高度，切换到滚动模式
            print("开始出问题啦")
            self.textView.contentSize = CGSize(width: 0, height: CGRectGetHeight(self.frame))
            isScrollEnabled = true
            textView.isScrollEnabled = true
        }
    }
    
    private func scrollToCurrentLine() {
        guard isScrollEnabled else { return }
        
        print("scrollToCurrentLine")
        
        displayLink?.isPaused = true // 暂停动画
        UIView.animate(
            withDuration: 0.3,
            animations: {
                let lastRange = NSRange(location: self.textView.text.count - 1, length: 1)
                self.textView.scrollRangeToVisible(lastRange)
            },
            completion: { [weak self] _ in
                self?.displayLink?.isPaused = false // 恢复动画
            }
        )
    }
    
    deinit {
        displayLink?.invalidate()
    }
}

class TypeTextView: UITextView {
    override var contentSize: CGSize {
        get {
            return super.contentSize
        }
        set {
            super.contentSize = newValue
            contentSizeChangeBlock?()
        }
    }
    
    var contentSizeChangeBlock: (() -> ())? = nil
}



extension NSAttributedString {
    /// 计算富文本在指定宽度下的渲染高度
    /// - Parameters:
    ///   - width: 文本渲染的宽度
    ///   - maximumHeight: 可选参数，限制最大高度，默认无限制
    /// - Returns: 文本渲染所需的高度
    func ml_height(for width: CGFloat, maximumHeight: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        guard width > 0 else { return 0 }
        
        // 设置一个最大宽高尺寸
        let maxSize = CGSize(width: width, height: maximumHeight)
        
        // 计算文本的渲染矩形
        let boundingRect = self.boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        
        // 返回高度（向上取整保证完整显示）
        return ceil(boundingRect.height)
    }
}
