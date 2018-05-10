//
//  Activity.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/3/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit

class Activity {
    var id: String?
    var name: String
    var category: String
    var created: Date
    var colorName: String?
    
    init(data: [String: Any], id: String?) {
        self.id = id
        self.name = data["name"] as! String
        self.category = data["category"] as! String
        self.colorName = data["colorName"] as! String
        if let d = data["created"] as? Date {
            self.created = d
        } else {
            self.created = Date()
        }
    }
    
    var color: UIColor {
        switch self.colorName {
        case "red":
            return UIColor.red
        case "blue":
            return UIColor.blue
        case "black":
            return UIColor.black
        case "orange":
            return UIColor.orange
        default:
            return UIColor.gray
        }
    }
    
    var data: [String: Any] {
        return [
            "name": self.name,
            "colorName": self.colorName!,
            "category": self.category,
            "created": self.created]
    }
}
