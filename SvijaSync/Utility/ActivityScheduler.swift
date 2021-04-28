//
//  ActivityScheduler.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 21/2/21.
//

import Foundation

class ActivityScheduler {

    private var activity: NSBackgroundActivityScheduler?

    private let schedulerIdentifier = "com.SvijaSync.activityScheduler"

    func schedule(_ block: @escaping (@escaping NSBackgroundActivityScheduler.CompletionHandler) -> Void) {
        activity = NSBackgroundActivityScheduler(identifier: schedulerIdentifier)
        activity?.interval = Constant.uploadSynchTimeInterval
        activity?.qualityOfService = .userInteractive
        activity?.tolerance = 0
        activity?.repeats = true
        activity?.schedule(block)
    }

    func invalidate() {
        activity?.invalidate()
    }
}
