//
//  BusinessModel.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/4/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation


struct BusinessModel {
    
    let buisnessId: String
    let buisnessName: String
    let type: String
    let partOfApp: Bool
    let email: String
    let address: String
    let description: String
    let paymentType: String
    let imageURL: String

    
}

extension BusinessModel {
    init(_ dictionary: [String: Any]){
        self.buisnessId = dictionary["buisnessId"] as? String ?? ""
        self.buisnessName = dictionary["buisnessName"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.partOfApp = dictionary["partOfApp"] as? Bool ?? false
        self.email = dictionary["email"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.paymentType = dictionary["paymentType"] as? String ?? ""
        self.imageURL = dictionary["imageURL"] as? String ?? ""
    }
}
