//
//  CurrentUser.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 3.03.24.
//

import Foundation

struct CurrentUser {
    var uid: String
    var name: String
    var email: String
    
    init?(uid: String, data: [String: Any]) {
        guard 
            let name = data["name"] as? String,
            let email = data["email"] as? String
        else {return nil}
        
        self.name = name
        self.email = email
        self.uid = uid
    }
    
}
