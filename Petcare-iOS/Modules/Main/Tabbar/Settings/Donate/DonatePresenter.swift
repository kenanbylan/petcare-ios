//
//  DonatePresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import Foundation

protocol DonatePresenterProtocol {
    func viewDidLoad()
    func setTitle() -> String
}

final class DonatePresenter {
    private weak var viewController: DonateViewController?
    let router: DonateRouterProtocol?
    let interactor: DonateInteractorProtocol?

    //MARK: Variable's
    var title:String = "Buy a Coffee"

    init(viewController: DonateViewController? = nil, router: DonateRouterProtocol?, interactor: DonateInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}
extension DonatePresenter: DonatePresenterProtocol {
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension DonatePresenter: DonateInteractorOutput {
    
}


