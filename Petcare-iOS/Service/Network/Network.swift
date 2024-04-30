//
//  Network.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.04.2024.
//  MARK: KBKit

import UIKit

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
                domain: "url Component error",
                code: 404,
                userInfo: nil
            )
            
            return completion(.failure(.init(ebusinessCode: "invalidEndpoint's",businessErrorDetails: nil,error: nil)))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        
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
                
            case 400,401,403,422:
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
                completion(.failure(.init(ebusinessCode: "\(httpResponse.statusCode)", businessErrorDetails: nil, error: "Default uydastıudas")))
            }
        }
        .resume()
    }
}
