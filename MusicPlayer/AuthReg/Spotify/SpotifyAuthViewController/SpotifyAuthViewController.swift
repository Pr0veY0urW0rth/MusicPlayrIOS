//
//  SpotifyAuthViewController.swift
//  MusicPlayer
//
//  Created by ProveY0urWorth on 08.04.2023.
//

import UIKit
import WebKit

class SpotifyAuthViewController: UIViewController, WKNavigationDelegate{
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = preferences
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    private var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(webView)
        webView.navigationDelegate = self
        setUpBackground()
        setWebAnchors()
        setUpWebView()
    }
    
    private func setUpBackground(){
        view.backgroundColor = .systemBackground
    }
    
    private func setWebAnchors(){
        webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func setUpWebView(){
        guard let url = SpotifyAuthManager.shared.signInURL else{
            return
        }
        webView.load(URLRequest(url: url))
    }
        
    private func handleSignIn(success: Bool){
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        let components = URLComponents(string: url.absoluteString)
        guard let code = components?.queryItems?.first(where: {$0.name == "code"})?.value else{
            return
        }
        webView.isHidden = true
        
        SpotifyAuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in
            DispatchQueue.main.async {
                self?.completionHandler?(success)
            }
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let vc = NavTapBar()
        vc.modalPresentationStyle = .fullScreen
        appDelegate.switchControllers(viewControllerToBeDismissed: self, controllerToBePresented: vc)
    }
}
