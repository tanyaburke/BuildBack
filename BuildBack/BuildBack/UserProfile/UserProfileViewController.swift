//
//  UserProfileViewController.swift
//  BuildBack
//
//  Created by Tanya Burke on 6/3/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
      
//      private var buisness = [BusinessModel]() {
//        didSet {
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//            }
//        }
//      }
//
//      override func loadView() {
//
//      }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
        
        // register collection view cell
        
//        podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
//
//        or register collection view cell using xib/nib
//
//        collectionView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCell")
        
    }
//
//      private func fetchPodcasts(_ name: String = "swift") {
//        PodcastAPIClient.fetchPodcast(with: name) { (result) in
//          switch result {
//          case .failure(let appError):
//            print("error fetching podcasts: \(appError)")
//          case .success(let podcasts):
//            self.podcasts = podcasts
//          }
//        }
//      }
//    }
//
//    extension PodcastViewController: UICollectionViewDataSource {
//      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(podcasts.count)
//        return podcasts.count
//
//      }
//
//      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
//            fatalError("Could not downcast to PodcastCell")
//        }
//
//        let cellinRow = podcasts[indexPath.row]
//        cell.configureCell(podcast: cellinRow)
//        cell.backgroundColor = .systemPink
//        return cell
//      }
//    }
//
//    extension PodcastViewController: UICollectionViewDelegateFlowLayout {
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//    //        override the default values of the itemSize layout from the collectionView
//
//            let maxSize: CGSize = UIScreen.main.bounds.size
//            let itemWidth: CGFloat = maxSize.width * 0.90
//
//            return CGSize(width: itemWidth, height: 120)
//        }
//
//
//        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//            let podcast = podcasts[indexPath.row]
//            print(podcast.collectionName)
//
//            //segue to the PodcastDetailController
//            //access the PodcastDetailController from storyBoard
//
//            //make sure that the storyBoard ID is set for the detail controller.
//            let podcastDetailStoryboard = UIStoryboard(name: "PodcastDetail", bundle: nil)
//
//            guard let podcastDetailController = podcastDetailStoryboard.instantiateViewController(identifier: "PodcastDetail") as? PodcastDetailController else {
//                fatalError(" could not downcast to PodcastDetailController")
//            }
//
//            podcastDetailController.podcast = podcast
//
//            // in the coming weels or nex week we will pass data using initializer / dependecy injection ex: PodcastDetailController(podcast:podcast)
//            navigationController?.pushViewController(podcastDetailController, animated: true)
//        }
//    }




}

