//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

struct TradingInfoResponse: Decodable {
  var open: Decimal
  var close: Decimal
  var high: Decimal
  var low: Decimal
  var volume: Int

  init(from pDecoder: Decoder) throws {
    let lContainer = try pDecoder.container(keyedBy: _CodingKey.self)
    let lOpenString = try lContainer.decode(String.self, forKey: .open)
    open = NSNumber(value: Double(lOpenString) ?? 0).decimalValue
    let lCloseString = try lContainer.decode(String.self, forKey: .close)
    close = NSNumber(value: Double(lCloseString) ?? 0).decimalValue
    let lHighString = try lContainer.decode(String.self, forKey: .high)
    high = NSNumber(value: Double(lHighString) ?? 0).decimalValue
    let lLowString = try lContainer.decode(String.self, forKey: .low)
    low = NSNumber(value: Double(lLowString) ?? 0).decimalValue
    let lVolumeString = try lContainer.decode(String.self, forKey: .volume)
    volume = Int(lVolumeString) ?? 0
  }

  private enum _CodingKey: String, CodingKey {
    case open = "1. open"
    case close = "4. close"
    case low = "3. low"
    case high = "2. high"
    case volume = "5. volume"
  }
}
