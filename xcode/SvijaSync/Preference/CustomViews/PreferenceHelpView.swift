//
//  PreferenceHelpView.swift
//  Svija Sync
//
//  Created by Rajesh Ramachandrakurup on 15/2/21.
//

import Cocoa
import WebKit

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

extension PreferenceHelpView: WKNavigationDelegate {

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


private extension PreferenceHelpView {

    var html: String {
        """
        <html>
        <head>
        <style type=\"text/css\">
            body{font-family: '-apple-system','HelveticaNeue'; font-size:13; cursor:default;}
            a:link{cursor:pointer;text-decoration:none;color:#3273DC}a:visited{text-decoration:none;color:#3273DC}a:hover{text-decoration:none;color:#3273DC}a:active{text-decoration:none;color:#3273DC}
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
