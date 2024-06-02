//
//  ReminderDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.05.2024.
//

import UIKit
import UserNotifications

protocol ReminderDetailDelegate: AnyObject {
    func didAddReminder(_ reminder: Reminder)
}


final class ReminderDetailViewController: UIViewController {
    var models = [Reminder]()
    
    weak var delegate: ReminderDetailDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerNib(with: ReminderListTableViewCell.identifier)
        tableView.registerCodedCell(with: ReminderListTableViewCell.self)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        accessNotification()
        loadData()
        sortModels()
        prepareTitle()
    }
    
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "ReminderView_Title".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem?.tintColor = AppColors.primaryColor
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func accessNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
            if success {
                print("working.")
            } else if error != nil {
                print("error occurred.")
            }
        })
    }
    
    private func loadData() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "data") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                models = try jsonDecoder.decode([Reminder].self, from: savedData)
            } catch {
                print("Failed to load data.")
            }
        }
    }
    
    private func sortModels() {
        models = models.sorted(by: { $0.date > $1.date })
    }
    
    private func saveData() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(models) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "data")
        } else {
            print("Failed to save data.")
        }
    }
    
    @objc private func addTapped() {
        let vc = AddViewController()
        vc.completion = { [weak self] title, body, date in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                let newReminder = Reminder(title: title, date: date, subtitle: body)
                self?.models.append(newReminder)
                self?.saveData()
                self?.sortModels()
                self?.tableView.reloadData()
                self?.delegate?.didAddReminder(newReminder)
                
                let content = UNMutableNotificationContent()
                content.title = title
                content.sound = .default
                content.body = body
                let targetDate = date
                let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
                let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
                UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                    if error != nil {
                        print("something went wrong.")
                    }
                })
                
            }
        }
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.preferredCornerRadius = 20
        }
        present(vc, animated: true, completion: nil)
    }
}

extension ReminderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = models[indexPath.row]
        let cell = tableView.dequeCell(cellClass: ReminderListTableViewCell.self, indexPath: indexPath)
        cell.configure(with: reminder)
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            return self.makeContextMenu(for: indexPath)
        })
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveData()
        }
    }
    
    func makeContextMenu(for indexPath: IndexPath) -> UIMenu {
        let action = UIAction(title: "ReminderView_delete".localized(), attributes: .destructive) { [weak self] _ in
            guard let self = self else { return }
            self.models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            self.saveData()
        }
        return UIMenu(title: "", children: [action])
    }
}
