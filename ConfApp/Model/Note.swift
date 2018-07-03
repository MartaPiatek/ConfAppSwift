//
//  Note.swift
//  ConfApp
//
//  Created by Marta Piątek on 11.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation
import Firebase

struct Note {
    
    let ref: DatabaseReference?
    
    let user: String
    let eventTitle: String
    let content: String
    //let id: String
    
    let key: String
    
    
    init( user: String, eventTitle: String, content: String, key: String = ""){
        
        self.ref = nil
        self.key = key
        self.user = user
        self.eventTitle = eventTitle
        self.content = content
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let user = value["user"] as? String,
            let eventTitle = value["eventTitle"] as? String,
            let content = value["content"] as? String
            else {
                return nil
        }
        //  self.eventId = ""
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.user = user
        self.eventTitle = eventTitle
        self.content = content
        
    }
    
    func toAnyObject() -> Any {
        return [
            "user": user,
            "eventTitle": eventTitle,
            "content": content
        ]
    }
}
