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
  var cellsSubject: Subject<[SearchCellModel], Never> = .init()

  init(searchUseCase pSearchUseCase: GetSecurity) {
    searchUseCase = pSearchUseCase
  }

  func handleSearch(text pText: String?) {
    guard let lSymbolCode = pText else {
      cellsSubject.send([])
      return
    }
    searchUseCase.getSecurities(symbolCode: lSymbolCode) { [weak self] pSecurityResult in
      guard let lSelf = self else { return }
      switch pSecurityResult {
      case .success(let lSecurities):
        lSelf.cellsSubject.send(lSecurities.map { SearchCellModel(security: $0) })
      case .failure(let lError):
        lSelf.errorMessageSubject.send("Failed to download security info from net: \(lError.localizedDescription)")
      }
    }
  }
}
