//
//  ViewController.swift
//  KingfisherDemo
//
//  Created by mal on 2020/1/9.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit
import Kingfisher

let url1 = "http://file02.16sucai.com/d/file/2014/0829/372edfeb74c3119b666237bd4af92be5.jpg"
let url2 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578581534853&di=a41c8e59a68751f808ba524edc6af905&imgtype=0&src=http%3A%2F%2Fyouimg1.c-ctrip.com%2Ftarget%2Ftg%2F096%2F755%2F666%2F49611e232c4646bcbfdca563a39b15ab.jpg"
let url3 = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1578581534853&di=af215beb456bda144351352e72a72203&imgtype=0&src=http%3A%2F%2Fattachments.gfan.com%2Fforum%2Fattachments2%2Fday_120607%2F12060716532b57ad85affd623f.jpg"

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var cacheSizeLB: UILabel!
    @IBOutlet weak var getCacheSizeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIImageView.ai.imageViewTestFunc()
    }
    
    @IBAction func downloadBtnClick(_ sender: UIButton) {
        sender.isEnabled = false
        AIKingfisher.downloadWith(urlStrArray: [url1, url2, url3]) { (result) in
            print("下载完成")
            sender.isEnabled = true
            self.getChacheSizeBtnClick(self.getCacheSizeBtn)
        }
    }
    
    @IBAction func clearimg(_ sender: Any) {
        img.image = nil
        img2.image = nil
        img3.image = nil
    }
    
    @IBAction func setImgBtnClick(_ sender: Any) {
        img.ai.setImage(imgUrl: url1)
        img2.ai.setImage(imgUrl: url2)
        img3.ai.setImage(imgUrl: url3)
    }
    
    @IBAction func clearCacheBtnClick(_ sender: UIButton) {
        sender.isEnabled = false
        AIKingfisher.clearCache { (_) in
            sender.isEnabled = true
            self.getChacheSizeBtnClick(self.getCacheSizeBtn)
        }
    }
    
    @IBAction func getChacheSizeBtnClick(_ sender: UIButton) {
        sender.isEnabled = false
        AIKingfisher.cacheSize { (sizeStr) in
            sender.isEnabled = true
            self.cacheSizeLB.text = sizeStr
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(NSHomeDirectory())
    }
}

