//
//  SORAUIView.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/28.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = SORAUIColor.defaultBackgroundViewColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
