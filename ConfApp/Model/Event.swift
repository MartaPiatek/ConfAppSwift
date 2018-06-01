//
//  Event.swift
//  ConfApp
//
//  Created by Marta Piątek on 20.05.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import Foundation
import Firebase

struct Event {
    
     let ref: DatabaseReference?
   // var eventId: String
    let speaker: String
    let title: String
    let date: String
    let time: String
    let localization: String
    let key: String
    
    
    init( speaker: String, title: String, date: String, time: String, localization: String, key: String = ""){
        
        self.ref = nil
        self.key = key
       // self.eventId = ""
        self.speaker = speaker
        self.title = title
        self.date = date
        self.time = time
        self.localization = localization
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let speaker = value["speaker"] as? String,
            let title = value["title"] as? String,
        let date = value["date"] as? String,
        let time = value["time"] as? String,
        let localization = value["localization"] as? String else {
                return nil
        }
      //  self.eventId = ""
        self.ref = snapshot.ref
        self.key = snapshot.key
        self.speaker = speaker
        self.title = title
        self.date = date
        self.time = time
        self.localization = localization
    }
    
    func toAnyObject() -> Any {
        return [
            "speaker": speaker,
            "title": title,
            "date": date,
            "time": time,
            "localization": localization
        ]
    }
}
