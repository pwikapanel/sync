//
//  AsyncOperation.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 25/5/21.
//

import Foundation

class AsyncOperation: Operation {
    private let lockQueue = DispatchQueue(label: "love.svija.svijasync.asyncoperation", attributes: .concurrent)

    override var isAsynchronous: Bool {
        return true
    }

    private var _isExecuting: Bool = false
    override private(set) var isExecuting: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            lockQueue.sync(flags: [.barrier]) {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }

    private var _isFinished: Bool = false
    override private(set) var isFinished: Bool {
        get {
            return lockQueue.sync { () -> Bool in
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            lockQueue.sync(flags: [.barrier]) {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }

    var delayAfterExecution = 1.0

    var executeBlock: ((@escaping () -> Void) -> Void)?

    override func start() {
        isFinished = false
        isExecuting = true
        main()
    }

    override func main() {
        executeBlock?() { [weak self] in
            guard let self = self else { return }
            DispatchQueue.global().asyncAfter(deadline: .now() + self.delayAfterExecution) { [weak self] in
                self?.finish()
            }
        }
    }

    func finish() {
        isExecuting = false
        isFinished = true
    }
}
