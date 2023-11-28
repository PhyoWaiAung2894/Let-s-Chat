//
//  ViewController.swift
//  Let's Chat
//
//  Created by PhyoWai Aung on 11/21/23.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    var appName : UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func loadView() {
        
        view = UIView()
        view.backgroundColor = .white
        
        appName = UILabel()
        appName.translatesAutoresizingMaskIntoConstraints = false
        appName.textAlignment = .center
        appName.text = "Let's Talk"
        appName.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        appName.textColor = UIColor(hex: "#2AC7FE")
        view.addSubview(appName)
        
        let registerButton = UIButton(type: .custom)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(hex: "#2AC7FE")
        registerButton.layer.cornerRadius = 8
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        let loginButton = UIButton(type: .custom)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(hex: "#2AC7FE")
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            appName.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            appName.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor,constant: 20),
            
//            registerButton.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 40),
            registerButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -10),
            
            loginButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 10),
            loginButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, constant: -10),
            loginButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -30)
            
        ])
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        appName.text = ""
        var charIndex = 0.0
        let titleLabel = "Let's Talk 😃"
        for letter in titleLabel {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.appName.text?.append(letter)
            }
            charIndex += 1
        }
    }

    @objc func loginTapped(_ sender: UIButton) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @objc func registerTapped(_ sender: UIButton) {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

