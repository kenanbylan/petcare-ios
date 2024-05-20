//
//  ContractVetListPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation
import MapKit

protocol ContractVetListPresenterProtocol {
    var numberOfVets: Int { get }
    func viewDidLoad()
    func vetList(at index: Int) -> UserRegisterRequest?
    func setTitle() -> String
    func navigateToDetail(data: UserRegisterRequest)
    func navigateToHistory()
}

final class ContractVetListPresenter {
    private weak var view: ContractVetListViewController?
    let interactor: ContractVetListInteractorProtocol?
    let router: ContractVetListRouterProtocol?
    
    var title: String = "Nearby List Veterinary"
    
    var contractVetList = [
        UserRegisterRequest(name: "John", surname: "Doe", email: "john@example.com", password: "password123", role: .VETERINARY, address: VetAddress(phoneNumber: "1234567890", clinicName: "Healthy Pets Clinic", clinicCity: "City", clinicDistrict: "District", clinicStreet: "Main Street", clinicNo: "123", apartmentNo: "4A"), document: Document(base64Document: "document1")),
        
        UserRegisterRequest(name: "Alice", surname: "Smith", email: "alice@example.com", password: "password456", role: .VETERINARY, address: VetAddress(phoneNumber: "0987654321", clinicName: "Happy Pets Clinic", clinicCity: "City", clinicDistrict: "District", clinicStreet: "First Avenue", clinicNo: "456", apartmentNo: "2B"), document: Document(base64Document: "document2")),
        
        UserRegisterRequest(name: "Emily", surname: "Johnson", email: "emily@example.com", password: "password789", role: .VETERINARY, address: VetAddress(phoneNumber: "5555555555", clinicName: "PetCare Clinic", clinicCity: "City", clinicDistrict: "District", clinicStreet: "Second Street", clinicNo: "789", apartmentNo: "3C"), document: Document(base64Document: "document3")),
        
        UserRegisterRequest(name: "Michael", surname: "Brown", email: "michael@example.com", password: "passwordABC", role: .VETERINARY, address: VetAddress(phoneNumber: "4444444444", clinicName: "Animal Hospital", clinicCity: "City", clinicDistrict: "District", clinicStreet: "Third Avenue", clinicNo: "321", apartmentNo: "1D"), document: Document(base64Document: "document4")),
        
        UserRegisterRequest(name: "Sophia", surname: "Garcia", email: "sophia@example.com", password: "passwordDEF", role: .VETERINARY, address: VetAddress(phoneNumber: "7777777777", clinicName: "Paw Prints Veterinary", clinicCity: "City", clinicDistrict: "District", clinicStreet: "Fourth Street", clinicNo: "567", apartmentNo: "5E"), document: Document(base64Document: "document5"))
    ]
    
    init(view: ContractVetListViewController?, interactor: ContractVetListInteractorProtocol?, router: ContractVetListRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func setTitle() -> String {
        return self.title
    }
}

extension ContractVetListPresenter: ContractVetListPresenterProtocol {
    var numberOfVets: Int {
        return contractVetList.count
    }
    
    func viewDidLoad() {
        
    }
    
    func vetList(at index: Int) -> UserRegisterRequest? {
        guard index >= 0 && index < contractVetList.count else {
            return nil
        }
        return contractVetList[index]
    }
    
    func navigateToDetail(data: UserRegisterRequest) {
        router?.navigateToDetail(data: data)
    }
    
    func navigateToHistory() {
        router?.navigateToHistory()
    }
}

extension ContractVetListPresenter: ContractVetListInteractorOutput {
    func getVetListSuccess() {
    }
    
    func getVetListFailure() {
        
    }
}
