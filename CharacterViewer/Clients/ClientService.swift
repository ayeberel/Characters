//  Created by ayu on 05/08/21.

import Foundation

class ClientService: ServiceClient {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func getCharacterList(from simpsonsEndPoint: Endpoint, completion: @escaping (Result<Character?, NetworkError>) -> Void) {
        fetchData(with: simpsonsEndPoint.request , decode: { json -> Character? in
            guard let result = json as? Character else { return  nil }
            return result
        }, completion: completion)
    }
}
