//
//  Activity.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/3/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import Foundation

class Activity {
    var id: String?
    let name: String
    let category: String
    let created: Date
    
    init(data: [String: Any], id: String?) {
        self.id = id
        self.name = data["name"] as! String
        self.category = data["category"] as! String
        if let d = data["created"] as? Date {
            self.created = d
        } else {
            self.created = Date()
        }
    }
}
