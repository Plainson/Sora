//
//  SORAFilesViewController.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/28.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAFilesViewController: SORAUIViewController {
    
    // MARK: - Property.
    
    // MARK: Data.
    
    var path: String = ""
    
    // MARK: View.
    
    private var imageDisplayView: SORAImageDisplayView!
    private var activityIndicatorView: SORAUIActivityIndicatorView?

    // MARK: - UIViewController.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.title
        if self.title == nil {
            self.navigationItem.title = internationalization(text: "浏览")
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // MARK: Image display view.
        
        self.imageDisplayView = SORAImageDisplayView.init(frame: self.view.frame)
        self.view.addSubview(self.imageDisplayView)
        self.imageDisplayView.imageCollectionDidSelectItemHandle = { [weak self] (indexPath) in
            if self!.imageDisplayView.contentsOfPaths[indexPath.row].isImage() {
                let image: UIImage = UIImage.init(contentsOfFile: self!.imageDisplayView.contentsOfPaths[indexPath.row].path)!
                let viewerViewController: SORAPictureViewerViewController = SORAPictureViewerViewController.init()
                viewerViewController.image = image
                viewerViewController.modalPresentationStyle = .formSheet
                self!.present(viewerViewController, animated: true, completion: nil)
            } else {
                let filesViewController: SORAFilesViewController = SORAFilesViewController.init()
                filesViewController.title = self!.imageDisplayView.contentsOfPaths[indexPath.row].lastPathComponent
                filesViewController.path = self!.imageDisplayView.contentsOfPaths[indexPath.row].path
                self!.navigationController?.pushViewController(filesViewController, animated: true)
            }
        }
        
        // MARK: Data init.
        
        // - 加载进度条。
        
        self.activityIndicatorView = SORAUIActivityIndicatorView.init()
        self.activityIndicatorView!.style = .medium
        self.view.addSubview(self.activityIndicatorView!)
        self.activityIndicatorView!.mas_makeConstraints({ (view) in
            view!.centerX.equalTo()(self.view.mas_centerX)
            view!.centerY.equalTo()(self.view.mas_centerY)
            view!.width.height()?.equalTo()(50)
        })
        self.activityIndicatorView!.startAnimating()
        
        // - 获取数据。
        
        DispatchQueue.global().async {
            do {
                if self.path == "" {
                    self.path = SORAConstant.iCloudDocumentUrl!.path
                }
                self.imageDisplayView.contentsOfPaths = try FileManager.default.contentsOfDirectory(at: URL.init(fileURLWithPath: self.path), includingPropertiesForKeys: nil, options: .init())
            } catch {
                print(error.localizedDescription)
            }
            
            var image: UIImage = UIImage.init()
            var prefetch: Bool = false
            if self.imageDisplayView.contentsOfPaths.count > 20 {
                for i in 0..<20 {
                    let url: URL = self.imageDisplayView.contentsOfPaths[i]
                    if url.isImage() {
                        image = downsample(imageAt: url, to: SORAConstant.thumbSize, scale: 1.0)
                    } else {
                        image = UIImage.init(systemName: "folder.fill")!
                    }
                    prefetch = true
                    self.imageDisplayView.images.append((image, prefetch))
                }
                let tuples: Array<(image: UIImage, prefetch: Bool)> = Array<(image: UIImage, prefetch: Bool)>.init(repeating: (UIImage.init(systemName: "folder.fill")!, false), count: self.imageDisplayView.contentsOfPaths.count - 20)
                self.imageDisplayView.images.append(contentsOf: tuples)
            } else {
                for i in 0..<self.imageDisplayView.contentsOfPaths.count {
                    let url: URL = self.imageDisplayView.contentsOfPaths[i]
                    if url.isImage() {
                        image = downsample(imageAt: self.imageDisplayView.contentsOfPaths[i], to: SORAConstant.thumbSize, scale: 1.0)
                    } else {
                        image = UIImage.init(systemName: "folder.fill")!
                    }
                    prefetch = true
                    self.imageDisplayView.images.append((image, prefetch))
                }
            }
            DispatchQueue.main.async {
                self.imageDisplayView.imageCollectionView.reloadData()
                self.activityIndicatorView?.stopAnimating()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Extension URL.

extension URL {
    
    func isImage() -> Bool {
        if self.path.contains(".png") || self.path.contains(".jpg") || self.path.contains(".jpeg") {
            return true
        } else {
            return false
        }
    }
}
