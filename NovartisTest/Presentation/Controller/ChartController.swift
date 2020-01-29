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

  override func loadView() {
    let lChart = LineChartView()
    view.addSubview(lChart)
    lChart.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }

  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    UIDevice.current.userInterfaceIdiom == .phone ? .landscape : .allButUpsideDown
  }

  override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    UIDevice.current.userInterfaceIdiom == .phone ? .landscapeLeft : .portrait
  }

  private var _model: YearlyChartModel
}
