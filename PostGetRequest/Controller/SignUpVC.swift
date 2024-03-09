//
//  SignUpVC.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 5.03.24.
//

import UIKit

class SignUpVC: UIViewController {

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
            let username = self.usernameTextField.text,
            let email = self.emailTextField.text,
            let password = self.passwordTextField.text,
            let confirmPassword = self.confirmPasswordTextField.text
        else { return }
        
        let formFilled = !username.isEmpty && !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
        
        self.setContinueButton(enabled: formFilled)
        
    }
    
    @objc private func handleContinueButton() {
        view.endEditing(true)
        print("Continue")
    }
    
    //MARK: UI Setup

    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sign Up"
        
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "user"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
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
        textField.tag = 2
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
        textField.tag = 3
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
    }()
    
    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm password"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.placeholder = "12345678"
        textField.textColor = .black
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 4
        textField.returnKeyType = .continue
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        return textField
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
        
        view.addSubview(signUpLabel)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([signUpLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
                                     signUpLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
                                     signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([usernameLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 16),
                                     usernameLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor)])
        
        NSLayoutConstraint.activate([usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
                                     usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
                                     emailLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor)])

        NSLayoutConstraint.activate([emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                                     emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
                                     passwordLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor)])

        NSLayoutConstraint.activate([passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
                                     passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])

        NSLayoutConstraint.activate([confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
                                     confirmPasswordLabel.leadingAnchor.constraint(equalTo: confirmPasswordTextField.leadingAnchor)])

        NSLayoutConstraint.activate([confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
                                     confirmPasswordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
                                     confirmPasswordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
        
        NSLayoutConstraint.activate([continueButton.bottomAnchor.constraint(equalTo: self.view.keyboardLayoutGuide.topAnchor, constant: -25),
                                     continueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     continueButton.heightAnchor.constraint(equalToConstant: 50),
                                     continueButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)])

    }

}

//MARK: - UITextFieldDelegate

extension SignUpVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextTextField = self.view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
    }
    
}
