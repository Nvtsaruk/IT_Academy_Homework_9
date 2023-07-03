//
//  ContactTableViewCell.swift
//  Nick_Tsaruk_Homework_9
//
//  Created by Tsaruk Nick on 3.07.23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
