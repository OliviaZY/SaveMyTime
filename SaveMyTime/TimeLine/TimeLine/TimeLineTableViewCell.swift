//
//  TimeLineTableViewCell.swift
//  SaveMyTime
//
//  Created by Fred Zhang on 5/10/18.
//  Copyright © 2018 Yuan zhou. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var CategoryNameLabel: UILabel!
    @IBOutlet weak var TimeSpanLabel: UILabel!
    @IBOutlet weak var numActionLabel: UILabel!
    @IBOutlet weak var timeLengthLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
