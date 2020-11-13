//
//  UserModel.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/4/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

struct UserModel {
    let userId: String
    let name: String
    let type: String
    let address: String
    let partOfApp: Bool
    let email: String
    let description: String
    let donatedTo: [Business]
    let bookmarkedBusinesses: [String]
}

struct Business {
    let donatedTo: BusinessModel
    let donatedAmount: Double
    
}
