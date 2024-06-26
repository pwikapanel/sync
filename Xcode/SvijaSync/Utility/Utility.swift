//
//  Utility.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 6/2/21.
//

import Cocoa

typealias Text = L10n

class Utility {

    static let shared = Utility()

    var isProcessRunning = false

    var nickName: String? {
        Storage.value(key: Key.userNickName)
    }

    var downloadProgressImages: [NSImage] {
        var images: [NSImage?] = []
        for n in (0...15) {
            images.append(NSImage(named: "progbar_down_any_\(n)"))
        }
        return images.compactMap { $0 }
    }

}
