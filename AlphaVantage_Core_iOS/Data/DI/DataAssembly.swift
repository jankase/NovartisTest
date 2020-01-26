//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation
import Swinject

public class DataAssembly: Assembly {
  public init() {
  }

  public func assemble(container pContainer: Container) {
    pContainer.register(Environment.self) { _ in EnvironmentImpl.current }

    pContainer
        .register(RemoteSecurityRepository.self) { pResolver in
          let api = AlphaVantageAPI(environment: pResolver.resolve(Environment.self)!)
          return RemoteSecurityRepositoryImpl(api: api)
        }
        .inObjectScope(.container)

    pContainer
        .register(GetSecurity.self) { pResolver in
          GetSecurityImpl(repository: pResolver.resolve(RemoteSecurityRepository.self)!)
        }
        .inObjectScope(.transient)
  }
}
