//
//  SORAImageDisplayView.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/28.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAImageDisplayView: SORAUIView {
    
    // MARK: - Property.
    
    // MARK: Data.
    
    var contentsOfPaths: Array<URL> = Array<URL>.init() {
        didSet {
            self.contentsOfPaths.sort { (url1, url2) -> Bool in
                return url1.path < url2.path
            }
        }
    }
    var images: Array<(image: UIImage, prefetch: Bool)> = Array<(image: UIImage, prefetch: Bool)>.init()
    
    // MARK: View.
    
    var imageCollectionView: SORAUICollectionView!
    
    // MARK: Operation.
    
    var imageCollectionDidSelectItemHandle: ((_ indexPath: IndexPath) -> (Void))?

    // MARK: - Init.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        self.imageCollectionView = SORAUICollectionView.init(frame: self.frame, collectionViewLayout: flowLayout)
        flowLayout.itemSize = CGSize.init(width: SORAConstant.ImageDisplayView.itemSizeWidth, height: SORAConstant.ImageDisplayView.itemSizeHeight)
        flowLayout.minimumLineSpacing = SORAConstant.ImageDisplayView.minLineSpace
        flowLayout.sectionInset.top = SORAConstant.ImageDisplayView.itemTopEdge
        flowLayout.sectionInset.left = SORAConstant.ImageDisplayView.itemLeftEdge
        flowLayout.sectionInset.right = SORAConstant.ImageDisplayView.itemRightEdge
        flowLayout.sectionInset.bottom = SORAConstant.ImageDisplayView.itemBottomEdge
        self.imageCollectionView.register(SORAImageCell.self, forCellWithReuseIdentifier: "Cell")
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        self.imageCollectionView.prefetchDataSource = self
        self.addSubview(self.imageCollectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate.

extension SORAImageDisplayView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource.
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SORAImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SORAImageCell
        let url: URL = self.contentsOfPaths[indexPath.row]
        if url.isImage() {
            let name: String = url.lastPathComponent.components(separatedBy: ".").first!
            cell.setTitle(title: name)
        } else {
            let pathName: String = url.lastPathComponent
            cell.setTitle(title: pathName)
        }
        cell.setIcon(icon: self.images[indexPath.row].image)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate.
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.imageCollectionDidSelectItemHandle?(indexPath)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching.

extension SORAImageDisplayView: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        DispatchQueue.global().async {
            for indexPath in indexPaths {
                if self.images[indexPath.row].prefetch == false {
                    let url: URL = self.contentsOfPaths[indexPath.row]
                    if FileManager.default.fileExists(atPath: url.path) && url.isImage() {
                        let image: UIImage = downsample(imageAt: url, to: SORAConstant.thumbSize, scale: 1.0)
                        self.images[indexPath.row].image = image
                    }
                }
            }
            DispatchQueue.main.async {
                var reloadItems: Array<IndexPath> = Array<IndexPath>.init()
                for indexPath in indexPaths {
                    if self.images[indexPath.row].prefetch == false {
                        reloadItems.append(indexPath)
                        self.images[indexPath.row].prefetch = true
                    }
                }
                if reloadItems.count != 0 {
                    self.imageCollectionView.reloadItems(at: reloadItems)
                }
            }
        }
    }
}
