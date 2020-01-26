//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation

public class GetSecurityImpl: GetSecurity {
  public init(repository pRepository: RemoteSecurityRepository) {
    _repository = pRepository
  }

  public func getSecurities(symbolCode pSymbolCode: String,
                            completionHandler pCompletionHandler: @escaping (Result<[Security], Error>) -> Void) {
    _repository.getRemoteSecurities(symbolCode: pSymbolCode, completionHandler: pCompletionHandler)
  }

  public func getTradingInfo(symbolCode pSymbolCode: String,
                             completionHandler pCompletionHandler: @escaping (Result<[TradingInfo], Error>) -> Void) {
    _repository.getRemoteTradingInfo(symbolCode: pSymbolCode, completionHandler: pCompletionHandler)
  }

  private var _repository: RemoteSecurityRepository
}
