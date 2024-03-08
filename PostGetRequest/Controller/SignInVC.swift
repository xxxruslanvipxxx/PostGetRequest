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
        print("Continue")
    }
    
    //MARK: UI Setup

    lazy var signInLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign In"
        
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        textField.returnKeyType = .continue
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
        signInLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        signInLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        signInLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 20).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        view.addSubview(signUpButton)
        signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        view.addSubview(continueButton)
        continueButton.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -40).isActive = true
        continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
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
