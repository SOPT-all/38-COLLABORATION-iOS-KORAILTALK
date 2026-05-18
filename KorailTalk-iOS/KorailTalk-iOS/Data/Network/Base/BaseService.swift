//
//  BaseService.swift
//  KorailTalk-iOS
//
//  Created by mandoo on 5/18/26.
//

import Foundation

class BaseService {
    
    struct BaseResponse<T: Decodable>: Decodable {
        let message: String
        let data: T?
    }
    
    struct APIErrorResponse: Decodable, Error {
        private let code: String
        let message: String
        let errors: [ValidationError]?
        
        var errorCode: APIErrorCode {
            return APIErrorCode(rawValue: code) ?? .unknown
        }
        
        struct ValidationError: Decodable {
            let field: String
            let value: String
            let reason: String
        }
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
        case unknownError
    }
    
    func request<Req: Encodable, Res: Decodable>(
        urlString: String,
        method: String = "GET",
        body: Req? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<Res, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        
        if let body = body {
            do {
                let encoder = JSONEncoder()
                request.httpBody = try encoder.encode(body)
            } catch {
                completion(.failure(NetworkError.decodingError))
                return
            }
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 9 * 3600)
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try decoder.decode(BaseResponse<Res>.self, from: data)
                    if let dataResult = decodedResponse.data {
                        completion(.success(dataResult))
                    } else if let emptyResult = EmptyResponse() as? Res {
                        completion(.success(emptyResult))
                    } else {
                        completion(.failure(NetworkError.decodingError))
                    }
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
                
            case 400...599:
                do {
                    let apiError = try decoder.decode(APIErrorResponse.self, from: data)
                    completion(.failure(apiError))
                } catch {
                    completion(.failure(NetworkError.decodingError))
                }
                
            default:
                completion(.failure(NetworkError.unknownError))
            }
        }.resume()
    }
    
    func request<Res: Decodable>(
        urlString: String,
        method: String = "GET",
        headers: [String: String]? = nil,
        completion: @escaping (Result<Res, Error>) -> Void
    ) {
        let noBody: EmptyRequest? = nil
        request(urlString: urlString, method: method, body: noBody, headers: headers, completion: completion)
    }
}

struct EmptyRequest: Encodable {}
struct EmptyResponse: Decodable {}
