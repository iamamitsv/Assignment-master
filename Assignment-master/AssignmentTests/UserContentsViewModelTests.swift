//
//  UserContentsViewModelTests.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 25/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import XCTest
@testable import Assignment

class UserContentsViewModelTests: XCTestCase {
    
    var viewModel: UserContentsViewModel!
      private var mockDataSource: GenericDataSource<UserContentsModel>!
      private var mockService: UserContentsServices!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.mockService = UserContentsServices()
        self.mockDataSource = GenericDataSource<UserContentsModel>()
        self.viewModel = UserContentsViewModel(withService: mockService, withDataSource: mockDataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
              self.mockDataSource = nil
              self.mockService = nil
              super.tearDown()
    }
    func testFetchFeeds() {
          mockService.data = ContentFeedModel(title: "Canada", rows: [])
          viewModel.fetchServiceCall { result in
              switch result {
              case .failure :
                  XCTAssert(false, "ViewModel should not be able to fetch without service")
              default: break
              }
          }
      }

      func testFetchNoFeeds() {
          mockService.data = nil
          viewModel.fetchServiceCall { result in
              switch result {
              case .success :
                  XCTAssert(false, "ViewModel should not be able to fetch ")
              default: break
              }
          }
      }

}
