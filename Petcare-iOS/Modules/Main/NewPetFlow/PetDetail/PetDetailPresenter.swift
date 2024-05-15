//
//  PetDetailPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import Foundation

protocol PetDetailPresenterProtocol {
    func viewDidLoad()
    var petData: PetResponse { get set }
}

final class PetDetailPresenter: PetDetailPresenterProtocol{
    private weak var view: PetDetailViewProtocol?
    let router: PetDetailProtocol?
    let interactor: PetDetailInteractorProtocol?
    
    var petData: PetResponse
    
    init(view: PetDetailViewProtocol? = nil, router: PetDetailProtocol?, interactor: PetDetailInteractorProtocol?, petData: PetResponse) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.petData = petData
    }
    
    func viewDidLoad() {
        print("PetDetail \(petData)")
        
    }
}

extension PetDetailPresenter: PetDetailInteractorOutput {
    
}
