//  Created by ayu on 05/08/21.

import Foundation

enum NetworkError: Error {
    case parsingFailure
    case invalidData
    case requestFailure
    case somethingWrongError
    
    var description: String {
        switch self {
        case .invalidData: return Constants.invalidData
        case .parsingFailure: return Constants.parsingFailure
        case .requestFailure: return Constants.requestFailure
        case .somethingWrongError: return Constants.somethingWrongError
        }
    }
}
