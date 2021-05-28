//
//  NewsView.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 15/2/21.
//

import Cocoa
import Foundation

class NewsView: NSView {

    private let viewModel = NewsViewModel()
    
    @IBOutlet weak var textLabel: NSTextField!
    @IBOutlet weak var messageLabel: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.stringValue = ""
        messageLabel.stringValue = ""
        loadContent()
    }

    func loadContent() {
        viewModel.fetchContent { [weak self] data in
            DispatchQueue.main.async {
                self?.update(data)
            }
        }
    }

    private func update(_ data: NewsData) {
        textLabel.stringValue = data.text
        messageLabel.stringValue = data.message
    }

}
