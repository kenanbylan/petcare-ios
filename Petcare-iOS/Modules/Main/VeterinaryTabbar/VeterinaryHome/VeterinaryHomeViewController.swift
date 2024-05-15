//
//  VeterinaryHomeViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol VeterinaryHomeViewProtocol: AnyObject {
    func getSuccessRezervation()
    func getFailureRezervation()
    func updatedTableView()
}

final class VeterinaryHomeViewController: UIViewController {
    var presenter: VeterinaryHomePresenterProtocol?
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        prepareTitleLabel()
        prepareTableView()
    }
    
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Veterinary Appointments", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "x.circle.fill"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonTapped))
        addButton.tintColor = AppColors.primaryColor
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonTapped() {
        presenter?.backToLogin()
    }
    
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(AppointmentListTableViewCell.self, forCellReuseIdentifier: AppointmentListTableViewCell.identifier)
    }
}

extension VeterinaryHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfVets ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let appointment = presenter?.appointment(at: indexPath.row) else {
            // Handle nil case or return a default cell
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AppointmentListTableViewCell.identifier, for: indexPath) as! AppointmentListTableViewCell
        cell.configuration(with: appointment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didSelectRow = presenter?.appointment(at: indexPath.row)
        presenter?.didSelectAppointment(at: indexPath.row)
    }
}

extension VeterinaryHomeViewController: VeterinaryHomeViewProtocol {
    
    func getSuccessRezervation() {
        
    }
    
    func getFailureRezervation() {
        
    }
    
    func updatedTableView() {
        tableView.reloadData()
    }
}
