//  Created by ayu on 05/08/21.

import Foundation

class CharacterListViewModel: CharacterViewModelable {
    var clientService = ClientService()
    var characterList: [CharacterViewModel]?
    var filteredCharacterList: [CharacterViewModel]?
    var onCompletion: ((NetworkError?)->())? = nil
    
    func getCharacters(at row: Int, isFiltering: Bool) -> ViewModelable? {
        if !isFiltering {
            return characterList?[row]
        }
        return filteredCharacterList?[row]
    }
    
    //Filter characters based on the search text
    func filterCharacterList(for searchText: String) -> [CharacterViewModel]? {
        filteredCharacterList = characterList?.filter({ simpsonsViewModel -> Bool in
            return simpsonsViewModel.characterInfo?.result.contains(searchText) ?? false
        })
        
        return filteredCharacterList
    }
    
    //Return number of characters in the characters list
    func numberOfCharacters(isFiltering: Bool = false) -> Int {
        if !isFiltering {
            return characterList?.count ?? 0
        } else {
            return filteredCharacterList?.count ?? 0
        }
    }
    
    //Return title for the tableview row
    func getTitle(at row: Int, isFiltering: Bool = false) -> String? {
        var result: CharacterViewModel?
        if !isFiltering {
            result = characterList?[row]
        } else {
            result = filteredCharacterList?[row]
        }
        let title = result?.characterInfo?.text.components(separatedBy: "-").first
        return title
    }
    
    //Fetch Character data from the service
    func fetchData() {
        clientService.getCharacterList(from: endpoint) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self?.characterList = character?.relatedTopics.map {
                        CharacterViewModel($0)
                    }
                    if let completion = self?.onCompletion {
                        completion(nil)
                    }
                case .failure:
                    if let completion = self?.onCompletion {
                        completion(.somethingWrongError)
                    }
                }
            }
        }
    }
}
