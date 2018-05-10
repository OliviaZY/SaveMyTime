//
//  Record.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/10/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import Foundation
//
//  Activity.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/3/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import Foundation

class Record {
    var id: String!
    var category: String!
    var numTracked: Int!
    var start: Date!
    var end: Date!
    
    init(data: [String: Any], id: String?) {
        self.id = id
        self.category = data["category"] as! String
        self.start = data["start"] as! Date
        self.end = data["end"] as! Date
        if let tracked = data["numTracked"] as? Int {
            self.numTracked = tracked
        } else {
            self.numTracked = 1
        }
    }
    
    var data: [String: Any] {
        return [
            "category": self.category,
            "numTracked": self.numTracked,
            "start": self.start,
            "end": self.end]
    }
}
