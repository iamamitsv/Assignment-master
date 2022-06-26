//
//  ContentFeedModel.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation

struct ContentFeedModel: Decodable {
    //MARK: Properties
    let title: String?
    let rows: [UserContentsModel]?
}

