//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct TradingInfoImpl: TradingInfo {
  private(set) var date: Date
  private(set) var open: Decimal
  private(set) var close: Decimal
  private(set) var low: Decimal
  private(set) var high: Decimal
  private(set) var volume: Int

  init(serverResponse pServerResponse: TradingInfoResponse, date pDate: Date) {
    date = pDate
    open = pServerResponse.open
    close = pServerResponse.close
    low = pServerResponse.low
    high = pServerResponse.high
    volume = pServerResponse.volume
  }
}
