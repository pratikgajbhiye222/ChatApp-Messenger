//
//  RegisterViewController.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 23/06/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    //UI design
    private var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    private var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        
        
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
        presentPhotoActionSheet()
    }
    
    
    
    //viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        scrollView.frame = view.bounds
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width - size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width / 2.0
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
        //firebase login
        
        DatabaseManeger.shared.userExits(with: email) { [weak self](exists) in
            guard let strongSelf = self else { return }

            guard !exists else {
                //user already exists
                strongSelf.alertUserLoginError(with: "User Already exists")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] (authResult, error) in
                guard let strongSelf = self else { return }
                guard let  _ =  authResult , error == nil else {
                    print("Error creating user")
                    return
                }
                DatabaseManeger.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    
    
    func alertUserLoginError(with message: String = "Please enter the correct information"){
        let alert = UIAlertController(title: "whoops", message: message, preferredStyle: .alert)
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func presentPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "Profile Picture", message: "How would you write to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: {[weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self]_ in
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet , animated: true)
        
    }
    
    func presentCamera(){
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc , animated:  true)
        
    }
    func presentPhotoPicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc , animated:  true)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = selectedImage
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

