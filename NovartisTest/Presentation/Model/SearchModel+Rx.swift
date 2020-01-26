//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Foundation
import ReactiveKit

extension ReactiveExtensions where Base: SearchModel {
  var errorMessage: SafeSignal<String> {
    base.errorMessageSubject.toSignal()
  }
  var cells: SafeSignal<[SearchCellModel]> {
    base.cellsSubject.toSignal()
  }
}
