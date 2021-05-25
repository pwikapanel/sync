//
//  ActivityScheduler.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 21/2/21.
//

import Foundation

class ActivityScheduler {

    private var activity: NSBackgroundActivityScheduler?

    private let schedulerIdentifier = "love.svija.svijasync.activityScheduler"

    func schedule(_ block: @escaping (@escaping NSBackgroundActivityScheduler.CompletionHandler) -> Void) {
        invalidate()
        activity = NSBackgroundActivityScheduler(identifier: schedulerIdentifier)
        activity?.interval = Constant.uploadSyncTimeInterval
        activity?.qualityOfService = .background
        activity?.tolerance = 0
        activity?.repeats = true
        activity?.schedule(block)
    }

    func invalidate() {
        activity?.invalidate()
        activity = nil
    }
}
