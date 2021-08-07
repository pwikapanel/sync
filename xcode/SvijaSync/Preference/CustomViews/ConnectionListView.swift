//
//  ConnectionListView.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 7/2/21.
//

import Cocoa
import Rsync

class ConnectionListView: NSView {

    var viewModel: PreferenceListInterface!
    private var items: [SiteConnection] = []
    @IBOutlet weak var tableView: NSTableView!

    var listSelectionChanged: ((SiteConnection?) -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.allowsMultipleSelection = false
    }

    func viewDidLoad() {
        refresh()
    }

    func preferenceUpdated() {
        refresh()
    }

    private func refresh() {
        items = viewModel.activeConnections
        tableView.reloadData()
    }
    
}


extension ConnectionListView: NSTableViewDelegate, NSTableViewDataSource {
    
    fileprivate enum CellIdentifiers {
        static let URLCell = "URLCell"
        static let FolderCell = "FolderCell"
      }

    func numberOfRows(in tableView: NSTableView) -> Int {
        items.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let site = items[row]
        var text = ""
        var identifier = ""
        if tableColumn == tableView.tableColumns[0] {
//        text = (site.isDefault && items.count > 1)  ? "›" + site.server : site.server
          text = site.server
            identifier = CellIdentifiers.URLCell
            tableColumn?.headerCell.title = Text.Preference.ListHeader.url
        } else if tableColumn == tableView.tableColumns[1] {
            text = site.shortLocalPath
            identifier = CellIdentifiers.FolderCell
            tableColumn?.headerCell.title = Text.Preference.ListHeader.localFolder
        }

        guard let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), owner: nil) as? NSTableCellView else { return nil }
        cell.textField?.stringValue = text
        cell.textField?.toolTip = site.localPath
        return cell
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        guard tableView.selectedRow >= 0 else {
            listSelectionChanged?(nil)
            return
        }
        let item = items[tableView.selectedRow]
        listSelectionChanged?(item)
    }

}
