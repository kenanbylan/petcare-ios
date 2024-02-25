//
//  VetMapViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import MapKit
import CoreLocation

protocol VetMapViewProtocol: AnyObject {
        
}

final class VetMapViewController: UIViewController {
    var presenter: VetMapPresenterProtocol?
    var locationManager: CLLocationManager?
    
//    private lazy var locationManager: CLLocationManager = {
//        let manager = CLLocationManager()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        manager.activityType = .automotiveNavigation
//        manager.distanceFilter = 10.0
//        return manager
//    }()
    
    let customBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen

        return view
    }()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.showsUserLocation = true
        return map
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = AppColors.primaryColor
        searchBar.backgroundColor = .systemRed
        searchBar.placeholder = "Search for vets"
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        
        setMapConstraints()
        setupSearchBar()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        locationManager?.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func setMapConstraints() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
        private func setupSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access authorized.")
        case .denied, .restricted:
            print("Location access denied.")
        case .notDetermined:
            print("Location access not determined.")
        default:
            break
        }
    }
}


extension VetMapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text  {
            print("Search for: \(searchText)")
        }
        searchBar.resignFirstResponder()
    }

    
}

extension VetMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager update")
        guard let location = locations.first else { return }
        print("Location: \(location)")
        updateMap(with: location.coordinate)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
}


extension VetMapViewController {
    func updateMap(with coordinate: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        performLocalSearch(for: "Vets")
    }
        
    func performLocalSearch(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mapView.region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let items = response?.mapItems else {
                if let error = error {
                    print("Search error: \(error.localizedDescription)")
                }
                return
            }
            self.showPins(for: items)
        }
    }
    
    func showPins(for mapItems: [MKMapItem]) {
        mapView.removeAnnotations(mapView.annotations)

        for item in mapItems {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.name
            mapView.addAnnotation(annotation)
        }
    }
}

extension VetMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? MKPointAnnotation {
            let mapDetail = MapDetailView()
            mapDetail.translatesAutoresizingMaskIntoConstraints = false
            mapView.addSubview(mapDetail)
            mapView.bringSubviewToFront(mapDetail)

            NSLayoutConstraint.activate([
                 mapDetail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 mapDetail.bottomAnchor.constraint(equalTo: view.topAnchor, constant: -10),

             ])
        }
    }
}

