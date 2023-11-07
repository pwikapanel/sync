//
//  HomeSyncStatusHandler.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 17/2/21.
//

import Cocoa

class HomeSyncStatusHandler: NSObject {

    weak var target: NSViewController?

    func handleDownloadCheck(_ status: DownloadFolderCheck, completion: @escaping (Bool) -> ()) {
        switch status {
        case .success:
            completion(true)
        case .localPathExpired:
            target?.showAlert(message: Text.Alert.Title.inaccessible, info: Text.Alert.Message.inaccessible)
            completion(false)
        case .filesExists:
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
		case let .serverNameMismatch(reason):
			switch reason {
			case .updated:
				target?.showAlert(
					message: Text.Alert.Title.siteUpdated,
					info: Text.Alert.Message.siteUpdated,
					okButton: Text.Alert.cancel,
					cancelButton: Text.Alert.continue,
					defaultAction: .ok,
					callback: { action in
						completion(action == .cancel) // here cancel and ok button positions are switched
					})
			case .created:
				completion(true)
			case .none:
				target?.showAlert(message: Text.Alert.Confirmation.Title.areYouSure, info: "\(con.lastOwner)\(Text.Alert.Confirmation.Message.lastOwnerChanged)", okButton: Text.Alert.continue, cancelButton: Text.Alert.cancel) { action in
					completion(action == .ok)
				}
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
