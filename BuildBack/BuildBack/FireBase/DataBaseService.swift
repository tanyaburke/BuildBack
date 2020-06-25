//
//  DataBaseService.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore


class DatabaseService {
    
    static let itemsCollectio = "items" //BusinessCollection
    
    
    lazy var db = Firestore.firestore()
    
    
    func createDatabaseUser(id: String, email: String, name: String, completion: @escaping ()-> Void? ) {
        db.collection("user").document(id).setData(["email": email, "name": name]) { (error) in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
    
//    func createItem(companyName: String, completion @escaping (Result<String, Error>) -> ()) {
//        
//        guard let user = Auth.auth().currentUser else {return}
//    }
//    func fetchData(userID: String, completion: @escaping(Result<[BusinessModel], Error>) -> ()){
//        
//        db.collection("business").getDocuments { (snapshot, error) in
//            if let error = error{
//                completion(.failure(error))
//            }else if let snapshot = snapshot {
//                let businesses = [BusinessModel]()
//                let business = snapshot.documents.map{$0.data()}
////                business.forEach{
//                    
//                
//                    
////                }
//            }
//        }
//        
//    }
    
    
}