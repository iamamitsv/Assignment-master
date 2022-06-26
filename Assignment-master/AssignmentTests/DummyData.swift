//
//  DummyData.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import XCTest
@testable import Assignment

class DummyData {

    func getUserContentsData() -> Data {
        guard let data = self.readJson(forResource: "UserContents") else {
            XCTAssert(false, "Can't get data from UserContents.json")
            return Data()
        }
        return data
    }

    func getData() -> ContentFeedModel {
        var responseResults: ContentFeedModel!
        guard let data = self.readJson(forResource: "UserContents") else {
            XCTAssert(false, "Can't get data from UserContents.json")
            return ContentFeedModel(title: "test Title", rows: nil)
        }
        let completion: ((Result<ContentFeedModel, ErrorResult>) -> Void) = { result in
            switch result {
            case .failure:
                XCTAssert(false, "Expected valid converter")
            case .success(let result):
                responseResults = result
                break
            }
        }
        ParsingHelper.parse(data: data, completion: completion)
        return responseResults
    }

    func getDatalist() -> [UserContentsModel] {
        guard let list = getData().rows else {
            return [UserContentsModel(title: "title", description: "description", imageHref: "imageHref")]
        }
        return list
    }
}

extension DummyData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTFail("unable to read json")
            return nil
        }
    }
}

