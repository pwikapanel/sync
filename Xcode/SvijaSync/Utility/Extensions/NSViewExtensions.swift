//
//  NSViewExtensions.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 12/2/21.
//

import Cocoa

enum AlertAction: Int {
    case ok = 1000
    case cancel = 1001
    case unknown = 0
}

extension NSView {

    func showAlert(
        message: String,
        info: String,
        style: NSAlert.Style = .warning,
        okButton: String = Text.Alert.ok,
        cancelButton: String = "",
		defaultAction: AlertAction? = nil,
        callback: ((AlertAction) -> ())? = nil
    ) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = info
        alert.alertStyle = style
        var buttonCount = 0
        if !okButton.isEmpty {
            let button = alert.addButton(withTitle: okButton)
			if defaultAction == .ok {
				button.keyEquivalent = "\r"
			}
            buttonCount += 1
        }
        if !cancelButton.isEmpty {
			let button = alert.addButton(withTitle: cancelButton)
			if defaultAction == .cancel {
				button.keyEquivalent = "\r"
			}
            buttonCount += 1
        }
        alert.beginSheetModal(for: self.window!) { response in
            if buttonCount == 1 {
                callback?(.ok)
                return
            }

            guard let action = AlertAction(rawValue: response.rawValue) else {
                callback?(.unknown)
                return
            }
            callback?(action)
        }
    }

}
