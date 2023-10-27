//
//  Logger.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup  on 26/10/2023.
//

import Foundation
import SwiftyBeaver

let log = SwiftyBeaver.self

enum Logger {
	static var currentFileDestination: FileDestination?
	
	static func addConsoleLog() {
		let console = ConsoleDestination()  // log to Xcode Console
		log.addDestination(console)
	}
	
	static func addLog(on url: URL) {
		if let currentFileDestination {
			log.removeDestination(currentFileDestination)
		}
		let file = FileDestination(logFileURL: url)
		file.logFileMaxSize = 1024 * 5 // 5 KB
		file.logFileAmount = 2
		log.addDestination(file)
		currentFileDestination = file
	}
}

extension SiteConnection {

	func addLog() {
		let localUrl = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: uuid)
		guard localUrl?.startAccessingSecurityScopedResource() ?? false else {
			return
		}
		if FileManager.createDirectoryIfNeeded(fullPath: localLogPath) {
			let logUrl = URL(fileURLWithPath: localLogPath + "Log.txt")
			Logger.addLog(on: logUrl)
		}
		localUrl?.stopAccessingSecurityScopedResource()
	}

}
