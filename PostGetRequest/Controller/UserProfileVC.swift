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
import GoogleSignIn

class UserProfileVC: UIViewController {
    
    private var provider: String?
    private var currentUser: CurrentUser?
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 32,
                                     y: view.frame.height - 172,
                                     width: view.frame.width - 64,
                                     height: 28)
        button.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 153/255, alpha: 1)
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(logOutButtonHandle), for: .touchUpInside)
        
        return button
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
        view.addSubview(logOutButton)
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: userNameLabel.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
    }
    
    //MARK: Objc methods
    @objc private func logOutButtonHandle() {
        singOut()
    }
    
}

//MARK: - Sign Out

extension UserProfileVC {
    
    private func openLoginViewController() {
        
        do {
            try Auth.auth().signOut()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let navigationController = UINavigationController(rootViewController: loginVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: false)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    private func fetchingUserData() {
        
        if Auth.auth().currentUser != nil {
            
            guard let uid = Auth.auth().currentUser?.uid,
                  let email = Auth.auth().currentUser?.email
            else {return}
            
            if let userName = Auth.auth().currentUser?.displayName,
               let email = Auth.auth().currentUser?.email,
               let data = ["email": email, "name": userName] as? [String: Any] {
                
                self.currentUser = CurrentUser(uid: uid, data: data)
                self.activityIndicator.stopAnimating()
                self.userNameLabel.isHidden = false
                self.userNameLabel.text = self.getProviderData()
                
            } else {
                
                Database
                    .database()
                    .reference()
                    .child("users")
                    .child(uid)
                    .observeSingleEvent(of: .value) { snapshot in
                        guard let userData = snapshot.value as? [String: Any] else {return}
                        self.currentUser = CurrentUser(uid: uid, data: userData)
                        self.activityIndicator.stopAnimating()
                        self.userNameLabel.isHidden = false
                        self.userNameLabel.text = self.getProviderData()
                    } withCancel: { error in
                        print(error.localizedDescription)
                    }
                
            }
        }
        
    }
    
    private func singOut() {
        
        guard let providerData = Auth.auth().currentUser?.providerData else {return}
        
        for userInfo in providerData {
            switch userInfo.providerID {
            case "facebook.com":
                LoginManager().logOut()
                print("User has logged out of Facebook")
                openLoginViewController()
            case "google.com":
                GIDSignIn.sharedInstance.signOut()
                print("User has logged out of Google")
                openLoginViewController()
            case "password":
                try! Auth.auth().signOut()
                print("User did sign out")
                openLoginViewController()
            default:
                print("User is signed in with \(userInfo.providerID)")
            }
        }
        
    }
    
    private func getProviderData() -> String {
        
        var greetings = ""
        guard let providerData = Auth.auth().currentUser?.providerData else {return "none"}
        for userInfo in providerData {
            switch userInfo.providerID {
            case "facebook.com":
                provider = "Facebook"
            case "google.com":
                provider = "Google"
            case "password":
                provider = "Email"
            default:
                break
            }
        }
        greetings = "\(currentUser?.name ?? "Noname") Logged in with \(provider!)"
        return greetings
    }
    
}
