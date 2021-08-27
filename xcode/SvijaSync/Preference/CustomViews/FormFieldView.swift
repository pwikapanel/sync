//
//  FormFieldView.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 7/2/21.
//

import Cocoa
import Rsync

class FormFieldView: NSView {

    @IBOutlet weak var urlFieldLabel: NSTextField!
    @IBOutlet weak var connectIdFieldLabel: NSTextField!
    @IBOutlet weak var passwordFieldLabel: NSTextField!

    @IBOutlet weak var urlField: NSTextField!
    @IBOutlet weak var connectIdField: NSTextField!
    @IBOutlet weak var passwordField: NSTextField!
    @IBOutlet weak var addButton: NSButton!

    var viewModel: PreferenceFormInterface!
    private var connection: SiteConnection?

    override func awakeFromNib() {
        super.awakeFromNib()
        checkFields()
        [urlField, connectIdField, passwordField].forEach { $0?.delegate = self }
        urlField.placeholderString = Text.Preference.TextPlaceholder.url
        connectIdField.placeholderString = Text.Preference.TextPlaceholder.connectId

        urlFieldLabel.stringValue = Text.Preference.Label.url
        connectIdFieldLabel.placeholderString = Text.Preference.Label.connectId
        passwordFieldLabel.placeholderString = Text.Preference.Label.password
        addButton.title = Text.Preference.Button.add
        addButton.toolTip = Text.Preference.Tooltip.add
        urlField.toolTip = Text.Preference.Tooltip.url
        connectIdField.toolTip = Text.Preference.Tooltip.connectID
        passwordField.toolTip = Text.Preference.Tooltip.password
    }

    func configure(_ connection: SiteConnection) {
        self.connection = connection
        addButton.title = Text.Preference.Button.update
        addButton.toolTip = Text.Preference.Tooltip.update
        urlField.stringValue = connection.server
        connectIdField.stringValue = connection.username
        passwordField.stringValue = connection.password
        checkFields()
    }

    @IBAction func addButtonAction(_ sender: NSButton) {

        guard let url  = urlField.text,
              url.isValidEntry(.url),
              let connectId = connectIdField.text,
              connectId.isValidEntry(.url),
              let password = passwordField.text,
              password.isValidEntry(.url) else {
            showAlert(message: Text.Alert.Title.invalidCharacters, info: Text.Alert.Message.invalidCharacters)
            return
        }

        let uuid = connection?.uuid ?? UUID().uuidString

        guard let localUrl = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: uuid, force: true) else {
            return
        }

        guard localUrl.lastPathComponent != "sync" else {
            showAlert(message: Text.Alert.Title.selectProjectFolderWithoutSync, info: Text.Alert.Message.selectProjectFolderWithoutSync)
            return
        }

        let con: SiteConnection
        if let connection = connection {
            con = SiteConnection(
                uuid: connection.uuid,
                server: url,
                username: connectId,
                password: password,
                localPath: localUrl.path,
                timestamp: .epochNow,
                isDefault: connection.isDefault
            )
            modify(con)

        } else {
            con = SiteConnection(
                uuid: uuid,
                server: url,
                username: connectId,
                password: password,
                localPath: localUrl.path,
                timestamp: .epochNow,
                isDefault: false
            )
            if viewModel.numberOfConnections < Constant.maxConnections {
                add(con)
            } else {
                showAlert(message: Text.Alert.Title.siteLimit, info: Text.Alert.Message.siteLimit)
            }
        }

    }
    
    private func modify(_ connection: SiteConnection) {
        handle(status: viewModel.modify(connection))
    }

    private func add(_ connection: SiteConnection) {
        handle(status: viewModel.add(connection))
    }

    private func handle(status: ConnectionSaveStatus) {
        switch status {
        case .duplicate:
            showAlert(message: Text.Alert.Title.duplicateSite, info: Text.Alert.Message.duplicateSite, callback: {_ in })
        case .unknown:
            showAlert(message: Text.Alert.Title.unknown, info: Text.Alert.Message.unknown, callback: {_ in })
        case .success:
            clear()
            checkFields()
            addButton.title = Text.Preference.Button.add
            addButton.toolTip = Text.Preference.Tooltip.add
        }
    }

    private func clear() {
        [urlField, connectIdField, passwordField].forEach {
            $0?.stringValue = ""
            $0?.isEnabled = false
            $0?.isEnabled = true
        }
        connection = nil
    }

    private func checkFields() {
       let disabled = [urlField, connectIdField, passwordField].contains { ($0?.text?.count ?? 0) == 0 }
        addButton.isEnabled = !disabled
    }
    
}

extension FormFieldView: NSTextFieldDelegate {

    func controlTextDidChange(_ obj: Notification) {
        checkFields()
    }

}
