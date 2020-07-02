//
//  DataBaseManeger.swift
//  ChatApp-Messanger
//
//  Created by pratik gajbhiye on 01/07/20.
//  Copyright © 2020 Mobile. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class DatabaseManeger{
    
    static let shared = DatabaseManeger()
    
    private let database  = Database.database().reference()
    
    
    
    
}

//MARK:- Account Manegment

extension DatabaseManeger {
    
    public func userExits(with email: String, completion : @escaping (Bool)-> Void) {
        database.child(email).observeSingleEvent(of: .value) { (snapshot) in
            guard  snapshot.value as? String != nil else {
                completion(false)
                return
                
            }
        }
        completion(true)
    }
    
    
    ///insert user in firebase to database
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName ,
            "last_name": user.lastName
        ])
    }
    
}


struct ChatAppUser {
    let firstName : String
    let lastName : String
    let emailAddress: String
//    let profilePicture: String
}
