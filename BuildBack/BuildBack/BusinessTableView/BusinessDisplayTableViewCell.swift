//
//  BusinessDisplayTableViewCell.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import Kingfisher

protocol BusinessCellDelegate: AnyObject {
    func didSelectBusiness( business: Business, businessCell: BusinessDisplayTableViewCell)
    
    
}


class BusinessDisplayTableViewCell: UITableViewCell {

    @IBOutlet public weak var businessLogoImageView: UIImageView!
    
    @IBOutlet private weak var businessNameLabel: UILabel!
    
    @IBOutlet private weak var businessTypeLabel: UILabel!
    
    @IBOutlet private weak var donateButton: UIButton!
    
//    func configureCell(buisnessName: String, buisnessType: String, buisnessImage: UIImage) {
    func configureCell(business: BusinessModel) {
        DispatchQueue.main.async {
            self.businessLogoImageView.kf.indicatorType = .activity
            print(business.imageURL)
            self.businessLogoImageView.kf.setImage(with: URL(string: business.imageURL))
//            self.businessLogoImageView.image = buisnessImage
        }
        businessNameLabel.text = business.name
        businessTypeLabel.text = business.type
    }
  
    @IBAction func donateButton(_ sender: UIButton) {
        UIViewController.showViewController(storyBoardName: "Donate", viewControllerId: "DonateViewController")
    }
}
