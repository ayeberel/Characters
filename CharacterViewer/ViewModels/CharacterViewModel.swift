//  Created by ayu on 05/08/21.

import Foundation

struct CharacterViewModel: ViewModelable {
    let characterInfo: CharacterInfo?
    
    init(_ characterInfo: CharacterInfo?) {
        self.characterInfo = characterInfo
    }
    
    //Get the characters description
    func getDescription() -> String? {
        return characterInfo?.text
    }
    
    //Construct the image url from the base url and the icon url
    func getImageUrl() -> String? {
        if let firstUrl = characterInfo?.firstURL, let iconUrl = characterInfo?.icon.url {
           return firstUrl + iconUrl
        }
        return nil
    }
    
    //The title of the character is part of the description in the json response
    func getTitle() -> String {
        return characterInfo?.text.components(separatedBy: "-").first ?? ""
    }
}
