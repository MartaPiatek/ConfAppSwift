//
//  ObserveEventTableViewCell.swift
//  ConfApp
//
//  Created by Marta Piątek on 29.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class ObserveEventTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
