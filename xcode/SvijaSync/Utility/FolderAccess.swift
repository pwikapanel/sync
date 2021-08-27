//
//  FolderSelection.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 6/2/21.
//

import Cocoa

class FolderAccess {

    static func promptDirectoryPermissionIfRequired(bookmarkKey: String, force: Bool = false) -> URL? {

        if !force, let url = restoreFileAccess(bookmarkKey: bookmarkKey) { return url }

        let openPanel = makePanel()
        openPanel.runModal()

        if let url = openPanel.urls.first {
            saveBookmarkData(url: url, key: bookmarkKey)
        }
        return openPanel.urls.first
    }

}

private extension FolderAccess {
    
    static func restoreFileAccess(bookmarkKey: String) -> URL? {
        guard let bookmarkData: Data = Storage.value(key: "bookmarkData-\(bookmarkKey)") else { return nil }
        do {
            var isStale = false
            let url = try URL(resolvingBookmarkData: bookmarkData, options: .withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)

            if isStale {
                saveBookmarkData(url: url, key: bookmarkKey)
            }
            
            return url
        } catch {
            print("Error resolving bookmark:", error)
            return nil
        }
    }

    static func saveBookmarkData(url: URL, key: String) {
        do {
            let bookmarkData = try url.bookmarkData(options: .withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            Storage.save(bookmarkData, key: "bookmarkData-\(key)")
        } catch {
            print("Failed to save bookmark data for \(url)", error)
        }
    }

    static func makePanel() -> NSOpenPanel {
        let openPanel = NSOpenPanel()
        openPanel.message = Text.Preference.OpenPanel.message
        openPanel.prompt = Text.Preference.OpenPanel.prompt
        openPanel.allowsOtherFileTypes = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        return openPanel
    }

}
