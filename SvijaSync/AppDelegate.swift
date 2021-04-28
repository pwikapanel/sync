//
//  AppDelegate.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 2/2/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        guard !shouldTerminate else {
            handleTerminationConfirmation()
            return .terminateCancel
        }
        return .terminateNow
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        guard !shouldTerminate else {
            handleTerminationConfirmation()
            return false
        }
        return true
    }

    private var shouldTerminate: Bool {
        Utility.shared.isProcessRunning
    }

    private func handleTerminationConfirmation() {
        let vc = NSApplication.shared.windows.first?.windowController?.contentViewController
        vc?.showAlert(
            message: Text.Alert.Confirmation.Title.areYouSure,
            info: Text.Alert.Confirmation.Message.quitAppWhenDownload,
            okButton: Text.Alert.continue,
            cancelButton: Text.Alert.cancel
        ) { action in
            if action == .ok {
                Utility.shared.isProcessRunning = false
                NSApplication.shared.terminate(self)
            }
        }
    }

}

