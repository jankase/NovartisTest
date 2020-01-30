//
// Created by Jan Kase on 30/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

@testable import AlphaVantage_Core
import Foundation

struct TradingInfoDummy: TradingInfo {
  private(set) var date: Date = .init()
  private(set) var open: Decimal = .init(0)
  private(set) var close: Decimal = .init(0)
  private(set) var low: Decimal = .init(0)
  private(set) var high: Decimal = .init(0)
  private(set) var volume: Int = 0
}

struct TradingInfoFake: TradingInfo {
  static let tradingInfo1 = TradingInfoFake(date: Date(), open: .init(15), close: .init(20), low: .init(12), high: .init(21), volume: 2000)
  static let tradingInfo2 = TradingInfoFake(date: Calendar.current.date(byAdding: .init(day: -7), to: Date())!,
                                            open: .init(10),
                                            close: .init(15),
                                            low: .init(8),
                                            high: .init(35),
                                            volume: 2000)
  static let tradingInfo3 = TradingInfoFake(date: Calendar.current.date(byAdding: .init(day: -14), to: Date())!,
                                            open: .init(10),
                                            close: .init(15),
                                            low: .init(8),
                                            high: .init(35),
                                            volume: 2000)

  private(set) var date: Date
  private(set) var open: Decimal
  private(set) var close: Decimal
  private(set) var low: Decimal
  private(set) var high: Decimal
  private(set) var volume: Int
}

class TradingInfoSpy: TradingInfo {
  var dateInvoked: Bool = false
  var openInvoked: Bool = false
  var closeInvoked: Bool = false
  var lowInvoked: Bool = false
  var highInvoked: Bool = false
  var volumeInvoked: Bool = false

  var date: Date {
    dateInvoked = true
    return Date()
  }
  var open: Decimal {
    openInvoked = true
    return Decimal(0)
  }
  var close: Decimal {
    closeInvoked = true
    return Decimal(0)
  }
  var low: Decimal {
    lowInvoked = true
    return Decimal(0)
  }
  var high: Decimal {
    highInvoked = true
    return Decimal(0)
  }
  var volume: Int {
    volumeInvoked = true
    return 0
  }
}
