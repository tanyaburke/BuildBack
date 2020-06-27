//
//  BusinessManager.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/26/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation

class BusinessManager {
    private let databaseService: DatabaseService
    
    init(databaseService: DatabaseService = DatabaseService()) {
        self.databaseService = databaseService
    }
    
    func retriveBusinesses(completion: @escaping (Result<[BusinessModel], Error>) -> Void) {
        databaseService.db.collection("business").getDocuments { (snapshot, error) in
            
            if let snapshot = snapshot{
                var businessArray = [BusinessModel]()
                snapshot.documents.forEach({
                    let business = BusinessModel($0.data())
                    businessArray.append(business)
                })
                completion(.success(businessArray))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
    }
    
  func sendBusinessData(business: BusinessModel) {
        databaseService.db.collection("business").document(business.documentId).setData(["name": business.name,
                                                                                         "documentId": business.documentId, "type": business.type,
                                                                                         "isMember": business.isMember,
                                                                                         "email": business.email,
                                                                                         "address": business.address,
                                                                                         "description":business.description,
                                                                                         "paymentType": business.paymentType,
                                                                                         "imageURL": business.imageURL
                                                                                         
        ]) { (error) in
            if let error = error{
                print(error)
            }
        }
        
        
    }
    
}

