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

final class VetMapViewController: BaseViewController {
    var presenter: VetMapPresenterProtocol?
    var locationManager: CLLocationManager?
    
    var selectedClinic: MKMapItem?
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .dark
        map.showsUserLocation = true
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        setupViews()
        checkLocationServices()
        mapView.delegate = self
        
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter!.setTitle(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
        
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
        let regionRadius: CLLocationDistance = 10000
        
        let coordinateRegion = MKCoordinateRegion(center: userLocation.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0,
                                                  longitudinalMeters: regionRadius * 2.0)
        // Sadece kullanıcı haritayı elle kaydırdığında bölgeyi yeniden ayarlama
        if mapView.region.span.latitudeDelta > 0.1 && mapView.region.span.longitudeDelta > 0.1 {
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Veteriner"
        request.region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
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
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let selectedPlace = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let error = error {
                // Handle error
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemarks found")
                return
            }
            
            let address = placemark.name ?? ""
            print("Reverse geocoded address: \(address)")
            self.showClinicDetailsBottomSheet(with: address)
        }
    }
    
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
    
    private func showClinicDetailsBottomSheet(with address: String) {
        let bottomSheetVC = MapBottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .overCurrentContext
        present(bottomSheetVC, animated: true, completion: nil)
    }
}
