//
//  LoginViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 21.02.24.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    lazy var fbLoginButton: UIButton = {
        let fbLoginButton = FBLoginButton()
        fbLoginButton.frame = CGRect(x: 32, y: 320, width: view.frame.width - 64, height: 28)
        fbLoginButton.delegate = self
        
        return fbLoginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        if let token = AccessToken.current, !token.isExpired {
            print(token.userID)
            print(AccessToken.isCurrentAccessTokenActive)
            print(token.expirationDate)
        }
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
    }

}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        print("Successfully logged in with facebook...")
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("Logged out")
    }
    
}
