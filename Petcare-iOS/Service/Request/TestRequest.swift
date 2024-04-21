//
//  TestRequest.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.
//

import Foundation

struct TestRequest: DataRequest {
    typealias Response = TestResponse
    
    var url: String = APIConfig(environment: .test).baseURL()
    var method: HTTPMethod = .get
    
    func decode(_ data: Data) throws -> TestResponse {
        let decoder = JSONDecoder()
        let response = try decoder.decode(TestResponse.self, from: data)
        return response
    }
}

struct TestResponse: Codable {
    let id: Int?
    let firstname, lastname, email, birthDate: String?
    let login: Login?
    let address: Address?
    let phone, website: String?
    let company: Company?
}

// MARK: - Address
struct Address: Codable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lng: String
}

// MARK: - Company
struct Company: Codable {
    let name, catchPhrase, bs: String
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, md5: String
    let sha1, registered: String
}
