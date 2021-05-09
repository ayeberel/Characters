//  Created by ayu on 05/08/21.

import Foundation

class SimpsonsListViewModel: CharacterViewModelable {
    let simpsonsService = SimpsonsService()
    var characterList: Character?
    var onCompletion: (()->())? = nil
    
    func fetchData() {
        simpsonsService.getCharacterList(from: SimpsonsEndPoint.get) { [weak self] result in
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
    
    func getCharacters(at row: Int) -> CharacterInfo? {
       return characterList?.relatedTopics[row]
    }
    
    func getTitle(at row: Int) -> String? {
        let result = characterList?.relatedTopics[row]
        let title = result?.text.components(separatedBy: "-").first
        
        return title
    }
}
