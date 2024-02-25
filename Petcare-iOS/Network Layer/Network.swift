//
//  Network.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 24.02.2024

import Foundation
import Combine

final class NetworkManager {
    private let tokenManager = TokenManager.shared
    
    func request<T>(
        type: T.Type,
        router: URLRouter,
        method: RequestMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        userID: String? = nil,
        requestData: Data? = nil // Yeni eklenen parametre
    ) -> AnyPublisher<T, Error> where T: Decodable {
        
        var request = buildRequest(router: router, method: method, parameters: parameters, headers: headers, userID: userID)
        request.httpMethod = method.rawValue
        
        // Eğer requestData varsa, HTTP Body'e ekle
        if let requestData = requestData  {
            request.httpBody = requestData
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func buildRequest(
        router: URLRouter,
        method: RequestMethod,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        userID: String?
    ) -> URLRequest {
        
        guard let baseURL = URL(string: NetworkConstants.https + NetworkConstants.baseURL) else {
            fatalError("Invalid base URL")
        }
        let url = baseURL.appendingPathComponent(router.path) //kontrol edilecektir...
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        // Append token if available and valid
        if let token = tokenManager.token, tokenManager.isTokenValid() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        // Append userID if available
        if let userID = userID {
            request.setValue(userID, forHTTPHeaderField: "UserID")
        }
        
        // Add other parameters if needed
        return request
    }
}
