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
        activity.invalidate()
        if uploadButton.state == .on {
            debugPrint("Upload action")
            prepareUploadAction(connection)
        } else {
            debugPrint("Pause action")
            pauseUpload()
        }
    }

    private func prepareUploadAction(_ connection: SiteConnection) {
        uploadStatus = .ready
        render(.upload)
        uploadStatus = .lastOwnerCheck
        viewModel.fetchLastOwner(connection: connection) { [weak self] status in
            guard let self = self, self.checkAndProcessLastOwnerStatus(status)  else { return }
            self.statusHandler.handleUploadCheck(self.viewModel.uploadCheck(connection) , connection) { [weak self] status in
                guard let self = self else { return }
                guard status else {
                    self.render(.noActivity)
                    self.uploadButton.setNextState()
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
        activity.invalidate()
        showStatusLabel(Text.Home.StatusLabel.uploadingPaused)
        stopSync()
    }

    private func scheduleUploadAction(_ connection: SiteConnection) {
        activity.schedule{ [weak self] handler in
            debugPrint("Scheduler starting...")
            guard let self = self else { return }
            guard self.uploadStatus == .completed || self.uploadStatus == .lastOwnerCheck else {
                handler(.finished)
                return
            }
            self.startUpload(connection) {
                handler(.finished)
            }
        }
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
