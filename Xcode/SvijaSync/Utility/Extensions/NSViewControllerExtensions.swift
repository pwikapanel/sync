//
//  NSViewControllerExtensions.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 12/2/21.
//

import Cocoa

extension NSViewController {

    func showAlert(
        message: String,
        info: String,
        style: NSAlert.Style = .warning,
        okButton: String = Text.Alert.ok,
        cancelButton: String = "",
		defaultAction: AlertAction? = nil,
        callback: ((AlertAction) -> ())? = nil
    ) {

        view.showAlert(message: message, info: info, style: style, okButton: okButton, cancelButton: cancelButton, defaultAction: defaultAction, callback: callback)
    }

}
