//
//  CircularImageView.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/15/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class CircularImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCornerRadius()
        configureShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addCornerRadius()
        configureShadow()
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
    
}
