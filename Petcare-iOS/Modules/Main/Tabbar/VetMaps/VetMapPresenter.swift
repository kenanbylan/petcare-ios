//
//  VetMapPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import Foundation

protocol VetMapPresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
}

final class VetMapPresenter {
    
    private weak var view: VetMapViewController?
    let router: VetMapRouterProtocol?
    let interactor: VetMapInteractorProtocol?
    
    let mapTitle = "Veterinary List"
    
 
    init(view: VetMapViewController? , router: VetMapRouterProtocol?, interactor: VetMapInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension VetMapPresenter: VetMapPresenterProtocol {
    func setTitle() -> String {
        return self.mapTitle
    }
  
    func viewDidLoad() {
        
    }
}

extension VetMapPresenter: VetMapInteractorOutput {
   
}
