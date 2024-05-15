//
//  DocumentVerifyInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import Foundation

protocol DocumentVerifyInteractorProtocol {
    func veterinaryRequest(vet: UserRegisterRequest) -> Void
}

protocol DocumentVerifyInteractorOutput {
    func vetRegisterSuccess(response: VetResponse)
    func vetRegisterFailure(error: ExceptionErrorHandle)
}

final class DocumentVerifyInteractor: DocumentVerifyInteractorProtocol {
    var output: DocumentVerifyInteractorOutput?
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func veterinaryRequest(vet: UserRegisterRequest) {
        let request = VeterinaryRegister(name: vet.name ?? "Kenan",
                                         surname: vet.surname ?? "Baylan",
                                         email: vet.email ?? "Email",
                                         password: vet.password ?? "deneme123",
                                         phoneNumber: vet.address?.phoneNumber ?? "5315847699",
                                         clinicName: vet.address?.clinicName ?? "küçükyalı",
                                         clinicCity: vet.address?.clinicCity ?? "aydınevler",
                                         clinicDistrict: vet.address?.clinicDistrict ?? "resad",
                                         clinicStreet: vet.address?.clinicStreet ?? "dsads",
                                         clinicNo: vet.address?.clinicNo ?? "d312",
                                         apartmentNo: vet.address?.apartmentNo ?? "adda",
                                         base64Document: vet.document?.base64Document ?? "dasdas")
        
        networkService.request(request) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                print("Register interactor: \(response)")
                self?.output?.vetRegisterSuccess(response: response)
            case .failure(let error):
                self?.output?.vetRegisterFailure(error: error)
            }
        }
    }
}
