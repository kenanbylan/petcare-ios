//
//  NetworkToken.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.05.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendRequest<T: Codable>(urlString: String,
                                  method: HTTPMethod,
                                  body: Data? = nil,
                                  headers: [String: String]? = nil,
                                  responseType: T.Type,
                                  successHandler: @escaping (T) -> Void,
                                  errorHandler: @escaping (Error) -> Void) {
        
        guard let url = URL(string: urlString) else {
            errorHandler(NetworkError.invalidURL)
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        if let body = body {
            urlRequest.httpBody = body
        }
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                errorHandler(error)
                return
            }
            
            guard let data = data else {
                errorHandler(NetworkError.invalidData)
                return
            }
            
            do {
                let responseObject = try JSONDecoder().decode(responseType, from: data)
                successHandler(responseObject)
            } catch {
                errorHandler(error)
            }
        }
        
        task.resume()
    }
    
    enum NetworkError: Error {
        case invalidURL
        case invalidData
    }
}
