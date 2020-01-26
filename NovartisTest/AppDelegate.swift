//
//  AppDelegate.swift
//  NovartisTest
//
//  Created by Jan Kase on 22/01/2020.
//  Copyright © 2020 Jan Kaše. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = .init(frame: UIScreen.main.bounds)
    window?.rootViewController = Router.shared.rootViewController()
    window?.makeKeyAndVisible()
    return true
  }
}
