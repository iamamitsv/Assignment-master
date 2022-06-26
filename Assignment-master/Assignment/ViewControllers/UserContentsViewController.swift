//
//  UserContentsViewController.swift
//  Assignment
//
//  Created by Amit Srivastava on 24/06/22.
//  Copyright © 2022 Amit Srivastava. All rights reserved.
//

import UIKit


class UserContentsViewController: UIViewController {
    var tableView: UITableView!
    let loaderView = LoaderViewController()
    private let refreshControl = UIRefreshControl()
    fileprivate var service: UserContentsService! = UserContentsService()
    let dataSource = UserContentsDataSource()
    lazy var viewModel: UserContentsViewModelProtocol = {
        let viewModel = UserContentsViewModel(withService: service, withDataSource: dataSource)
        return viewModel
    }()
    func setupUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ContentTableViewCell.self, forCellReuseIdentifier: Constants.Constant.CellIdentifier)
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.dataSource = self.dataSource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
        self.setupUIRefreshControl()
        self.serviceCall()
    }
    
    func setupViewModel() {
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            self?.tableView.reloadData()
        }
        self.viewModel.title.bindAndFire({ [weak self] in
            self?.title = $0
        })
    }
    
    //MARK:- Setup Refresh control
    func setupUIRefreshControl() {
        refreshControl.addTarget(self, action: #selector(serviceCall), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    @objc func serviceCall() {
        let reachability = Reachability()
        if (reachability!.isReachable) {
            DispatchQueue.main.async {
                self.showLoader()
                self.viewModel.fetchServiceCall { result in
                    switch result {
                    case .success :
                        break
                    case .failure :
                        break
                    }
                    self.hideLoader()
                }
            }
           refreshControl.endRefreshing()
        }
        else{
            self.checkNetworkAvailability()
        }
    }
    //MARK:- Show Loader
    func showLoader() {
        // add the loader view controller
        addChild(loaderView)
        loaderView.view.frame = view.frame
        view.addSubview(loaderView.view)
        loaderView.didMove(toParent: self)
    }
    
    //MARK:- Hide Loader
    func hideLoader() {
        loaderView.willMove(toParent: nil)
        loaderView.view.removeFromSuperview()
        loaderView.removeFromParent()
    }
    //MARK:- Check Network Availability
    func checkNetworkAvailability() {
        self.title = Constants.Messages.TitleError
        var userContentModel = [UserContentsModel]()
        userContentModel.removeAll()
         self.tableView.reloadData()
         refreshControl.endRefreshing()
         self.tableView.setContentOffset(CGPoint.zero, animated: true)
         UIAlertController.alert(title:"", msg:Constants.Messages.NoInternetConnection, buttonTitle:Constants.Constant.AlertButtonTitle, target: self)
    }
}

// MARK: - TableViewDelegate Setup
extension UserContentsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: UISCROLLVIEW DELEGATE
extension UserContentsViewController {
    // MARK: - Lazy Loading of cells
    func loadImagesForOnscreenRows() {
        self.tableView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadImagesForOnscreenRows()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate { loadImagesForOnscreenRows() }
    }
}
