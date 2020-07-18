//
//  AIRefreshHeader.swift
//  MRxSwiftDemo
//
//  Created by mal on 2020/7/7.
//  Copyright © 2020 mal. All rights reserved.
//

import UIKit

private let kMinPercent: CGFloat = 0.1
private let kMaxPercent: CGFloat = 1.0

class AIRefreshHeader: MJRefreshGifHeader {
    private static var refreshImages: [UIImage] = {
        var images = [UIImage]()
        let defaultImage = UIImage()
        for i in 0...24 {
            let fileName = "下拉刷新_000" + String(format: "%02d", i)
            if let filePath = Bundle.main.path(forResource: fileName, ofType: "png") {
                let image = UIImage(contentsOfFile: filePath)
                images.append(image ?? defaultImage)
            }
        }
        return images
    }()
    
    lazy var zoomImageView: UIImageView = {
        let im = UIImageView()
        im.image = UIImage(named: "下拉刷新_00000")
        return im
    }()
    
    override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
        let images = AIRefreshHeader.refreshImages
        setImages(images, duration: Double(images.count) * 0.025, for: .refreshing)
        addSubview(zoomImageView)
        updateZoomImageViewWith(percent: 0.0)
    }
    
    override var pullingPercent: CGFloat {
        didSet {
            updateZoomImageViewWith(percent: pullingPercent)
        }
    }
    
    private func updateZoomImageViewWith(percent: CGFloat) {
        var p = max(kMinPercent, percent)
        p = min(percent, kMaxPercent)
        if let view = gifView {
            let wh = view.mj_h * p
            zoomImageView.frame.size = CGSize(width: wh, height: wh)
            zoomImageView.center = view.center
            print(wh)
        }
    }
}
