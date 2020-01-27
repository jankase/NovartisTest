//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct WeeklyTimeSeriesResponse: Decodable {
  var timeSeries: [TradingInfo]

  init(from pDecoder: Decoder) throws {
    let lContainer = try pDecoder.container(keyedBy: _CodingKeys.self)
    let responseTimeSeries = try lContainer.decode([String: TradingInfoResponse].self, forKey: .timeSeries)
    timeSeries = responseTimeSeries.compactMap { pDateString, pTradingInfoResponse -> TradingInfo? in
      guard let lDate = WeeklyTimeSeriesResponse._dateFormatter.date(from: pDateString) else { return nil }
      return TradingInfoImpl(serverResponse: pTradingInfoResponse, date: lDate)
    }
  }

  private enum _CodingKeys: String, CodingKey {
    case timeSeries = "Weekly Time Series"
  }

  private static var _dateFormatter: DateFormatter = {
    let lResult = DateFormatter()
    lResult.dateFormat = "YYYY-MM-dd"
    return lResult
  }()
}
