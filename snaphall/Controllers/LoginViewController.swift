//
//  ViewController.swift
//  snaphall
//
//  Created by IACD 013 on 2022/12/10.
//

import UIKit

class LoginViewController: UIViewController {

    private let imageView: UIImageView = {
       let imageView = UIImageView()
    
        imageView.contentMode = .scaleAspectFill
        imageView.layer.opacity = 0.5
        imageView.layer.opacity = 5
        imageView.image = UIImage(named: "ball")
        
       return imageView
    }()
    
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var signInButton: UIButton!
    
    var activeField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundImage()
        prepViews()
        
    }
    
    
    @IBAction func login(_ sender: Any) {
        
        performSegue(withIdentifier: "login", sender: nil)
        
    }
    
    
    
    func prepViews() {
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.leftSymbol(sysImage: "envelope")
        passwordField.leftSymbol(sysImage: "lock")
        
        passwordField.configTextEdit()
        emailField.configTextEdit()
        
        signInButton.backgroundColor = Colors.darkColor
        signInButton.titleLabel?.textColor = Colors.redColor
        signInButton.makeRound()
        
    
        emailField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    

    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardY = self.view.frame.height - keyboardFrame.cgRectValue.height

            guard let activeField = activeField else { return }
        
            let fieldPosition = activeField.frame.origin.y
            
            if self.view.frame.origin.y >= 0 {
            
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    print("ORIGIN: \(self.view.frame.origin.y)")
                
                    if fieldPosition > (keyboardY - 20) {
                        self.view.frame.origin.y = self.view.frame.origin.y - (fieldPosition - (keyboardY - 80))
   
                    }

                }, completion: nil)
            }
            
        }
        
    }

    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn , animations: {
            
            self.view.frame.origin.y = 0
            
        }, completion: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func configBackgroundImage() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.sendSubviewToBack(imageView)
    }
    
    @IBAction func unwindToLogin(unwind: UIStoryboardSegue) {
        
    }
    
    

}


extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            passwordField.resignFirstResponder()
        }
        
        return true
    }
    
    
}
