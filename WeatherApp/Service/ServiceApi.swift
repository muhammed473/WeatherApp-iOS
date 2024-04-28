//
//  ApiService2.swift
//  WeatherApp
//
//  Created by muhammed dursun on 23.04.2024.
//

import Foundation

public  class ServiceApi {
    
    public static let shared = ServiceApi()
    
    public   enum APIError: Error {
        case error(_ errorString: String)
    }
    
    public func getJSON<T:Decodable>(urlString:String,
                                     dateDecodingStrategy : JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                     keyDecodingStrategy : JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                     completion: @escaping(Result<T,APIError>) -> Void ){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: ""))))
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(.error("Error: \(error.localizedDescription)")))
                return
            }
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data mistake", comment: ""))))
                return
            }
            let  decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            }
            catch let decodingError{
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
        
        }.resume()
                   
    }
    
}
