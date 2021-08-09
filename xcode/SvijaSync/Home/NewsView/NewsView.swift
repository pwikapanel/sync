//
//  NewsView.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 15/2/21.
//

import Cocoa
import Foundation
import WebKit

class NewsView: NSView {
  
  private let viewModel = NewsViewModel()
  
  @IBOutlet weak var textLabel: NSTextField!
  @IBOutlet weak var messageLabel: NSTextField!
  @IBOutlet weak var newsWebView: WKWebView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    textLabel.isHidden = true
    messageLabel.isHidden = true
    
    newsWebView.loadHTMLString("", baseURL: nil)
    newsWebView.setValue(false, forKey: "drawsBackground")
    
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
    newsWebView.loadHTMLString(data.text, baseURL: nil)
  }
  
}

extension NewsView: WKNavigationDelegate {
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if navigationAction.navigationType == .linkActivated {
      if let url = navigationAction.request.url {
        NSWorkspace.shared.open(url)
        decisionHandler(.cancel);
      } else {
        decisionHandler(.allow);
      }
    } else {
      decisionHandler(.allow);
    }
  }
  
}
