//
//  UploadStatus.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 23/5/21.
//

import Foundation

enum UploadStatus: String {
    case ready
    case lastOwnerCheck
    case uploading
    case completed
    case terminate
}
