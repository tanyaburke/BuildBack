//
//  BusinessDisplayTableViewCell.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth

protocol BusinessCellDelegate: AnyObject {
    func didSelectBusiness( business: Business, businessCell: BusinessDisplayTableViewCell)
}

class BusinessDisplayTableViewCell: UITableViewCell {

    @IBOutlet private weak var businessLogoImageView: UIImageView!
    @IBOutlet private weak var businessNameLabel: UILabel!
    @IBOutlet private weak var businessTypeLabel: UILabel!
    @IBOutlet private weak var donateButton: UIButton!
    @IBOutlet private weak var bookmarkButton: UIButton!
    
    private var businessToSave: BusinessModel?
    private let db = DatabaseService()
    public var isBookmarked = false
    
    func configureCell(business: BusinessModel) {
        businessToSave = business
        businessNameLabel.adjustsFontSizeToFitWidth = true

        businessNameLabel.text = business.name
        businessTypeLabel.text = business.type
        
        DispatchQueue.main.async {
            self.businessLogoImageView.kf.indicatorType = .activity
            self.businessLogoImageView.kf.setImage(with: URL(string: business.imageURL))
        }
        
        if isBookmarked {
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }
    }
  
    @IBAction func donateButton(_ sender: UIButton) {
        UIViewController.showViewController(storyBoardName: "Donate", viewControllerId: "DonateViewController")
    }
    @IBAction func bookmarkButtonPressed(_ sender: UIButton) {
        guard let businessToBeBookmarked = businessToSave,
              let user = Auth.auth().currentUser
        else { return }
        if !isBookmarked {
            isBookmarked = true
            bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            db.bookmarkBusinessForUser(id: user.uid, business: businessToBeBookmarked) { () -> Void? in
                return
            }
        } else {
            isBookmarked = false
            bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            db.removeBookmarkedBusinessForUser(id: user.uid, businessID: businessToBeBookmarked.documentId) { () -> Void? in
                return
            }
        }
    }
}
