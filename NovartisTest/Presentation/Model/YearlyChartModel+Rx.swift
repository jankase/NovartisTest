//
// Created by Jan Kase on 28/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Charts
import Foundation
import ReactiveKit

extension ReactiveExtensions where Base: YearlyChartModel {
  var monthlyInfoDownloaded: SafeSignal<(String, [TradingInfo])> {
    base.monthlyInfoDownloaded.map { ($0, self.base.tradingInfos[$0]!) }
  }

  var chartDataSet: SafeSignal<CandleChartDataSet> {
    monthlyInfoDownloaded.map { self.base.createCandleChartDataSet(symbol: $0.0, tradingInfo: $0.1) }
  }

  var chartData: SafeSignal<CandleChartData> {
    chartDataSet
        .map { self.base.append(dataSet: $0) }
        .prepend(self.base.chartData)
  }

  func monthlyInfoDownloaded(for pSymbol: String) -> SafeSignal<[TradingInfo]> {
    base.monthlyInfoDownloaded.filter { $0 == pSymbol }.compactMap { self.base.tradingInfos[$0] }
  }
}
