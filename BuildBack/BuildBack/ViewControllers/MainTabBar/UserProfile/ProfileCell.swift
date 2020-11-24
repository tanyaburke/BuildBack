//
//  ProfileCell.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/4/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit



class ProfileCell: UICollectionViewCell {

    @IBOutlet weak var companyImage: UIImageView!
    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var companyType: UILabel!
    
    @IBOutlet weak var donateButton: UIButton!
    
//    func configureCell(podcast: Podcast) {
//        podcastCollectionNameLabel.text = podcast.collectionName
//        podcastImageView.getImage(with: podcast.artworkUrl600) { [weak self] (result) in
//            switch result {
//            case .failure:
//                
//                DispatchQueue.main.async {
//                    self?.podcastImageView.image = UIImage(named: "circle")
//                }
//                
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self?.podcastImageView.image = image
//                }
//            }
//        }
//    }
}
