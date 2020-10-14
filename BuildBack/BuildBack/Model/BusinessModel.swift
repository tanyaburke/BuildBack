//
//  BusinessModel.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/4/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation


struct BusinessModel {
    
    let documentId: String
    let name: String
    let type: String
    let isMember: Bool
    let email: String
    let address: String
    let description: String
    let paymentType: String
    let imageURL: String

    
}

extension BusinessModel {
    init(_ dictionary: [String: Any]){
        self.documentId = dictionary["documentId"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        self.isMember = dictionary["isMember"] as? Bool ?? false
        self.email = dictionary["email"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.paymentType = dictionary["paymentType"] as? String ?? ""
        self.imageURL = dictionary["imageURL"] as? String ?? ""
    }
}
