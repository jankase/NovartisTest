//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct WeeklyTradingInfoCellModel {
  var date: String
  var open: String
  var close: String
  var high: String
  var low: String

  init(tradingInfo pInfo: TradingInfo) {
    date = WeeklyTradingInfoCellModel._dateFormatter.string(from: pInfo.date)
    open = String(format: "%.02f", (pInfo.open as NSDecimalNumber).doubleValue)
    close = String(format: "%.02f", (pInfo.close as NSDecimalNumber).doubleValue)
    high = String(format: "%.02f", (pInfo.high as NSDecimalNumber).doubleValue)
    low = String(format: "%.02f", (pInfo.low as NSDecimalNumber).doubleValue)
  }

  private static var _dateFormatter: DateFormatter = {
    let lResult = DateFormatter()
    lResult.dateFormat = DateFormatter.dateFormat(fromTemplate: "dMY", options: 0, locale: Locale.current)
    return lResult
  }()

  private static var _numberFormatter: NumberFormatter = {
    let lResult = NumberFormatter()
    lResult.numberStyle = .decimal
    lResult.usesSignificantDigits = true
    lResult.minimumFractionDigits = 4
    lResult.maximumFractionDigits = 4
    return lResult
  }()
}
