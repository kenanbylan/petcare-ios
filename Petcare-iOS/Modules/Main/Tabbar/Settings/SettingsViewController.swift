//
//  SettingsViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit

protocol SettingsViewProtocol: AnyObject {
    
}

struct Section {
    let title: String
    let options: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsModel)
    case switchCell(model: SwitchSettingsModel)
}

final class SettingsViewController: UIViewController {
    var presenter: SettingsPresenterProtocol!
    var models = [Section]()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        presenter.viewDidLoad()
        prepareTableView()
        configure()
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.frame = view.bounds
        tableView.layer.cornerRadius = 10
        tableView.layer.masksToBounds = true
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.identifier)
    }
    
    
    private func configure() {
        //MARK: Switch Configuration
        
        models.append(Section(title: "General", options: [
            .switchCell(model: SwitchSettingsModel(title: "Dark mode", icon: UIImage(named: "cat") , iconBackgroundColor: AppColors.primaryColor, handler: {
                //MARK: Switch actions code
            }, isOn: false))
        ]))
        
        models.append(Section(title: "General", options: [
            .staticCell(model: SettingsModel(title: "Password Information", icon: UIImage(named: "dog"), iconBackgroundColor: AppColors.primaryColor, handler: {
                //MARK: password is required navigate
            })),
            .staticCell(model: SettingsModel(title: "Manage Notifications", icon: UIImage(named: "bird"), iconBackgroundColor: AppColors.bgColor2!, handler: {
                // MARK: Manage Notifications is clicked
            })),
            .staticCell(model: SettingsModel(title: "Privacy Policy", icon: UIImage(named: "pati"), iconBackgroundColor: .bgColor2, handler: {
                // MARK: Privacy Policy is clicked
            }))
        ]))
        
        models.append(Section(title: "Buy A Coffea", options: [
            .staticCell(model: SettingsModel(title: "Donate Us", icon: UIImage(named: "pati"), iconBackgroundColor: .bgColor2, handler: {
                // MARK: Donate Us
            }))
        ]))
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
            
        case .switchCell(model: let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: model)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == models.count - 1 {
            return 60.0
        }
        return 0.0
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: 540, height: 55)
        if (section == models.count - 1){
            footer.backgroundColor = .clear
            let lbl = UILabel()
            lbl.frame = CGRect(x: 10, y: 0, width: 540, height: 40)
            lbl.backgroundColor = .clear
            lbl.font = AppFonts.bold.font(size: 12)
            lbl.text = "Created By Kenan Baylan"
            lbl.numberOfLines = 1
            footer.addSubview(lbl)
            let lbl2 = UILabel()
            lbl2.frame = CGRect(x: 10, y: 12, width: 540, height: 40)
            lbl2.backgroundColor = .clear
            lbl2.font = AppFonts.bold.font(size: 12)
            lbl2.text = "Version 1.0.0"
            lbl2.numberOfLines = 1
            footer.addSubview(lbl2)
            self.tableView.tableFooterView = footer

        }
            return footer
    }

}
