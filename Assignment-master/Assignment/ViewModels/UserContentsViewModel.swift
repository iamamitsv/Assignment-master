//
//  UserContentsViewModel.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import Foundation

class UserContentsViewModel: UserContentsViewModelProtocol {
    //Input
    private var service: UserContentsServiceProtocol?
    weak var dataSource: GenericDataSource<UserContentsModel>?

    //Output
    var cellDidSelect: GenericDataSource<Int>?
    var title: Dynamic<String>
    var selectedData: UserContentsModel?

    init(withService service: UserContentsServiceProtocol, withDataSource dataSource: GenericDataSource<UserContentsModel>?) {
        self.dataSource = dataSource
        self.service = service
        self.title = Dynamic("")
    }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)? = nil) {

        guard let service = service else {
            completion?(Result.failure(ErrorResult.custom(string: Constants.Messages.MissingService)))
            return
        }
        service.fetchFeeds { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let converter) :
                    if
                        let rows = converter.rows,
                        let title = converter.title
                    {
                        self.dataSource?.data.value = rows
                        self.title.value = title
                        completion?(Result.success(true))
                    } else {
                        completion?(Result.failure(.custom(string: Constants.Messages.ParsingErrorMessage)))
                    }

                    break
                case .failure(let error) :
                    completion?(Result.failure(error))
                    break
                }
            }
        }
    }

    func didSelectItemAt(indexPath: IndexPath) {
        let feedsValue = dataSource?.data.value[indexPath.row]
        selectedData = feedsValue
    }

}

protocol UserContentsViewModelProtocol {
    var title: Dynamic<String> { get }
    var selectedData: UserContentsModel? { get set }

    func fetchServiceCall(_ completion: ((Result<Bool, ErrorResult>) -> Void)?)
    func didSelectItemAt(indexPath: IndexPath)
}

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}
