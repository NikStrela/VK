////
////  ViewController.swift
////  vkClient2
////
////  Created by Yuriy borisov on 15.09.17.
////  Copyright © 2017 Yuriy borisov. All rights reserved.
////
//
//import UIKit
//import WebKit
//import Alamofire
//
//var globalToken: String = "0b24ce041f9e60731e2fb90c33420c8ba5d6aad789a0437b48f7f8ced3baf877c9aa5c7fe3a436d373bdb"
//
//class ViewController: UIViewController {
//    @IBOutlet weak var webview: WKWebView!{
//        didSet{
//            webview.navigationDelegate = self
//        }
//    }
//    
////    @IBOutlet weak var webview: WKWebView!
////    {
////        didSet {
////            webview.navigationDelegate = self
////        }
////    }
//    
//    var service = VKLoginService()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//       webview.load(service.getrequest())
//    }
//    
//    
//}
//
//extension ViewController: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
//        
//        guard let url = navigationResponse.response.url,
//            url.path == "/blank.html",
//            let fragment = url.fragment  else {
//                decisionHandler(.allow)
//                return
//        }
//        
//        let params = fragment
//            .components(separatedBy: "&")
//            .map { $0.components(separatedBy: "=") }
//            .reduce([String: String]()) { result, param in
//                var dict = result
//                let key = param[0]
//                let value = param[1]
//                dict[key] = value
//                return dict
//        }
//        
//        print(params)
//        
//        let token = params["access_token"]
//        
//        globalToken = token!
//        decisionHandler(.cancel)
//        
//        performSegue(withIdentifier: "toLoginPage", sender: token)
//    }
//}
//
//
//
