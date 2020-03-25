//
//  ViewController.swift
//  TouchBarDisplayTest
//
//  Created by Adam Marcus on 15/12/2019.
//  Copyright © 2019 Adam Marcus. All rights reserved.
//

import Cocoa

/// Define's custom Touch Bar identifier
private extension NSTouchBarItem.Identifier {
  static let custom = NSTouchBarItem.Identifier("custom")
}

class ViewController: NSViewController, NSTouchBarDelegate {
  var customTouchBarItem: NSCustomTouchBarItem?
  
  @IBOutlet weak var popupButton: NSPopUpButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    // Create custom Touch Bar
    let touchBar = NSTouchBar()
    touchBar.delegate = self
    touchBar.defaultItemIdentifiers = [.custom]
    
    // Display custom Touch Bar using private API
    NSTouchBarPrivate.presentSystemModalTouchBar?(
      touchBar,
      placement: 1,
      systemTrayItemIdentifier: nil
    )
    
    // Populate menu with colors to cycle through and assign actions to update the view
    let colors = [
      ("Black", .black),
      ("White", .white),
      ("Red", .red),
      ("Green", .green),
      ("Blue", .blue),
      ("Gray (25%)", NSColor(white: 0.25, alpha: 1.0)),
      ("Gray (50%)", NSColor(white: 0.50, alpha: 1.0)),
      ("Gray (75%)", NSColor(white: 0.75, alpha: 1.0)),
    ]
    for (title, color) in colors {
      let menuItem = NSMenuItem(title: title, keyEquivalent: "") {
        self.customTouchBarItem?.view.layer?.backgroundColor = color.cgColor
      }
      popupButton.menu?.addItem(menuItem)
    }
  }
  
  /// Returns controls consisting of a single tappable view for the custom Touch Bar
  ///
  /// - Parameters:
  ///   - touchBar: The Touch Bar
  ///   - identifier: The Touch Bar identifier
  /// - Returns: The custom Touch bar controls
  func touchBar(
    _ touchBar: NSTouchBar,
    makeItemForIdentifier identifier: NSTouchBarItem.Identifier
  ) -> NSTouchBarItem? {

    guard identifier == .custom else { return nil }

    if customTouchBarItem == nil {
      customTouchBarItem = NSCustomTouchBarItem(identifier: identifier)
      customTouchBarItem?.view.wantsLayer = true

      let recognizer = NSClickGestureRecognizer(target: self, action: #selector(handleTap))
      recognizer.allowedTouchTypes = .direct
      customTouchBarItem?.view.addGestureRecognizer(recognizer)
    }
    
    return customTouchBarItem
  }
  
  /// Responds to Touch Bar taps by cycling through colors
  ///
  /// - Parameter sender: The NSGestureRecognizer responsible for the tap
  @objc func handleTap(_ sender: NSGestureRecognizer?) {
    guard let touchBarView = customTouchBarItem?.view,
          let point = sender?.location(in: touchBarView) else {
      return
    }
    
    // Move forwards or backwards if tapped right or left half of Touch Bar respectively
    let direction = point.x < touchBarView.bounds.width * 0.5 ? -1 : 1
    let newIndex = popupButton.indexOfSelectedItem + direction + popupButton.numberOfItems
    popupButton.menu?.performActionForItem(at: newIndex % popupButton.numberOfItems)
  }
}
