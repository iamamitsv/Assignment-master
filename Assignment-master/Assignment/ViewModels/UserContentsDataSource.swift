//
//  UserContentsDataSource.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation
import UIKit
typealias CompletionHandler = (() -> Void)
class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class UserContentsDataSource: GenericDataSource<UserContentsModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let reachability = Reachability(), !reachability.isReachable {
            return 0
        }
         return data.value.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Constant.CellIdentifier, for: indexPath) as! ContentTableViewCell
        cell.selectionStyle = .none
         let feedsValue = self.data.value[indexPath.row]
         cell.feedsValue = feedsValue
         guard let imageUrl = feedsValue.imageHref else {
             return cell
         }
         // Image caching and lazy loading
       ImageHelper().updateImageForTableViewCell(cell, inTableView: tableView, imageURL: imageUrl, atIndexPath: indexPath)
         return cell
     }
}


class DynamicValue<T> {
    var value: T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()
    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value() })
    }

    deinit {
        observers.removeAll()
    }
}
