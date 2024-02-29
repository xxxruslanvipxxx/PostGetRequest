//
//  UserProfileVC.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 22.02.24.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class UserProfileVC: UIViewController {
    
    lazy var fbLoginButton: UIButton = {
        let fbLoginButton = FBLoginButton()
        fbLoginButton.frame = CGRect(x: 32,
                                     y: view.frame.height - 172,
                                     width: view.frame.width - 64,
                                     height: 28)
        fbLoginButton.delegate = self
        
        return fbLoginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
    }
    
}

//MARK: - Facebook SDK
extension UserProfileVC: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        openLoginViewController()
        print("Logged out")
        
    }
    
    private func openLoginViewController() {
        
        do {
            try Auth.auth().signOut()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}
