//
//  HomeSyncStatusHandler.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 17/2/21.
//

import Cocoa
import Rsync

class HomeSyncStatusHandler: NSObject {

    weak var target: NSViewController?

    func handleDownloadCheck(_ status: DownloadFolderCheck, completion: @escaping (Bool) -> ()) {
        switch status {
        case .success:
            completion(true)
        case .localPathExpired:
            target?.showAlert(message: Text.Alert.Title.inaccessible, info: Text.Alert.Message.inaccessible)
            completion(false)
        case .subfoldersExists:
            target?.showAlert(message: Text.Alert.Confirmation.Title.areYouSure, info: Text.Alert.Confirmation.Message.localFileErase, okButton: Text.Alert.continue, cancelButton: Text.Alert.cancel) { action in
                completion(action == .ok)
            }
        }
    }


    func handleUploadCheck(_ status: UploadFolderCheck, _ con: SiteConnection, completion: @escaping (Bool) -> ()) {
        switch status {
        case .success:
            completion(true)
        case .nickNameMissing:
            target?.showAlert(message: Text.Alert.Title.missingName, info: Text.Alert.Message.missingName)
            completion(false)
        case .localPathExpired:
            target?.showAlert(message: Text.Alert.Title.inaccessible, info: Text.Alert.Message.inaccessible)
            completion(false)
        case .serverNameMismatch:
            target?.showAlert(message: Text.Alert.Confirmation.Title.areYouSure, info: "\(con.lastOwner)\(Text.Alert.Confirmation.Message.lastOwnerChanged)", okButton: Text.Alert.continue, cancelButton: Text.Alert.cancel) { action in
                completion(action == .ok)
            }
        case .subfoldersMissing:
            target?.showAlert(message: Text.Alert.Title.projectFolderDamaged, info: Text.Alert.Message.projectFolderDamaged, okButton: Text.Alert.continue) { action in
                completion(false)
            }
        case .syncFolderNotFound, .syncFolderEmpty:
            target?.showAlert(message: Text.Alert.Title.nothingToUpload, info: Text.Alert.Message.nothingToUpload)
            completion(false)
        }
    }
}
