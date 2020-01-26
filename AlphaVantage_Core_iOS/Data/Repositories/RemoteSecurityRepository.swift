//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct RemoteSecurityRepositoryImpl: RemoteSecurityRepository {
  init(api: AlphaVantageAPI) {
    _api = api
  }

  func getRemoteSecurities(symbolCode pSymbolCode: String?, completionHandler pCompletionHandler: @escaping SecurityCompletionHandler) {
    _api.searchSymbol(pSymbolCode, completion: pCompletionHandler)
  }

  func getRemoteTradingInfo(symbolCode pSymbolCode: String, completionHandler pCompletionHandler: @escaping TradingInfoCompletionHandler) {
    _api.getSymbolDetail(pSymbolCode, completion: pCompletionHandler)
  }

  private var _api: AlphaVantageAPI
}
