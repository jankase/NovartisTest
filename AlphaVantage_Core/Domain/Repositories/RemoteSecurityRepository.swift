//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public protocol RemoteSecurityRepository {
  func getRemoteSecurities(symbolCode: String?, completionHandler: @escaping SecurityCompletionHandler)
  func getRemoteWeeklyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler)
  func getRemoteMonthlyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler)
}
