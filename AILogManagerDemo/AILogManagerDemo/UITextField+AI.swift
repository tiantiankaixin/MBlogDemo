//
//  UITextField+AI.swift
//  AILogManagerDemo
//
//  Created by mal on 2020/5/29.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

extension UITextField {
    func aiSelectedRange() -> NSRange {
        let start = selectedTextRange?.start ?? beginningOfDocument
        let end = selectedTextRange?.end ?? endOfDocument
        let location = offset(from: beginningOfDocument, to: start)
        let length = offset(from: start, to: end)
        return NSRange(location: location, length: length)
    }
    
    func aisetSelectedRange(range: NSRange) {
        let start = position(from: beginningOfDocument, offset: range.location) ?? beginningOfDocument
        let end = position(from: beginningOfDocument, offset: range.location + range.length) ?? endOfDocument
        selectedTextRange = textRange(from: start, to: end)
    }
}
