//
//  ContractVetListViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import UIKit

protocol ContractVetListViewProtocol: AnyObject {
    func updateTableView()
    func showError(message: String)
}

final class ContractVetListViewController: UIViewController {
    var presenter: ContractVetListPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareTitle()
        presenter?.viewDidLoad()
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: NearbyListTableViewCell.identifier)
        tableView.registerCodedCell(with: NearbyListTableViewCell.self)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "ContractVetListView_title".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = AppColors.primaryColor
    }
    
    @objc private func addTapped() {
        presenter?.navigateToHistory()
    }
}

extension ContractVetListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfVets ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let list = presenter?.vetList(at: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeCell(cellClass: NearbyListTableViewCell.self, indexPath: indexPath)
        cell.configureContractCell(with: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let didSelect = presenter?.vetList(at: indexPath.item) else { return }
        presenter?.navigateToDetail(data: didSelect)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 4.5
    }
}

extension ContractVetListViewController: ContractVetListViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        ///alert data
    }
}
