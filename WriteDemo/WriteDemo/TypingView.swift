//
//  TypingView.swift
//  WriteDemo
//
//  Created by maliang on 2024/11/30.
//

import UIKit

class TypingView: UIView {
    private lazy var scrollView: UIScrollView = {
        let scro = UIScrollView()
        return scro
    }()
    private lazy var textLB: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.textColor = .systemPink
        return lb
    }()
    
    private var displayLink: CADisplayLink?
    private var fullText: String = ""
    private var currentIndex: Int = 0
    private var typingSpeed: Double = 0.05 // 每个字的间隔时间，单位秒
    private var lineBreakPause: Double = 0.5 // 换行符停顿时间，单位秒
    private var lastUpdateTime: CFTimeInterval = 0
    private var lineSpacing: CGFloat = 4.0 // 行间距
    private var isTyping: Bool = false // 是否正在打印
    private var currentHeight: CGFloat = 0 // 当前高度
    private var isScrollEnabled: Bool = false // 是否启用滚动

    var maxHeight: CGFloat = 200 // 设置最大高度
    var skip: Bool = false

    init(frame: CGRect, speed: Double = 0.1, lineBreakPause: Double = 0.5, lineSpacing: CGFloat = 4.0) {
        super.init(frame: frame)
        self.typingSpeed = speed
        self.lineBreakPause = lineBreakPause
        self.lineSpacing = lineSpacing
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .red
        scrollView.backgroundColor = .clear
        textLB.backgroundColor = .black
        scrollView.addSubview(textLB)
        addSubview(scrollView)
    }
    
    /// 开始打印文本
    func startTyping() {
        guard !isTyping else { return }
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
        
        if skip {
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
        let attStr = attributedText(with: currentText)
        
        skip = true
        adjustHeightUsingAttributedText(attributedText: attStr) { [weak self] in
            self?.textLB.attributedText = attStr
            self?.skip = false
        }
    }
    
    /// 根据富文本内容动态调整高度
    private func adjustHeightUsingAttributedText(attributedText: NSAttributedString, complete:@escaping () -> ()) {
        let renderTextHeight = attributedText.ml_height(for: CGRectGetWidth(self.frame))
        if renderTextHeight <= maxHeight {
            updateFrameWithNewHeight(renderTextHeight, complete: complete)
        }  else {
            updateContent(height: renderTextHeight, complete: complete)
        }
    }
    
    //MARK: 更新高度
    private func updateFrameWithNewHeight(_ height: CGFloat, complete:@escaping () -> ()) {
        let oldHeight = CGRectGetHeight(self.frame)
        if oldHeight > height {
            complete()
            return
        }
        self.scrollView.contentSize = CGSize(width: 0, height: height)
        let changeHeight = height - oldHeight
        displayLink?.isPaused = true // 暂停动画
        UIView.animate(withDuration: 0.5) {
            var frame = self.frame
            frame.size.height = height
            frame.origin.y = frame.origin.y - changeHeight
            self.frame = frame
        } completion: { result in
            self.scrollView.frame = self.bounds
            self.textLB.frame = self.bounds
            complete()
            self.displayLink?.isPaused = false // 暂停动画
        }
    }
    
    private func updateContent(height: CGFloat, complete:@escaping () -> ()) {
        let oldHeight = scrollView.contentSize.height
        if height > oldHeight {
            scrollView.contentSize = CGSize(width: 0, height: height)
            let changeHeight = height - oldHeight
            let newPoint = CGPoint(x: 0, y: self.scrollView.contentOffset.y + changeHeight)
            displayLink?.isPaused = true // 暂停动画
            UIView.animate(withDuration: 0.3) {
                self.scrollView.setContentOffset(newPoint, animated: false)
            } completion: { result in
                var lbFrame = self.textLB.frame
                lbFrame.size.height = height
                self.textLB.frame = lbFrame
                complete()
                self.displayLink?.isPaused = false // 暂停动画
            }
        } else {
            complete()
        }
    }
    
    private func attributedText(with text: String) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
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
