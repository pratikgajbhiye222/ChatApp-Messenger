//
//  LoginViewController.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 23/06/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //UI design
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profilepic")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    private var emailField : UITextField = {
        let feild = UITextField()
        feild.autocapitalizationType = .none
        feild.autocorrectionType = .no
        feild.returnKeyType = .continue
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "Email Address..."
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.leftViewMode = .always
        feild.backgroundColor = .clear
        return feild
    }()
    
    private var passwordField : UITextField = {
        let feild = UITextField()
        feild.autocapitalizationType = .none
        feild.autocorrectionType = .no
        feild.returnKeyType = .done
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "Password"
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.leftViewMode = .always
        feild.backgroundColor = .clear
        feild.isSecureTextEntry = true
        return feild
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

   // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Log in"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTappedRegister))
        
        loginButton.addTarget(self, action: #selector(logginButtonTapped), for: .touchUpInside)
        
        //textfeild delegate
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        
        scrollView.addSubview(loginButton)
    }
    
    //viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        loginButton.frame = CGRect(x: 30,
        y: passwordField.bottom + 10,
        width: scrollView.width-60,
        height: 52)
    }
    @objc private func logginButtonTapped(){
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text , let password = passwordField.text , !email.isEmpty , !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
    }
    
    //firebase login
    
    func alertUserLoginError(){
        let alert = UIAlertController(title: "whoops", message: "Please enter the correct information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    }
    
    
   //for new registration didTappedRegister
    @objc private func didTappedRegister(){
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
}


  //MARK: - Textfeild delegate
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            logginButtonTapped()
        }
        
        return true
        
        
    }
    
    
}
