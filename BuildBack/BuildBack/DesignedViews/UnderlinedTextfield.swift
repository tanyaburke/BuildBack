//
//  UnderlinedTextfield.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/30/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class UnderlinedTextfield: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commontInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commontInit()
    }
    
    private func commontInit() {
        configurePlaceHolderTextAttribute()
        let bottomLayer: CALayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: frame.height - 3, width: frame.width , height: 2)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLayer)
    }
    
    private func configurePlaceHolderTextAttribute(){
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        
    }
}
