//
//  CodableExtension.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 11/2/21.
//

import Foundation

extension Encodable {

    var encoded: Data? {
        try? JSONEncoder().encode(self)
    }
    
}

extension Decodable {

    static func decode(_ data: Data) -> Self? {
        try? JSONDecoder().decode(Self.self, from: data)
    }
}

