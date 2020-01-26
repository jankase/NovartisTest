//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public typealias SecurityCompletionHandler = (Result<[Security], Error>) -> Void
public typealias TradingInfoCompletionHandler = (Result<[TradingInfo], Error>) -> Void

public protocol GetSecurity {
  func getSecurities(symbolCode: String, completionHandler: @escaping SecurityCompletionHandler)
  func getTradingInfo(symbolCode: String, completionHandler: @escaping TradingInfoCompletionHandler)
}
