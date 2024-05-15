//
//  HomePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//
import Foundation

protocol HomePresenterProtocol {
    func viewDidLoad()
    func navigateToPetType()
    
    var pets: [PetResponse] { get set }
    
    func navigateToNearbyList(onlyShow: Bool) -> Void
    func navigateToReminder() -> Void
    func getPetByPetId(petId: String) -> Void
    
}

final class HomePresenter {
    private weak var view: HomeViewProtocol?
    let router: HomeRouterProtocol?
    let interactor: HomeInteractorProtocol?
    
    var pets: [PetResponse] = []
    
    init(view: HomeViewProtocol? , router: HomeRouterProtocol?, interactor: HomeInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    func navigateToNearbyList(onlyShow: Bool) {
        router?.navigateToNearbyList(with: onlyShow)
    }
    
    func navigateToReminder() {
        router?.navigateToReminder()
    }
    
    
    func navigateToPetType() {
        router?.navigateToPetType()
    }
    
    func viewDidLoad() {
        view?.prepareUI()
        interactor?.getPetsbyId()
    }
    
    func getPetByPetId(petId: String) {
        interactor?.getPetsDetail(petsId: petId)
    }
}

extension HomePresenter: HomeInteractorOutput {
    func getPetsSuccess(response: [PetResponse]) {
        print("Response \(response)")
        view?.getPetsSuccess("message success")
        pets = response
    }
    
    func getPetsFailure(error: String) {
        
    }
    
    func getPetsFailure(error: ExceptionErrorHandle) {
        
    }
    
    
    func getPetDetailSucces(response: PetResponse) {
        router?.navigateToPetDetail(petData: response)
    }
    
    func getPetDetailFailure(error: String) {
        
    }
}
