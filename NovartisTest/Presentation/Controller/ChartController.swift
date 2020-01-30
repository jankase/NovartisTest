//
// Created by Jan Kase on 28/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Bond
import Charts
import ReactiveKit
import SnapKit
import UIKit

class ChartController: UIViewController {
  init(model pModel: YearlyChartModel) {
    _model = pModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("Not supported")
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    _observeErrorMessage()
  }

  override func loadView() {
    view = UIView(frame: .zero)
    view.backgroundColor = .appBackgroundColor
    let lChart = CandleStickChartView()
    view.addSubview(lChart)
    lChart.snp.makeConstraints {
      $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
    }
    _chartView = lChart
    _observeChartData()
    switch UIDevice.current.orientation {
    case .portrait, .portraitUpsideDown:
      UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    default: ()
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ChartController.attemptRotationToDeviceOrientation()
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    UIDevice.current.userInterfaceIdiom == .phone ? .landscape : .allButUpsideDown
  }

  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    UIDevice.current.userInterfaceIdiom == .phone ? .landscapeLeft : .portrait
  }

  private var _model: YearlyChartModel
  private var _bag: DisposeBag = .init()
  private weak var _chartView: CandleStickChartView?

  private func _observeChartData() {
    _model.reactive.chartData
        .observeNext { [weak self] pChartData in
          self?._chartView?.data = pChartData
        }
        .dispose(in: _bag)
  }

  private func _observeErrorMessage() {
    _model.reactive.errorMessage.receive(on: DispatchQueue.main).observeNext {
      let lAlert = UIAlertController(title: nil, message: $0, preferredStyle: .alert)
      lAlert.addAction(.init(title: "OK", style: .default))
      self.present(lAlert, animated: true)
    }.dispose(in: _bag)
  }
}
