//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

class SearchCellModel: Comparable {
  var title: String?
  var subtitle: String?
  var symbol: String

  init(security pSecurity: Security) {
    title = pSecurity.name
    subtitle = pSecurity.symbol
    symbol = pSecurity.symbol
    _score = pSecurity.score
  }

  private var _score: Double

  static func < (lhs: SearchCellModel, rhs: SearchCellModel) -> Bool {
    lhs._score < rhs._score
  }

  static func == (lhs: SearchCellModel, rhs: SearchCellModel) -> Bool {
    lhs._score == rhs._score
  }
}
