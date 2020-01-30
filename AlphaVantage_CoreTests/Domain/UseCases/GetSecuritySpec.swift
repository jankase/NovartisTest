//
// Created by Jan Kase on 30/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

@testable import AlphaVantage_Core
import Foundation
import Nimble
import Quick

class GetSecuritySpec: QuickSpec {
  override func spec() {
    describe("given get security use case") {
      //swiftlint:disable:next implicitly_unwrapped_optional
      var lUseCase: GetSecurity!
      beforeEach {
        let lRepository = RemoteSecurityRepositoryFake(securities: .success([SecurityFake.aas, SecurityFake.apple]),
                                                       weeklyTradingInfo: .success([TradingInfoFake.tradingInfo1,
                                                                                    TradingInfoFake.tradingInfo2,
                                                                                    TradingInfoFake.tradingInfo3]),
                                                       monthlyTradingInfo: .success([TradingInfoFake.tradingInfo1,
                                                                                     TradingInfoFake.tradingInfo2]))
        lUseCase = GetSecurityImpl(repository: lRepository)
      }
      it("then get securities return success with 2 items") {
        waitUntil { pDone in
          lUseCase.getSecurities(symbolCode: "AA") { pResult in
            switch pResult {
            case .success(let lSecurity):
              expect(lSecurity.count).to(be(2))
            case .failure:
              fail("Expected success")
            }
            pDone()
          }
        }
      }
      it("then get weekly trading info success with 3 items") {
        waitUntil { pDone in
          lUseCase.getWeeklyTradingInfo(symbolCode: "AA") { pResult in
            switch pResult {
            case .success(let lTradingInfo):
              expect(lTradingInfo.count).to(be(3))
            case .failure:
              fail("Expected success")
            }
            pDone()
          }
        }
      }
      it("then get monthly trading info success with 2 items") {
        waitUntil { pDone in
          lUseCase.getMonthlyTradingInfo(symbolCode: "AA") { pResult in
            switch pResult {
            case .success(let lTradingInfo):
              expect(lTradingInfo.count).to(be(2))
            case .failure:
              fail("Expected success")
            }
            pDone()
          }
        }
      }
    }
  }
}
