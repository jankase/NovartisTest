//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct EnvironmentImpl: Environment {
  static let current: Environment = EnvironmentImpl(baseAddress: "https://www.alphavantage.co//query", apiKey: "A63A9SQPLT9MK0DK")

  private(set) var baseAddress: String
  var apiKey: String

  private init(baseAddress pBaseAddress: String, apiKey pApiKey: String) {
    baseAddress = pBaseAddress
    apiKey = pApiKey
  }
}
