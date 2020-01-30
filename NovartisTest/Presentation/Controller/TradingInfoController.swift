//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Bond
import ReactiveKit
import UIKit

class TradingInfoController: UIViewController {
  init(model pModel: SymbolWeeklyDetailModel) {
    _model = pModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("Not supported")
  }

  override func loadView() {
    view = UIView()
    view.backgroundColor = .appBackgroundColor
    navigationItem.title = _model.symbol
    let lTableView = UITableView()
    view.addSubview(lTableView)
    lTableView.snp.makeConstraints {
      $0.trailing.leading.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
    _tableView = lTableView
    _model.reactive.tradingInfos.bind(to: lTableView, cellType: TradingInfoCell.self, configureCell: _setupCell)
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .allButUpsideDown
  }

  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .portrait
  }

  private var _model: SymbolWeeklyDetailModel
  weak private var _tableView: UITableView?
  private var _bag: DisposeBag = .init()

  private func _setupCell(cell pCell: TradingInfoCell, tradingInfo pTradingInfo: WeeklyTradingInfoCellModel) {
    pCell.applyModel(pTradingInfo)
  }

  private func _observeErrorMessage() {
    _model.reactive.errorMessage.receive(on: DispatchQueue.main).observeNext {
      let lAlert = UIAlertController(title: nil, message: $0, preferredStyle: .alert)
      lAlert.addAction(.init(title: "OK", style: .default))
      self.present(lAlert, animated: true)
    }.dispose(in: _bag)
  }
}
