//
//  ViewController.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 23/06/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        print("firstcommit")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav , animated: false)
        }
    }


}

