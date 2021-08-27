//
//  Storage.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 6/2/21.
//

import Foundation

class Storage {

    static func save<T: Any>(_ value: T, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    static func value<T: Any>(key: String) -> T? {
        UserDefaults.standard.value(forKey: key) as? T
    }

}
