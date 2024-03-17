//
//  NearbyListPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 9.03.2024.
//

import Foundation
import MapKit
import UIKit

protocol NearbyListPresenterProtocol {
    var numberOfVets: Int { get }
    func viewDidLoad()
    func fetchNearbyVets(at location: CLLocationCoordinate2D)
    func vet(at index: Int) -> NearbyPlace
    func didSelectVet(at index: Int)
    func setTitle() -> String
    func navigateToDetail(data: NearbyPlace)
}

final class NearbyListPresenter {
    private weak var view: NearbyListViewController?
    var title: String = "Nearby List Veterinary"
    var nearbyPlaces = [NearbyPlace]()
    
    let router: NearbyListRouterProtocol?
    let interactor: NearbyListInteractorProtocol?
    
    init(view: NearbyListViewController?, router: NearbyListRouterProtocol?, interactor: NearbyListInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setTitle() -> String {
        return self.title
    }

}

extension NearbyListPresenter: NearbyListPresenterProtocol {
    var numberOfVets: Int {
        return nearbyPlaces.count
    }
    
    func fetchNearbyVets(at location: CLLocationCoordinate2D) {
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
                    
                }
            }
            
            DispatchQueue.main.async {
                self.view?.updateTableView()
            }
        }
    }
    
    func vet(at index: Int) -> NearbyPlace {
        return nearbyPlaces[index]
    }
    
    func didSelectVet(at index: Int) {
        //seçilen veteriner ile ilgili işlem
    }
    
    func viewDidLoad() {
        view?.prepareTitle()
    }
    
    func navigateToDetail(data: NearbyPlace) {
        router?.navigateToDetail(data: data)
    }
}

extension NearbyListPresenter: NearbyListInteractOutput {
    func didFetchPlaces(_ places: [NearbyPlace]) {
        nearbyPlaces = places
        view?.updateTableView()
    }
    
    func onError(_ message: String) {
        view?.showError(message: message)
    }
}
