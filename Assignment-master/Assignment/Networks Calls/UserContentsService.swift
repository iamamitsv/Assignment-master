//
//  UserContentsService.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation

class UserContentsService: RequestHandler, UserContentsServiceProtocol {
    let endpoint = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    var task: URLSessionTask?

    func fetchFeeds(_ completion: @escaping ((Result<ContentFeedModel, ErrorResult>) -> Void)) {
        self.cancelFetchFeeds()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }

    func cancelFetchFeeds() {
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

protocol UserContentsServiceProtocol {
    func fetchFeeds(_ completion: @escaping ((Result<ContentFeedModel, ErrorResult>) -> Void))
}
