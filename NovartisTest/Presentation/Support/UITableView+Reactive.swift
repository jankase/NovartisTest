//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

extension ReactiveExtensions where Base: UITableView {
  var detailDisclosureTapped: SafeSignal<IndexPath> {
    //swiftlint:disable:next trailing_closure
    delegate.signal(
        for: #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:)),
        dispatch: { (pSubject: PassthroughSubject<IndexPath, Never>, _: UITableView, pIndexPath: IndexPath) in
          pSubject.send(pIndexPath)
        })
  }

  var selectedIndexPath: SafeSignal<IndexPath> {
    //swiftlint:disable:next trailing_closure
    delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:)),
                    dispatch: { (pSubject: PassthroughSubject<IndexPath, Never>, _: UITableView, pIndexPath: IndexPath) in
                      pSubject.send(pIndexPath)
                    })
  }

  var deselectedIndexPath: SafeSignal<IndexPath> {
    //swiftlint:disable:next trailing_closure
    delegate.signal(for: #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:)),
                    dispatch: { (pSubject: PassthroughSubject<IndexPath, Never>, _: UITableView, pIndexPath: IndexPath) in
                      pSubject.send(pIndexPath)
                    })
  }

  var selectedIndexPaths: SafeSignal<[IndexPath]> {
    merge(selectedIndexPath, deselectedIndexPath).map { _ in
      self.base.indexPathsForSelectedRows ?? []
    }
  }

  var numberOfSelectedRow: SafeSignal<Int> {
    selectedIndexPaths.map { $0.count }
  }
}
