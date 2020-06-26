//
//  BusinessDisplayTableViewCell.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BusinessDisplayTableViewCell: UITableViewCell {

    @IBOutlet private weak var businessImageImageView: UIImageView!
    
    @IBOutlet private weak var businessNameLabel: UILabel!
    
    @IBOutlet private weak var businessTypeLabel: UILabel!
    
    @IBOutlet private weak var donateButton: UIButton!
    
    func configureCell(buisnessName: String, buisnessType: String, buisnessImage: UIImage){
        
        businessImageImageView.image = buisnessImage
        businessNameLabel.text = buisnessName
        businessTypeLabel.text = buisnessType
    }
  
}
