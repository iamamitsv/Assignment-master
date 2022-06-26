//
//  UserContentsServices.swift
//  AssignmentTests
//
//  Created by Amit Srivastava on 25/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation
@testable import Assignment

class UserContentsServices: UserContentsServiceProtocol {
    var data: ContentFeedModel?
    func fetchFeeds(_ completion: @escaping ((Result<ContentFeedModel, ErrorResult>) -> Void)) {
        if let data = data {
            completion(Result.success(data))
        } else {
            completion(Result.failure(ErrorResult.custom(string: "No converter")))
        }
    }
}
