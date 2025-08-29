//
//  ContentView.swift
//  DistortionEffectSwiftUI
//
//  Created by Angelos Staboulis on 29/8/25.
//

import SwiftUI

struct ContentView: View {
        @State private var distortedImage: UIImage?
        @State private var time: Double = 0.0

        let context = CIContext()
        let filter = CIFilter.bumpDistortion()
        let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            ZStack{
                VStack{
                    Text("Distortion Effect")
                }.frame(maxWidth: .infinity,maxHeight: 25,alignment:.top)
            }
                   if let uiImage = distortedImage {
                       Image(uiImage: uiImage)
                           .resizable()
                           .scaledToFit()
                           .frame(maxWidth: .infinity, maxHeight: .infinity)
                   } else {
                       Text("Loading image...")
                   }
               }
               .onAppear {
                   applyDistortion()
               }
               .onReceive(timer) { _ in
                   time += 0.1
                   applyDistortion()
               }
    }
    func applyDistortion() {
              guard let inputImage = UIImage(named: "me"),
                    let ciImage = CIImage(image: inputImage) else { return }

              let imageSize = ciImage.extent.size

              let centerX = imageSize.width / 2 + sin(time) * (imageSize.width / 4)
              let centerY = imageSize.height / 2 + cos(time) * (imageSize.height / 4)

              filter.inputImage = ciImage
              filter.center = CGPoint(x: centerX, y: centerY)
              filter.radius = 300
              filter.scale = 0.5

              if let outputImage = filter.outputImage,
                 let cgImage = context.createCGImage(outputImage, from: ciImage.extent) {
                  distortedImage = UIImage(cgImage: cgImage)
              }
    }
}

#Preview {
    ContentView()
}
