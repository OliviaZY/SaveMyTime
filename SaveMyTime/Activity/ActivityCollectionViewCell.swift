//
//  ActivityCollectionViewCell.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/3/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class ActivityCollectionViewCell: MDCCardCollectionCell {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var labelView: UILabel!
    
    func display(_ activity: Activity) {
        self.labelView.text = activity.name
        self.iconLabel.text = activity.icon
        self.backgroundColor = activity.color
    }
}
