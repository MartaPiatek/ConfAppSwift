//
//  News.swift
//  ConfApp
//
//  Created by Marta Piątek on 06.07.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation
import Firebase

struct News {
    
    let ref: DatabaseReference?
    
  
    let title: String
    let content: String
    //let id: String
    
    let key: String
    
    
    init( title: String, content: String, key: String = ""){
        
        self.ref = nil
        self.key = key
        
        self.title = title
        self.content = content
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
           
            let title = value["title"] as? String,
            let content = value["content"] as? String
            else {
                return nil
        }
        //  self.eventId = ""
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.title = title
        self.content = content
        
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "content": content
        ]
    }
}
