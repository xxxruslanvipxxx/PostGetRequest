//
//  UserProfileVC.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 22.02.24.
//

import UIKit
import FBSDKLoginKit

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
        guard !AccessToken.isCurrentAccessTokenActive else {return}
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    @objc private func handleCustomFBLogin() {
        
    }
}
