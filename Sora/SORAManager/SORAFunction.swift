//
//  SORAFunction.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/29.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Internationalization.

func internationalization(text: String) -> String {
    return text
}

// MARK: - 降采样。

func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
    
    var returnImage: UIImage = UIImage.init()
    let byAccessor: ((URL) -> Void) = { url in
        // 生成 CGImageSourceRef 时，不需要先解码。
        let imageSourceOptions: CFDictionary = [kCGImageSourceShouldCache: false] as CFDictionary
        let imageSource: CGImageSource = CGImageSourceCreateWithURL(url as CFURL, imageSourceOptions)!
        let maxDimensionInPixels: CGFloat = max(pointSize.width, pointSize.height) * scale
        
        // kCGImageSourceShouldCacheImmediately
        // 在创建 Thumbnail 时直接解码，这样就把解码的时机控制在这个 downsample 的函数内。
        let downSampleOptions: CFDictionary = [kCGImageSourceCreateThumbnailFromImageAlways: true,
                                               kCGImageSourceShouldCacheImmediately: true,
                                               kCGImageSourceCreateThumbnailWithTransform: true,
                                               kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
        let downsampledImage: CGImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSampleOptions)!
        returnImage = UIImage.init(cgImage: downsampledImage)
    }
    
    byAccessor(imageURL)
    
    return returnImage
}

// MARK: - Clear trash.

func clearTrash() {
    let documentsPath: String = SORAConstant.iCloudDocumentUrl!.path
    let trashPath: String = documentsPath.appending("/.Trash/")
    if FileManager.default.fileExists(atPath: trashPath) {
        do {
            try FileManager.default.removeItem(atPath: trashPath)
        } catch {
            print(error.localizedDescription)
        }
    }
}
