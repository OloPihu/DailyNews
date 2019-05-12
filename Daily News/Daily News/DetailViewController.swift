//
//  DetailViewController.swift
//  Daily News
//
//  Created by Aleksander  on 06/05/2019.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
        // set delegate for the webView
        webView.navigationDelegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if articleUrl != nil {
            
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                return
            }
            
            let request = URLRequest(url: url!)
            
            webView.load(request)
            
        }
        

        
    }
}



extension DetailViewController: WKNavigationDelegate {
 
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        activityIndicator.stopAnimating()
        activityIndicator.alpha = 0
        
    }
}
