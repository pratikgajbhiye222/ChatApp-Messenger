//
//  RegisterViewController.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 23/06/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //UI design
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
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
    private var firstNameFeild : UITextField = {
        let feild = UITextField()
        feild.autocapitalizationType = .none
        feild.autocorrectionType = .no
        feild.returnKeyType = .continue
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "FirstName"
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.leftViewMode = .always
        feild.backgroundColor = .clear
        return feild
    }()
    
    private var lastNameFeild : UITextField = {
        let feild = UITextField()
        feild.autocapitalizationType = .none
        feild.autocorrectionType = .no
        feild.returnKeyType = .continue
        feild.layer.cornerRadius = 12
        feild.layer.borderWidth = 1
        feild.layer.borderColor = UIColor.lightGray.cgColor
        feild.placeholder = "Last Name"
        feild.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        feild.leftViewMode = .always
        feild.backgroundColor = .clear
        return feild
    }()
    
    private let registerButton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
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
        
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        //textfeild delegate
        emailField.delegate = self
        passwordField.delegate = self
        
        //Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(firstNameFeild)
        scrollView.addSubview(lastNameFeild)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        
        //add gesture to imageview for change in profile picture
        scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self,
                                          action: #selector(didTappedChangeProfilePic))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
        
        
    }
    
    @objc private func didTappedChangeProfilePic(){
        print("hora hai bhai tapped")
    }
    
    
    
    //viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        firstNameFeild.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        lastNameFeild.frame = CGRect(x: 30,
                                  y: firstNameFeild.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameFeild.bottom + 10,
                                  width: scrollView.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width-60,
                                     height: 52)
        registerButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width-60,
                                   height: 52)
    }
    @objc private func registerButtonTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let firstName = firstNameFeild.text ,
            let lastName = lastNameFeild.text,
            let email = emailField.text ,
            let password = passwordField.text,
            !firstName.isEmpty,
            !email.isEmpty ,
            !lastName.isEmpty ,
            !password.isEmpty,
            password.count >= 6
            else {
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
extension RegisterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            registerButtonTapped()
        }
        
        return true
        
        
    }
    
    
}
