//
//  HomeUploadAction.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 21/2/21.
//

import Cocoa
import Rsync

//MARK: - UPLOAD
extension HomeViewController {
  
  func uploadAction(_ connection: SiteConnection) {
    if uploadButton.state == .on {
      debugPrint("👤 Start Upload action")
      prepareUploadAction(connection)
    } else {
      debugPrint("👤 Pause Upload action")
      pauseUpload()
    }
  }
  
  private func prepareUploadAction(_ connection: SiteConnection) {
    uploadStatus = .ready
    render(.upload)
    uploadStatus = .lastOwnerCheck
    startBackgroundActivityActivity()
    viewModel.fetchLastOwner(connection: connection) { [weak self] status in
      guard let self = self, self.checkAndProcessLastOwnerStatus(status)  else { return }
      self.statusHandler.handleUploadCheck(self.viewModel.uploadCheck(connection) , connection) { [weak self] status in
        guard let self = self else { return }
        guard status else {
          self.render(.noActivity)
          self.uploadButton.setNextState()
          self.stopBackgroundActivityActivity()
          return
        }
        self.scheduleUploadAction(connection)
      }
    }
  }
  
  private func checkAndProcessLastOwnerStatus(_ status: LastOwnerFetchCheck) -> Bool {
    switch status {
    case .fail:
      render(.noActivity)
      showStatusLabel(Text.Home.StatusLabel.unableToConnect)
      uploadButton.setNextState()
      uploadStatus = .terminate
      return false
    case .projectFolderMissing:
      render(.noActivity)
      uploadButton.setNextState()
      showAlert(message: Text.Alert.Title.projectFolderMissing, info: Text.Alert.Message.projectFolderMissing)
      uploadStatus = .terminate
      return false
    case .success:
      return true
    }
  }
  
  private func pauseUpload() {
    uploadStatus = .terminate
    uploadOperationQueue?.cancelAllOperations()
    uploadOperationQueue = nil
    stopBackgroundActivityActivity()
    showStatusLabel(Text.Home.StatusLabel.uploadingPaused)
    stopSync()
  }
  
  func uploadOperation(_ connection: SiteConnection) -> Operation {
    // added 210812
    let image = "progbar_start_any_\(uploadProgressIndex)"
    statusImageView.image = NSImage(named: image)

    let operation = AsyncOperation()
    var date: Date?
    operation.executeBlock = { [weak self] callback in
      date = Date()
      self?.startUpload(connection) {
        callback()
      }
    }
    operation.completionBlock = { [weak self] in
      debugPrint("🚀 Current upload iteration completed")
      guard let self = self else { return }
      if self.uploadStatus == .completed {
        let diff = TimeInterval(date?.secondsDifferenceNow ?? 0)
        //let delay = diff > Constant.uploadSyncTimeInterval ? 0 : Constant.uploadSyncTimeInterval - diff
        let delay = Constant.uploadSyncTimeInterval
        debugPrint("🚀 Starting next upload iteration with delay \(delay)")
        //DispatchQueue.global().asyncAfter(deadline: .now() + delay) { [weak self] in
          DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
          guard let self = self else { return }
          self.uploadOperationQueue?.addOperation(self.uploadOperation(connection))
        }
      } else {
        debugPrint("🚀 Ending full upload operation queue")
        self.stopBackgroundActivityActivity()
      }
    }
    return operation
  }
  
  private func scheduleUploadAction(_ connection: SiteConnection) {
    debugPrint("🚀 Starting upload operation queue")
    uploadOperationQueue = OperationQueue()
    uploadOperationQueue?.addOperation(uploadOperation(connection))
  }
  
  private func startUpload(_ connection: SiteConnection, finish: (() -> ())?) {
    uploadStatus = .uploading
    viewModel.upload(connection: connection) { [weak self] status in
      guard let self = self else { return }
      DispatchQueue.main.async { [weak self] in
        self?.uploadProgressNext(error: !status)
      }
      self.uploadStatus = .completed
      finish?()
    }
  }
  
  func uploadProgressNext(error: Bool) {
    let image = error ? "progbar_error_any_\(uploadProgressIndex)" : "progbar_up_any_\(uploadProgressIndex)"
    statusImageView.image = NSImage(named: image)
    uploadProgressIndex += 1
    if uploadProgressIndex > 14 {
      uploadProgressIndex = 0
    }
  }
  
}
