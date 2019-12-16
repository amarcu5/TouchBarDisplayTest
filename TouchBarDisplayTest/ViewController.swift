//
//  ViewController.swift
//  TouchBarDisplayTest
//
//  Created by Adam Marcus on 15/12/2019.
//  Copyright © 2019 Adam Marcus. All rights reserved.
//

import Cocoa

extension NSTouchBarItem.Identifier {
  static let custom = NSTouchBarItem.Identifier("custom")
}

class ViewController: NSViewController, NSTouchBarDelegate {

  let colors: [NSColor] = [
    .red,
    .blue,
    .green,
    .white,
    .black,
    .cyan,
    .magenta,
    .yellow,
    .gray,
  ]
  var colorIdx = 0
  
  var customTouchBarItem: NSCustomTouchBarItem?

  
  override func viewDidLoad() {
    super.viewDidLoad()

    let touchBar = NSTouchBar()
    touchBar.delegate = self
    touchBar.defaultItemIdentifiers = [.custom]

    DFRSystemModalShowsCloseBoxWhenFrontMost(false)
    NSTouchBar.presentSystemModalTouchBar(touchBar,
                                          placement: 1,
                                          systemTrayItemIdentifier: nil)
  }

  func touchBar(_ touchBar: NSTouchBar,
                makeItemForIdentifier identifier: NSTouchBarItem.Identifier)
    -> NSTouchBarItem? {

    guard identifier == .custom else {
      return nil
    }

    if customTouchBarItem == nil {
      customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
      customTouchBarItem?.view.wantsLayer = true

      Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
        let nextColor = self.colors[self.colorIdx].cgColor
        self.customTouchBarItem?.view.layer?.backgroundColor = nextColor
        
        self.colorIdx += 1
        if self.colorIdx >= self.colors.count {
          self.colorIdx = 0
        }
      }.fire()
    }
    
    return customTouchBarItem
  }
}

