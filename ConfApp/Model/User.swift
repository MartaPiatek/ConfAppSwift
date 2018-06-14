//
//  User.swift
//  ConfApp
//
//  Created by Marta Piątek on 30.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    let ref: DatabaseReference?
  
    let firstName: String
    let lastName: String
    let company: String
    let job: String
    
    let key: String
    
    
    init( firstName: String, lastName: String, company: String, job: String, key: String = ""){
        
        self.ref = nil
        self.key = key
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.job = job
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let firstName = value["firstName"] as? String,
            let lastName = value["lastName"] as? String,
            let company = value["company"] as? String,
         let job = value["job"] as? String
            else {
                return nil
        }
        //  self.eventId = ""
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.company = company
        self.job = job
        
    }
    
    func toAnyObject() -> Any {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "company": company,
            "job": job
        ]
    }
}
