//
//  UIView+Ai.swift
//  ArtAIClassSwift
//
//  Created by mal on 2019/11/9.
//  Copyright © 2019 meishubao.com. All rights reserved.
//

import UIKit

let MNotSet = CGFloat.greatestFiniteMagnitude
let ScreenSize = UIScreen.main.bounds.size
let ScreenWidth = ScreenSize.width
let ScreenHeight = ScreenSize.height

//MARK: - UIView frame
extension UIView {
        
    func ai_setFrame(X: CGFloat = MNotSet, Y: CGFloat = MNotSet, Width: CGFloat = MNotSet, Height: CGFloat = MNotSet) {
        var viewFrame = self.frame
        
        if X != MNotSet{
            viewFrame.origin.x = X
        }
        
        if Y != MNotSet{
            viewFrame.origin.y = Y
        }
        
        if Width != MNotSet{
            viewFrame.size.width = Width
        }
        
        if Height != MNotSet{
            viewFrame.size.height = Height
        }
        
        self.frame = viewFrame
    }
    
    var ai_width: CGFloat {
        get {
            return self.frame.width
        }
        set {
            ai_setFrame(Width: newValue)
        }
    }
    
    var ai_height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            ai_setFrame(Height: newValue)
        }
    }
    
    var ai_left: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            ai_setFrame(X: newValue)
        }
    }
    
    var ai_right: CGFloat {
        get {
            return self.ai_left + self.ai_width
        }
        set {
            ai_setFrame(X: newValue - self.ai_width)
        }
    }
    
    var ai_top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            ai_setFrame(Y: newValue)
        }
    }
    
    var ai_bottom: CGFloat {
        get {
            return self.ai_top + self.ai_height
        }
        set {
            ai_setFrame(Y: newValue - self.ai_height)
        }
    }
    
    var ai_centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    
    var ai_centerY:CGFloat{
           get{
               return self.center.y
           }
           set(newValue){
               var center = self.center
               center.y = newValue
               self.center = center
           }
       }
}

//MARK: - UIView help
extension UIView {
    func ai_setCorner(corner: CGFloat) {
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
    }
    
    func ai_setCorner(corner: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        self.layer.mask = shape
    }
    
    func ai_addSubViews(subViews: [UIView]) {
        for view in subViews {
            if view.isDescendant(of: self) == false {
                self.addSubview(view)
            }
        }
    }
    
    func ai_removeSubViews(subViews: [UIView]) {
        for view in subViews {
            if view.isDescendant(of: self) {
                view.removeFromSuperview()
            }
        }
    }
    
    static func ai_removeFromSuperView(views: [UIView]) {
        for view in views {
            view.removeFromSuperview()
        }
    }
    
    func ai_addBorder(width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func ai_clearBorder() {
        self.layer.borderColor = nil
        self.layer.borderWidth = 0.0
    }
    
    func ai_addShadow(shadowOpacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, shadowColor: UIColor = UIColor.black, shadowOffset: CGSize = CGSize(width: 0, height: 1)) {
        
        let shadowLayer = CALayer()
        shadowLayer.frame = self.layer.frame
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = shadowOffset
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        
        let path = UIBezierPath()
        let rect = shadowLayer.bounds
        let width = rect.width
        let height = rect.height
        let x = rect.origin.x
        let y = rect.origin.y
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: x + width, y: y)
        let bottomRight = CGPoint(x: x + width, y: y + height)
        let bottomLeft = CGPoint(x: x, y: y + height)
        
        let offSet: CGFloat = -1.0
        path.move(to: CGPoint(x: topLeft.x - offSet, y: topLeft.y + cornerRadius))
        path.addArc(withCenter: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y + cornerRadius), radius: cornerRadius + offSet, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi / 2 * 3), clockwise: true)
        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y - offSet))
        path.addArc(withCenter: CGPoint(x: topRight.x - cornerRadius, y: topRight.y + cornerRadius), radius: cornerRadius + offSet, startAngle: CGFloat(Double.pi / 2 * 3), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        path.addLine(to: CGPoint(x: bottomRight.x + offSet, y: bottomRight.y - cornerRadius))
        path.addArc(withCenter: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y - cornerRadius), radius: cornerRadius + offSet, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y + offSet))
        path.addArc(withCenter: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y - cornerRadius), radius: cornerRadius + offSet, startAngle: CGFloat(Double.pi / 2.0), endAngle: CGFloat(Double.pi), clockwise: true)
        path.addLine(to: CGPoint(x: topLeft.x - offSet, y: topLeft.y + cornerRadius))
        
        shadowLayer.shadowPath = path.cgPath
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.superview?.layer.insertSublayer(shadowLayer, below: self.layer)
    }
}

//MARK: - UITableView
extension UITableView {
    
    /// UITableView通用设置
    func AITableViewSet() {
        self.sectionHeaderHeight = 0.0
        self.sectionFooterHeight = 0.0
        self.estimatedRowHeight = 0.0
        self.estimatedSectionHeaderHeight = 0.0
        self.estimatedSectionFooterHeight = 0.0
        if #available(iOS 11, *) {
            self.contentInsetAdjustmentBehavior = .never
        }
    }
        
    /// 滚动到顶部
    func AIScrollToTop(animated: Bool = false) {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
    }
}

