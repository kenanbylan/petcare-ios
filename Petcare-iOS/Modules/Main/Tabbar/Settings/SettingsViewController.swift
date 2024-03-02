//
//  SettingsViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsModel)
}

protocol SettingsViewProtocol: AnyObject {
    func updateTableView(with sections: [Section])
    func prepareTableView()
    func prepareSetup()
}

final class SettingsViewController: BaseViewController {
    var presenter: SettingsPresenterProtocol!
    var models = [Section]()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTableView()
    }
}

extension SettingsViewController: SettingsViewProtocol {
    func updateTableView(with sections: [Section]) {
        self.models = sections
        self.tableView.reloadData()
    }
    
    func prepareSetup() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    func prepareTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppColors.bgColor
        tableView.frame = view.bounds
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedOption = models[indexPath.section].options[indexPath.row]
        switch selectedOption {
        case .staticCell(model: let model):
            presenter.navigateDetail(detail: model)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return models[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == models.count - 1 ? 60.0 : 0.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 100)
        if section == models.count - 1 {
            let lbl = CustomLabel(text: "Version 1.0.0", fontSize: 12, fontType: .medium, textColor: AppColors.primaryColor)
            lbl.translatesAutoresizingMaskIntoConstraints = false // Auto Layout kullanacağımızı belirtiyoruz
            footer.addSubview(lbl)
            
            // Label'i sol kenara yasla constraint'i oluştur
            NSLayoutConstraint.activate([
                lbl.leadingAnchor.constraint(equalTo: footer.leadingAnchor, constant: 10),
                lbl.topAnchor.constraint(equalTo: footer.topAnchor),
                lbl.trailingAnchor.constraint(equalTo: footer.trailingAnchor)
            ])
            
            return footer
        }
        return nil
    }
}
