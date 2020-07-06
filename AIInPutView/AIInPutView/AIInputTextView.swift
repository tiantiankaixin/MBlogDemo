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

class AIInputTextView: UIView {
    private var isRegisterNotifation = false
    
    private var textView: UITextView = {
        let view = UITextView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.textContainerInset = .zero
        view.font = UIFont.systemFont(ofSize: 20)
        return view
    }()
    
    private var textContainerView: UIView = {
        let view = UIView()
        view.ai_setCorner(corner: 6)
        view.ai_addBorder(width: 1, color: .red)
        return view
    }()
    
    private var maxHeight: CGFloat = 0
    
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
        inView.addSubview(self)
        registerNotifation()
        textView.becomeFirstResponder()
    }
    
    func dismiss() {
        resignNotifation()
        removeFromSuperview()
    }
    
    private func setUpView() {
        textContainerView.addSubview(textView)
        ai_addSubViews(subViews: [textContainerView])
        let textHeight = textView.sizeThatFits(CGSize(width: kInputViewWidth , height: CGFloat(MAXFLOAT))).height
        ai_height = textHeight + kInputViewVMargin * 2 + kInputContainerViewVMargin * 2
        updateTextView()
    }
    
    private func updateTextView() {
        textContainerView.frame = CGRect(x: kInputContainerViewHMargin, y: kInputContainerViewVMargin, width: ai_width - kInputContainerViewHMargin * 2, height: ai_height - kInputContainerViewVMargin * 2)
        textView.frame = CGRect(x: kInputViewHMargin, y: kInputViewVMargin, width: textContainerView.ai_width - 2 * kInputViewHMargin, height: textContainerView.ai_height - 2 * kInputViewVMargin)
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
