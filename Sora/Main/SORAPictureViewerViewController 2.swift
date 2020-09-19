//
//  SORAPictureViewerViewController.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/27.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit
import Masonry

class SORAPictureViewerViewController: SORAUIViewController {
    
    // MARK: - Property.
    
    // MARK: Data.
    
    var image: UIImage!

    // MARK: View.
    
    private var imageView: UIImageView!
    
    // MARK: - UIViewController.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.imageView = UIImageView.init()
        self.imageView.image = self.image
        self.imageView.contentMode = .scaleAspectFit
        self.view.addSubview(self.imageView)
        self.imageView.mas_makeConstraints { (view) in
            view!.left.equalTo()(self.view.mas_safeAreaLayoutGuideLeft)?.offset()
            view!.right.equalTo()(self.view.mas_safeAreaLayoutGuideRight)?.offset()
            view!.top.equalTo()(self.view.mas_safeAreaLayoutGuideTop)?.offset()
            view!.bottom.equalTo()(self.view.mas_safeAreaLayoutGuideBottom)?.offset()
        }
    }
    
    // MARK: - 更改显示的图片。
    
    func changeImage(image: UIImage) {
        self.imageView.image = image
    }
}
