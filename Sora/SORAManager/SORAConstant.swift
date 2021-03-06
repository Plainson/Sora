//
//  SORAConstant.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/22.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import Foundation
#if iOS || iPadOS
import UIKit
#elseif macOS
import Cocoa
#endif

class SORAConstant {
    
    static var iCloudUrl: URL?
    
    static var iCloudDocumentUrl: URL? {
        if let iCloudUrl = self.iCloudUrl {
            return iCloudUrl.appendingPathComponent("Documents")
        } else {
            return nil
        }
    }
    
    static var screenWidth: CGFloat {
        #if iOS || iPadOS
        return UIScreen.main.bounds.width
        #elseif macOS
        return 0.0
        #endif
    }
    
    static var screenHeight: CGFloat {
        #if iOS || iPadOS
        return UIScreen.main.bounds.height
        #elseif macOS
        return 0.0
        #endif
    }
    
    static var thumbSize: CGSize = CGSize.init(width: SORAConstant.ImageDisplayView.itemSizeWidth * 2, height: SORAConstant.ImageDisplayView.itemSizeHeight * 2)
    
    struct ImageDisplayView {
        static let itemSizeWidth: CGFloat = 90
        static let itemSizeImageHeight: CGFloat = 70
        static let itemSizeLabelHeight: CGFloat = 20
        
        static let itemSizeEdgeForLabelAndImage: CGFloat = 3
        static let itemSizeHeight: CGFloat = SORAConstant.ImageDisplayView.itemSizeImageHeight + SORAConstant.ImageDisplayView.itemSizeLabelHeight + SORAConstant.ImageDisplayView.itemSizeEdgeForLabelAndImage
        
        static var minLineSpace: CGFloat = 20
        static let itemTopEdge: CGFloat = 10
        static let itemLeftEdge: CGFloat = 20
        static let itemRightEdge: CGFloat = 20
        static let itemBottomEdge: CGFloat = 10
    }
}
