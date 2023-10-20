//
//  AppDelegate.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 2/2/21.
//

import Cocoa
import SwiftyBeaver

let log = SwiftyBeaver.self

@main
class AppDelegate: NSObject, NSApplicationDelegate {
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  //https://stackoverflow.com/questions/45231879/how-to-delete-emoji-symbols-and-dictation-in-menu-bar
  func applicationWillFinishLaunching(_ notification: Notification) {
    UserDefaults.standard.set(true, forKey: "NSDisabledDictationMenuItem")
    UserDefaults.standard.set(true, forKey: "NSDisabledCharacterPaletteMenuItem")
	  let file = FileDestination()
	  let console = ConsoleDestination()  // log to Xcode Console
	  log.addDestination(file)
	  log.addDestination(console)
	  file.logFileMaxSize = 1024 * 1024 // 1 MB
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

