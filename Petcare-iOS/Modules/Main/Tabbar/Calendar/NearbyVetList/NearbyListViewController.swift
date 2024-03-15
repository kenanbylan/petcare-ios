//  NearbyListViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import UIKit
import SwiftUI
import MapKit

protocol NearbyListViewProtocol: AnyObject { }

final class NearbyListViewController: UIViewController {
    var presenter: NearbyListPresenterProtocol!
    var nearbyList = [NearbyList]()
    var nearbyPlaces = [NearbyPlace]()
    
    var activityIndicator = UIActivityIndicatorView()
    
    private let tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTableView()
        prepareTitle()
        getUserLocation()
        prepareActivityIndicator()
    }
    
    private func getUserLocation() {
        activityIndicator.startAnimating()
        LocationManager.shared.locationUpdated = { [weak self] location in
            guard let self = self else { return }
            print("Location \(location)")
            self.fetchPlaces(location: location)
        }
    }
    
    private func fetchPlaces(location: CLLocationCoordinate2D) {
        let searchSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let searchRegion = MKCoordinateRegion(center: location, span: searchSpan)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.region = searchRegion
        searchRequest.resultTypes = .pointOfInterest
        searchRequest.naturalLanguageQuery = "Veteriner"
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let mapItems = response?.mapItems else { return }
            self.nearbyPlaces.removeAll()
            
            for mapItem in mapItems {
                let placeCoordinate = mapItem.placemark.coordinate
                let placeLocation = CLLocation(latitude: placeCoordinate.latitude, longitude: placeCoordinate.longitude)
                
                let name = mapItem.name ?? "No name found"
                let phoneNumber = mapItem.phoneNumber ?? "No phone number found"
                let address = "\(mapItem.placemark.subThoroughfare ?? ""),\(mapItem.placemark.thoroughfare ?? ""), \(mapItem.placemark.locality ?? ""), \(mapItem.placemark.subLocality ?? ""), \(mapItem.placemark.administrativeArea ?? ""), \(mapItem.placemark.country ?? "")"
                
                let distance = "\(location.distance(to: placeLocation.coordinate))"
                
                ///MARK: Already list not append.
                if !self.nearbyPlaces.contains(where: { $0.placeTitle == name }) {
                    let nearbyPlace = NearbyPlace(placeTitle: name, address: address, phoneNumber: phoneNumber, distance: distance)
                    self.nearbyPlaces.append(nearbyPlace)
                    self.activityIndicator.stopAnimating()
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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

extension NearbyListViewController: NearbyListViewProtocol {
    func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Nearby Veterinary List", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension NearbyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearbyPlaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = nearbyPlaces[indexPath.row]
        let cell = tableView.dequeCell(cellClass: NearbyListTableViewCell.self, indexPath: indexPath)
        cell.configureCell(with: list)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.screenWidth / 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let didSelectRow = nearbyPlaces[indexPath.row]
        print("didSelectRow: \(didSelectRow)")
        presenter.navigateToDetail(data: didSelectRow)
    }
    
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let position = scrollView.contentOffset.y
    //        if (position > tableView.contentSize.height - 100 - scrollView.frame.height) {
    //            activityIndicator.startAnimating()
    //        } else {
    //            activityIndicator.stopAnimating()
    //        }
    //    }
    
}
