//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Alamofire
import AlphaVantage_Core
import Foundation

class AlphaVantageAPI {
  init(environment pEnvironment: Environment, sessionManager pSessionManager: SessionManager? = nil) {
    _environment = pEnvironment
    _sessionManager = pSessionManager ?? SessionManager.default
  }

  func searchSymbol(_ pSymbol: String?, completion pCompletion: @escaping SecurityCompletionHandler) {
    _searchRequest?.cancel()
    guard let lSymbol = pSymbol, !lSymbol.isEmpty else {
      pCompletion(.success([]))
      return
    }
    _searchRequest = _sessionManager.request(AlphaVantageEndpoint.search(_environment, lSymbol))
    _searchRequest?
        .validate(statusCode: 200..<300)
        .log()
        .responseObject(type: SearchResponse.self) { [weak self] pResult in
          switch pResult {
          case .success(let lResponse):
            guard let lResponse = lResponse else {
              pCompletion(.success([]))
              return
            }
            pCompletion(.success(lResponse.matches))
          case .failure(let lError):
            pCompletion(.failure(lError))
          }
          self?._searchRequest = nil
        }
  }

  func getWeeklyTradingInfo(symbol pSymbol: String, completion pCompletion: @escaping TradingInfoCompletionHandler) {
    _sessionManager.request(AlphaVantageEndpoint.weeklyTradingInfo(_environment, pSymbol))
        .validate(statusCode: 200..<300)
        .log()
        .responseObject(type: WeeklyTimeSeriesResponse.self) { pResult in
          switch pResult {
          case .success(let lTimeSeriesResponse):
            pCompletion(.success(lTimeSeriesResponse?.timeSeries ?? []))
          case .failure(let lError):
            pCompletion(.failure(lError))
          }
        }
  }

  func getMonthlyTradingInfo(symbol pSymbol: String, completion pCompletion: @escaping TradingInfoCompletionHandler) {
    _sessionManager.request(AlphaVantageEndpoint.monthlyTradingInfo(_environment, pSymbol))
        .validate(statusCode: 200..<300)
        .log()
        .responseObject(type: MonthlyTimeSeriesResponse.self) { pResult in
          switch pResult {
          case .success(let lTimeSeriesResponse):
            pCompletion(.success(lTimeSeriesResponse?.timeSeries ?? []))
          case .failure(let lError):
            pCompletion(.failure(lError))
          }
        }
  }

  private var _environment: Environment
  private var _sessionManager: SessionManager
  private var _searchRequest: DataRequest?
}
