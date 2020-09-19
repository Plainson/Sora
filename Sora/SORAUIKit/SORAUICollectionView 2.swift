//
//  SORAUICollectionView.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/28.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAUICollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = SORAUIColor.defaultBackgroundViewColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
