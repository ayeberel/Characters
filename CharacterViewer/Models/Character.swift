//  Created by ayu on 05/08/21.

import Foundation

// MARK: - Common Simpsons/Wire Characters Model
struct Character: Codable {
    let relatedTopics: [CharacterInfo]

    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
}

struct CharacterInfo: Codable {
    let firstURL: String
    let icon: Icon
    let result, text: String

    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

struct Icon: Codable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
}
