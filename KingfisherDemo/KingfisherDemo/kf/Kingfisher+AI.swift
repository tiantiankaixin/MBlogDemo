//
//  Kingfisher+AI.swift
//  ArtAIClassSwift
//
//  Created by mal on 2019/12/19.
//  Copyright © 2019 meishubao.com. All rights reserved.
//

import UIKit
import Kingfisher

private let kOneMB: Double = 1024 * 1024

protocol AICompatible : AnyObject {}

extension AICompatible {
    public var ai: AIWrapper<Self> {
        return AIWrapper(self)
    }
    
    static var ai: AIWrapper<Self>.Type {
        return AIWrapper<Self>.self
    }
}

struct AIWrapper<Base> {
    public let base: Base
    static var baseType: Base.Type {
        return Base.self
    }
    public init(_ base: Base) {
        self.base = base
    }
}

extension UIImageView: AICompatible {}
extension UIButton: AICompatible {}

extension AIWrapper where Base: UIImageView {
    func setImage(imgUrl: String?, placeHolder: UIImage? = nil) {
        if let urlStr = imgUrl, let url = URL(string: urlStr) {
            self.base.kf.setImage(with: url, placeholder: placeHolder, options: [.transition(.fade(0.2))])
        }
    }
    
    static func imageViewTestFunc() {
        print(baseType)
    }
}

extension AIWrapper where Base: UIButton {
    func setImage(imgUrl: String?, state: UIControl.State = .normal, placeHolder: UIImage? = nil) {
        if let urlStr = imgUrl, let url = URL(string: urlStr) {
            self.base.kf.setImage(with: url, for: state, placeholder: placeHolder, options: [.transition(.fade(0.2))])
        }
    }
}

struct AIKingfisherDownLoadResult {
    var imgDic: [String: UIImage]?
    func imgWith(urlStr: String) -> UIImage {
        if let dic = self.imgDic, let img = dic[urlStr] {
            return img
        }
        return UIImage()
    }
}

typealias AIKingfisherDownLoadResultBlock = (AIKingfisherDownLoadResult?) -> ()

class AIKingfisher {
    static func downloadWith(urlStr: String, complete: ((UIImage?) -> ())? = nil) {
        if let url = URL(string: urlStr) {
            KingfisherManager.shared.retrieveImage(with: url) { (result) in
                switch result {
                case .success(let imgResult):
                    complete?(imgResult.image)
                case .failure(let error):
                    print(error)
                    complete?(nil)
                }
            }
        } else {
            complete?(nil)
        }
    }
    
    static func downloadWith(urlStrArray: [String], complete: @escaping AIKingfisherDownLoadResultBlock) {
        let group = DispatchGroup()
        let queue = DispatchQueue.main
        var imgDic = [String: UIImage]()
        var downLoadCount = 0
        var block: AIKingfisherDownLoadResultBlock? = complete
        for urlStr in urlStrArray {
            group.enter()
            queue.async(group: group) {
                AIKingfisher.downloadWith(urlStr: urlStr) { (image) in
                    if let img = image {
                        imgDic.updateValue(img, forKey: urlStr)
                        downLoadCount = downLoadCount + 1
                    } else { //有一个下载失败就提前终止
                        block?(nil)
                        block = nil
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: queue) {
            if downLoadCount != urlStrArray.count {
                block?(nil)
            } else {
                block?(AIKingfisherDownLoadResult(imgDic: imgDic))
            }
        }
    }
    
    static func cacheSize(complete: @escaping (_ size: String) -> ()) {
        KingfisherManager.shared.cache.calculateDiskStorageSize { (result) in
            switch result {
            case .success(let size):
                print("缓存大小为：\(size)byte")
                let s = max(Double(size) / kOneMB, 0.0)
                let sizeStr = String(format: "%.1fMB", s)
                complete(sizeStr)
            case .failure(let error):
                print(error.errorDescription ?? "获取缓存失败")
            }
        }
    }
    
    static func clearCache(complete: @escaping (_ isSuccess: Bool) -> ()) {
        KingfisherManager.shared.cache.clearMemoryCache()
        KingfisherManager.shared.cache.clearDiskCache {
            print("缓存已清除")
            complete(true)
        }
    }
}
