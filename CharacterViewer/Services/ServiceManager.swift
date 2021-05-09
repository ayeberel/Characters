//  Created by ayu on 4/22/21.

import Foundation

protocol ServiceClient {
    var session: URLSession { get }
    func fetchData<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkError>) -> Void)
}

extension ServiceClient {
    
    typealias CompletionHandler = (Decodable?, NetworkError?) -> Void

    func fetchData<T: Decodable>(with request: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = decodeTask(with: request, type: T.self) { response, error in
            DispatchQueue.main.async {
                guard let response = response else {
                    if error != nil {
                        completion(Result.failure(.invalidData))
                    } else {
                        completion(Result.failure(.parsingFailure))
                    }
                    return
                }
                if let result = decode(response) {
                    completion(.success(result))
                } else {
                    completion(.failure(.parsingFailure))
                }
            }
        }
        task.resume()
    }
    
    private func decodeTask<T: Decodable>(with request: URLRequest, type: T.Type, completionHandler completion: @escaping CompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailure)
                return
            }
            
            guard httpResponse.statusCode == 200, let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let responseJson = try JSONDecoder().decode(type, from: data)
                completion(responseJson, nil)
            } catch {
                completion(nil, .parsingFailure)
            }
        }
        return task
    }
}
