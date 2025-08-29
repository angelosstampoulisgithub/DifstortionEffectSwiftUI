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

    func applyDistortion(to inputImage: UIImage, center: CGPoint? = nil) -> UIImage? {
        guard let ciImage = CIImage(image: inputImage) else { return nil }

        filter.inputImage = ciImage
        filter.radius = 300
        filter.scale = 0.5
        filter.center = center ?? CGPoint(x: ciImage.extent.size.width / 2,
                                          y: ciImage.extent.size.height / 2)

        guard let outputImage = filter.outputImage,
              let cgimg = context.createCGImage(outputImage, from: ciImage.extent) else {
            return nil
        }

        return UIImage(cgImage: cgimg)
    }
}
