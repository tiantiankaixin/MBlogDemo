//
//  TestImageView.swift
//  MFrameworkDemo
//
//  Created by maliang on 2020/7/20.
//  Copyright © 2020 maliang. All rights reserved.
//

import UIKit
import Kingfisher

class TestImageView: UIImageView {

    func test() {
        let imgUrl: String = "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png"
        let placeHolder = UIImage()
        kf.setImage(with: URL(string: imgUrl), placeholder: placeHolder, options: [.transition(.fade(1))])
    }

}
