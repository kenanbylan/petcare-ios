//
//  VetMapViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import MapKit
import CoreLocation
import SwiftUI

protocol VetMapViewProtocol: AnyObject {
    
}

final class VetMapViewController: BaseViewController {
    var presenter: VetMapPresenterProtocol?
    var locationManager: CLLocationManager?
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        
        setupViews()
        checkLocationServices()
        mapView.delegate = self
        
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter!.setTitle(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mapView.delegate = self
        checkLocationServices()
    }
    
    private func setupViews() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func checkLocationServices() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            // Show an alert or message to the user indicating that location permission is denied.
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert or message to the user indicating that location services are restricted.
            break
        case .authorizedAlways:
            break
        @unknown default:
            fatalError("Unknown case")
        }
    }
    
    private func fetchNearbyVetClinics(userLocation: CLLocation) {
        let regionRadius: CLLocationDistance = 5000 //MARK: Distance
        
        let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Veteriner"
        request.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            guard let self = self else { return }
            guard error == nil else {
                // Handle error
                return
            }
            guard let response = response else {
                // Handle empty response
                return
            }
            
            for item in response.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                print("item.placemark.addressDictionary:\(item.placemark.addressDictionary)")
                self.mapView.addAnnotation(annotation)
            }
        }
    }
}

extension VetMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchNearbyVetClinics(userLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension VetMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let coordinate = annotation.coordinate
        let selectedPlace = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        var address: String?
        
        selectedPlace.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            if let error = error {
                // Handle error
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            print("placemarksArray!: ", placemarksArray!)
            print("selectedPlace PHONE NUMBER : ", selectedPlace.phoneNumber)
            
            if (error) == nil {
                if placemarksArray!.count > 0 {
                    let placemark = placemarksArray?[0]
                    address = "\(placemark?.subThoroughfare ?? ""), \(placemark?.thoroughfare ?? ""), \(placemark?.locality ?? ""), \(placemark?.subLocality ?? ""), \(placemark?.administrativeArea ?? ""), \(placemark?.postalCode ?? ""), \(placemark?.country ?? "")"
                    print("\(address)")
                }
            }
        }
    }
    //MARK: Drawing pin icon image's
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            
            let pinImage = UIImage(named: "pati")
            let pinSize = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContext(pinSize)
            pinImage?.draw(in: CGRect(x: 0, y: 0, width: pinSize.width, height: pinSize.height))
            
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            annotationView?.image = resizedImage
            annotationView?.contentMode = .scaleAspectFit
            
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
