//
//  UserProfile.swift
//  PostGetRequest
//
//  Created by Руслан Забиран on 3.03.24.
//

import Foundation

struct UserProfile: Decodable {
    
    var name: String?
    var id: Int?
    var email: String?
    
    init(data: [String: Any]) {
        let name = data["name"] as? String
        let id = data["id"] as? Int
        let email = data["email"] as? String
        
        self.name = name
        self.id = id
        self.email = email
    }
    
}
