//
// Created by Jan Kase on 30/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

@testable import AlphaVantage_Core
import Foundation

struct SecurityDummy: Security {
  var symbol: String = ""
  var name: String = ""
  var currencyCode: String = ""
  var score: Double = 0
}

struct SecurityFake: Security {
  static let apple = SecurityFake(symbol: "AAPL", name: "Apple", currencyCode: "USD", score: 1.0)
  static let aas = SecurityFake(symbol: "aas", name: "Auto Auto Sweden", currencyCode: "EURO", score: 0.8)

  var symbol: String
  var name: String
  var currencyCode: String
  var score: Double
}

class SecuritySpy: Security {
  var symbolGetInvoked: Bool = false
  var symbolSetInvoked: Bool = false
  var nameGetInvoked: Bool = false
  var nameSetInvoked: Bool = false
  var currencyCodeGetInvoked: Bool = false
  var currencyCodeSetInvoked: Bool = false
  var scoreGetInvoked: Bool = false
  var scoreSetInvoked: Bool = false

  var symbol: String {
    get {
      symbolGetInvoked = true
      return ""
    }
    set {
      symbolSetInvoked = true
      _ = newValue
    }
  }
  var name: String {
    get {
      nameGetInvoked = true
      return ""
    }
    set {
      nameSetInvoked = true
      _ = newValue
    }
  }
  var currencyCode: String {
    get {
      currencyCodeGetInvoked = true
      return ""
    }
    set {
      currencyCodeSetInvoked = true
      _ = newValue
    }
  }
  var score: Double {
    get {
      scoreGetInvoked = true
      return 0
    }
    set {
      scoreSetInvoked = true
      _ = newValue
    }
  }
}
