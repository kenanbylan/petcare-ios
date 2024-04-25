//
//  Network.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.
//
import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case invalidData
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case badRequest // 400
    case serverError // 5xx
    case unknown(Int)
    case status(Int) //
}

struct ExceptionErrorHandle: Codable, Error {
    var ebusinessCode: String?
    var businessErrorDetails: String?
    var error: String?
    
    init(ebusinessCode: String?, businessErrorDetails: String?, error: String?) {
        self.ebusinessCode = ebusinessCode
        self.businessErrorDetails = businessErrorDetails
        self.error = error
    }
}


protocol NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, ExceptionErrorHandle>) -> Void)
}

final class DefaultNetworkService: NetworkService {
    func request<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, ExceptionErrorHandle>) -> Void) {
        guard var urlComponent = URLComponents(string: request.url) else {
            return completion(.failure(.init(ebusinessCode: "Invalid URL Component's",businessErrorDetails: nil,error: nil)))
        }
        
        var queryItems: [URLQueryItem] = []
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            let error = NSError(
                domain: ErrorResponse.invalidEndpoint.rawValue,
                code: 404,
                userInfo: nil
            )
            
            return completion(.failure(.init(ebusinessCode: "invalidEndpoint's",businessErrorDetails: nil,error: nil)))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers // header eklendi.
        urlRequest.httpBody = request.body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type") // Content-Type ayarlandı
        
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.init(ebusinessCode: nil, businessErrorDetails: nil, error: error.localizedDescription)))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.init(ebusinessCode: nil, businessErrorDetails: nil, error: "Invalid http Response")))
                return
            }
            
            switch httpResponse.statusCode {
                
            case 200..<300:
                guard let data = data else {
                    completion(.failure(.init(ebusinessCode: nil, businessErrorDetails: nil, error: "Data decoding error")))
                    return
                }
                do {
                    try completion(.success(request.decode(data)))
                } catch {
                    completion(.failure(.init(ebusinessCode: nil, businessErrorDetails: nil, error: error.localizedDescription)))
                }
                
            case 400:
                guard let data = data else {
                    completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: "Data decoding error")))
                    return
                }
                
                do {
                    let exceptionErrorHandle = try JSONDecoder().decode(ExceptionErrorHandle.self, from: data)
                    completion(.failure(exceptionErrorHandle))
                } catch {
                    completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: error.localizedDescription)))
                }
                
            case 500..<600:
                guard let data = data else {
                    completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: "Data decoding error")))
                    return
                }
                
                do {
                    let exceptionErrorHandle = try JSONDecoder().decode(ExceptionErrorHandle.self, from: data)
                    completion(.failure(exceptionErrorHandle))
                } catch {
                    completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: error.localizedDescription)))
                }
                
            default:
                completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: "Default")))
            }
        }
        .resume()
    }
}
