//
//  MPTableViewCell.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit

class MPTableViewCell: UITableViewCell {
   
   
   @IBOutlet weak var fullName: UILabel!
   
   @IBOutlet weak var email: UILabel!
   
   @IBOutlet weak var phone: UILabel!
   
   @IBOutlet weak var photo: UIImageView!
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
