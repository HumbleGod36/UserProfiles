//
//  TableTableViewCell.swift
//  UserProfiles
//
//  Created by Tony Michael on 15/01/24.
//

import UIKit

class TableTableViewCell: UITableViewCell {

    @IBOutlet weak var userPhoneNumber: UILabel!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
