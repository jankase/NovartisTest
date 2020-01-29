//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public class GetSecurityImpl: GetSecurity {
  public init(repository pRepository: RemoteSecurityRepository) {
    _repository = pRepository
  }

  public func getSecurities(symbolCode pSymbolCode: String, completionHandler pCompletionHandler: @escaping SecurityCompletionHandler) {
    _repository.getRemoteSecurities(symbolCode: pSymbolCode, completionHandler: pCompletionHandler)
  }

  public func getWeeklyTradingInfo(symbolCode pSymbolCode: String,
                                   completionHandler pCompletionHandler: @escaping TradingInfoCompletionHandler) {
    _repository.getRemoteWeeklyTradingInfo(symbolCode: pSymbolCode, completionHandler: pCompletionHandler)
  }

  public func getMonthlyTradingInfo(symbolCode pSymbolCode: String,
                                    completionHandler pCompletionHandler: @escaping TradingInfoCompletionHandler) {
    _repository.getRemoteMonthlyTradingInfo(symbolCode: pSymbolCode, completionHandler: pCompletionHandler)
  }

  private var _repository: RemoteSecurityRepository
}
