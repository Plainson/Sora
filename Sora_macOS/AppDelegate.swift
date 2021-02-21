//
//  AppDelegate.swift
//  Sora_macOS
//
//  Created by Grass Plainson on 2021/2/21.
//  Copyright © 2021 Grass Plainson. All rights reserved.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        while SORAConstant.iCloudUrl == nil {
            SORAConstant.iCloudUrl = FileManager.default.url(forUbiquityContainerIdentifier: nil)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

