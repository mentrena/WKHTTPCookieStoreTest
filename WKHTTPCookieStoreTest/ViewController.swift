//
//  ViewController.swift
//  WKHTTPCookieStoreTest
//
//  Created by Manuel Entrena on 09/04/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureWebView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        webView.load(URLRequest(url: URL(string: "https://www.theguardian.com/uk")!))
    }

    func configureWebView() {
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = .nonPersistent()
        configuration.websiteDataStore.httpCookieStore.add(self)
        let wv = WKWebView(frame: view.bounds, configuration: configuration)
        
        wv.navigationDelegate = self

        view.insertSubview(wv, at: 0)
        view.addConstraints([wv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                             wv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                             wv.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                             wv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)])
        self.webView = wv
    }
}

extension ViewController: WKHTTPCookieStoreObserver {
    
    func cookiesDidChange(in cookieStore: WKHTTPCookieStore) {
        cookieStore.getAllCookies { (cookies) in
            print("*************************")
            print("Cookies in observer function:")
            cookies.forEach { print($0.name) }
            print("*************************")
        }
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { (cookies) in
            print("*************************")
            print("Cookies in navigation delegate:")
            cookies.forEach { print($0.name) }
            print("*************************")
        }
    }

//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//        passCookiesToPresenter()
//    }
//
//    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
//        passCookiesToPresenter()
//    }
//
    
}
