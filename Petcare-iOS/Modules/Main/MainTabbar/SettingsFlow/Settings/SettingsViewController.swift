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
    func prepareTitle()
}

final class SettingsViewController: BaseViewController {
    var presenter: SettingsPresenterProtocol!
    var models = [Section]()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
        return tableView
    }()
    
    override func viewDidLoad(){
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
    
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: SettingTableViewCell.identifier)
        tableView.registerCodedCell(with: SettingTableViewCell.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
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
            let lbl = CustomLabel(text: "Version 1.0.1", fontSize: 15, fontType: .medium, textColor: AppColors.primaryColor)
            lbl.translatesAutoresizingMaskIntoConstraints = false
            footer.addSubview(lbl)
            
            NSLayoutConstraint.activate([
                lbl.leadingAnchor.constraint(equalTo: footer.leadingAnchor, constant: 12),
                lbl.topAnchor.constraint(equalTo: footer.topAnchor,constant: 8),
                lbl.trailingAnchor.constraint(equalTo: footer.trailingAnchor)
            ])
            
            return footer
        }
        return nil
    }
}
