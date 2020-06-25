//
//  StorageService.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/17/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    private let storageRef = Storage.storage().reference()
    
    public func uploadPhoto(userId: String? = nil, itemID: String? = nil, image: UIImage, completion: @escaping (Result<URL, Error>) -> ()){
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        var photoReference: StorageReference!
        
        if let userId = userId {
            photoReference = storageRef.child("UserProfilePhotos/\(userId).jpeg")
            
        } else if let itemId = itemID {
            
            photoReference = storageRef.child("BusinessPhoto\(itemId).jpeg")
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        let _ = photoReference.putData(imageData, metadata: metadata) { (metadata, error) in
            
            if let error = error {
                completion(.failure(error))
            } else if let _ = metadata {
                photoReference.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
    
    
}
