//
//  ViewController.swift
//  Hackin the Web
//
//  Created by Kyle Lee on 6/18/17.
//  Copyright © 2017 Kyle Lee. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    let webView = WKWebView()
    
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.gmail.com")!
        let request = URLRequest(url: url)
        webView.frame = CGRect(x: 0, y: 300, width: 300, height: 300)
        webView.load(request)
        view.addSubview(webView)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let emails = sender as AnyObject as? [Email],
            let emailsVC = segue.destination as? EmailsVC
            else { return }
        emailsVC.emails = emails
    }

    @IBAction func onSignInTapped() {
        switch counter {
        case 0:
            webView.evaluateJavaScript("document.getElementById('Email').value='\(emailTF.text!)'", completionHandler: nil)
        case 1:
            webView.evaluateJavaScript("document.getElementById('gaia_loginform').submit();", completionHandler: nil)
        case 2:
            webView.evaluateJavaScript("document.getElementById('Passwd').value='\(passwordTF.text!)'", completionHandler: nil)
        case 3:
            webView.evaluateJavaScript("document.getElementById('gaia_loginform').submit();", completionHandler: nil)
        case 4:
            webView.reload()
        default:
            webView.evaluateJavaScript("document.getElementsByTagName('html')[0].innerHTML", completionHandler: { (innerHTML, error) in
                do {
                    let gmailResponse = try GmailResponse(innerHTML)
                    self.performSegue(withIdentifier: "ShowEmails", sender: gmailResponse.emails)
                } catch {}
            })
        }
        counter += 1
    }
    
    
}

