//
//  HeaderView.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/15/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit
import Kingfisher

///Can be removed. Initially wanted a Header view with scrollable list of buseinesses donated to
class HeaderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "mic")
        
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.5
        
        return iv
        
        
    }()
    
    //    private lazy var logoutButton: UIButton = {
    //        
    //        let lb = UIButton()
    //        
    //        return lb
    //        
    //    }
    
    init(imageURL: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
        commonInit()
        imageView.kf.setImage(with: URL(string: imageURL))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func addCornerRadius(){
        layer.cornerRadius = frame.height/2
    }
    
    private func configureShadow(){
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.5
    }
    private func commonInit() {
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    
    
}
