// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Alert {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Alert.Cancel", fallback: "Cancel")
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "Alert.Continue", fallback: "Continue")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "Alert.Ok", fallback: "Ok")
    internal enum Confirmation {
      internal enum Message {
        ///  has modified the site.
        /// Do you want to continue?
        internal static let lastOwnerChanged = L10n.tr("Localizable", "Alert.Confirmation.Message.lastOwnerChanged", fallback: " has modified the site.\nDo you want to continue?")
        /// Your files will be deleted or replaced.
        /// Do you want to continue?
        internal static let localFileErase = L10n.tr("Localizable", "Alert.Confirmation.Message.localFileErase", fallback: "Your files will be deleted or replaced.\nDo you want to continue?")
        /// Quitting now will leave incomplete files on your computer.
        /// 
        /// Download next time to finish synching.
        internal static let quitAppWhenDownload = L10n.tr("Localizable", "Alert.Confirmation.Message.quitAppWhenDownload", fallback: "Quitting now will leave incomplete files on your computer.\n\nDownload next time to finish synching.")
      }
      internal enum Title {
        /// Are you sure?
        internal static let areYouSure = L10n.tr("Localizable", "Alert.Confirmation.Title.areYouSure", fallback: "Are you sure?")
      }
    }
    internal enum Message {
      /// Downloaded website is incomplete. Download next time to finish synching.
      internal static let downloadCanceled = L10n.tr("Localizable", "Alert.Message.downloadCanceled", fallback: "Downloaded website is incomplete. Download next time to finish synching.")
      /// Download interrupted – files on your computer may be incomplete.
      internal static let downloadInterrupted = L10n.tr("Localizable", "Alert.Message.downloadInterrupted", fallback: "Download interrupted – files on your computer may be incomplete.")
      /// The specified website already exists. Please select it then click Modify.
      internal static let duplicateSite = L10n.tr("Localizable", "Alert.Message.duplicateSite", fallback: "The specified website already exists. Please select it then click Modify.")
      /// Please enter a nickname. You can change it at any time.
      internal static let enterName = L10n.tr("Localizable", "Alert.Message.enterName", fallback: "Please enter a nickname. You can change it at any time.")
      /// Please select the project folder or open Preferences to reconfigure the website
      internal static let inaccessible = L10n.tr("Localizable", "Alert.Message.inaccessible", fallback: "Please select the project folder or open Preferences to reconfigure the website")
      /// Please use only letters, numbers and common symbols.
      internal static let invalidCharacters = L10n.tr("Localizable", "Alert.Message.invalidCharacters", fallback: "Please use only letters, numbers and common symbols.")
      /// Please open Preferences then enter your nickname.
      internal static let missingName = L10n.tr("Localizable", "Alert.Message.missingName", fallback: "Please open Preferences then enter your nickname.")
      /// There is nothing to upload. Please download first or choose a different project folder.
      internal static let nothingToUpload = L10n.tr("Localizable", "Alert.Message.nothingToUpload", fallback: "There is nothing to upload. Please download first or choose a different project folder.")
      /// Re-download to continue or contact support.
      internal static let projectFolderDamaged = L10n.tr("Localizable", "Alert.Message.projectFolderDamaged", fallback: "Re-download to continue or contact support.")
      /// Open Preferences to modify this website and select a project folder.
      internal static let projectFolderMissing = L10n.tr("Localizable", "Alert.Message.projectFolderMissing", fallback: "Open Preferences to modify this website and select a project folder.")
      /// Please select a project folder that is not named "SYNC".
      internal static let selectProjectFolderWithoutSync = L10n.tr("Localizable", "Alert.Message.selectProjectFolderWithoutSync", fallback: "Please select a project folder that is not named \"SYNC\".")
      /// Please delete a website or modify an existing website.
      internal static let siteLimit = L10n.tr("Localizable", "Alert.Message.siteLimit", fallback: "Please delete a website or modify an existing website.")
      /// Your site has been updated to a new version of Svija — please download before continuing
      internal static let siteUpdated = L10n.tr("Localizable", "Alert.Message.siteUpdated", fallback: "Your site has been updated to a new version of Svija — please download before continuing")
      /// Please quit the app and try again. Check your internet connection.
      internal static let unknown = L10n.tr("Localizable", "Alert.Message.unknown", fallback: "Please quit the app and try again. Check your internet connection.")
    }
    internal enum Title {
      /// Downloading Canceled
      internal static let downloadCanceled = L10n.tr("Localizable", "Alert.Title.downloadCanceled", fallback: "Downloading Canceled")
      /// Download Interrupted
      internal static let downloadInterrupted = L10n.tr("Localizable", "Alert.Title.downloadInterrupted", fallback: "Download Interrupted")
      /// Website Already Exists
      internal static let duplicateSite = L10n.tr("Localizable", "Alert.Title.duplicateSite", fallback: "Website Already Exists")
      /// Enter Your Name
      internal static let enterName = L10n.tr("Localizable", "Alert.Title.enterName", fallback: "Enter Your Name")
      /// Project folder inaccessible
      internal static let inaccessible = L10n.tr("Localizable", "Alert.Title.inaccessible", fallback: "Project folder inaccessible")
      /// Some characters are not allowed
      internal static let invalidCharacters = L10n.tr("Localizable", "Alert.Title.invalidCharacters", fallback: "Some characters are not allowed")
      /// Configuration Incomplete
      internal static let missingName = L10n.tr("Localizable", "Alert.Title.missingName", fallback: "Configuration Incomplete")
      /// Nothing to Upload
      internal static let nothingToUpload = L10n.tr("Localizable", "Alert.Title.nothingToUpload", fallback: "Nothing to Upload")
      /// Project Folder is Damaged
      internal static let projectFolderDamaged = L10n.tr("Localizable", "Alert.Title.projectFolderDamaged", fallback: "Project Folder is Damaged")
      /// Project Folder is Missing
      internal static let projectFolderMissing = L10n.tr("Localizable", "Alert.Title.projectFolderMissing", fallback: "Project Folder is Missing")
      /// Select a Different Folder
      internal static let selectProjectFolderWithoutSync = L10n.tr("Localizable", "Alert.Title.selectProjectFolderWithoutSync", fallback: "Select a Different Folder")
      /// Limit 50 Websites
      internal static let siteLimit = L10n.tr("Localizable", "Alert.Title.siteLimit", fallback: "Limit 50 Websites")
      /// Please Download
      internal static let siteUpdated = L10n.tr("Localizable", "Alert.Title.siteUpdated", fallback: "Please Download")
      /// Unknown Error
      internal static let unknown = L10n.tr("Localizable", "Alert.Title.unknown", fallback: "Unknown Error")
    }
  }
  internal enum Home {
    /// downloading…
    internal static let windowDownloadTitle = L10n.tr("Localizable", "Home.WindowDownloadTitle", fallback: "downloading…")
    /// Localizable.strings
    ///  SvijaSync
    ///  
    ///  Created by Rajesh Ramachandrakurup on 11/2/21.
    internal static let windowUploadTitle = L10n.tr("Localizable", "Home.WindowUploadTitle", fallback: "uploading…")
    internal enum Button {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "Home.Button.cancel", fallback: "Cancel")
      /// Download
      internal static let download = L10n.tr("Localizable", "Home.Button.download", fallback: "Download")
      /// Pause
      internal static let pause = L10n.tr("Localizable", "Home.Button.pause", fallback: "Pause")
      /// Click here to get started…
      internal static let popupPlaceholder = L10n.tr("Localizable", "Home.Button.popupPlaceholder", fallback: "Click here to get started…")
      /// Upload
      internal static let upload = L10n.tr("Localizable", "Home.Button.upload", fallback: "Upload")
    }
    internal enum StatusLabel {
      /// Download Canceled
      internal static let downloadingCancelled = L10n.tr("Localizable", "Home.StatusLabel.downloadingCancelled", fallback: "Download Canceled")
      /// Download Complete
      internal static let downloadingComplete = L10n.tr("Localizable", "Home.StatusLabel.downloadingComplete", fallback: "Download Complete")
      /// Unable to Connect
      internal static let unableToConnect = L10n.tr("Localizable", "Home.StatusLabel.unableToConnect", fallback: "Unable to Connect")
      /// Uploading Paused
      internal static let uploadingPaused = L10n.tr("Localizable", "Home.StatusLabel.uploadingPaused", fallback: "Uploading Paused")
    }
    internal enum Tooltip {
      /// C · connect to Svija Cloud
      internal static let adminButton = L10n.tr("Localizable", "Home.Tooltip.adminButton", fallback: "C · connect to Svija Cloud")
      /// A · clear the website cache
      internal static let cacheButton = L10n.tr("Localizable", "Home.Tooltip.cacheButton", fallback: "A · clear the website cache")
      /// Update computer files to match the website
      internal static let downloadButton = L10n.tr("Localizable", "Home.Tooltip.downloadButton", fallback: "Update computer files to match the website")
      /// F · open the project folder in the Finder
      internal static let folderButton = L10n.tr("Localizable", "Home.Tooltip.folderButton", fallback: "F · open the project folder in the Finder")
      /// News and product updates
      internal static let newsView = L10n.tr("Localizable", "Home.Tooltip.newsView", fallback: "News and product updates")
      /// H · Help and answers to your questions
      internal static let preferenceButton = L10n.tr("Localizable", "Home.Tooltip.preferenceButton", fallback: "H · Help and answers to your questions")
      /// S · visit the website
      internal static let siteButton = L10n.tr("Localizable", "Home.Tooltip.siteButton", fallback: "S · visit the website")
      /// Select a different website
      internal static let sitePopupWithList = L10n.tr("Localizable", "Home.Tooltip.sitePopupWithList", fallback: "Select a different website")
      /// Open Preferences and configure websites
      internal static let sitePopupWithoutList = L10n.tr("Localizable", "Home.Tooltip.sitePopupWithoutList", fallback: "Open Preferences and configure websites")
      /// spacebar · update the website to match computer files
      internal static let uploadButton = L10n.tr("Localizable", "Home.Tooltip.uploadButton", fallback: "spacebar · update the website to match computer files")
    }
  }
  internal enum News {
    /// en
    internal static let language = L10n.tr("Localizable", "News.language", fallback: "en")
    internal enum Placeholder {
      /// 
      internal static let message = L10n.tr("Localizable", "News.Placeholder.message", fallback: "")
      /// <h1>Svija Sync</h1><p>Click on <b>Click Here to get started…</b> to add your website<br>credentials. Connect to <b>Svija Cloud</b> to see your modifications.
      internal static let text = L10n.tr("Localizable", "News.Placeholder.text", fallback: "<h1>Svija Sync</h1><p>Click on <b>Click Here to get started…</b> to add your website<br>credentials. Connect to <b>Svija Cloud</b> to see your modifications.")
    }
  }
  internal enum Preference {
    internal enum Button {
      /// Set Folder
      internal static let add = L10n.tr("Localizable", "Preference.Button.add", fallback: "Set Folder")
      /// Done
      internal static let done = L10n.tr("Localizable", "Preference.Button.done", fallback: "Done")
      /// Modify
      internal static let modify = L10n.tr("Localizable", "Preference.Button.modify", fallback: "Modify")
      /// Remove
      internal static let remove = L10n.tr("Localizable", "Preference.Button.remove", fallback: "Remove")
      /// Undo
      internal static let undo = L10n.tr("Localizable", "Preference.Button.undo", fallback: "Undo")
      /// Set Folder
      internal static let update = L10n.tr("Localizable", "Preference.Button.update", fallback: "Set Folder")
    }
    internal enum Help {
      /// Svija is free — create an account at <a href="https://svija.com/fromsync">svija.com</a>.
      internal static let html = L10n.tr("Localizable", "Preference.Help.html", fallback: "Svija is free — create an account at <a href=\"https://svija.com/fromsync\">svija.com</a>.")
    }
    internal enum Label {
      /// Connect ID
      internal static let connectId = L10n.tr("Localizable", "Preference.Label.connectId", fallback: "Connect ID")
      /// Nickname
      internal static let nickname = L10n.tr("Localizable", "Preference.Label.nickname", fallback: "Nickname")
      /// Password
      internal static let password = L10n.tr("Localizable", "Preference.Label.password", fallback: "Password")
      /// URL
      internal static let url = L10n.tr("Localizable", "Preference.Label.url", fallback: "URL")
    }
    internal enum ListHeader {
      /// Project Folder
      internal static let localFolder = L10n.tr("Localizable", "Preference.ListHeader.localFolder", fallback: "Project Folder")
      /// URL
      internal static let url = L10n.tr("Localizable", "Preference.ListHeader.url", fallback: "URL")
    }
    internal enum OpenPanel {
      /// Please choose a Project Folder
      internal static let message = L10n.tr("Localizable", "Preference.OpenPanel.message", fallback: "Please choose a Project Folder")
      /// Choose
      internal static let prompt = L10n.tr("Localizable", "Preference.OpenPanel.prompt", fallback: "Choose")
    }
    internal enum TextPlaceholder {
      /// connect ID
      internal static let connectId = L10n.tr("Localizable", "Preference.TextPlaceholder.connectId", fallback: "connect ID")
      /// your nickname
      internal static let nickname = L10n.tr("Localizable", "Preference.TextPlaceholder.nickname", fallback: "your nickname")
      /// website address
      internal static let url = L10n.tr("Localizable", "Preference.TextPlaceholder.url", fallback: "website address")
    }
    internal enum Tooltip {
      /// Select a project folder and save this configuration
      internal static let add = L10n.tr("Localizable", "Preference.Tooltip.add", fallback: "Select a project folder and save this configuration")
      /// The connect ID from the email you received
      internal static let connectID = L10n.tr("Localizable", "Preference.Tooltip.connectID", fallback: "The connect ID from the email you received")
      /// Esc · close this window and go back to the home screen
      internal static let done = L10n.tr("Localizable", "Preference.Tooltip.done", fallback: "Esc · close this window and go back to the home screen")
      /// Modify the selected configuration or change the project folder
      internal static let modify = L10n.tr("Localizable", "Preference.Tooltip.modify", fallback: "Modify the selected configuration or change the project folder")
      /// Any name, to show who last worked on the website
      internal static let nickname = L10n.tr("Localizable", "Preference.Tooltip.nickname", fallback: "Any name, to show who last worked on the website")
      /// The password from the email you received
      internal static let password = L10n.tr("Localizable", "Preference.Tooltip.password", fallback: "The password from the email you received")
      /// Delete the selected configuration
      internal static let remove = L10n.tr("Localizable", "Preference.Tooltip.remove", fallback: "Delete the selected configuration")
      /// Undo all changes
      internal static let undo = L10n.tr("Localizable", "Preference.Tooltip.undo", fallback: "Undo all changes")
      /// Update this configuration and select a project folder
      internal static let update = L10n.tr("Localizable", "Preference.Tooltip.update", fallback: "Update this configuration and select a project folder")
      /// The address of the website without http or /
      internal static let url = L10n.tr("Localizable", "Preference.Tooltip.url", fallback: "The address of the website without http or /")
      /// Visit svija.com in your browser.
      internal static let visitLink = L10n.tr("Localizable", "Preference.Tooltip.visitLink", fallback: "Visit svija.com in your browser.")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
