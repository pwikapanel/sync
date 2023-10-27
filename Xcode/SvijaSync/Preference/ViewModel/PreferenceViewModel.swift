//
//  PreferenceViewModel.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 7/2/21.
//

import Foundation

enum PreferenceUpdate {
    case add
    case modify
    case remove
    case undo
}

protocol PreferenceFormInterface {
    var numberOfConnections: Int { get }
    func add(_ connection: SiteConnection) -> ConnectionSaveStatus
    func modify(_ connection: SiteConnection) -> ConnectionSaveStatus
    func checkConnection(_ connection: SiteConnection, completion: @escaping (Bool) -> ())
}

protocol PreferenceListInterface {
    var activeConnections: [SiteConnection] { get }
}

protocol PreferenceViewModelInterface: PreferenceFormInterface, PreferenceListInterface {

    var lastConnection: SiteConnection? { get set }
    func remove(site: SiteConnection)
    func saveName(_ name: String)
    var preferenceDidUpdate: ((SiteConnection, PreferenceUpdate) -> ())? { get set }
    func undo()
}

final class PreferenceViewModel: PreferenceViewModelInterface {

    var lastConnection: SiteConnection?
    var preferenceDidUpdate: ((SiteConnection, PreferenceUpdate) -> ())?

    private let siteOperations = SiteConnectionOperation()

    func remove(site: SiteConnection) {
        siteOperations.remove(site: site)
        preferenceDidUpdate?(site, .remove)
        lastConnection = site
    }

    func saveName(_ name: String) {
        Storage.save(name, key: Key.userNickName)
    }

    func undo() {
        debugPrint("Preparing undo")
        guard let connection = lastConnection else { return }
        debugPrint("Connection found - \(connection)")
        let status: ConnectionSaveStatus
        if siteOperations.connectionExist(connection) {
            debugPrint("Connection exist - \(connection)")
            status = siteOperations.modify(site: connection).status
        } else {
            debugPrint("Connection not exist - \(connection)")
            status = siteOperations.add(site: connection)
        }
        if status == .success {
            debugPrint("Connection undo success - \(connection)")
            preferenceDidUpdate?(connection, .undo)
        } else {
            debugPrint("Connection undo failed - \(status)")
        }
        lastConnection = nil
    }

}

extension PreferenceViewModel: PreferenceFormInterface {

    var numberOfConnections: Int {
        return activeConnections.count
    }

    func checkConnection(_ connection: SiteConnection, completion: @escaping (Bool) -> ()) {
        RsyncManager.shared.execute(.checkConnection, connection: connection) { result in
            switch result {
            case let .success(status): completion(status)
            case .failure: completion(false)
            }
        }
    }

    func add(_ connection: SiteConnection) -> ConnectionSaveStatus {
        var connection = connection
        if let con = siteOperations.anyExistingServer(connection) {
            connection.isDefault = con.isDefault
            siteOperations.remove(site: con)
            debugPrint("Existing connection with same server found \(con.server). Removing without warning")
        }
        let status = siteOperations.add(site: connection)
        if status == .success {
			siteOperations.makeDefault(site: connection)
            preferenceDidUpdate?(connection, .add)
			
        }
        return status
    }

    func modify(_ connection: SiteConnection) -> ConnectionSaveStatus {
        let output = siteOperations.modify(site: connection)
        if output.status == .success {
            preferenceDidUpdate?(output.site, .modify)
        }
        lastConnection = output.site
        return output.status
    }
    
}

extension PreferenceViewModel: PreferenceListInterface {

    var activeConnections: [SiteConnection] { siteOperations.allConnections }

}
