//
//  SORAImageCell.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/28.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAImageCell: UICollectionViewCell {
    
    // MARK: - Property.
    
    private var iconImageView: UIImageView!
    private var titleLabel: SORAUILabel!
    
    // MARK: - Init.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isSelected = false
        
        self.iconImageView = UIImageView.init()
        self.iconImageView.image = UIImage.init(named: "")
        self.iconImageView.contentMode = .scaleAspectFit
        self.iconImageView.layer.masksToBounds = true
        self.contentView.addSubview(self.iconImageView)
        self.iconImageView.mas_remakeConstraints { (view) in
            view!.left.equalTo()(self.contentView.mas_left)?.offset()
            view!.top.equalTo()(self.contentView.mas_top)?.offset()
            view!.right.equalTo()(self.contentView.mas_right)?.offset()
            view!.height.equalTo()(SORAConstant.ImageDisplayView.itemSizeImageHeight)
        }
        
        self.titleLabel = SORAUILabel.init()
        self.titleLabel.text = "title"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = SORAUIFont.default
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.mas_remakeConstraints { (view) in
            view!.left.equalTo()(self.contentView.mas_left)?.offset()(5)
            view!.top.equalTo()(self.iconImageView.mas_bottom)?.offset()(SORAConstant.ImageDisplayView.itemSizeEdgeForLabelAndImage)
            view!.right.equalTo()(self.contentView.mas_right)?.offset()
            view!.height.equalTo()(SORAConstant.ImageDisplayView.itemSizeLabelHeight)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI.
    
    func setIcon(icon: UIImage) {
        self.iconImageView.image = icon
    }
    
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
}
