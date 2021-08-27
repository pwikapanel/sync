//
//  File.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 11/2/21.
//

import Foundation
import Rsync

enum ConnectionSaveStatus {
    case duplicate
    case unknown
    case success
}

class SiteConnectionOperation {

    var allConnections: [SiteConnection] {
        guard let data: Data = Storage.value(key: Key.siteConnection), let connections = [SiteConnection].decode(data) else { return [] }
        return connections
    }

    func connectionExist(_ connection: SiteConnection) -> Bool {
        allConnections.contains { $0.uuid == connection.uuid }
    }

    func anyExistingServer(_ connection: SiteConnection) -> SiteConnection? {
        allConnections.first { $0.server == connection.server }
    }

    func makeDefault(site: SiteConnection) {
        var connections = allConnections
        if let index = connections.firstIndex(where: { $0.isDefault == true }) {
            // var current = connections[index]
            // current.isDefault = false
            // connections[index] = current
            connections[index].isDefault = false
        }

        if let index = connections.firstIndex (where: { $0.uuid == site.uuid }) {
            var current = connections[index]
            current.isDefault = true
            connections[index] = current
        }
        Storage.save(connections.encoded, key: Key.siteConnection)
    }

    func remove(site: SiteConnection) {
        var connections = allConnections
        if let index = connections.firstIndex(where: { $0.uuid == site.uuid }) {
            connections.remove(at: index)
            Storage.save(connections.encoded, key: Key.siteConnection)
        }
    }

    func add(site: SiteConnection) -> ConnectionSaveStatus {
        var connections = allConnections

        guard !connections.contains(where: { $0.server == site.server || $0.uuid == site.uuid }) else { return .duplicate }
        connections.append(site)

        guard let encoded = connections.encoded else { return .unknown }
        Storage.save(encoded, key: Key.siteConnection)
        return .success
    }

    func modify(site: SiteConnection) -> (status: ConnectionSaveStatus, site:  SiteConnection) {
        var connections = allConnections
        var connection = site
        if let index = connections.firstIndex(where: { $0.server == site.server }) {
            connection = connections[index]
            connections[index] = connection.copy(from: site)
        } else if let index = connections.firstIndex(where: { $0.uuid == site.uuid }) {
            connection = connections[index]
            connections[index] = site
        } else {
            return (.unknown, site)
        }

        guard let encoded = connections.encoded else { return (.unknown, site) }
        Storage.save(encoded, key: Key.siteConnection)
        return (.success, connection)
    }

}
