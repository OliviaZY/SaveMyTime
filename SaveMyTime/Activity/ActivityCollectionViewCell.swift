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
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    
    func display(_ activity: Activity) {
        self.labelView.text = activity.name
//        self.iconImageView.text =
        self.backgroundColor = activity.color
    }
}
