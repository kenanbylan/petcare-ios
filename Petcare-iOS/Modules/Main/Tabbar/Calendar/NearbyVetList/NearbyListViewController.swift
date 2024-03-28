//  NearbyListViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import UIKit
import SwiftUI
import MapKit

protocol NearbyListViewProtocol: AnyObject {
    func updateTableView()
    func showError(message: String)
}

final class NearbyListViewController: UIViewController {
    var presenter: NearbyListPresenterProtocol!
    private let locationManager = LocationManager() // Create an instance of LocationManager

    var activityIndicator = UIActivityIndicatorView()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTableView()
        prepareTitle()
        prepareActivityIndicator()
        locationManager.delegate = self
        locationManager.requestPermissionToAccessLocation()
    }
    
    
    private func prepareTableView() {
        view.addSubview(tableView)
        tableView.registerNib(with: NearbyListTableViewCell.identifier)
        tableView.registerCodedCell(with: NearbyListTableViewCell.self)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func prepareActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension NearbyListViewController: LocationManagerDelegate {
    func didUpdateLocation(_ location: CLLocationCoordinate2D) {
        print("Location \(location)")
        presenter.fetchNearbyVets(at: location)
    }
    
    func didFailWithError(_ error: any Error) {
        print("errorerror \(error.localizedDescription)")
    }
}

extension NearbyListViewController: NearbyListViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        //alert
    }
    
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Nearby Veterinary List", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension NearbyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfVets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = presenter.vet(at: indexPath.row)
        let cell = tableView.dequeCell(cellClass: NearbyListTableViewCell.self, indexPath: indexPath)
        cell.configureCell(with: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didSelectRow = presenter.vet(at: indexPath.row)
        print("didSelectRow: \(didSelectRow)")
        presenter.navigateToDetail(data: didSelectRow)
    }
}
