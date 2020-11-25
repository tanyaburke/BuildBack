//
//  InitialView.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class GifIntroView: UIView {
    
    //MARK:- UI Elements
    public lazy var logoGifImageView: UIImageView = {
        let gifImage =  UIImageView()
        gifImage.loadGif(name: "buildBack")
        gifImage.backgroundColor = .black
        gifImage.contentMode = .scaleAspectFit
        gifImage.animationDuration = 0.5
        return gifImage
    }()
    
    //MARK:- Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit(){
        loadingGif()
    }

    //MARK:- Element Constraint functions
    private func loadingGif() {
        addSubview(logoGifImageView)
        logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
        logoGifImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoGifImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logoGifImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        logoGifImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }

}
