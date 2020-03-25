//
//  NSTouchBar+Private.swift
//  Touch Bar Display Test
//
//  Created by Adam Marcus on 24/03/2020.
//  Copyright © 2020 Adam Marcus. All rights reserved.
//

import Cocoa

@objc protocol NSTouchBarPrivateProtocol {
  @available(macOS 10.14, *)
  @objc optional static func presentSystemModalTouchBar(
    _ touchBar: NSTouchBar,
    placement: UInt64,
    systemTrayItemIdentifier identifier: NSTouchBarItem.Identifier?
  )
}

extension NSTouchBar: NSTouchBarPrivateProtocol {}

let NSTouchBarClass: NSTouchBar.Type! = NSClassFromString("NSTouchBar") as? NSTouchBar.Type
let NSTouchBarPrivate: NSTouchBarPrivateProtocol.Type = NSTouchBarClass
