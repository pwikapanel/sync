//
//  DateExtensions.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 19/2/21.
//

import Foundation

extension Date {

    var secondsDifferenceNow: Int {
        let diffComponents = Calendar.current.dateComponents([.second], from: self, to: Date())
        return diffComponents.second ?? 0
    }

}
