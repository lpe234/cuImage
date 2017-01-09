//
//  AppDelegate.swift
//  cuImage
//
//  Created by HuLizhen on 03/01/2017.
//  Copyright © 2017 HuLizhen. All rights reserved.
//

import Cocoa

// MARK: - AppDelegate
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    let statusItemController = StatusItemController.shared
    let uploadController = UploadController.shared
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        addObservers()
    }
}

// MARK: - Observers
extension AppDelegate {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else { return }
        guard let key = PreferenceKeys(rawValue: keyPath) else { return }
        
        switch key {
        case PreferenceKeys.launchAtLogin:
            launchAtLogin(preferences[.launchAtLogin])
        case PreferenceKeys.keepWindowsOnTop:
            keepWindowsOnTop(preferences[.keepWindowsOnTop])
        default:
            print("Observe value for key path: \(keyPath)")
        }
    }
    
    fileprivate func addObservers() {
        let defaults = UserDefaults.standard
        
        defaults.addObserver(self, forKeyPath: PreferenceKeys.launchAtLogin.rawValue,
                             options: [.initial, .new], context: nil)
        defaults.addObserver(self, forKeyPath: PreferenceKeys.keepWindowsOnTop.rawValue,
                             options: [.initial, .new], context: nil)
    }
}
