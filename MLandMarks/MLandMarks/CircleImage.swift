//
//  CircleImage.swift
//  MLandMarks
//
//  Created by mal on 2019/11/6.
//  Copyright © 2019 mal. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image.init("timg")
            .frame(width: 200, height: 200, alignment: Alignment.center)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4)
                    .shadow(radius: 10)
        )
    }
}


