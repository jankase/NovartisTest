//
// Created by Jan Kase on 22/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public protocol Security {
  var symbol: String { get set }
  var name: String { get set }
  var currencyCode: String { get set }
  var score: Double { get set }
}
