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
    var name: String
    var category: String
    var created: Date
    
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
    
    var data: [String: Any] {
        return [
            "name": self.name,
            "category": self.category,
            "created": self.created]
    }
}
