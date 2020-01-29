//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation
import ReactiveKit

class SymbolWeeklyDetailModel: ReactiveExtensionsProvider {
  var symbol: String
  var tradingInfos: Property<[WeeklyTradingInfoCellModel]> = .init([])
  var errorMessageSubject: PassthroughSubject<String, Never> = .init()

  init(symbol pSymbol: String, useCase pUseCase: GetSecurity) {
    symbol = pSymbol
    _useCase = pUseCase
    _useCase.getWeeklyTradingInfo(symbolCode: pSymbol) { [weak self] pResult in
      guard let lSelf = self else { return }
      switch pResult {
      case .success(let lTradingInfo):
        lSelf.tradingInfos.send(lTradingInfo.sorted { $0.date > $1.date }.map { WeeklyTradingInfoCellModel(tradingInfo: $0) })
      case .failure(let lError):
        lSelf.tradingInfos.send([])
        lSelf.errorMessageSubject.send("Failed to download weekly data with error: \(lError.localizedDescription)")
      }
    }
  }

  private var _useCase: GetSecurity
}
