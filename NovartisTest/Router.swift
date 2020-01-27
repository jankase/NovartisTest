//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Swinject
import UIKit

class Router {
  static var shared: Router = .init()

  var sharedResolver: Resolver

  init(resolver pResolver: Resolver = AppAssembler.shared.resolver) {
    sharedResolver = pResolver
  }

  func rootViewController() -> UIViewController {
    let lNavController = UINavigationController(rootViewController: sharedResolver.resolve(SearchController.self)!)
    _navigationController = lNavController
    return lNavController
  }

  func showDetail(symbol pSymbol: String) {
    _navigationController?.pushViewController(sharedResolver.resolve(TradingInfoController.self, argument: pSymbol)!, animated: true)
  }

  private var _navigationController: UINavigationController?
}
