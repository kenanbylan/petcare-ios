//
//  HomePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.

import Foundation
import CoreLocation
import MapKit

protocol HomePresenterProtocol {
    var pets: [PetResponse] { get set }
    
    func viewDidLoad()
    func navigateToPetType()
    func navigateToNearbyList(onlyShow: Bool) -> Void
    func navigateToContractVetList()
    func navigateToReminder() -> Void
    func getPetByPetId(petId: String) -> Void
    func fetchNearbyVets(at location: CLLocationCoordinate2D)
    func vet(at index: Int) -> NearbyPlace?
    func prepareSlideData() -> [SlideView.SlideData]
    
    func getUserPets() -> Void
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    let router: HomeRouterProtocol?
    let interactor: HomeInteractorProtocol?
    
    private let locationManager: CLLocationManager
    
    var pets: [PetResponse] = []
    var nearbyPlaces = [NearbyPlace]()
    
    init(view: HomeViewProtocol?, router: HomeRouterProtocol?, interactor: HomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.locationManager = CLLocationManager()
    }
}

extension HomePresenter: HomePresenterProtocol {
    func vet(at index: Int) -> NearbyPlace? {
        guard index >= 0 && index < nearbyPlaces.count else { return nil }
        return nearbyPlaces[index]
    }
    
    func prepareSlideData() -> [SlideView.SlideData] {
        var sliderData = [SlideView.SlideData]()
        sliderData.append(.init(image: UIImage(named: "info-host"), text: "Home_SlideView_label_1".localized()))
        sliderData.append(.init(image: UIImage(named: "info-dog"), text: "Home_SlideView_label_2".localized()))
        sliderData.append(.init(image: UIImage(named: "info-cat"), text: "Home_SlideView_label_3".localized()))
        return sliderData
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
            self.view?.updateNearbyVetView()
        }
    }
    
    func navigateToNearbyList(onlyShow: Bool) {
        router?.navigateToNearbyList(with: onlyShow)
    }
    
    func navigateToReminder() {
        router?.navigateToReminder()
    }
    
    func navigateToPetType() {
        router?.navigateToPetType()
    }
    
    func navigateToContractVetList() {
        router?.navigateToContractVetList()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
        interactor?.getPetsbyId()
        view?.updateNearbyVetView()
        view?.reloadData()
    }
    
    func getUserPets() {
        interactor?.getPetsbyId()
    }
    
    func getPetByPetId(petId: String) {
        interactor?.getPetsDetail(petsId: petId)
    }
}

extension HomePresenter: HomeInteractorOutput {
    func getPetsSuccess(response: [PetResponse]) {
        pets = response
        view?.getPetsSuccess("message success")
        view?.reloadData()
    }
    
    func getPetsFailure(error: String) { }

    func getPetDetailSucces(response: PetResponse) {
        router?.navigateToPetDetail(petData: response)
    }
    
    func getPetDetailFailure(error: String) { }
}
