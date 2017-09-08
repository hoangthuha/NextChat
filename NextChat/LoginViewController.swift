//
//  LoginViewController.swift
//  NextChat
//
//  Created by Jae Kee Li on 9/8/17.
//  Copyright © 2017 Hoang Thu Ha. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check if there is a suser logged in
        if Auth.auth().currentUser != nil{
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {return}
            //skip loginpage / go to homepage
            present(vc, animated: true, completion: nil)
        }
        
        loginButton.addTarget(self, action: #selector(loginUser), for: .touchUpInside)
        
    }
    
    func loginUser() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if self.emailTextField.text == "" {
                self.createErrorAlert("Empty Email Field", "Please Input Valid Email")
                return
            } else if self.passwordTextField.text == "" {
                self.createErrorAlert("Enpty Password Field", "Please Input Vaild Password")
                return
            }
        }
        
        if let validUser = user? {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {return}
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func createErrorAlert(_ title: String, _ message : String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
