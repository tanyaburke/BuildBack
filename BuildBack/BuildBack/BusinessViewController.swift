//
//  BusinessViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 5/28/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class BusinessViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     override func viewDidLoad() {
            super.viewDidLoad()

        view.backgroundColor = .clear
//        collectionView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "profileCell")
//         
        
        }
        
         override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
//            listener = Firestore.firestore().collection(DatabaseService.itemsCollection).addSnapshotListener({ [weak self] (snapshot, error) in
//              if let error = error {
//                DispatchQueue.main.async {
//                  self?.showAlert(title: "Try again later", message: "\(error.localizedDescription)")
//                }
//              } else if let snapshot = snapshot {
//                let items = snapshot.documents.map { Item($0.data()) }
//                self?.imageObjects = items
//              }
//            })
//          }
        
          
//          override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(true)
//            listener?.remove() // no longer are we listening for changes from Firebase
//          }
//
        
        }
}

    extension BusinessViewController: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let maxWidth: CGFloat = UIScreen.main.bounds.size.width
            let itemWidth: CGFloat = maxWidth * 0.80
            return CGSize(width: itemWidth, height: itemWidth)  }
        
    }

    extension BusinessViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as? ProfileCell else {
                fatalError("Was expecting an ProfileCell, but found a different type")
            }

//              let imageObject = imageObjects[indexPath.row]
//            cell.configureCell(for: imageObject)
            
//            cell.delegate = self
            return cell
        }
    

   

}
