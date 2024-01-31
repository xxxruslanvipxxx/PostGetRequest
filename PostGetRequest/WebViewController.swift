//
//  WebViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 31.01.24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var selectedCourse: String?
    var courseURL = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedCourse
        setupWebView()
    }

    
    func setupWebView() {
        guard let url = URL(string: courseURL) else {return}
        let request = URLRequest(url: url)
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    
}
