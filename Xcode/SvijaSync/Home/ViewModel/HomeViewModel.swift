//
//  HomeViewModel.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 7/2/21.
//

import Foundation

protocol HomeViewModelInterface {
  var allConnections: [SiteConnection] { get }
  func stop(callback: () -> ())
  func fetchLastOwner(connection: SiteConnection, completion: @escaping (LastOwnerFetchCheck) -> ())
  func download(connection: SiteConnection, completion: @escaping (Bool) -> ())
  func upload(connection: SiteConnection, completion: @escaping (Bool) -> ())
  func uploadCheck(_ connection: SiteConnection) -> UploadFolderCheck
  func downloadCheck(_ connection: SiteConnection) -> DownloadFolderCheck
}

enum UploadFolderCheck {
	enum NameMismatch {
		case updated
		case created
		case none
	}
  case success
  case syncFolderNotFound
  case localPathExpired
  case subfoldersMissing
  case syncFolderEmpty
  case serverNameMismatch(NameMismatch)
  case nickNameMissing
}

enum DownloadFolderCheck {
  case success
  case localPathExpired
  case filesExists
}

enum LastOwnerFetchCheck {
  case success
  case fail
  case projectFolderMissing
}

class HomeViewModel: HomeViewModelInterface  {
  
  let siteOperation = SiteConnectionOperation()
  
  var allConnections: [SiteConnection] {
    var allConnections = siteOperation.allConnections.sorted(by: { $0.server < $1.server })
    if let index = allConnections.firstIndex(where: { $0.isDefault }) {
      let primary = allConnections[index]
      allConnections.remove(at: index)
      allConnections.insert(primary, at: 0)
    }
    return allConnections
  }
  
	func fetchLastOwner(connection: SiteConnection, completion: @escaping (LastOwnerFetchCheck) -> ()) {
		let localUrl = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
		guard localUrl?.startAccessingSecurityScopedResource() ?? false else {
			completion(.fail)
			return
		}
		guard FileManager.default.fileExists(atPath: connection.localPath) else {
			completion(.projectFolderMissing)
			return
		}
		guard FileManager.createSyncDirectoryIfNeeded(at: connection.localPath) else {
			completion(.fail)
			return
		}
		
		RsyncManager.shared.execute(.fetchLastOwner, connection: connection) {  result in
			switch result {
			case .success: completion(.success)
				//case .failure: completion(.fail)
			case .failure: completion(.success)
				
			}
			localUrl?.stopAccessingSecurityScopedResource()
		}
		
	}
  
  func download(connection: SiteConnection, completion: @escaping (Bool) -> ()) {
    let localUrl = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
    guard localUrl?.startAccessingSecurityScopedResource() ?? false else {
      completion(false)
      return
    }
    guard FileManager.createSyncDirectoryIfNeeded(at: connection.localPath) else { return }
    RsyncManager.shared.execute(.download, connection: connection) {  result in
      switch result {
      case let .success(status): completion(status)
      case .failure: completion(false)
        localUrl?.stopAccessingSecurityScopedResource()
      }
    }
  }
  
  func upload(connection: SiteConnection, completion: @escaping (Bool) -> ()) {
    let localUrl = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
    guard localUrl?.startAccessingSecurityScopedResource() ?? false else {
      completion(false)
      return
    }
    do {
      guard let name = Utility.shared.nickName else {
        completion(false)
        return
      }
      try name.write(toFile: connection.localLastModifiedFilePath, atomically: true, encoding: .utf8)
      RsyncManager.shared.execute(.upload, connection: connection) {  result in
        switch result {
        case let .success(status): completion(status)
        case .failure: completion(false)
          localUrl?.stopAccessingSecurityScopedResource()
        }
      }
      
    } catch {
      completion(false)
    }
  }
  
  func downloadCheck(_ connection: SiteConnection) -> DownloadFolderCheck {
    let url = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
    defer {
      url?.stopAccessingSecurityScopedResource()
    }
    guard let localUrl = url, localUrl.startAccessingSecurityScopedResource() else { return .localPathExpired }
    
    guard localUrl.path == connection.localPath else { return .localPathExpired }
    
    guard FileManager.createSyncDirectoryIfNeeded(at: connection.localPath) else { return .localPathExpired }
    
    let files = (try? FileManager.default.contentsOfDirectory(
                        at: localUrl.appendingPathComponent("SYNC"),
                        includingPropertiesForKeys: nil,
                        options: []) ) ?? []
    if files.count >= Constant.downloadMinFilesCount { return .filesExists }
    return .success
  }
  
  func uploadCheck(_ connection: SiteConnection) -> UploadFolderCheck {
    let url = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
    defer {
      url?.stopAccessingSecurityScopedResource()
    }
    guard let localUrl = url, localUrl.startAccessingSecurityScopedResource() else { return .localPathExpired }
    guard localUrl.path == connection.localPath else { return .localPathExpired }
    
    guard FileManager.default.fileExists(atPath: connection.localSyncPath) else { return .syncFolderNotFound }
    
    let subFolders = (try? FileManager.default.contentsOfDirectory(
                        at: localUrl.appendingPathComponent("SYNC/SVIJA"),
                        includingPropertiesForKeys: nil,
                        options: []).filter { $0.hasDirectoryPath } ) ?? []
    
    if subFolders.isEmpty { return .syncFolderEmpty }
    
    if subFolders.count < Constant.syncSubFolderCount { return .subfoldersMissing }
    
    guard let name = Utility.shared.nickName else { return .nickNameMissing }
    
	  if !connection.lastOwner.isEmpty, connection.lastOwner != name {
		  if connection.lastOwner.localizedStandardContains("updated") {
			  return .serverNameMismatch(.updated)
		  } else if connection.lastOwner.localizedStandardContains("created") {
			  return .serverNameMismatch(.created)
		  } else {
			  return .serverNameMismatch(.none)
		  }
	  }
    
    return .success
  }
  
  func stop(callback: () -> ()) {
    RsyncManager.shared.stop(callback: callback)
  }
  
}
