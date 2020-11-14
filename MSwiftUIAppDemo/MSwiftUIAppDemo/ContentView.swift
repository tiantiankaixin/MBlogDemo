//
//  ContentView.swift
//  MSwiftUIAppDemo
//
//  Created by maliang on 2020/10/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                MSCustomView()
                    .frame(width: 100, height: 100)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


