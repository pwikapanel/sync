//
//  Constants.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 10/2/21.
//

import Foundation

enum Key {
    static let siteConnection = "Key.SiteConnection"
    static let userNickName = "Key.UserNickName"
}

enum Constant {
    static let newsUrl = "http://msg.svija.love/sync"

    static let uploadSyncTimeInterval: TimeInterval = 3.0
    static let downloadProgressTimeInterval: TimeInterval = 1.0
    static let maxConnections = 50
    static let syncSubFolderCount = 6
}
