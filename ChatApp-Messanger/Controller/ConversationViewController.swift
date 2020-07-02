//
//  ViewController.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 23/06/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("firstcommit")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        validateAuth()
        
        }
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav , animated: false)
        }
    }
    
}

