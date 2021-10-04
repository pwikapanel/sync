// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Alert {
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "Alert.Cancel")
    /// Continue
    internal static let `continue` = L10n.tr("Localizable", "Alert.Continue")
    /// Ok
    internal static let ok = L10n.tr("Localizable", "Alert.Ok")
    internal enum Confirmation {
      internal enum Message {
        ///  has modified the site.\nDo you want to continue?
        internal static let lastOwnerChanged = L10n.tr("Localizable", "Alert.Confirmation.Message.lastOwnerChanged")
        /// Files on your computer will be replaced.\nDo you want to continue?
        internal static let localFileErase = L10n.tr("Localizable", "Alert.Confirmation.Message.localFileErase")
        /// Quitting now will leave incomplete files on your computer.\n\nDownload next time to finish synching.
        internal static let quitAppWhenDownload = L10n.tr("Localizable", "Alert.Confirmation.Message.quitAppWhenDownload")
      }
      internal enum Title {
        /// Are you sure?
        internal static let areYouSure = L10n.tr("Localizable", "Alert.Confirmation.Title.areYouSure")
      }
    }
    internal enum Message {
      /// Downloaded website is incomplete. Download next time to finish synching.
      internal static let downloadCanceled = L10n.tr("Localizable", "Alert.Message.downloadCanceled")
      /// Download interrupted – files on your computer may be incomplete.
      internal static let downloadInterrupted = L10n.tr("Localizable", "Alert.Message.downloadInterrupted")
      /// The specified website already exists. Please select it then click Modify.
      internal static let duplicateSite = L10n.tr("Localizable", "Alert.Message.duplicateSite")
      /// Please enter a nickname. You can change it at any time.
      internal static let enterName = L10n.tr("Localizable", "Alert.Message.enterName")
      /// Please select the project folder or open Preferences to reconfigure the website
      internal static let inaccessible = L10n.tr("Localizable", "Alert.Message.inaccessible")
      /// Please use only letters and numbers.
      internal static let invalidCharacters = L10n.tr("Localizable", "Alert.Message.invalidCharacters")
      /// Please open Preferences then enter your nickname.
      internal static let missingName = L10n.tr("Localizable", "Alert.Message.missingName")
      /// There is nothing to upload. Please download first or choose a different project folder.
      internal static let nothingToUpload = L10n.tr("Localizable", "Alert.Message.nothingToUpload")
      /// Re-download to continue or contact support.
      internal static let projectFolderDamaged = L10n.tr("Localizable", "Alert.Message.projectFolderDamaged")
      /// Open Preferences to modify this website and select a project folder.
      internal static let projectFolderMissing = L10n.tr("Localizable", "Alert.Message.projectFolderMissing")
      /// Please select a project folder that is not named "sync".
      internal static let selectProjectFolderWithoutSync = L10n.tr("Localizable", "Alert.Message.selectProjectFolderWithoutSync")
      /// Please delete a website or modify an existing website.
      internal static let siteLimit = L10n.tr("Localizable", "Alert.Message.siteLimit")
      /// Please quit the app and try again. Check your internet connection.
      internal static let unknown = L10n.tr("Localizable", "Alert.Message.unknown")
    }
    internal enum Title {
      /// Downloading Canceled
      internal static let downloadCanceled = L10n.tr("Localizable", "Alert.Title.downloadCanceled")
      /// Download Interrupted
      internal static let downloadInterrupted = L10n.tr("Localizable", "Alert.Title.downloadInterrupted")
      /// Website Already Exists
      internal static let duplicateSite = L10n.tr("Localizable", "Alert.Title.duplicateSite")
      /// Enter Your Name
      internal static let enterName = L10n.tr("Localizable", "Alert.Title.enterName")
      /// Project folder inaccessible
      internal static let inaccessible = L10n.tr("Localizable", "Alert.Title.inaccessible")
      /// Some characters are not allowed
      internal static let invalidCharacters = L10n.tr("Localizable", "Alert.Title.invalidCharacters")
      /// Configuration Incomplete
      internal static let missingName = L10n.tr("Localizable", "Alert.Title.missingName")
      /// Nothing to Upload
      internal static let nothingToUpload = L10n.tr("Localizable", "Alert.Title.nothingToUpload")
      /// Project Folder is Damaged
      internal static let projectFolderDamaged = L10n.tr("Localizable", "Alert.Title.projectFolderDamaged")
      /// Project Folder is Missing
      internal static let projectFolderMissing = L10n.tr("Localizable", "Alert.Title.projectFolderMissing")
      /// Select a Different Folder
      internal static let selectProjectFolderWithoutSync = L10n.tr("Localizable", "Alert.Title.selectProjectFolderWithoutSync")
      /// Limit 50 Websites
      internal static let siteLimit = L10n.tr("Localizable", "Alert.Title.siteLimit")
      /// Unknown Error
      internal static let unknown = L10n.tr("Localizable", "Alert.Title.unknown")
    }
  }

  internal enum Home {
    /// downloading…
    internal static let windowDownloadTitle = L10n.tr("Localizable", "Home.WindowDownloadTitle")
    /// uploading…
    internal static let windowUploadTitle = L10n.tr("Localizable", "Home.WindowUploadTitle")
    internal enum Button {
      /// Cancel
      internal static let cancel = L10n.tr("Localizable", "Home.Button.cancel")
      /// Download
      internal static let download = L10n.tr("Localizable", "Home.Button.download")
      /// Pause
      internal static let pause = L10n.tr("Localizable", "Home.Button.pause")
      /// Click here to get started…
      internal static let popupPlaceholder = L10n.tr("Localizable", "Home.Button.popupPlaceholder")
      /// Upload
      internal static let upload = L10n.tr("Localizable", "Home.Button.upload")
    }
    internal enum StatusLabel {
      /// Download Canceled
      internal static let downloadingCancelled = L10n.tr("Localizable", "Home.StatusLabel.downloadingCancelled")
      /// Download Complete
      internal static let downloadingComplete = L10n.tr("Localizable", "Home.StatusLabel.downloadingComplete")
      /// Unable to Connect
      internal static let unableToConnect = L10n.tr("Localizable", "Home.StatusLabel.unableToConnect")
      /// Uploading Paused
      internal static let uploadingPaused = L10n.tr("Localizable", "Home.StatusLabel.uploadingPaused")
    }
    internal enum Tooltip {
      /// A · connect to Svija Admin
      internal static let adminButton = L10n.tr("Localizable", "Home.Tooltip.adminButton")
      /// C · clear the website cache
      internal static let cacheButton = L10n.tr("Localizable", "Home.Tooltip.cacheButton")
      /// Update computer files to match the website
      internal static let downloadButton = L10n.tr("Localizable", "Home.Tooltip.downloadButton")
      /// F · open the project folder in the Finder
      internal static let folderButton = L10n.tr("Localizable", "Home.Tooltip.folderButton")
      /// News and product updates
      internal static let newsView = L10n.tr("Localizable", "Home.Tooltip.newsView")
      /// Find answers to your questions
      internal static let preferenceButton = L10n.tr("Localizable", "Home.Tooltip.preferenceButton")
      /// S · visit the website
      internal static let siteButton = L10n.tr("Localizable", "Home.Tooltip.siteButton")
      /// Select a different website
      internal static let sitePopupWithList = L10n.tr("Localizable", "Home.Tooltip.sitePopupWithList")
      /// Open Preferences and configure websites
      internal static let sitePopupWithoutList = L10n.tr("Localizable", "Home.Tooltip.sitePopupWithoutList")
      /// spacebar · update the website to match computer files
      internal static let uploadButton = L10n.tr("Localizable", "Home.Tooltip.uploadButton")
    }
  }

  internal enum News {
    /// en
    internal static let language = L10n.tr("Localizable", "News.language")
    internal enum Placeholder {
      /// 
      internal static let message = L10n.tr("Localizable", "News.Placeholder.message")
      /// <h1>Svija Sync</h1><p>Open menu <b>Svija Sync › Preferences</b> to get started. You must<br>connect to <b>Svija Admin</b> for your modifications to be visible.
      internal static let text = L10n.tr("Localizable", "News.Placeholder.text")
    }
  }

  internal enum Preference {
    internal enum Button {
      /// Set Folder
      internal static let add = L10n.tr("Localizable", "Preference.Button.add")
      /// Done
      internal static let done = L10n.tr("Localizable", "Preference.Button.done")
      /// Make Default
      internal static let makeDefault = L10n.tr("Localizable", "Preference.Button.makeDefault")
      /// Modify
      internal static let modify = L10n.tr("Localizable", "Preference.Button.modify")
      /// Remove
      internal static let remove = L10n.tr("Localizable", "Preference.Button.remove")
      /// Undo
      internal static let undo = L10n.tr("Localizable", "Preference.Button.undo")
      /// Set Folder
      internal static let update = L10n.tr("Localizable", "Preference.Button.update")
    }
    internal enum Help {
      /// Svija is free — create an account at <a href="https://svija.love/sync">svija.love</a>.
      internal static let html = L10n.tr("Localizable", "Preference.Help.html")
    }
    internal enum Label {
      /// Connect ID
      internal static let connectId = L10n.tr("Localizable", "Preference.Label.connectId")
      /// Nickname
      internal static let nickname = L10n.tr("Localizable", "Preference.Label.nickname")
      /// Password
      internal static let password = L10n.tr("Localizable", "Preference.Label.password")
      /// URL
      internal static let url = L10n.tr("Localizable", "Preference.Label.url")
    }
    internal enum ListHeader {
      /// Project Folder
      internal static let localFolder = L10n.tr("Localizable", "Preference.ListHeader.localFolder")
      /// URL
      internal static let url = L10n.tr("Localizable", "Preference.ListHeader.url")
    }
    internal enum OpenPanel {
      /// Please choose a Project Folder
      internal static let message = L10n.tr("Localizable", "Preference.OpenPanel.message")
      /// Choose
      internal static let prompt = L10n.tr("Localizable", "Preference.OpenPanel.prompt")
    }
    internal enum TextPlaceholder {
      /// connect ID
      internal static let connectId = L10n.tr("Localizable", "Preference.TextPlaceholder.connectId")
      /// your nickname
      internal static let nickname = L10n.tr("Localizable", "Preference.TextPlaceholder.nickname")
      /// website address
      internal static let url = L10n.tr("Localizable", "Preference.TextPlaceholder.url")
    }
    internal enum Tooltip {
      /// Select a project folder and save this configuration
      internal static let add = L10n.tr("Localizable", "Preference.Tooltip.add")
      /// The connect ID from the email you received
      internal static let connectID = L10n.tr("Localizable", "Preference.Tooltip.connectID")
      /// Esc · close this window and go back to the home screen
      internal static let done = L10n.tr("Localizable", "Preference.Tooltip.done")
      /// Choose which website is selected at launch
      internal static let makeDefault = L10n.tr("Localizable", "Preference.Tooltip.makeDefault")
      /// Modify the selected configuration or change the project folder
      internal static let modify = L10n.tr("Localizable", "Preference.Tooltip.modify")
      /// Any name, to show who last worked on the website
      internal static let nickname = L10n.tr("Localizable", "Preference.Tooltip.nickname")
      /// The password from the email you received
      internal static let password = L10n.tr("Localizable", "Preference.Tooltip.password")
      /// Delete the selected configuration
      internal static let remove = L10n.tr("Localizable", "Preference.Tooltip.remove")
      /// Undo all changes
      internal static let undo = L10n.tr("Localizable", "Preference.Tooltip.undo")
      /// Update this configuration and select a project folder
      internal static let update = L10n.tr("Localizable", "Preference.Tooltip.update")
      /// The address of the website without http or /
      internal static let url = L10n.tr("Localizable", "Preference.Tooltip.url")
      /// Visit svija.love in your browser.
      internal static let visitLink = L10n.tr("Localizable", "Preference.Tooltip.visitLink")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
