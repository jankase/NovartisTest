//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import UIKit

extension UIColor {
  static let appBackgroundColor: UIColor = {
    if #available(iOS 13, *) {
      return .systemBackground
    } else {
      return .white
    }
  }()
  static let secondaryText: UIColor = {
    if #available(iOS 13, *) {
      return .secondaryLabel
    } else {
      return .lightGray
    }
  }()
}
