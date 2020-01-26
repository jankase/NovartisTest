//
// Created by Jan Kase on 25/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import AlphaVantage_Core
import Foundation

struct SearchResponse: Decodable {
  var matches: [Security]

  init(from pDecoder: Decoder) throws {
    let lContainer = try pDecoder.container(keyedBy: _DecodingKeys.self)
    matches = try lContainer.decode([SecurityImpl].self, forKey: .bestMatches)
  }

  private enum _DecodingKeys: String, CodingKey {
    case bestMatches
  }
}
