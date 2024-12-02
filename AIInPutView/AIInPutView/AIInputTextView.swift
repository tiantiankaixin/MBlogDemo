//
//  AIInputTextView.swift
//  AIInPutView
//
//  Created by mal on 2020/7/6.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

private let kInputViewHMargin: CGFloat = 5
private let kInputViewVMargin: CGFloat = 10
private let kInputContainerViewHMargin: CGFloat = 10
private let kInputContainerViewVMargin: CGFloat = 10
private let kInputViewWidth: CGFloat = (ScreenWidth - kInputViewHMargin * 2 - kInputContainerViewHMargin * 2)
private let kBgViewDismissColor = UIColor(aiHex: 0x000000, alpha: 0.0)
private let kBgViewShowColor = UIColor(aiHex: 0x000000, alpha: 0.4)

private let kTextFont = UIFont.systemFont(ofSize: 12)

class AIInputTextView: UIView {
    private var isRegisterNotifation = false
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.textContainerInset = .zero
        view.font = kTextFont
        view.textColor = .black
        view.returnKeyType = .send
        view.delegate = self
        return view
    }()
    
    private lazy var placeHolderTextView: UITextView = {
        let view = UITextView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.textContainerInset = .zero
        view.font = kTextFont
        view.textColor = .lightGray
        return view
    }()
    
    private lazy var textContainerView: UIView = {
        let view = UIView()
        view.ai_setCorner(corner: 6)
        view.ai_addBorder(width: 1, color: .red)
        return view
    }()
    
    private lazy var bgView: UIControl = {
        let view = UIControl(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        view.addTarget(self, action: #selector(bgViewClick), for: .touchUpInside)
        view.backgroundColor = kBgViewDismissColor
        return view
    }()
    
    var placeHolder: String? = nil {
        willSet {
            placeHolderTextView.text = newValue ?? ""
        }
    }
    
    private var maxHeight: CGFloat = 0
    
    var sendTextBlock: ((String) -> ())? = nil
    
    var maxLines: Int = 4 {
        willSet {
            if newValue > 0 {
                let lineHeight = textView.font?.lineHeight ?? 0
                let insert = textView.textContainerInset
                maxHeight = ceil(lineHeight * CGFloat(newValue) + insert.top + insert.bottom)
            }
        }
    }
    
    static func viewWith() -> AIInputTextView {
        let view = AIInputTextView(frame: CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 0))
        view.setUpView()
        return view
    }
    
    func show(inView: UIView) {
        dismiss()
        inView.addSubview(bgView)
        inView.addSubview(self)
        updatePlaceholderShowState()
        registerNotifation()
        textView.becomeFirstResponder()
    }
    
    func dismiss() {
        bgView.removeFromSuperview()
        resignNotifation()
        removeFromSuperview()
    }
    
    func sendText() {
        if let text = textView.text, text.isEmpty == false {
            if let block = sendTextBlock {
                block(text)
                textView.text = ""
                dismiss()
            }
        }
    }
    
    private func setUpView() {
        backgroundColor = .white
        textContainerView.ai_addSubViews(subViews: [textView, placeHolderTextView])
        ai_addSubViews(subViews: [textContainerView])
        let textHeight = textView.sizeThatFits(CGSize(width: kInputViewWidth , height: CGFloat(MAXFLOAT))).height
        ai_height = textHeight + kInputViewVMargin * 2 + kInputContainerViewVMargin * 2
        updateTextView()
    }
    
    private func updateTextView() {
        textContainerView.frame = CGRect(x: kInputContainerViewHMargin, y: kInputContainerViewVMargin, width: ai_width - kInputContainerViewHMargin * 2, height: ai_height - kInputContainerViewVMargin * 2)
        textView.frame = CGRect(x: kInputViewHMargin, y: kInputViewVMargin, width: textContainerView.ai_width - 2 * kInputViewHMargin, height: textContainerView.ai_height - 2 * kInputViewVMargin)
        placeHolderTextView.frame = textView.frame
    }
    
    @objc private func bgViewClick() {
        dismiss()
    }
    
    deinit {
        print("AIInputTextView deinit")
    }
}

private let kContentSizeKeyPath = "contentSize"
private let kChangeFrameAnimationDuration: TimeInterval = 0.3

extension AIInputTextView {
    private func registerNotifation() {
        if isRegisterNotifation == false {
            isRegisterNotifation = true
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
            textView.addObserver(self, forKeyPath: kContentSizeKeyPath, options: .new, context: nil)
        }
    }
    
    private func resignNotifation() {
        if isRegisterNotifation {
            isRegisterNotifation = false
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
            textView.removeObserver(self, forKeyPath: kContentSizeKeyPath)
        }
    }
    
    @objc func keyboardWillShow(noti: Notification) {
        let keyboardFrame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        if let rect = keyboardFrame, let timeInterval = duration {
            let keyboardHeight = rect.size.height
            UIView.animate(withDuration: timeInterval) {
                self.ai_bottom = ScreenHeight - keyboardHeight
                self.bgView.backgroundColor = kBgViewShowColor
            }
        }
    }
    
    @objc func keyboardWillHidden(noti: Notification) {
        let duration = noti.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        if let timeInterval = duration {
            UIView.animate(withDuration: timeInterval, animations: {
                self.ai_top = ScreenHeight
            }) { (finished) in
                self.dismiss()
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let path = keyPath, path == kContentSizeKeyPath, let newSize = change?[.newKey] as? CGSize {
            updateTextViewFrameWith(height: newSize.height)
        }
    }
    
    func updateTextViewFrameWith(height: CGFloat) {
        let newHeight = min(height, maxHeight)
        if newHeight != textView.ai_height {
            let changeHeight = newHeight - textView.ai_height
            UIView.animate(withDuration: kChangeFrameAnimationDuration) {
                self.ai_height = self.ai_height + changeHeight
                self.ai_top = self.ai_top - changeHeight
                self.updateTextView()
            }
        }
    }
}

extension AIInputTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderShowState()
//        if textView.check(withMaxinputNum: 2) {
//            print("123123123123123132131")
//        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            sendText()
            return false
        }
        return true
    }
    
    func updatePlaceholderShowState() {
        placeHolderTextView.isHidden = !textView.text.isEmpty
    }
}
