//
// Created by Jan Kase on 26/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import SnapKit
import UIKit

class TradingInfoCell: UITableViewCell {
  override init(style: CellStyle, reuseIdentifier: String?) {
    super.init(style: .default, reuseIdentifier: reuseIdentifier)
    _loadElements()
  }

  required init?(coder: NSCoder) {
    fatalError("Not supported")
  }

  func applyModel(_ pModel: WeeklyTradingInfoCellModel) {
    _dateContainer?.textLabel?.text = pModel.date
    _openContainer?.textLabel?.text = pModel.open
    _highContainer?.textLabel?.text = pModel.high
    _lowContainer?.textLabel?.text = pModel.low
    _closeContainer?.textLabel?.text = pModel.close
  }

  private func _loadElements() {
    if UIDevice.current.userInterfaceIdiom == .phone {
      _dateContainer = _addContainer(previousContainer: nil, isLast: true, secondLine: false, alignment: .left)
      _openContainer = _addContainer(previousContainer: nil, topView: _dateContainer)
      _highContainer = _addContainer(previousContainer: _openContainer, topView: _dateContainer)
      _lowContainer = _addContainer(previousContainer: _highContainer, topView: _dateContainer)
      _closeContainer = _addContainer(previousContainer: _lowContainer, topView: _dateContainer, isLast: true)
    } else {
      _dateContainer = _addContainer(previousContainer: nil, alignment: .left)
      _openContainer = _addContainer(previousContainer: _dateContainer)
      _highContainer = _addContainer(previousContainer: _openContainer)
      _lowContainer = _addContainer(previousContainer: _highContainer)
      _closeContainer = _addContainer(previousContainer: _lowContainer, isLast: true)
    }
  }

  private func _addContainer(previousContainer pPrevious: UIView?,
                             topView pTop: UIView? = nil,
                             isLast pIsLast: Bool = false,
                             secondLine pIsSecondLine: Bool = true,
                             alignment pAlignment: NSTextAlignment = .right) -> _TextContainer {
    let lResult = _TextContainer(alignment: pAlignment)
    contentView.addSubview(lResult)
    lResult.snp.makeConstraints {
      if let lPrevious = pPrevious {
        $0.leading.equalTo(lPrevious.snp.trailing)
        $0.width.equalTo(lPrevious.snp.width)
      } else {
        $0.leading.equalToSuperview().offset(10)
      }
      if let lTopView = pTop {
        $0.top.equalTo(lTopView.snp.bottom).offset(10)
        $0.height.equalTo(lTopView.snp.height)
      } else {
        $0.top.equalToSuperview().inset(10)
      }
      if pIsSecondLine {
        $0.bottom.equalToSuperview().inset(10)
      }
      if pIsLast {
        $0.trailing.equalToSuperview().inset(10)
      }
    }
    return lResult
  }

  private weak var _dateContainer: _TextContainer?
  private weak var _openContainer: _TextContainer?
  private weak var _highContainer: _TextContainer?
  private weak var _lowContainer: _TextContainer?
  private weak var _closeContainer: _TextContainer?
}

private class _TextContainer: UIView {
  weak var textLabel: UILabel?

  init(text pText: String? = nil, alignment pAlignment: NSTextAlignment = .natural) {
    super.init(frame: .zero)
    _loadTextLabel(text: pText, alignment: pAlignment)
  }

  required init?(coder: NSCoder) {
    fatalError("Not supported")
  }

  private func _loadTextLabel(text pText: String?, alignment pAlignment: NSTextAlignment) {
    let lLabel = UILabel()
    addSubview(lLabel)
    lLabel.text = pText
    lLabel.textAlignment = pAlignment
    textLabel = lLabel
    lLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(5)
      $0.centerY.equalToSuperview()
    }
  }
}
