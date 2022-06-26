//
//  UserContentsServiceTests.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 25/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import XCTest
@testable import Assignment
class UserContentsServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testCancelRequest() {
           let service: UserContentsService! = UserContentsService()
           service.fetchFeeds { (_) in
           }
           service.cancelFetchFeeds()
           XCTAssertNil(service.task, "Expected task nil")
       }

}
