//  Created by ayu on 05/08/21.

import Foundation

enum Constants {
    static let wiresUrl = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
    static let simpsonsUrl = "http://api.duckduckgo.com/?q=simpsons+characters&format=json"
    
    static let invalidData = "Invalid Data"
    static let parsingFailure = "Parsing Failure"
    static let requestFailure = "Request Failure"
    static let somethingWrongError = "Something Wrong. Please Try later."
}

#if SIMPSONS
let endpoint = SimpsonsEndPoint.get
#else
let endpoint = WiresEndPoint.get
#endif

