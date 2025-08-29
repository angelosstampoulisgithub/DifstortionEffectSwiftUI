//
//  ContentView.swift
//  DistortionEffectSwiftUI
//
//  Created by Angelos Staboulis on 29/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject  var  process = ImageProcess()
    @State private var time: Float = 0.0
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            ZStack{
                VStack{
                    Text("Distortion Effect")
                }.frame(maxWidth: .infinity,maxHeight: 25,alignment:.top)
            }
            if let uiImage = process.applyDistortion(time: time) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            
        }.onReceive(timer) { _ in
            time += 0.1
        }
        
    }
}
