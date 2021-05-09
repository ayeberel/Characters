//  Created by ayu on 5/8/21.

import Foundation

protocol CharacterViewModelable {
    func fetchData()
    var onCompletion: ((NetworkError?)->())? {get set}
    func getCharacters(at row: Int, isFiltering: Bool) -> ViewModelable?
    func numberOfCharacters(isFiltering: Bool) -> Int
    func getTitle(at row: Int, isFiltering: Bool) -> String?
    func filterCharacterList(for searchText: String) -> [CharacterViewModel]?
}

protocol ViewModelable {
    func getDescription() -> String?    
    func getImageUrl() -> String?
    func getTitle() -> String
}

extension CharacterViewModelable {
    func numberOfCharacters(isFiltered: Bool) -> Int {
        return numberOfCharacters(isFiltering: isFiltered)
    }
    
    func getTitle(at row: Int, isFiltering: Bool) -> String? {
        return getTitle(at: row, isFiltering: isFiltering)
    }
}
