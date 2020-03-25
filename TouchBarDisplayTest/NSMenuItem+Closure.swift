//
//  NSMenuItem+Closure.swift
//  Touch Bar Display Test
//
//  Created by Adam Marcus on 24/03/2020.
//  Copyright © 2020 Adam Marcus. All rights reserved.
//

import Cocoa

private var actionKey: Void?

extension NSMenuItem {
  private var _action: () -> () {
    get {
      objc_getAssociatedObject(self, &actionKey) as! () -> ()
    }
    set {
      objc_setAssociatedObject(
        self,
        &actionKey,
        newValue,
        objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }

  convenience init(
    title string: String,
    keyEquivalent charCode: String,
    action: @escaping () -> ()
  ) {
    self.init(title: string, action: #selector(pressed), keyEquivalent: charCode)
    self.target = self
    self._action = action
  }

  @objc private func pressed(sender: NSMenuItem) {
    _action()
  }
}
