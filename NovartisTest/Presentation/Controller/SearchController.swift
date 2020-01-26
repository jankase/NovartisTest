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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
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
    _model.reactive.cells.bind(to: lTableView, createCell: _createCell)
    lTableView.reactive.detailDisclosureTapped.observeNext(with: _model.handleDetailDisclosureTapped).dispose(in: _bag)
    _tableView = lTableView
  }

  private var _model: SearchModel
  private weak var _tableView: UITableView?
  private weak var _searchBar: UISearchBar?
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
