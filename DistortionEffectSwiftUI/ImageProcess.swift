//
//  ImageProcess.swift
//  DistortionEffectSwiftUI
//
//  Created by Angelos Staboulis on 29/8/25.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
class ImageProcess: ObservableObject {
    let context = CIContext()
    let filter = CIFilter.bumpDistortion()
    private var distortedImage: UIImage?
    
    func applyDistortion(time:Float) -> UIImage? {
        guard let inputImage = UIImage(named: "me"),
              let ciImage = CIImage(image: inputImage) else { return .me}

        let imageSize = ciImage.extent.size

        let centerX = imageSize.width / 2 + CGFloat(sin(time)) * (imageSize.width / 4)
        let centerY = imageSize.height / 2 + CGFloat(cos(time)) * (imageSize.height / 4)

        filter.inputImage = ciImage
        filter.center = CGPoint(x: centerX, y: centerY)
        filter.radius = 300
        filter.scale = 0.5

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: ciImage.extent) {
            distortedImage = UIImage(cgImage: cgImage)
        }
        return distortedImage
    }
}
