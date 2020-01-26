//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public protocol Environment {
  var baseAddress: String { get }
  var apiKey: String { get set }
}
