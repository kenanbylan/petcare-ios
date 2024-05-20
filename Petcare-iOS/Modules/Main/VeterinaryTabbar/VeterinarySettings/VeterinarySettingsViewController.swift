//
//  VeterinarySettingsViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol VeterinarySettingsViewProtocol: AnyObject {
    
}

final class VeterinarySettingsViewController: UIViewController {
    var presenter: VeterinarySettingsPresenterProtocol?
    var models = [SectionDay]()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        prepareTitleLabel()
        prepareTableView()
        
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "VeterinarySettingsView_title".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension VeterinarySettingsViewController: VeterinarySettingsViewProtocol {
    func updateTableView(with sections: [SectionDay]) {
        self.models = sections
        self.tableView.reloadData()
    }
    
    func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: SettingTableViewCell.identifier)
        tableView.registerCodedCell(with: SettingTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds

        tableView.backgroundColor = AppColors.bgColor
        tableView.layer.cornerRadius = 10
    }
}

extension VeterinarySettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model {
        case .staticCell(model: let settingModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as! SettingTableViewCell
            cell.configureCell(with: settingModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = models[indexPath.section].options[indexPath.row]
        switch selectedOption {
        case .staticCell(model: let model):
            presenter?.navigateDetail(detail: model)
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
}
