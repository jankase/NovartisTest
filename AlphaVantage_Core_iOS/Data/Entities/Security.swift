//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct SecurityImpl: Security, Decodable {
  var symbol: String
  var name: String
  var currencyCode: String
  var score: Double

  init(from pDecoder: Decoder) throws {
    let lContainer = try pDecoder.container(keyedBy: _CodingKeys.self)
    symbol = try lContainer.decode(String.self, forKey: .symbol)
    name = try lContainer.decode(String.self, forKey: .name)
    currencyCode = try lContainer.decode(String.self, forKey: .currencyCode)
    let lStringScore = try lContainer.decode(String.self, forKey: .score)
    score = Double(lStringScore) ?? 0
  }

  private enum _CodingKeys: String, CodingKey {
    case symbol = "1. symbol"
    case name = "2. name"
    case currencyCode = "8. currency"
    case score = "9. matchScore"
  }
}
