//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import UIKit
import Swinject

class Router {
  static var shared: Router = .init()

  var sharedResolver: Resolver

  init(resolver pResolver: Resolver = AppAssembler.shared.resolver) {
    sharedResolver = pResolver
  }

  func rootViewController() -> UIViewController {
    let lNavController = UINavigationController(rootViewController: sharedResolver.resolve(SearchController.self)!)
    return lNavController
  }
}
