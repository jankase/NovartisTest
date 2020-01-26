//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public protocol TradingInfo {
  var date: Date { get }
  var open: Decimal { get }
  var close: Decimal { get }
  var low: Decimal { get }
  var high: Decimal { get }
  var volume: Int { get }
}
