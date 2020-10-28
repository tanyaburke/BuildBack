//
//  BuildBackTests.swift
//  BuildBackTests
//
//  Created by Tanya Burke on 5/21/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import XCTest
import Firebase
import FirebaseFirestore
import FirebaseAuth
@testable import BuildBack

class BuildBackTests: XCTestCase {
    override func setUp() {
    
    }
    
    func testPostBusinessToDataBase(){
        
        let exp = XCTestExpectation(description: "business added")
        guard let user = FirebaseAuth.Auth.auth().currentUser else{
            XCTFail("no logged user")
            return
        }
        let documentId = Firestore.firestore().collection("business").document().documentID
        let business = BusinessModel(documentId: documentId, name: "NailsByDreaKing", type: "Nail Technician", isMember: true, email: "@nailsbydreaking Instagram", address: "", description: "Nail Technician, Acrylics Only", paymentType: "ApplePay", imageURL: "gs://buildback-2e1ee.appspot.com/91968497_256415468821982_7294447772625797120_n(1).jpg")
        
  
        Firestore.firestore().collection("business").document(business.documentId).setData(["name": business.name,
                                                                                            "documentId": business.documentId, "type": business.type,
                                                                                            "isMember": business.isMember,
                                                                                            "email": business.email,
                                                                                            "address": business.address,
                                                                                            "description":business.description,
                                                                                            "paymentType": business.paymentType,
                                                                                            "imageURL": business.imageURL
            
        ]) { (error) in exp.fulfill()
            if let error = error{
                XCTFail("failed to upload video with error: \(error.localizedDescription)")
            }
            
            
            XCTAssert(true)
        }
        
        wait(for: [exp], timeout: 5.0)
        
    }
    
    
}


