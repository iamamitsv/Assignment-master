//
//  ParsingHelper.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation

protocol Parsing {
    static func parseObject(data: Data) -> Result<Self, ErrorResult>
}

final class ParsingHelper {
    static func parse<T: Parsing>(data: Data, completion: (Result<[T], ErrorResult>) -> Void) {
        switch T.parseObject(data: data) {
        case .failure(let error):
            completion(.failure(error))
            break
        case .success(let newModel):
            completion(.success([newModel]))
            break
        }
    }

    static func parse<T: Parsing>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {

        if
            let response = String(data: data, encoding: String.Encoding.ascii),
            let data = response.data(using: String.Encoding.utf8)
        {
            switch T.parseObject(data: data) {
            case .failure(let error):
                completion(.failure(error))
                break
            case .success(let newModel):
                completion(.success(newModel))
                break
            }
        } else {
            completion(.failure(.parser(string: Constants.Messages.ParsingErrorMessage)))
        }
    }
}

protocol UserContentServiceProtocol {
    func fetchFeeds(_ completion: @escaping ((Result<ContentFeedModel, ErrorResult>) -> Void))
}
