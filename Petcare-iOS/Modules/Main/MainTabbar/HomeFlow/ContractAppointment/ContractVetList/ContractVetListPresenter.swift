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
    func vetList(at index: Int) -> VeterinaryResponse?
    func setTitle() -> String
    func navigateToDetail(data: VeterinaryResponse)
    func navigateToHistory()
}

final class ContractVetListPresenter {
    private weak var view: ContractVetListViewController?
    let interactor: ContractVetListInteractorProtocol?
    let router: ContractVetListRouterProtocol?
    
    var title: String = "Nearby List Veterinary"
    var contractVetList: [VeterinaryResponse] = []
    
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
        interactor?.getContractVetList()
    }
    
    func vetList(at index: Int) -> VeterinaryResponse? {
        guard index >= 0 && index < contractVetList.count else {
            return nil
        }
        return contractVetList[index]
    }
    
    func navigateToDetail(data: VeterinaryResponse) {
                router?.navigateToDetail(data: data)
    }
    
    func navigateToHistory() {
        router?.navigateToHistory()
    }
}

extension ContractVetListPresenter: ContractVetListInteractorOutput {
    func getVetListSuccess(response: [VeterinaryResponse]) {
        contractVetList = response
    }
    
    func getVetListFailure(error: String) { }
}
