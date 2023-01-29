//
//  RegisterViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2023/01/27.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet var firstnameField: UITextField!
    @IBOutlet var lastnameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepViews()
    }
    
    func prepViews() {
        emailField.delegate = self
        passwordField.delegate = self
        
        firstnameField.leftSymbol(sysImage: "person")
        lastnameField.leftSymbol(sysImage: "person")
        emailField.leftSymbol(sysImage: "envelope")
        passwordField.leftSymbol(sysImage: "lock")
        
//        passwordField.configTextEdit()
//        emailField.configTextEdit()
        
        signUpButton.backgroundColor = Colors.darkColor
        signUpButton.titleLabel?.textColor = Colors.redColor
        
        firstnameField.makeRound()
        lastnameField.makeRound()
        emailField.makeRound()
        passwordField.makeRound()
        signUpButton.makeRound()
        
        firstnameField.becomeFirstResponder()
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        performSegue(withIdentifier: "register", sender: nil)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    
    
}
