//
//  NoteTableViewCell.swift
//  ConfApp
//
//  Created by Marta Piątek on 11.06.2018.
//  Copyright © 2018 Marta Piątek. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentLabel: UITextView!
  //  @IBOutlet var dateLabel: UILabel!
   // @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .blue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
