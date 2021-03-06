//
//  AINameSpace.swift
//  AIRouterDemo
//
//  Created by mal on 2020/1/9.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

public protocol AINameSpace {}

extension AINameSpace {
    public var ai: AIWrapper<Self> {
        return AIWrapper(self)
    }
    
    public static var ai: AIWrapper<Self>.Type {
        return AIWrapper<Self>.self
    }
}

public struct AIWrapper<Wrapper> {
    let wrapper: Wrapper
    init(_ wrapper: Wrapper) {
        self.wrapper = wrapper
    }
}
