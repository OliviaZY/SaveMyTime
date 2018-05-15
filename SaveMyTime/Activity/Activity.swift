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
    var name: String?
    var category: String?
    var icon: String?
    var created: Date?
    var color: UIColor?
    
    init(data: [String: Any], id: String?) {
        self.id = id
        self.name = data["name"] as? String
        self.category = data["category"] as? String
        self.icon = data["icon"] as? String
        self.color = (data["colorName"] as? String)?.toUIColor()
        if let d = data["created"] as? Date {
            self.created = d
        } else {
            self.created = Date()
        }
    }
    
    var data: [String: Any] {
        return [
            "name": self.name!,
            "colorName": self.color!.toString(),
            "icon": self.icon!,
            "category": self.category!,
            "created": self.created!]
    }
}

public extension String {
    func toUIColor() -> UIColor? {
        let componentsString = self.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        if components.count != 4 {
            return nil
        }
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                       green: CGFloat((components[1] as NSString).floatValue),
                       blue: CGFloat((components[2] as NSString).floatValue),
                       alpha: CGFloat((components[3] as NSString).floatValue))
    }
}

public extension UIColor {
    func toString() -> String {
        let components = self.cgColor.components!
        return "[\(components[0]), \(components[1]), \(components[2]), \(components[3])]"
    }
}
