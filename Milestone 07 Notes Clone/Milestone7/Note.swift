//
//  Note.swift
//  Milestone7
//
//  Created by Mike Killewald on 8/5/17.
//  Copyright © 2017 Gameaholix. All rights reserved.
//

import UIKit

class Note: NSObject, NSCoding {
    
    var body: String
    var creation: Date
//    var lastEdit: Date?
    
    init(body: String) {
        self.body = body
        self.creation = Date()
    }
    
    required init(coder aDecoder: NSCoder) {
        body = aDecoder.decodeObject(forKey: "body") as! String
        creation = aDecoder.decodeObject(forKey: "creation") as! Date
//        lastEdit = aDecoder.decodeObject(forKey: "lastEdit") as? Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(body, forKey: "body")
        aCoder.encode(creation, forKey: "creation")
//        aCoder.encode(lastEdit, forKey: "lastEdit")
    }
}
