//
// Created by Jan Kase on 24/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import Alamofire
import Foundation

extension DataRequest {
  @discardableResult
  func responseObject<T: Decodable>(type: T.Type, completion pCompletion: @escaping (Swift.Result<T?, Error>) -> Void) -> Self {
    responseData { pResponse in
      switch pResponse.result {
      case .failure(let lError):
        pCompletion(.failure(lError))
      case .success(let lData) where !lData.isEmpty:
        do {
          let lResult = try JSONDecoder().decode(T.self, from: lData)
          pCompletion(.success(lResult))
        } catch let lError {
          pCompletion(.failure(lError))
        }
      case .success:
        pCompletion(.success(nil))
      }
    }
  }
}
