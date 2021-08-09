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
    //textLabel.stringValue = ""
    //messageLabel.stringValue = ""
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
    //textLabel.stringValue = data.text
    //messageLabel.stringValue = data.message
    newsWebView.loadHTMLString(data.text, baseURL: nil)
  }
  
}

/*
 class PreferenceHelpView: NSView {
 @IBOutlet weak var helpWebView: WKWebView!
 
 override func awakeFromNib() {
 super.awakeFromNib()
 loadContent()
 helpWebView.navigationDelegate = self
 }
 
 private func loadContent() {
 helpWebView.loadHTMLString(html, baseURL: nil)
 helpWebView.setValue(false, forKey: "drawsBackground")
 toolTip = Text.Preference.Tooltip.visitLink
 }
 }

 */
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

private extension NewsView {
  
  var html: String {
    """
        <html>
        <head>
        <style type=\"text/css\">
            body{font-family: '-apple-system','HelveticaNeue'; font-size:13;}
            a:link{text-decoration:none;color:#3273DC}a:visited{text-decoration:none;color:#3273DC}a:hover{text-decoration:none;color:#3273DC}a:active{text-decoration:none;color:#3273DC}
            @media (prefers-color-scheme: dark) {
            body{color: white;}
            }
        </style>
        </head>
        <body style="margin: 0;padding: 0">
            \(Text.Preference.Help.html)
        </body>
        </html>
        """
  }
}
