//
//  AppDelegate.swift
//  TouchBarDisplayTest
//
//  Created by Adam Marcus on 15/12/2019.
//  Copyright © 2019 Adam Marcus. All rights reserved.
//

import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {
  
  /// Terminate application once last window closes
  func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
