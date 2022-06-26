//
//  UserContentsDataSourceTests.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 25/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import XCTest
@testable import Assignment
class UserContentsDataSourceTests: XCTestCase {
    var dataSource: UserContentsDataSource!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
          dataSource = UserContentsDataSource()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        dataSource = nil
        super.tearDown()
    }
    func testEmptyValueInDataSource() {
        dataSource.data.value = []
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        tableView.dataSource = dataSource
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 0), 0, "Expected no cell in table view")
    }

    func testValueInDataSource() {
        let responseResults: [UserContentsModel] = DummyData().getDatalist()
        dataSource.data.value = responseResults
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        tableView.dataSource = dataSource
     tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: Constants.Constant.CellIdentifier)
        XCTAssertEqual(dataSource.numberOfSections(in: tableView), 1, "Expected one section in table view")
        XCTAssertEqual(dataSource.tableView(tableView, numberOfRowsInSection: 14), responseResults.count, "Expected responseResults.count cell in table view")
    }

    func testValueCell() {
        dataSource.data.value = DummyData().getDatalist()
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        tableView.dataSource = dataSource
      tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: Constants.Constant.CellIdentifier)
        let indexPath = IndexPath(row: 0, section: 0)
        guard let _ = dataSource.tableView(tableView, cellForRowAt: indexPath)as? ContentTableViewCell else {
            XCTAssert(false, "Expected tableViewCell class")
            return
        }
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
