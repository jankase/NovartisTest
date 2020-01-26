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
  }
}
