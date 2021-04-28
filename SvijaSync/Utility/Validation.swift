//
//  Validation.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 5/3/21.
//

import Foundation

enum ValidationRule {
    case name
    case url
}

extension String {

    func isValidEntry( _ validation: ValidationRule) -> Bool {
        let characters: CharacterSet
        switch validation {
        case .name:
            characters = CharacterSet.special
                .union(.accentedCharacters)
                .union(.pureAlphanumerics)
                .union(CharacterSet(charactersIn: ",'"))
        case .url:
            characters = CharacterSet.special.union(.pureAlphanumerics)
        }
        return rangeOfCharacter(from: characters.inverted) == nil
    }

}
