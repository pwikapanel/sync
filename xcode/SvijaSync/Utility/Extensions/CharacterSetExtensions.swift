//
//  CharacterSetExtensions.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 5/3/21.
//

import Foundation

extension CharacterSet {

    static var special: CharacterSet {
        CharacterSet(charactersIn: "-_. ")
    }

    static var pureAlphanumerics: CharacterSet {
        let alphabets = "abcdefghijklmnopqrstuvwxyz"
        return CharacterSet(charactersIn: alphabets + alphabets.map { $0.uppercased()}.joined() + "0123456789")
    }

    static var accentedCharacters: CharacterSet {
        CharacterSet(charactersIn: "àèìòùÀÈÌÒÙáéíóúýÁÉÍÓÚÝâêîôûÂÊÎÔÛãñõÃÑÕäëïöüÿÄËÏÖÜŸåÅæÆœŒçÇðÐøØß")
    }

}
