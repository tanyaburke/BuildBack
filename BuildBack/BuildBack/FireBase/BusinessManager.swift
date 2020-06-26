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
        databaseService.db.collection("buisness").getDocuments { (snapshot, error) in
            
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
    
}

