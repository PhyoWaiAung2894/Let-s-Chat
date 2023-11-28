//
//  RegisterViewController.swift
//  Let's Chat
//
//  Created by PhyoWai Aung on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    var userNameTextField : UITextField!
    var passwordTextField : UITextField!
    
    var text = "3aws@gmai.com"
    var text1 = "toutomobi"
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User Name"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.backgroundColor = .cyan
        view.addSubview(userNameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .cyan
        view.addSubview(passwordTextField)
        
        let registerButton = UIButton(type: .custom)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .blue
        registerButton.layer.cornerRadius = 10
        registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 40),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,constant: 8),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 120)
            
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @objc func registerPressed(_ sender: UIButton) {
        if let email = userNameTextField.text ,let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                // ...
                if let e = error {
                    print(e)
                }else{
                    
                    let chatviewController = ChatViewController()
                    self.navigationController?.pushViewController(chatviewController, animated: true)
                }
            }
        }

    }
    
}
