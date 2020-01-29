//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation
import Swinject

class PresentationAssembly: Assembly {
  func assemble(container pContainer: Container) {
    pContainer
        .register(SearchModel.self) { pResolver in
          SearchModel(searchUseCase: pResolver.resolve(GetSecurity.self)!)
        }.inObjectScope(.container)
    pContainer
        .register(SearchController.self) { pResolver in
          SearchController(model: pResolver.resolve(SearchModel.self)!)
        }
        .inObjectScope(.transient)
    pContainer
        .register(SymbolWeeklyDetailModel.self) { (pResolver: Resolver, pSymbol: String) in
          SymbolWeeklyDetailModel(symbol: pSymbol, useCase: pResolver.resolve(GetSecurity.self)!)
        }
        .inObjectScope(.transient)
    pContainer
        .register(TradingInfoController.self) { (pResolver: Resolver, pSymbol: String) in
          TradingInfoController(model: pResolver.resolve(SymbolWeeklyDetailModel.self, argument: pSymbol)!)
        }
        .inObjectScope(.transient)
    pContainer
        .register(YearlyChartModel.self) { (pResolver: Resolver, pSymbols: [String]) in
          YearlyChartModel(symbols: pSymbols, useCase: pResolver.resolve(GetSecurity.self)!)
        }
        .inObjectScope(.transient)
  }
}
