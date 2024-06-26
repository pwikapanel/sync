//
//  FileManagerExtensions.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 15/2/21.
//

import Cocoa

extension FileManager {

    static func createDirectoryIfNeeded(fullPath: String) -> Bool {
        guard !FileManager.default.fileExists(atPath: fullPath) else { return true }
        do {
            try FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            return false
        }
    }

    static func createSyncDirectoryIfNeeded(at path: String) -> Bool {
        createDirectoryIfNeeded(fullPath: path + "/SYNC")
    }

}
