//
//  LoginViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 21.02.24.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    lazy var fbLoginButton: UIButton = {
        let fbLoginButton = FBLoginButton()
        fbLoginButton.frame = CGRect(x: 32, y: 320, width: view.frame.width - 64, height: 28)
        fbLoginButton.delegate = self
        
        return fbLoginButton
    }()
    
    lazy var fbCustomLoginButton: UIButton = {
        let fbButton = UIButton(type: .custom)
        fbButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 153/255, alpha: 1)
        fbButton.setTitle("Login with Facebook", for: .normal)
        fbButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        fbButton.setTitleColor(.white, for: .normal)
        fbButton.frame = CGRect(x: 32,
                                y: view.frame.height - 242,
                                width: view.frame.width - 64,
                                height: 50)
        fbButton.layer.cornerRadius = 4
        fbButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
        return fbButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(fbCustomLoginButton)
    }

}

//MARK: - Facebook SDK

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
        guard AccessToken.isCurrentAccessTokenActive else {return}
        singIntoFirebase()
        fetchFBFields()
        openMainViewController()
        print("Successfully logged in with facebook...")
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("Logged out")
    }
    
    private func openMainViewController() {
        dismiss(animated: true)
    }
    
    @objc private func handleCustomFBLogin() {
        
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["email", "public_profile"], from: self) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                self.singIntoFirebase()
                self.fetchFBFields()
                self.openMainViewController()
            }
        }

    }

    private func singIntoFirebase() {
        
        let acessToken = AccessToken.current
        
        guard let acessTokenString = acessToken?.tokenString else {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: acessTokenString)
        Auth.auth().signIn(with: credentials) { authResult, error in
            if let error = error {
                print("Error")
                print(error.localizedDescription)
            } else if let result = authResult {
                print("Success")
                print(result.user)
            }
            
        }
    }
    
    private func fetchFBFields() {
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]) // [:] parameters fetch only "name" and "id" fields
        
        request.start { _, result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let result = result as? [String: Any] else {return}
            print(result)
        }
        
    }

}
