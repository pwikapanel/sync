//
//  RsyncManager.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 30/1/21.
//

import Foundation

public enum OperationType {
    case checkConnection
    case fetchLastOwner
    case download
    case upload
}

public protocol RsyncManagerInterface {
    func execute(_ operation: OperationType, connection: SiteConnection, callback: @escaping BashCallBack)
    func stop(callback: () -> ())
}

public class RsyncManager: RsyncManagerInterface {

    public static let shared = RsyncManager()

    private lazy var bash: BashExecuter = BashExecuter(successCheck: successCheck)

    public func stop(callback: () -> ()) {
        bash.stop(callback: callback)
    }
	
	/// A Helper function to quickly check the version of rsync, This will provide a callback failed , however the console will print the rsync version.
	public func checkVersion(callback: @escaping BashCallBack) {
		let finalArgs = [rsyncArg, successCheck]
		execute(Script(file: "version", ext: "sh"), args: finalArgs, dirPath: "/", callback: callback)
	}

    public func execute(_ operation: OperationType, connection: SiteConnection, callback: @escaping BashCallBack) {
        execute(operation.script, args: connection.basicArgs, dirPath: connection.localPath, callback: callback)
    }

    private func execute(_ script: Script, args: [String], dirPath: String, callback: @escaping BashCallBack) {
		let finalArgs = [rsyncArg] + args
        bash.execute(script.file, type: script.ext, args: finalArgs, dirPath: dirPath, callback: callback)
    }
	
	private var rsyncArg: String {
		if #available(macOS 14, *) {
			guard let rsyncPath = Bundle.main.rsyncPath else {
				debugPrint("❌[IMPORTANT] RsyncManager \(#line): Error: Embeded rsync binary not found")
				debugPrint("❌[IMPORTANT] RsyncManager \(#line): Make sure to add rsync-debug executable to your current target.")
				return "rsync"
			}
			return rsyncPath
		} else {
			return "rsync"
		}
	}

}

let successCheck = "success"

fileprivate extension SiteConnection {

    // Remote connection, password, success check word
    var basicArgs: [String] { [remoteSyncAddress, password, successCheck] }

}

fileprivate extension OperationType {

    var script: Script {
        var file = ""
        switch self {
        case .checkConnection: file = "check-connection"
        case .fetchLastOwner: file = "last-owner"
        case .download: file = "download"
        case .upload: file = "upload"
        }
        return Script(file: file, ext: "sh")
    }

}

fileprivate struct Script {
    let file: String
    let ext: String
}

private extension Bundle {
	
	var rsyncPath: String? {
		#if DEBUG
		path(forResource: "rsync-debug", ofType:nil)
		#else
		path(forResource: "rsync", ofType:nil)
		#endif
	}

}
