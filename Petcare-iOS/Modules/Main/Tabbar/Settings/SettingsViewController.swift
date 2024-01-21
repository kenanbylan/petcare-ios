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
        let table = UITableView(frame: .zero, style: .grouped)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        presenter.viewDidLoad()
        prepareTableView()
        configure()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
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
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! UITableViewCell
        
        cell.backgroundColor = .blue
        
         
        return cell

    }
    
    
}
