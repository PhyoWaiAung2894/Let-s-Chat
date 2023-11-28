//
//  LoginViewController.swift
//  Let's Chat
//
//  Created by PhyoWai Aung on 11/22/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {
    
    var userNameTextField : UITextField!
    var passwordTextField : UITextField!
    
    var text = "1aws@gmai.com"
    var text1 = "automobi"
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User Name"
        userNameTextField.text = text
        userNameTextField.autocapitalizationType = .none
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.backgroundColor = .cyan
        view.addSubview(userNameTextField)
        
        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.text = text1
        passwordTextField.autocapitalizationType = .none
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .cyan
        view.addSubview(passwordTextField)
        
        let loginButton = UIButton(type: .custom)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.layer.cornerRadius = 10
        loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 40),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,constant: 8),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 120)
            
        ])
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @objc func loginPressed(_ sender: UIButton) {
        if let email = userNameTextField.text , let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    let alert = UIAlertController(title: "Can't Login", message: "Wrong Email or Wrong Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Done", style: .cancel))
                    self!.present(alert,animated: true)
                }else {
                    let chatViewController = ChatViewController()
                    self?.navigationController?.pushViewController(chatViewController, animated: true)
                }
            }
        }
    }

}
