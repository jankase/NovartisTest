//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core_iOS
import Foundation
import Swinject

class AppAssembler {
  static var shared: Assembler = .init([DataAssembly(), PresentationAssembly()])
}
