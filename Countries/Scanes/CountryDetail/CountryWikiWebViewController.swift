//
//  WebViewViewController.swift
//  Countries
//
//  Created by Ali Eren on 2.09.2022.
//

import Foundation
import UIKit
import WebKit

final class CountryWikiWebViewController: UIViewController {
    
    private var url: URL?
    
    private let webView: WKWebView = {
       let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let webView = WKWebView(frame: .zero,configuration: config)
        return webView
    }()

    convenience init(url: URL) {
        self.init()
        self.url = url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
