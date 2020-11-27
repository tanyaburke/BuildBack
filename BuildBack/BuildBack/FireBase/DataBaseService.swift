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
    static let userCollection = "user"
    
    lazy var db = Firestore.firestore()
    
    func createDatabaseUser(id: String, email: String, name: String, completion: @escaping ()-> Void? ) {
        db.collection(DatabaseService.userCollection).document(id).setData(["email": email, "name": name]) { (error) in
            if let error = error {
                print(error)
            }
            completion()
        }
    }
    func bookmarkBusinessForUser(id: String, business: BusinessModel, completion: @escaping ()-> Void? ) {
        db.collection(DatabaseService.userCollection).document(id).collection(DatabaseService.bookmarkedBusinessesCollection).document(business.documentId).setData(["documentId": business.documentId, "name": business.name, "type": business.type, "isMember": business.isMember, "email": business.email, "address": business.address, "description": business.description, "paymentType": business.paymentType, "imageURL": business.imageURL]) { (error) in
            if let error = error {
                print(error)
            } else {
                completion()
            }
        }
    }
    func removeBookmarkedBusinessForUser(id: String, businessID: String, completion: @escaping ()-> Void? ) {
        db.collection(DatabaseService.userCollection).document(id).collection(DatabaseService.bookmarkedBusinessesCollection).document(businessID).delete { (error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                completion()
            } else {
                completion()
            }
        }
    }
    func fetchUserBusinessBookmarks(completion: @escaping (Result<[BusinessModel], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        let userID = user.uid
        db.collection(DatabaseService.userCollection).document(userID).collection(DatabaseService.bookmarkedBusinessesCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let bookmarkedBusinesses = snapshot.documents.map { BusinessModel($0.data()) }
                completion(.success(bookmarkedBusinesses))
            }
        }
    }
    ///Function to add business
    //    func createBusiness(companyName: String, completion @escaping (Result<String, Error>) -> ()) {
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
