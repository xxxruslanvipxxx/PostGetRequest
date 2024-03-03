//
//  LoginViewController.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 21.02.24.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    var userProfile: UserProfile?
    
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
            }
        }

    }

    private func singIntoFirebase() {
        
        let acessToken = AccessToken.current
        
        guard let acessTokenString = acessToken?.tokenString else {return}
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: acessTokenString)
        
        Auth.auth().signIn(with: credentials) { authResult, error in
            if let error = error {
                print("Error singIntoFirebase")
                print(error.localizedDescription)
            }
            print("Success singIntoFirebase")
            self.fetchFBFields()
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
            self.userProfile = UserProfile(data: result)
            self.saveIntoFirebase()
        }
        
    }

    private func saveIntoFirebase() {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userData = ["name": userProfile?.name, "email": userProfile?.email]
        let values = [uid: userData]
        
        Database
            .database(url: "https://networking-test-app-default-rtdb.europe-west1.firebasedatabase.app")
            .reference()
            .child("users")
            .updateChildValues(values) { error, _ in
            if let error = error {
                print(error.localizedDescription)
            }
            
            print("Successfully saved user into firebase database")
            self.openMainViewController()
        }
        
    }
    
}
