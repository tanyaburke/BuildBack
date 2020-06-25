//
//  BusinessDisplayTableViewCell.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BusinessDisplayTableViewCell: UITableViewCell {

    @IBOutlet weak var businessImage: UIImageView!
    
    @IBOutlet weak var businessName: UILabel!
    
    @IBOutlet weak var businessType: UILabel!
    
    @IBOutlet weak var buusinessButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
