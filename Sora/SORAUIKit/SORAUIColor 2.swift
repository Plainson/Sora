//
//  SORAUIColor.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/27.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAUIColor: UIColor {
    
    // MARK: - View.
    
    static var defaultBackgroundViewColor: UIColor {
        return UIColor.init { (traitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return UIColor.init(white: 0.0, alpha: 1.0)
            } else {
                return UIColor.init(white: 255.0, alpha: 1.0)
            }
        }
    }

    // MARK: - Font.
    
    struct Font {
        static let `default`: UIColor = .label
    }
    
}
