//
//  LocationManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.01.2024.

import Foundation
import CoreLocation

final class LocationManager: NSObject {
    static let shared = LocationManager()
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    var locationUpdated: ((CLLocationCoordinate2D) -> Void)?
    
    override private init() {
        super.init()
        self.requestPermissionToAccessLocation()
    }
    
    func requestPermissionToAccessLocation() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            break
        case .restricted:
            break
        case .denied:
            break
        @unknown default:
            print("error with location auth change")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
//            locationManager.stopUpdatingLocation()
            locationUpdated!(location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
