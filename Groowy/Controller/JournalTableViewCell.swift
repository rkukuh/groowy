//
//  JournalTableViewCell.swift
//  Groowy
//
//  Created by Jaya Pranata on 2/14/19.
//  Copyright © 2019 R. Kukuh. All rights reserved.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
