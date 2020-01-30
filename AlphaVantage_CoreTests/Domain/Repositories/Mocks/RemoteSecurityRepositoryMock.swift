//
// Created by Jan Kase on 30/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

@testable import AlphaVantage_Core
import Foundation

class RemoteSecurityRepositoryDummy: RemoteSecurityRepository {
  func getRemoteSecurities(symbolCode: String?, completionHandler: @escaping SecurityCompletionHandler) {
  }

  func getRemoteWeeklyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
  }

  func getRemoteMonthlyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
  }
}

class RemoteSecurityRepositoryFake: RemoteSecurityRepository {
  func getRemoteSecurities(symbolCode: String?, completionHandler: @escaping SecurityCompletionHandler) {
    completionHandler(_securities)
  }

  func getRemoteWeeklyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
    completionHandler(_weeklyTradingInfo)
  }

  func getRemoteMonthlyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
    completionHandler(_monthlyTradingInfo)
  }

  init(securities pSecurities: Result<[Security], Error>,
       weeklyTradingInfo pWeekly: Result<[TradingInfo], Error>,
       monthlyTradingInfo pMonthly: Result<[TradingInfo], Error>) {
    _securities = pSecurities
    _weeklyTradingInfo = pWeekly
    _monthlyTradingInfo = pMonthly
  }

  private var _securities: Result<[Security], Error>
  private var _weeklyTradingInfo: Result<[TradingInfo], Error>
  private var _monthlyTradingInfo: Result<[TradingInfo], Error>
}

class RemoteSecurityRepositorySpy: RemoteSecurityRepository {
  var getRemoteSecuritiesInvoked: Bool = false
  var getRemoteWeeklyTradingInfo: Bool = false
  var getRemoteMonthlyTradingInfo: Bool = false

  func getRemoteSecurities(symbolCode: String?, completionHandler: @escaping SecurityCompletionHandler) {
    getRemoteSecuritiesInvoked = true
  }

  func getRemoteWeeklyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
    getRemoteWeeklyTradingInfo = true
  }

  func getRemoteMonthlyTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler) {
    getRemoteMonthlyTradingInfo = true
  }
}
