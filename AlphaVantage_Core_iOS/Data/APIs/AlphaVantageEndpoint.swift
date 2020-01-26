//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Alamofire
import AlphaVantage_Core
import Foundation

enum AlphaVantageEndpoint: URLConvertible {
  case search(Environment, String)
  case detail(Environment, String)

  func asURL() throws -> URL {
    var lUrlString: String
    switch self {
    case let .search(pEnvironment, pSymbol):
      lUrlString = "\(pEnvironment.baseAddress)?function=SYMBOL_SEARCH&apikey=\(pEnvironment.apiKey)&keywords=\(pSymbol)"
    case let .detail(pEnvironment, pSymbol):
      lUrlString = "\(pEnvironment.baseAddress)?function=TIME_SERIES_WEEKLY&apikey=\(pEnvironment.apiKey)&symbol=\(pSymbol)"
    }
    return URL(string: lUrlString)!
  }
}
