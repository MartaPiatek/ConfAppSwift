//
//  CreateChannelTableViewCell.swift
//  ConfApp
//
//  Created by Marta Piątek on 06.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class CreateChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var newChannelNameField: UITextField!
    @IBOutlet weak var createChannelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
