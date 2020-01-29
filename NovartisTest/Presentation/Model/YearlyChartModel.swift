//
// Created by Jan Kase on 27/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Charts
import ReactiveKit
import UIKit

class YearlyChartModel: ReactiveExtensionsProvider {
  var symbols: [(String, UIColor)]
  var tradingInfos: [String: [TradingInfo]] = [:]
  var errorMessageSubject: PassthroughSubject<String, Never> = .init()
  var monthlyInfoDownloaded: PassthroughSubject<String, Never> = .init()
  var chartData: CandleChartData = .init()

  init?(symbols pSymbols: [String], useCase pUseCase: GetSecurity) {
    guard pSymbols.count == 2 else {
      return nil
    }
    symbols = Array(zip(pSymbols, [UIColor.red, UIColor.blue]))
    _useCase = pUseCase
    pSymbols.forEach { self._loadSymbol($0) }
  }

  func createCandleChartDataSet(symbol pSymbol: String, tradingInfo pTradingInfo: [TradingInfo]) -> CandleChartDataSet {
    let lSortedTradingInfo = pTradingInfo.sorted { $0.date > $1.date }
    let lChartEntries = lSortedTradingInfo.enumerated().map { pIndex, pTradingInfo in
      CandleChartDataEntry(x: Double(pIndex),
                           shadowH: (pTradingInfo.high as NSDecimalNumber).doubleValue,
                           shadowL: (pTradingInfo.low as NSDecimalNumber).doubleValue,
                           open: (pTradingInfo.open as NSDecimalNumber).doubleValue,
                           close: (pTradingInfo.close as NSDecimalNumber).doubleValue)
    }
    let lResult = CandleChartDataSet(entries: lChartEntries, label: pSymbol)
    lResult.colors = symbols.filter { $0.0 == pSymbol }.map { $0.1 }
    return lResult
  }

  func append(dataSet pDataSet: CandleChartDataSet) -> CandleChartData {
    chartData.dataSets.append(pDataSet)
    return chartData
  }

  private var _useCase: GetSecurity
  private var _bag: DisposeBag = .init()

  private func _loadSymbol(_ pSymbol: String) {
    _useCase.getMonthlyTradingInfo(symbolCode: pSymbol) { [weak self] pResult in
      guard let lSelf = self else { return }
      switch pResult {
      case .success(let lTradingInfos):
        lSelf.tradingInfos[pSymbol] = lTradingInfos
        lSelf.monthlyInfoDownloaded.send(pSymbol)
      case .failure(let lError):
        lSelf.errorMessageSubject.send("Failed to download weekly data with error: \(lError.localizedDescription)")
      }
    }
  }

}
