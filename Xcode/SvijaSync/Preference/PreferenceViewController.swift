//
//  PreferenceViewController.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 6/2/21.
//

import Cocoa
import WebKit

class PreferenceViewController: NSViewController {

    @IBOutlet weak var nameFieldLabel: NSTextField!
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var formView: FormFieldView!
    @IBOutlet weak var listView: ConnectionListView!
    @IBOutlet weak var removeButton: NSButton!
    @IBOutlet weak var modifyButton: NSButton!
    @IBOutlet weak var makeDefaultButton: NSButton!
    @IBOutlet weak var doneButton: NSButton!

    private lazy var viewModel: PreferenceViewModelInterface = PreferenceViewModel()

    private var selectedSite: SiteConnection?

    var doneAction: (() -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = view.frame.size

      // hide default button because no longer used
      makeDefaultButton.isHidden = true
      
        nameField.stringValue = Utility.shared.nickName ?? ""
        nameField.placeholderString = Text.Preference.TextPlaceholder.nickname
        nameFieldLabel.stringValue = Text.Preference.Label.nickname
        nameField.toolTip = Text.Preference.Tooltip.nickname

        formView.viewModel = viewModel
        listView.viewModel = viewModel
        listView.viewDidLoad()

        removeButton.title = Text.Preference.Button.remove
        modifyButton.title = Text.Preference.Button.modify
        makeDefaultButton.title = Text.Preference.Button.makeDefault
        doneButton.title = Text.Preference.Button.done
        removeButton.toolTip = Text.Preference.Tooltip.remove
        modifyButton.toolTip = Text.Preference.Tooltip.modify
        makeDefaultButton.toolTip = Text.Preference.Tooltip.makeDefault
        doneButton.toolTip = Text.Preference.Tooltip.done

        [removeButton, modifyButton, makeDefaultButton].forEach { $0?.isEnabled = false }

        listView.listSelectionChanged = { [weak self] site in
            self?.selectedSite = site
            self?.refreshButtons()
            self?.modifyButton.title =  Text.Preference.Button.modify
            self?.removeButton.title =  Text.Preference.Button.remove
        }

        viewModel.preferenceDidUpdate = { [weak self] connection, status in
            self?.listView.preferenceUpdated()
            self?.selectedSite = nil
            switch status {
            case .modify:
                self?.modifyButton.title = Text.Preference.Button.undo
                self?.modifyButton.toolTip = Text.Preference.Tooltip.undo
            case .remove:
                self?.removeButton.title = Text.Preference.Button.undo
                self?.removeButton.toolTip = Text.Preference.Tooltip.undo
            case .add, .changeDefault: break
            case .undo:
                self?.modifyButton.title =  Text.Preference.Button.modify
                self?.removeButton.title =  Text.Preference.Button.remove
                self?.modifyButton.toolTip = Text.Preference.Tooltip.modify
                self?.removeButton.toolTip = Text.Preference.Tooltip.remove
            }
            self?.refreshButtons()
        }
    }

    @IBAction func removeButtonAction(_ sender: Any) {
        if removeButton.title == Text.Preference.Button.undo {
            viewModel.undo()
        } else if let connection = selectedSite {
            viewModel.remove(site: connection)
            selectedSite = nil
            refreshButtons()
        }
    }

    @IBAction func modifyButtonAction(_ sender: Any) {
        if modifyButton.title == Text.Preference.Button.undo {
            viewModel.undo()
        } else if let connection = selectedSite {
            formView.configure(connection)
        }
    }

    @IBAction func makeDefaultButtonAction(_ sender: Any) {
        if let connection = selectedSite {
            viewModel.makeDefault(site: connection)
        }
    }

    @IBAction func doneButtonAction(_ sender: Any) {
        guard let name = nameField.text else {
            showAlert(message: Text.Alert.Title.enterName, info: Text.Alert.Message.enterName)
            return
        }

        guard name.isValidEntry(.name) else {
            showAlert(message: Text.Alert.Title.invalidCharacters, info: Text.Alert.Message.invalidCharacters)
            return
        }
        viewModel.saveName(name)
        doneAction?()
        dismiss(self)
    }

    private func refreshButtons() {
        [removeButton, modifyButton].forEach { $0?.isEnabled = (self.selectedSite != nil) || $0?.title == Text.Preference.Button.undo }
        makeDefaultButton.isEnabled = viewModel.activeConnections.count >= 2 && selectedSite != nil && !(selectedSite?.isDefault ?? false)
    }

}


extension PreferenceViewController {

    static func makeModule() -> Self {
        guard let vc =  NSStoryboard.main?.instantiateController(withIdentifier: "PreferenceViewController") as? Self else { fatalError() }
        return vc
    }
    
}
