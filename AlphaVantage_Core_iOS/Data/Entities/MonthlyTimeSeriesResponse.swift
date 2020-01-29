//
// Created by Jan Kase on 27/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct MonthlyTimeSeriesResponse: Decodable {
  var timeSeries: [TradingInfo]

  init(from pDecoder: Decoder) throws {
    let lContainer = try pDecoder.container(keyedBy: _CodingKey.self)
    let lResponseTimeSeries = try lContainer.decode([String: TradingInfoResponse].self, forKey: .timeSeries)
    timeSeries = lResponseTimeSeries.compactMap { pDateString, pTradingInfoResponse -> TradingInfo? in
      guard let lDate = MonthlyTimeSeriesResponse._dateFormatter.date(from: pDateString) else { return nil }
      return TradingInfoImpl(serverResponse: pTradingInfoResponse, date: lDate)
    }
  }

  private enum _CodingKey: String, CodingKey {
    case timeSeries = "Monthly Time Series"
  }

  private static var _dateFormatter: DateFormatter = {
    let lResult = DateFormatter()
    lResult.dateFormat = "YYYY-MM-dd"
    return lResult
  }()
}
