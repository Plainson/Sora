//
//  SORAUIViewController.swift
//  Sora
//
//  Created by Grass Plainson on 2020/7/27.
//  Copyright © 2020 Grass Plainson. All rights reserved.
//

import UIKit

class SORAUIViewController: UIViewController {
    
    // MARK: - Property.
    
    // MARK: Safe area layout guide.
    
    var viewSafeAreaLayoutGuideX: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.origin.x
    }
    
    var viewSafeAreaLayoutGuideY: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.origin.y
    }
    
    var viewSafeAreaLayoutGuideWidth: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.size.width
    }
    
    var viewSafeAreaLayoutGuideHeight: CGFloat {
        return self.view.safeAreaLayoutGuide.layoutFrame.size.height
    }
    
    // MARK: - UIViewController.

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = SORAUIColor.defaultBackgroundViewColor
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - deinit.
    
    deinit {
        print("\(NSStringFromClass(self.classForCoder)) 已释放。")
        NotificationCenter.default.removeObserver(self)
    }

}
