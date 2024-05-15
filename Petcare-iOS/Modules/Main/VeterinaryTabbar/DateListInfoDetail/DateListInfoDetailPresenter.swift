//
//  DateListInfoDetailPresenter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import Foundation

protocol DateListInfoDetailPresenterProtocol {
    func viewDidLoad()
    func backToMain() -> Void
    func setTitle() -> String
    func signOut()
    
    var dateTimeList: [String: Bool] { get set }
}

final class DateListInfoDetailPresenter {
    
    private weak var view: DateListInfoDetailViewController?
    let router: DateListInfoDetailRouterProtocol?
    let interactor: DateListInfoDetailInteractorProtocol?
    
    
    //MARK: Variables
    var title: String = "Date Time Select"
    var dateTimeList: [String: Bool] = ["09.00": true, "11.00": false , "13.00": true, "15.00": true, "17.00": false]
    
    
    init(view: DateListInfoDetailViewController? , router: DateListInfoDetailRouterProtocol?, interactor: DateListInfoDetailInteractorProtocol?) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func setTitle() -> String {
        return self.title
    }
}

extension DateListInfoDetailPresenter: DateListInfoDetailPresenterProtocol {
    func viewDidLoad() {}
    
    func signOut() { }
    
    func backToMain() {
        router?.backtoMain()
    }
}

extension DateListInfoDetailPresenter: DateListInfoDetailInteractorOutput {
    func settingsSectionsFetched(_ sections: [Section]) {
        
    }
}
