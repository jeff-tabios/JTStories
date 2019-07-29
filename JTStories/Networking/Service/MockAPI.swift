//
//  Router.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

class MockAPI:APIProtocol{
    
    private var data:Data?
    func request<U>(endPoint: EndPoint, completion: @escaping (Result<U, APIServiceError>) -> Void) where U : Decodable, U : Encodable {
        let jsonFile = "mockResponse"
        if let path = Bundle.main.path(forResource: jsonFile, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                decode(completion: completion)
            } catch {
                completion(.failure(.noData))
            }
        }else{
            fatalError(jsonFile + ".json not found")
        }
    }
    
    func decode<U>(completion: @escaping (Result<U, APIServiceError>) -> Void) where U : Decodable {
        if let data = data {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            guard let result = try? decoder.decode(U.self, from: data) else{
                completion(.failure(.decodeError))
                return
            }
            completion(.success(result))
        }else{
            completion(.failure(.decodeError))
        }
    }
}
