//  Created by ayu on 05/08/21.

import Foundation

enum WiresEndPoint {
    case get
}
extension WiresEndPoint: Endpoint {
    
    var path: String {
        switch self {
        case .get: return Constants.wiresUrl
        }
    }
}
