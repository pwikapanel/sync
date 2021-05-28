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
            
            prepareUploadAction(connection)
            
        } else {
            pauseUpload()
        }
    }

    func scheduleUploadAction(_ connection: SiteConnection) {
        debugPrint("HomeUploadHandler.scheduleUploadAction 26")
        activity.schedule{ [weak self] handler in
            guard let self = self else {
                debugPrint("HomeUploadHandler.scheduleUploadAction 29 NOT PRINTED WHEN UPLOAD FAILS")
                return }
            guard !self.isUploadInProgress else {
                debugPrint("HomeUploadHandler.scheduleUploadAction 32 NOT PRINTED WHEN UPLOAD FAILS")
                handler(.finished)
                debugPrint("HomeUploadHandler.scheduleUploadAction 34 NOT PRINTED WHEN UPLOAD FAILS")
                return
            }
            debugPrint("HomeUploadHandler.scheduleUploadAction 36 NOT PRINTED WHEN UPLOAD FAILS")
            self.startUpload(connection) {
                handler(.finished)
            }
            
        }
    }

    func prepareUploadAction(_ connection: SiteConnection) {
        
        render(.upload)
        
        viewModel.fetchLastOwner(connection: connection) { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .fail:
                
                self.render(.noActivity)
                
                self.showStatusLabel(Text.Home.StatusLabel.unableToConnect)
                
                self.uploadButton.setNextState()
                
                return
            case .projectFolderMissing:
                
                self.render(.noActivity)
                
                self.uploadButton.setNextState()
                
                self.showAlert(message: Text.Alert.Title.projectFolderMissing, info: Text.Alert.Message.projectFolderMissing)
                
                return
            case .success:
                debugPrint("HomeUploadHandler.prepareUploadAction 70")
                break
            }
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

    func pauseUpload() {
        activity.invalidate()
        showStatusLabel(Text.Home.StatusLabel.uploadingPaused)
        stopSync()
    }

    func startUpload(_ connection: SiteConnection, finish: (() -> ())?) {
        debugPrint("———————————————————————————————————— HomeUploadHandler.swift begin func startUpload()")
        debugPrint(Date())
        isUploadInProgress = true
        viewModel.upload(connection: connection) { [weak self] status in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                self?.uploadProgressNext(error: !status)
            }
            self.isUploadInProgress = false
            finish?()
            debugPrint(Date())
            debugPrint("———————————————————————————————————— HomeUploadHandler.swift end func startUpload()")
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
