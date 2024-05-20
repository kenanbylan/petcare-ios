//
//  AppointmentHistoryViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import UIKit

protocol AppointmentHistoryViewProtocol: AnyObject {
    func updateTableView()
    func showError(message: String)
}

final class AppointmentHistoryViewController: UIViewController {
    var presenter: AppointmentHistoryPresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        prepareTableView()
        prepareTitle()
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: PastAppointmentTableViewCell.identifier)
        tableView.registerCodedCell(with: PastAppointmentTableViewCell.self)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "AppointmentHistoryView_title".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension AppointmentHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfAppointment ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = presenter?.appointmentHistoryList(at: indexPath.item) else { return UITableViewCell() }
        let cell = tableView.dequeCell(cellClass: PastAppointmentTableViewCell.self, indexPath: indexPath)
        cell.configureCell(with: data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 4.5
    }
}

extension AppointmentHistoryViewController: AppointmentHistoryViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        ///alert data
    }
}
