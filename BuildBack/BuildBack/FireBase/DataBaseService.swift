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
    
    static let itemsCollection = "items" //BusinessCollection
    static let bookmarkedBusinessesCollection = "bookmarkedBusinesses"
    
    lazy var db = Firestore.firestore()
    
    
    func createDatabaseUser(id: String, email: String, name: String, completion: @escaping ()-> Void? ) {
        db.collection("user").document(id).setData(["email": email, "name": name]) { (error) in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
    func bookmarkBusinessForUser(id: String, businessID: String, completion: @escaping ()-> Void? ) {
        db.collection("user").document(id).collection(DatabaseService.bookmarkedBusinessesCollection).document().setData(["bookmarkedBusinesses": businessID]) { (error) in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
    func removeBookmarkedBusinessForUser(id: String, businessID: String, completion: @escaping ()-> Void? ) {
        
        //TODO: It appears business IDs are generated uniquely each time, this needs to be changed to a static id for the purposes of bookmarking and removing bookmarks
        db.collection("user").document(id).collection(DatabaseService.bookmarkedBusinessesCollection).document(businessID).delete { (error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                completion()
            } else {
                print("bookmark removed successfully")
                completion()
            }
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
