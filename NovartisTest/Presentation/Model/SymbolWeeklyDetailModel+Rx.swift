//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation
import ReactiveKit

extension ReactiveExtensions where Base: SymbolWeeklyDetailModel {
  var errorMessage: SafeSignal<String> {
    base.errorMessageSubject.toSignal()
  }
  var tradingInfos: SafeSignal<[WeeklyTradingInfoCellModel]> {
    base.tradingInfos.toSignal()
  }
}
