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
    _dateContainer = _addContainer(previousContainer: nil, alignment: .left)
    _openContainer = _addContainer(previousContainer: _dateContainer)
    _highContainer = _addContainer(previousContainer: _openContainer)
    _lowContainer = _addContainer(previousContainer: _highContainer)
    _closeContainer = _addContainer(previousContainer: _lowContainer, isLast: true)
  }

  private func _addContainer(previousContainer pPrevious: UIView?,
                             isLast pIsLast: Bool = false,
                             alignment pAlignment: NSTextAlignment = .right) -> _TextContainer {
    let lResult = _TextContainer(alignment: pAlignment)
    contentView.addSubview(lResult)
    lResult.snp.makeConstraints {
      if let lPrevious = pPrevious {
        $0.leading.equalTo(lPrevious.snp.trailing)
        $0.width.equalTo(lPrevious.snp.width)
      } else {
        $0.leading.equalToSuperview().offset(5)
      }
      $0.top.bottom.equalToSuperview().inset(10)
      if pIsLast {
        $0.trailing.equalToSuperview().inset(5)
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
