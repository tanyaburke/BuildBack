//
//  AppColors.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/30/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit


enum AppColors{
    
    case purple
    //case spring
    
    var color: UIColor {
        switch self {
            
        case .purple:
            return UIColor(named:"purple") ?? UIColor.black
        @unknown default:
            return .black
        }
    }
}

func apply(){
 
}
