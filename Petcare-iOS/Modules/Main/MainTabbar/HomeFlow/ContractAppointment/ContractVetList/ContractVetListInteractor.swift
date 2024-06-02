//
//  ContractVetListInteractor.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.05.2024.
//

import Foundation

protocol ContractVetListInteractorProtocol {
    func getContractVetList() -> Void
}

protocol ContractVetListInteractorOutput {
    func getVetListSuccess(response: [VeterinaryResponse])
    func getVetListFailure(error: String)
}

final class ContractVetListInteractor: ContractVetListInteractorProtocol {
    var output: ContractVetListInteractorOutput?
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    let mockVeterinaryResponses: [VeterinaryResponse] = [
        VeterinaryResponse(
            veterinaryId: "vet123",
            createdAt: "2024-05-01T10:00:00Z",
            updatedAt: "2024-05-10T15:00:00Z",
            name: "Ahmet",
            surname: "Yılmaz",
            email: "ahmet.yilmaz@example.com",
            role: "Veteriner",
            address: Address(
                id: "address123",
                createdAt: "2024-05-01T10:00:00Z",
                updatedAt: "2024-05-10T15:00:00Z",
                phoneNumber: "05551234567",
                clinicName: "Yılmaz Veteriner Kliniği",
                clinicCity: "İstanbul",
                clinicDistrict: "Kadıköy",
                clinicStreet: "Bağdat Caddesi",
                clinicNo: "123",
                apartmentNo: "45"
            ),
            document: DocumentVet(
                id: 1,
                base64Document: "SGVsbG8gd29ybGQh"
            )
        ),
        VeterinaryResponse(
            veterinaryId: "vet124",
            createdAt: "2024-05-02T11:00:00Z",
            updatedAt: "2024-05-11T16:00:00Z",
            name: "Ayşe",
            surname: "Kara",
            email: "ayse.kara@example.com",
            role: "Veteriner",
            address: Address(
                id: "address124",
                createdAt: "2024-05-02T11:00:00Z",
                updatedAt: "2024-05-11T16:00:00Z",
                phoneNumber: "05559876543",
                clinicName: "Kara Veteriner Kliniği",
                clinicCity: "Ankara",
                clinicDistrict: "Çankaya",
                clinicStreet: "Atatürk Bulvarı",
                clinicNo: "456",
                apartmentNo: "78"
            ),
            document: DocumentVet(
                id: 2,
                base64Document: "SGVsbG8gd29ybGQh"
            )
        ),
        VeterinaryResponse(
            veterinaryId: "vet125",
            createdAt: "2024-05-03T12:00:00Z",
            updatedAt: "2024-05-12T17:00:00Z",
            name: "Mehmet",
            surname: "Demir",
            email: "mehmet.demir@example.com",
            role: "Veteriner",
            address: Address(
                id: "address125",
                createdAt: "2024-05-03T12:00:00Z",
                updatedAt: "2024-05-12T17:00:00Z",
                phoneNumber: "05551239876",
                clinicName: "Demir Veteriner Kliniği",
                clinicCity: "İzmir",
                clinicDistrict: "Bornova",
                clinicStreet: "Kordon Boyu",
                clinicNo: "789",
                apartmentNo: "12"
            ),
            document: DocumentVet(
                id: 3,
                base64Document: "SGVsbG8gd29ybGQh"
            )
        )
    ]
    
    
    func getContractVetList() {
        self.output?.getVetListSuccess(response: mockVeterinaryResponses)
        //        let request = GetVeterinariesRequest()
        //        networkManager.sendRequest(urlString: request.url, method: .get, headers: request.headers, responseType: [VeterinaryResponse].self) { [weak self] response in
        //            self?.output?.getVetListSuccess(response: response)
        //        } errorHandler: { [weak self] error in
        //            self?.output?.getVetListFailure(error: error.localizedDescription)
        //        }
    }
}
