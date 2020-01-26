//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Alamofire
import Foundation

extension DataRequest {
  enum LogOption {
    case debug, dump, mute
  }

  func log(option pLogOption: LogOption = .debug) -> Self {
    logRequest(option: pLogOption).logResponse(option: pLogOption)
  }

  func logRequest(option pLogOption: LogOption = .debug) -> Self {
    _log(option: pLogOption, subject: self)
    return self
  }

  func logResponse(option pLogOption: LogOption = .debug) -> Self {
    delegate.queue.addOperation {
      DataRequest._queue.async {
        guard let lResponse = self.response else {
          return
        }
        self._log(option: pLogOption, subject: lResponse)

        guard let lData = self.delegate.data, !lData.isEmpty else {
          return
        }
        self._prettyPrintResponseData(lData, logOption: pLogOption)
      }
    }
    return self
  }

  private static let _queue: DispatchQueue = .global(qos: .utility)

  private func _log(option pLogOption: LogOption, subject pSubject: Any) {
    switch pLogOption {
    case .mute: ()
    case .debug:
      if let lSubject = pSubject as? String {
        NSLog(lSubject)
      } else {
        NSLog(String(reflecting: pSubject))
      }
    case .dump:
      dump(pSubject)
    }
  }

  private func _prettyPrintResponseData(_ pData: Data, logOption pLogOption: LogOption) {
    guard let lJson = try? JSONSerialization.jsonObject(with: pData),
          let lPrettyPrintedData = try? JSONSerialization.data(withJSONObject: lJson, options: [.prettyPrinted]),
          let lJsonString = String(data: lPrettyPrintedData, encoding: .utf8) else {
      if let lSomeString = String(data: pData, encoding: .utf8) {
        _log(option: pLogOption, subject: lSomeString)
      } else {
        _log(option: pLogOption, subject: pData)
      }
      return
    }
    _log(option: pLogOption, subject: lJsonString)
  }
}
