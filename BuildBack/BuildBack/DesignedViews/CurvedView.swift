//
//  CurvedView.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/15/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class CurvedView: UIView {

     override init(frame: CGRect) {
          super.init(frame: frame)
          addCornerRadius()
        
      }
      
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          
          addCornerRadius()
          
      }
      
      private func addCornerRadius(){
          layer.cornerRadius = 20
       
      }

}
