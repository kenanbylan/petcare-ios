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
    func didSelectDonationOption(at index: Int)
    var donationOptions: [DonationOption] { get  }
}

struct DonationOption {
    let size: String
    let amount: Double
}

final class DonatePresenter {
    private weak var viewController: DonateViewController?
    let router: DonateRouterProtocol?
    let interactor: DonateInteractorProtocol?
    
    //MARK: Variable's
    var title:String = "Buy a Coffee"
    
    var donationOptions: [DonationOption] = [
        DonationOption(size: "Small", amount: 60),
        DonationOption(size: "Medium", amount: 100),
        DonationOption(size: "Large", amount: 120)
    ]
    
    init(viewController: DonateViewController? = nil, router: DonateRouterProtocol?, interactor: DonateInteractorProtocol?) {
        self.viewController = viewController
        self.router = router
        self.interactor = interactor
    }
}
extension DonatePresenter: DonatePresenterProtocol {
    func didSelectDonationOption(at index: Int) {
        let _ = donationOptions[index]
    }
    
    func viewDidLoad() {
        
    }
    
    func setTitle() -> String {
        return title
    }
}

extension DonatePresenter: DonateInteractorOutput {
    
}


