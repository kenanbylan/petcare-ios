//  NearbyListViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import UIKit
import SwiftUI


protocol NearbyListViewProtocol: AnyObject {
}

final class NearbyListViewController: UIViewController {
    var presenter: NearbyListPresenterProtocol!
    var nearbyList = [NearbyList]()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nearbyList.append(.init(title: "Çınar Veteriner ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "340 M"))
        nearbyList.append(.init(title: "liste1 ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "21 Km"))
        nearbyList.append(.init(title: "liste1 ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "700 M"))
        nearbyList.append(.init(title: "liste1 ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "2.3 Km" ))
        nearbyList.append(.init(title: "Çınar Veteriner ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "340 M"))
        nearbyList.append(.init(title: "Çınar Veteriner ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "340 M"))
        nearbyList.append(.init(title: "Çınar Veteriner ", address: "Çınar Mahallesi 747.Sok no:16 daire:2 Bağcılar/İstanbul", userDistance: "340 M"))

        
        presenter.viewDidLoad()
        prepareTableView()
        prepareTitle()
        view.backgroundColor = .systemRed
    }
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: NearbyListTableViewCell.identifier)
        tableView.registerCodedCell(with: NearbyListTableViewCell.self)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension NearbyListViewController: NearbyListViewProtocol {
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Nearby Veterinary List", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension NearbyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = nearbyList[indexPath.row]
        let cell = tableView.dequeCell(cellClass: NearbyListTableViewCell.self, indexPath: indexPath)
        cell.configureCell(with: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 3
    }
}
