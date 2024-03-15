//
//  CLLocationCoordinate2D + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.03.2024.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    /// Returns the distance between two coordinates in meters.
    func distance(to: CLLocationCoordinate2D) -> CLLocationDistance {
        MKMapPoint(self).distance(to: MKMapPoint(to))
    }

}
