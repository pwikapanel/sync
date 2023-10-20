//
//  SiteConnectionExtensions.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 11/2/21.
//

import Foundation

extension SiteConnection {
  
  var lastOwner: String {
    let last = try? String(contentsOfFile: localSyncPath + ".last", encoding: .utf8)
      .trimmingCharacters(in: .whitespacesAndNewlines)
    return last ?? ""
  }
  
  var shortLocalPath: String {
    Array(localSyncPath.components(separatedBy: "/").dropLast(2).suffix(2)).joined(separator: "/")
  }
  
  var adminUrl:   URL? { URL(string: "https://" + server + "/cloud/svija/") }
  var cacheUrl:   URL? { URL(string: "https://" + server + "/csync") }
  var siteUrl:    URL? { URL(string: "https://" + server) }
  
  func copy(from con: SiteConnection) -> SiteConnection {
    return SiteConnection(uuid: uuid, server: con.server, username: con.username, password: con.password, localPath: con.localPath, timestamp: con.timestamp, isDefault: con.isDefault)
  }
  
}
