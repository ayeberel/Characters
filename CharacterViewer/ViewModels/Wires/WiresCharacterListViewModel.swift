//  Created by ayu on 05/08/21.

import Foundation

class WiresListViewModel: CharacterViewModelable {
    let wiresService = WiresService()
    var characterList: Character?
    var onCompletion: (()->())? = nil
    
    func fetchData() {
        wiresService.getCharacterList(from: WiresEndPoint.get) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characterList = characters
                    if let completion = self?.onCompletion {
                        completion()
                    }
                case .failure:
                    if let completion = self?.onCompletion {
                        completion()
                    }
                }
            }
        }
    }
    
    func numberOfCharacters() -> Int {
        characterList?.relatedTopics.count ?? 0
    }
    
    func getCharacters(at row: Int) -> RelatedTopic? {
       return characterList?.relatedTopics[row]
    }
    
    func getTitle(at row: Int) -> String? {
        let result = characterList?.relatedTopics[row]
        let title = result?.text.components(separatedBy: "-").first
        
        return title
    }
}
