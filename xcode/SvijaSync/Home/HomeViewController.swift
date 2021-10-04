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
  
  @IBOutlet weak var siteButton: NSButton!
  @IBOutlet weak var adminButton: NSButton!
  @IBOutlet weak var cacheButton: NSButton!
  @IBOutlet weak var folderButton: NSButton!
  @IBOutlet weak var preferenceButton: NSButton!
  @IBOutlet weak var answersButton: NSButton!
  
  @IBOutlet weak var statusLabel: NSTextField!
  @IBOutlet weak var statusImageView: ImageView!
  @IBOutlet weak var logoImageView: NSImageView!
  
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
    logoImageView.isHidden = false
    
    statusImageView.images = Utility.shared.downloadProgressImages
    render(.noActivity)
    render(.refreshList)
    
    siteButton.toolTip = Text.Home.Tooltip.siteButton
    adminButton.toolTip = Text.Home.Tooltip.adminButton
    cacheButton.toolTip = Text.Home.Tooltip.cacheButton
    folderButton.toolTip = Text.Home.Tooltip.folderButton
    answersButton.toolTip = Text.Home.Tooltip.preferenceButton
    
    downloadButton.toolTip = Text.Home.Tooltip.downloadButton
    uploadButton.toolTip = Text.Home.Tooltip.uploadButton

    //———————————————————————————————————————————————————————————————————————————————— begin changes

    NotificationCenter.default.addObserver(self,
                                           selector: #selector(popupEmptyClick),
                                           name: NSPopUpButton.willPopUpNotification,
                                           object: nil)
  }
  
  @IBAction func popupEmptyClick(_ sender: Any) {
    if connections.isEmpty {
      debugPrint("⚠️ user clicked pop up button with no sites configured")
      resetStatus()
      let preferenceViewController =  PreferenceViewController.makeModule()
      presentAsSheet(preferenceViewController)
      preferenceViewController.doneAction = { [weak self] in
        self?.refreshConnections()
      }
    }
  }

  //———————————————————————————————————————————————————————————————————————————————— end changes

  @IBAction func preferenceButtonAction(_ sender: Any) {
    resetStatus()
    let preferenceViewController =  PreferenceViewController.makeModule()
    presentAsSheet(preferenceViewController)
    preferenceViewController.doneAction = { [weak self] in
      self?.refreshConnections()
    }
  }
  
  private func cacheResponseAlert(code: Int){
    let title: String
    let mesg : String
    
    switch code{
    case 2 : title = "No Internet Connection"
    case 3 : title = "Connection Problem"
    default: title = "Cache Cleared"
    }
    
    switch code{
    case 2 : mesg = "Try visiting a website in your browser to check your connection."
    case 3 : mesg = "To clear the cache manually, visit [your website]/c in your browser."
    default: mesg = "Visitors will now see the most recent version of your pages."
    }
    
    let myAlert = NSAlert.init()
    myAlert.messageText = title
    myAlert.informativeText = mesg
    myAlert.addButton(withTitle: "OK")
    myAlert.runModal()
  }
  
  @IBAction func siteButtonAction(_ sender: Any) {
    guard let connection = selectedConnection, let url = connection.siteUrl else { return }
    NSWorkspace.shared.open(url)
  }

  @IBAction func adminButtonAction(_ sender: Any) {
    guard let connection = selectedConnection, let url = connection.adminUrl else { return }
    NSWorkspace.shared.open(url)
  }
  
  @IBAction func cacheButtonAction(_ sender: Any) {
    guard let connection = selectedConnection, let url = connection.cacheUrl else { return }
    
    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
      if error != nil {
        DispatchQueue.main.async { self.cacheResponseAlert(code: 2) }
        return
      }
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        DispatchQueue.main.async { self.cacheResponseAlert(code: 3) }
        return
      }
      debugPrint("⚠️⚠️⚠️⚠️  103 \(url) " + String(data: data!, encoding: .utf8)!)
      DispatchQueue.main.async { self.cacheResponseAlert(code: 1) }
    }
    task.resume()
    
  }
  
  @IBAction func folderButtonAction(_ sender: Any ) {
    guard let connection = selectedConnection else {
      let myAlert = NSAlert.init()
      myAlert.messageText = "No Site Selected"
      myAlert.informativeText = "Click \"Set Up\" to configure a website and select a project folder."
      myAlert.addButton(withTitle: "OK")
      myAlert.runModal()
      return
    }
    
    let url = FolderAccess.promptDirectoryPermissionIfRequired(bookmarkKey: connection.uuid)
    defer {
      url?.stopAccessingSecurityScopedResource()
    }
    
    guard let localUrl = url, localUrl.startAccessingSecurityScopedResource() else {
      let myAlert = NSAlert.init()
      myAlert.messageText = "Project Folder Inaccessible"
      myAlert.informativeText = "Cannot open " + connection.localPath + "\n\nClick \"Set Up\" to modify this website and select a project folder."
      myAlert.addButton(withTitle: "OK")
      myAlert.runModal()
      return }
    
    guard localUrl.path == connection.localPath else {
      let myAlert = NSAlert.init()
      myAlert.messageText = "Project Folder Inaccessible"
      myAlert.informativeText = "Cannot open " + connection.localPath + "\n\nClick \"Set Up\" to modify this website and select a project folder."
      myAlert.addButton(withTitle: "OK")
      myAlert.runModal()
      return
    }
    
    let configuration: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
    
    configuration.promptsUserIfNeeded = true
    let myUrlString = localUrl.path + "/sync/Svija"
    let myUrl = URL(fileURLWithPath: myUrlString)
    NSWorkspace.shared.activateFileViewerSelecting([myUrl])
  }
  
  @IBAction func answersButtonAction(_ sender: Any) {
    guard let connection = selectedConnection, let url = connection.answersUrl else { return }
    NSWorkspace.shared.open(url)
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
    logoImageView.isHidden = false
    statusLabel.stringValue = ""
    
  }
  
  func showStatusLabel(_ message: String) {
    logoImageView.isHidden = true
    statusLabel.isHidden = false
    statusLabel.stringValue = message
  }
  
  // siteButton, adminButton, cacheButton, folderButton,
  
  func render(_ state: HomeViewState) {
    currentState = state
    switch state {
    case .noActivity: // only when activity canceled, not at startup
      [siteButton, adminButton, cacheButton, folderButton, answersButton, downloadButton, uploadButton].forEach { $0?.isEnabled = !connections.isEmpty }
      answersButton.isEnabled = true
      view.window?.title = selectedConnection!.server
      uploadProgressIndex = 0
      Utility.shared.isProcessRunning = false
      if (statusLabel.isHidden == true){
        statusImageView.isHidden = true
        logoImageView.isHidden = false
      }
      popupButton.isEnabled = true
      statusImageView.stopAnimation()
    case .upload:
      [popupButton, downloadButton].forEach { $0.isEnabled = false }
      view.window?.title = selectedConnection!.server + " · " + Text.Home.windowUploadTitle
      logoImageView.isHidden = true
      statusImageView.isHidden = false
      uploadProgressNext(error: false)
    case .download:
      [popupButton, uploadButton].forEach { $0.isEnabled = false }
      view.window?.title = selectedConnection!.server + " · " + Text.Home.windowDownloadTitle
      logoImageView.isHidden = true
      statusImageView.isHidden = false
      statusImageView.autoAnimate(interval: Constant.downloadProgressTimeInterval)
      Utility.shared.isProcessRunning = true
    case .refreshList:
      refreshConnections()
      view.window?.title = selectedConnection!.server
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
    
    //—————————————————————————————————————————————————— added, to automatically set default
    
    var allConnections: [SiteConnection] {
      guard let data: Data = Storage.value(key: Key.siteConnection), let connections = [SiteConnection].decode(data) else { return [] }
      return connections
    }
    
    var connections = allConnections
    if let index = connections.firstIndex(where: { $0.isDefault == true }) { connections[index].isDefault = false }
    if let index = connections.firstIndex (where: { $0.uuid == selectedConnection!.uuid }) { connections[index].isDefault = true }
    Storage.save(connections.encoded, key: Key.siteConnection)
    
    //—————————————————————————————————————————————————— set window title to current url
    view.window?.title = selectedConnection!.server
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
    [siteButton, adminButton, cacheButton, folderButton, answersButton, downloadButton, uploadButton].forEach { $0?.isEnabled = !connections.isEmpty }
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
