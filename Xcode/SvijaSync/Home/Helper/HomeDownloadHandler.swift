//
//  HomeDownloadHandler.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 21/2/21.
//

import Cocoa
import Rsync

//MARK: - DOWNLOAD
extension HomeViewController {
  
  func downloadAction(_ connection: SiteConnection) {
    if downloadButton.state == .on {
      downloadButton.isEnabled = false
      statusHandler.handleDownloadCheck(viewModel.downloadCheck(connection)) { [weak self] status in
        self?.downloadButton.isEnabled = true
        guard status else {
          self?.render(.noActivity)
          self?.downloadButton.setNextState()
          return
        }
        self?.startDownload(connection)
      }
    } else {
      cancelDownload()
    }
  }
  
  private func cancelDownload() {
    stopBackgroundActivityActivity()
    logoImageView.isHidden = true
    statusLabel.isHidden = false
    statusLabel.stringValue = Text.Home.StatusLabel.downloadingCancelled
    showAlert(message: Text.Alert.Title.downloadCanceled, info: Text.Alert.Message.downloadCanceled)
    stopSync()
  }
  
  private func startDownload(_ connection: SiteConnection) {
    render(.download)
    startBackgroundActivityActivity()
    let currentDate = Date()
    viewModel.download(connection: connection) { [weak self] status in
      self?.handleDownloadResponse(status, since: currentDate)
      self?.stopBackgroundActivityActivity()
    }
  }
  
  private func handleDownloadResponse(_ status: Bool, since currentDate: Date) {
    render(.noActivity)
    downloadButton.setNextState()
    if !status {
      if currentDate.secondsDifferenceNow > 1 {
        showAlert(message: Text.Alert.Title.downloadInterrupted, info: Text.Alert.Message.downloadInterrupted)
      } else {
        showStatusLabel(Text.Home.StatusLabel.unableToConnect)
      }
    } else {
      showStatusLabel(Text.Home.StatusLabel.downloadingComplete)
    }
  }
  
}
