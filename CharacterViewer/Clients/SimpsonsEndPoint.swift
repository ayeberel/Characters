//  Created by ayu on 05/08/21.

import Foundation

enum SimpsonsEndPoint {
    case get
}
extension SimpsonsEndPoint: Endpoint {
    
    var path: String {
        switch self {
        case .get: return Constants.simpsonsUrl
        }
    }
}
