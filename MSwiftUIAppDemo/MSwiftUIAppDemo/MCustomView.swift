//
//  MCustomView.swift
//  MSwiftUIAppDemo
//
//  Created by maliang on 2020/10/17.
//

import UIKit
import SwiftUI

class MCustomView: UIControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        backgroundColor = .red
        
        addTarget(self, action: #selector(clickSelf), for: .touchUpInside)
    }
    
    @objc func clickSelf() {
        print("MCustomView click")
    }
}

struct MSCustomView: UIViewRepresentable {
    func makeUIView(context: Context) -> MCustomView {
        return MCustomView()
    }
    
    func updateUIView(_ uiView: MCustomView, context: Context) {
        
    }
    
    typealias UIViewType = MCustomView
}

struct MSCustomView_Previews: PreviewProvider {
    static var previews: MSCustomView {
        MSCustomView()
    }
    
    typealias Previews = MSCustomView
}
