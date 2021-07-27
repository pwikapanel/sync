//
//  HomeViewController.swift
//  SvijaSync
//
//  Created by Rajesh Ramachandrakurup on 6/2/21.
//

import Cocoa
import Rsync

class HomeViewController: NSViewController {

    enum HomeViewState {
        case noActivity
        case download
        case upload
        case refreshList
    }

    @IBOutlet weak var downloadButton: NSButton!
    @IBOutlet weak var uploadButton: NSButton!
    @IBOutlet weak var popupButton: NSPopUpButton!
    @IBOutlet weak var preferenceButton: NSButton!
    @IBOutlet weak var adminButton: NSButton!
    @IBOutlet weak var cacheButton: NSButton!
    @IBOutlet weak var siteButton: NSButton!
    @IBOutlet weak var folderButton: NSButton!

    @IBOutlet weak var statusLabel: NSTextField!
    @IBOutlet weak var statusImageView: ImageView!

    let viewModel: HomeViewModelInterface = HomeViewModel()
    var connections: [SiteConnection] = []
    var selectedConnection: SiteConnection?
    var uploadStatus: UploadStatus = .ready
    var currentState: HomeViewState = .noActivity
    let statusHandler = HomeSyncStatusHandler()
    var uploadOperationQueue: OperationQueue?
    let myBackgroundActivity = ProcessInfo.processInfo
    var backgroundActivityToken: NSObjectProtocol?


    var uploadProgressIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadButton.title = Text.Home.Button.download
        downloadButton.alternateTitle = Text.Home.Button.cancel
        uploadButton.title = Text.Home.Button.upload
        uploadButton.alternateTitle = Text.Home.Button.pause
        statusHandler.target = self
        statusLabel.isHidden = true
        statusImageView.isHidden = true

        statusImageView.images = Utility.shared.downloadProgressImages
        render(.noActivity)
        render(.refreshList)
        preferenceButton.toolTip = Text.Home.Tooltip.preferenceButton
        adminButton.toolTip = Text.Home.Tooltip.adminButton
        cacheButton.toolTip = Text.Home.Tooltip.cacheButton
        siteButton.toolTip = Text.Home.Tooltip.siteButton
        folderButton.toolTip = Text.Home.Tooltip.folderButton

        downloadButton.toolTip = Text.Home.Tooltip.downloadButton
        uploadButton.toolTip = Text.Home.Tooltip.uploadButton
    }

    @IBAction func preferenceButtonAction(_ sender: Any) {
        resetStatus()
        let preferenceViewController =  PreferenceViewController.makeModule()
        presentAsSheet(preferenceViewController)
        preferenceViewController.doneAction = { [weak self] in
            self?.refreshConnections()
        }
    }

    @IBAction func adminButtonAction(_ sender: Any) {
        guard let connection = selectedConnection, let url = connection.adminUrl else { return }
        NSWorkspace.shared.open(url)
    }

    @IBAction func cacheButtonAction(_ sender: Any) {
        guard let connection = selectedConnection, let url = connection.cacheUrl else { return }
        NSWorkspace.shared.open(url)
    }

    @IBAction func siteButtonAction(_ sender: Any) {
        guard let connection = selectedConnection, let url = connection.siteUrl else { return }
        NSWorkspace.shared.open(url)
    }
    
    @IBAction func folderButtonAction(_ sender: Any ) {
        guard let connection = selectedConnection else { return }

        let url = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
        defer {
            url?.stopAccessingSecurityScopedResource()
        }
        guard let localUrl = url, localUrl.startAccessingSecurityScopedResource() else {
            debugPrint ("⚠️ 100")
            return }

        guard localUrl.path == connection.localPath else {
            let myAlert = NSAlert.init()
            myAlert.messageText = "Permission Needed"
            myAlert.informativeText = "To access " + connection.localPath + ", please update the site in the configuration screen"
            myAlert.addButton(withTitle: "OK")
            myAlert.runModal()
            return  }

        guard FileManager.createSyncDirectoryIfNeeded(at: connection.localPath) else {  debugPrint("⚠️105"); return }

        let configuration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
        configuration.promptsUserIfNeeded = true

        let finder = NSWorkspace.shared.urlForApplication(withBundleIdentifier: "com.apple.finder")
        
        NSWorkspace.shared.open([localUrl], withApplicationAt: finder!, configuration: configuration)
    }
    
    @IBAction func popupButtonSelectionChange(_ sender: Any) {
        resetStatus()
        connectionDidChange()
    }

    @IBAction func downloadButtonAction(_ sender: Any) {
        resetStatus()
        guard let connection = selectedConnection else { return }
        downloadAction(connection)
    }

    @IBAction func uploadButtonAction(_ sender: Any) {
        resetStatus()
        guard let connection = selectedConnection else { return }
        uploadAction(connection)
    }

}

extension HomeViewController {

    func resetStatus() {
        statusLabel.isHidden = true
        statusImageView.isHidden = true
        statusLabel.stringValue = ""
    }

    func showStatusLabel(_ message: String) {
        statusLabel.isHidden = false
        statusLabel.stringValue = message
    }

    func render(_ state: HomeViewState) {
        currentState = state
        switch state {
        case .noActivity:
            [downloadButton, uploadButton].forEach { $0?.isEnabled = !connections.isEmpty }
            preferenceButton.isEnabled = true
            view.window?.title = Text.Home.title
            uploadProgressIndex = 0
            Utility.shared.isProcessRunning = false
            statusImageView.isHidden = true
            popupButton.isEnabled = true
            statusImageView.stopAnimation()
        case .upload:
            [popupButton, preferenceButton, downloadButton].forEach { $0.isEnabled = false }
            view.window?.title = Text.Home.windowUploadTitle
            statusImageView.isHidden = false
            uploadProgressNext(error: false)
        case .download:
            [popupButton, preferenceButton, uploadButton].forEach { $0.isEnabled = false }
            view.window?.title = Text.Home.windowDownloadTitle
            statusImageView.isHidden = false
            statusImageView.autoAnimate(interval: Constant.downloadProgressTimeInterval)
            Utility.shared.isProcessRunning = true
        case .refreshList:
            refreshConnections()
        }
    }

    func connectionDidChange() {
        guard let selectedItem = popupButton.selectedItem else { return }
        if connections.isEmpty {
            selectedConnection = nil
            return
        }
        let index = popupButton.index(of: selectedItem)
        selectedConnection = connections[index]
    }

    func refreshConnections() {
        connections = viewModel.allConnections
        refreshPopupList()
    }

    func refreshPopupList() {
        popupButton.removeAllItems()
        [downloadButton, uploadButton].forEach { $0?.isEnabled = !connections.isEmpty }
        if connections.isEmpty {
            popupButton.addItem(withTitle: Text.Home.Button.popupPlaceholder)
            popupButton.toolTip = Text.Home.Tooltip.sitePopupWithoutList
        } else {
            popupButton.toolTip = Text.Home.Tooltip.sitePopupWithList
        }
        connections.forEach {
            popupButton.addItem(withTitle: $0.server)
        }
        connectionDidChange()
        popupButton.isEnabled = true
    }

    func stopSync(completion: (() -> ())? = nil) {
        viewModel.stop { [weak self] in
            self?.render(.noActivity)
        }
    }

    func stopBackgroundActivityActivity() {
        guard let token = self.backgroundActivityToken else { return }
        ProcessInfo.processInfo.endActivity(token)
    }

    func startBackgroundActivityActivity() {
        backgroundActivityToken = myBackgroundActivity.beginActivity(options: .background, reason: "important network tasks")
    }

}
