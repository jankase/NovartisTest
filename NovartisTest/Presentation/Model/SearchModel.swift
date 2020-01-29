//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import AlphaVantage_Core_iOS
import Foundation
import ReactiveKit

class SearchModel: ReactiveExtensionsProvider {
  var searchUseCase: GetSecurity
  var errorMessageSubject: PassthroughSubject<String, Never> = .init()
  var cellsInfo: Property<[SearchCellModel]> = .init([])
  var selectedSymbols: [String] = []

  init(searchUseCase pSearchUseCase: GetSecurity) {
    searchUseCase = pSearchUseCase
  }

  func handleSearch(text pText: String?) {
    guard let lSymbolCode = pText else {
      cellsInfo.send([])
      return
    }
    searchUseCase.getSecurities(symbolCode: lSymbolCode) { [weak self] pSecurityResult in
      guard let lSelf = self else { return }
      switch pSecurityResult {
      case .success(let lSecurities):
        lSelf.cellsInfo.send(lSecurities.map { SearchCellModel(security: $0) })
      case .failure(let lError):
        lSelf.errorMessageSubject.send("Failed to download security info from net: \(lError.localizedDescription)")
      }
    }
  }

  func handleDetailDisclosureTapped(indexPath pIndexPath: IndexPath) {
    let lSymbol = cellsInfo.value[pIndexPath.row].symbol
    Router.shared.showDetail(symbol: lSymbol)
  }
}
