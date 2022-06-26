//
//  ContentFeedModelTests.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 25/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import XCTest
@testable import Assignment
class ContentFeedModelTests: XCTestCase {
    func testEmptyFeedsResult() {
           let data = Data()
           let completion: ((Result<ContentFeedModel, ErrorResult>) -> Void) = { result in
               switch result {
               case .success:
                   XCTAssert(false, "Expected failure when no data")
               default:
                   break
               }
           }
           ParsingHelper.parse(data: data, completion: completion)
       }

       func testParseFeedsResult() {
           let data = DummyData().getUserContentsData()
           let completion: ((Result<ContentFeedModel, ErrorResult>) -> Void) = { result in
               switch result {
               case .failure:
                   XCTAssert(false, "Expected valid FeedsModel")
               case .success(let response):
                   XCTAssertEqual(response.title, "About Canada", "Expected About Canada base")
                   if let list = response.rows {
                       XCTAssertEqual(list.count, 14, "Expected 14 rates")

                   } else {
                       XCTAssert(false, "Expected valid ListModel")
                   }
               }
           }
        ParsingHelper.parse(data: data, completion: completion)
       }

       func testWrongKeyFeedsResult() {
           let data = Data()
           let result = ContentFeedModel.parseObject(data: data)
           switch result {
           case .success:
               XCTAssert(false, "Expected failure when wrong data")
           default:
               return
           }
       }

}
