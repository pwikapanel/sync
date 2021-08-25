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
    
    newsWebView.loadHTMLString(html + Text.News.Placeholder.message + "</body></html>", baseURL: nil)
    //newsWebView.loadHTMLString(html + "" + "</body></html>", baseURL: nil)
    newsWebView.setValue(false, forKey: "drawsBackground")
    toolTip = Text.Home.Tooltip.newsView
    
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
    //newsWebView.loadHTMLString(data.text, baseURL: nil)
    newsWebView.loadHTMLString(html + data.text + "</body></html>", baseURL: nil)
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

private extension NewsView {
  
  var html: String {
    """
        <html><head><style type="text/css">
        
        html, body  { margin: 0; height: 100%; overflow: hidden; cursor:default;}
        
        h1, p{ font-family: '-apple-system','HelveticaNeue';
            margin: 0;
           padding: 0;
             color: #535353; }
        
        h1{ margin-bottom:3px; }
        
        h1{ font-size:13; line-height:13pt; }
        p { font-size:11; line-height:11.5pt; }
        
        a:link, a:visited{ text-decoration:none; color:#3273DC; }
        a:hover, a:active{ text-decoration:none; color:#FF00AA; }
        
        @media (prefers-color-scheme: dark) { h1, p{ color:#9b9b9b; }
        
        </style></head><body style="margin: 0;padding: 0">
        """
  }
}
