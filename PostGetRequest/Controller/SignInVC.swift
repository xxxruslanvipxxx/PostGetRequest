//
//  SignInVC.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 5.03.24.
//

import UIKit

class SignInVC: UIViewController {
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .black
        setupView()
        initializeHideKeyboard()
    }
    
    //MARK: Methods
    
    private func initializeHideKeyboard() {
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    private func setContinueButton(enabled: Bool) {
        
        if enabled {
            continueButton.isEnabled = true
            continueButton.alpha = 1
        } else {
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
        }
        
    }
    
    //MARK: Objc methods
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func textFieldChanged() {
        
        guard 
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text
        else { return }
        
        let formFilled = !email.isEmpty && !password.isEmpty
        
        self.setContinueButton(enabled: formFilled)
        
    }
    
    @objc private func handleSignUpButton() {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    
    @objc private func handleContinueButton() {
        view.endEditing(true)
        // add signUp.isEnabled = false later
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityIndicator.startAnimating()
        
        print("Continue")
    }
    
    //MARK: UI Setup

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In"
        
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "example@mail.com"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "12345678"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        textField.returnKeyType = .continue
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 4
        button.alpha = 0.5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleContinueButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private func setupView() {
        
        view.addSubview(signInLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(signUpButton)
        view.addSubview(continueButton)
        continueButton.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([signInLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                                     signInLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
                                     signInLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 16),
                                     emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)])

        NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                                     emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
                                     passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor)])

        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
                                     passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
                                     signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
                                     signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
        
        NSLayoutConstraint.activate([continueButton.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -40),
                                     continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     continueButton.heightAnchor.constraint(equalToConstant: 50),
                                     continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)])
        
        NSLayoutConstraint.activate([activityIndicator.centerXAnchor.constraint(equalTo: continueButton.centerXAnchor),
                                     activityIndicator.centerYAnchor.constraint(equalTo: continueButton.centerYAnchor)])

    }

}

//MARK: - UITextFieldDelegate

extension SignInVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
    }
    
}
