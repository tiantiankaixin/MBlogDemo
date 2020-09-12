//
//  AITabbarItemBase.swift
//  AITabbarDemo
//
//  Created by maliang on 2020/9/12.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit

class AITabbarItemBase: UIView {

}

struct AITabbarItemGeneralInfo {
    var title: String = ""
    var image: UIImage? = nil
    var selectImage: UIImage? = nil
    var titleColor: UIColor? = nil
    var selectTitleColor: UIColor? = nil
    var font: UIFont? = nil
}

class AITabbarItemGeneral: AITabbarItemBase {
    
    lazy var titleLB: UILabel = {
        let lb = UILabel()
        return lb
    }()
    
    lazy var iconIM: UIImageView = {
        let im = UIImageView()
        return im
    }()
    
    var info: AITabbarItemGeneralInfo? = nil
    
    static func makeWith(info: AITabbarItemGeneralInfo?) -> AITabbarItemGeneral {
        let item = AITabbarItemGeneral()
        item.info = info
        item.setUp()
        return item
    }
    
    func setUp() {
        addSubview(titleLB)
        addSubview(iconIM)
        titleLB.snp.makeConstraints { (make) in
            //make.top.equalToSuperview().offset(<#T##amount: ConstraintOffsetTarget##ConstraintOffsetTarget#>)
        }
    }
}
