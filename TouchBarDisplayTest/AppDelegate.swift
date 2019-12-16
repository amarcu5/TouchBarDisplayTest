//
//  AppDelegate.swift
//  TouchBarDisplayTest
//
//  Created by Adam Marcus on 15/12/2019.
//  Copyright © 2019 Adam Marcus. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  
}

