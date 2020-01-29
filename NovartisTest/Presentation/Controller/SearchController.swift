//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Bond
import ReactiveKit
import SnapKit
import UIKit

class SearchController: UIViewController {
  init(model pModel: SearchModel) {
    _model = pModel
    super.init(nibName: nil, bundle: nil)
    navigationItem.title = "Symbols"
  }

  required init?(coder: NSCoder) {
    fatalError("Not supported")
  }

  override func loadView() {
    view = UIView(frame: .zero)
    view.backgroundColor = .appBackgroundColor
    let lSearchBar = UISearchBar()
    lSearchBar.searchBarStyle = .prominent
    lSearchBar.placeholder = "Symbol name you are looking for"
    view.addSubview(lSearchBar)
    lSearchBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    _searchBar = lSearchBar
    lSearchBar.reactive.text.observeNext(with: _model.handleSearch).dispose(in: _bag)
    let lTableView = UITableView()
    lTableView.allowsMultipleSelection = true
    view.addSubview(lTableView)
    lTableView.snp.makeConstraints {
      $0.leading.equalToSuperview()
      $0.trailing.equalToSuperview()
      $0.top.equalTo(lSearchBar.snp.bottom)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    _tableView = lTableView
    let lChartButton = UIBarButtonItem(title: "Compare", style: .plain, target: nil, action: nil)
    lChartButton.isEnabled = false
    navigationItem.rightBarButtonItem = lChartButton
    _compareButton = lChartButton
    _setupObserver()
  }

  private func _setupObserver() {
    guard let lTableView = _tableView else { return }
    _model.reactive.cells.observeNext { [weak self] _ in self?._compareButton?.isEnabled = false }.dispose(in: _bag)
    _model.reactive.cells.bind(to: lTableView, createCell: _createCell)
    lTableView.reactive.detailDisclosureTapped
        .observeNext { [weak self] pIndexPath in
          self?._searchBar?.resignFirstResponder()
          DispatchQueue.main.async {
            self?._model.handleDetailDisclosureTapped(indexPath: pIndexPath)
          }
        }
        .dispose(in: _bag)
    lTableView.reactive
        .numberOfSelectedRow
        .observeNext { [weak self] pNumberOfRows in
          self?._compareButton?.isEnabled = pNumberOfRows == 2
        }
        .dispose(in: _bag)
    lTableView.reactive.selectedIndexPaths
        .map { [weak self] (pIndexPaths: [IndexPath]) -> [String] in
          guard let lSelf = self else { return [] }
          return pIndexPaths.map { lSelf._model.cellsInfo.value[$0.row].symbol }
        }
        .observeNext { [weak self] in
          self?._model.selectedSymbols = $0
        }
        .dispose(in: _bag)
    _compareButton?.reactive.tap
        .observeNext { [weak self] in
          Router.shared.showChart(symbols: self?._model.selectedSymbols ?? [])
        }
        .dispose(in: _bag)
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    .portrait
  }

  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    .portrait
  }
  private var _model: SearchModel
  private weak var _tableView: UITableView?
  private weak var _searchBar: UISearchBar?
  private weak var _compareButton: UIBarButtonItem?
  private var _bag: DisposeBag = .init()

  private func _createCell(dataSource pDataSource: [SearchCellModel],
                           indexPath pIndexPath: IndexPath,
                           tableView pTableView: UITableView) -> UITableViewCell {
    let lModel = pDataSource[pIndexPath.row]
    var lCell = pTableView.dequeueReusableCell(withIdentifier: "Cell")
    if lCell == nil {
      lCell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
    }
    lCell?.textLabel?.text = lModel.title
    lCell?.detailTextLabel?.text = lModel.subtitle
    lCell?.accessoryType = .detailButton
    return lCell!
  }
}
