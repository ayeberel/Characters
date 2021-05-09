//  Created by ayu on 05/08/21.

import Foundation

protocol Endpoint {
    var path: String { get }
}

extension Endpoint {
    var request: URLRequest {
        return URLRequest(url: URL(string: path)!)
    }
}

