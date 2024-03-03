//
//  UserProfileVC.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 22.02.24.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase

class UserProfileVC: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
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

        userNameLabel.isHidden = true
        setupViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchingUserData()
    }
    
    private func setupViews() {
        view.addSubview(fbLoginButton)
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: userNameLabel.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
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
    
    private func fetchingUserData() {
        
        if Auth.auth().currentUser != nil {
            guard let uid = Auth.auth().currentUser?.uid else {return}
            
            Database
                .database()
                .reference()
                .child("users")
                .child(uid)
                .observeSingleEvent(of: .value) { snapshot in
                    guard let userData = snapshot.value as? [String: Any] else {return}
                    let currentUser = CurrentUser(uid: uid, data: userData)
                    self.activityIndicator.stopAnimating()
                    self.userNameLabel.isHidden = false
                    self.userNameLabel.text = "\(currentUser?.name ?? "Noname") logged in with Facebook"
                } withCancel: { error in
                    print(error.localizedDescription)
                }

        }
    }
    
}
