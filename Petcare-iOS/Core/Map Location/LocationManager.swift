//
//  LocationManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.01.2024.

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func didUpdateLocation(_ location: CLLocationCoordinate2D)
    func didFailWithError(_ error: Error)
}

protocol LocationDataSource: AnyObject {
    func fetchNearbyPlaces(location: CLLocationCoordinate2D)
}

class LocationManager: NSObject {
    private let locationManager: CLLocationManager
    weak var delegate: LocationManagerDelegate?

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
    
    
    func requestPermissionToAccessLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // Handle restricted or denied authorization status
            break
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            delegate?.didUpdateLocation(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.didFailWithError(error)
    }
}
