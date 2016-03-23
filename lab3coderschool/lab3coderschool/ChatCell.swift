//
//  ChatCell.swift
//  lab3coderschool
//
//  Created by Tien on 3/23/16.
//  Copyright © 2016 Cititech. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
